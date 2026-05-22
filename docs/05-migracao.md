# 05 — Estratégia de Migração

> Plano detalhado de migração do sistema legado ServSaúde (PHP/Laravel/MySQL) para o novo sistema (Next.js/Prisma/Supabase PostgreSQL), utilizando o padrão **Strangler Fig**.

---

## 1. Padrão Adotado: Strangler Fig

O **Strangler Fig** é a estratégia de migração que mantém o sistema legado em produção enquanto o novo sistema é construído incrementalmente. Módulos são migrados um a um, até o legado ser completamente substituído ("estrangulado").

### Por que Strangler Fig?

| Critério | Strangler Fig | Big Bang |
|---|---|---|
| **Risco de downtime** | Baixo — legado continua operando | Alto — tudo migra de uma vez |
| **Rollback** | Por módulo — sem impacto geral | Total — reversão de tudo ou nada |
| **Tempo até go-live** | Parcial rápido (módulo a módulo) | Longo (só vai ao ar quando tudo está pronto) |
| **Validação** | Incremental — usuários validam cada módulo | Validação massiva no final |
| **Recomendação ANS** | Adequado — histórico preservado por módulo | Inadequado — risco regulatório alto |

### Condição eliminatória
O sistema gerencia dados de saúde regulados pela ANS. Um downtime não planejado pode impedir emissão de guias, violando prazos ANS (Art. 20, RN 259). Isso invalida a estratégia Big Bang para este contexto.

---

## 2. Arquitetura de Migração

```
┌─────────────────────────────────────────────────────────────────────┐
│                         FASE DE COEXISTÊNCIA                         │
│                                                                       │
│  ┌──────────────┐    ┌───────────────────┐    ┌──────────────────┐  │
│  │  Legado PHP  │    │   API Gateway /   │    │  Novo Sistema    │  │
│  │  (Laravel)   │◄───│   Proxy Reverso   │───►│  (Next.js)       │  │
│  │   MySQL      │    │   (Nginx/Vercel)  │    │  Supabase PG     │  │
│  └──────────────┘    └───────────────────┘    └──────────────────┘  │
│                                                                       │
│  Roteamento por módulo:                                               │
│  /auth, /convenidos → Novo sistema                                   │
│  /guias, /financeiro → Legado (até migração do módulo)               │
└─────────────────────────────────────────────────────────────────────┘
```

### Sincronização durante coexistência
- **ETL unidirecional**: legado → novo banco (read-only no novo durante fase de coexistência)
- **Sync por evento**: triggers no MySQL legado publicam eventos consumidos pelo novo sistema
- **Sync por batch**: cron job noturno reconcilia dados críticos (guias, lancamentos)

---

## 3. Fases de Migração

### Fase 0 — Preparação (Semana 1–2)

**Objetivo**: configurar infraestrutura e validar o schema do novo banco.

| Tarefa | Responsável | Critério de saída |
|---|---|---|
| Provisionar Supabase project (prod + staging) | TI | URLs e chaves configuradas |
| Executar `prisma migrate deploy` no staging | TI | Zero erros de migration |
| Criar políticas RLS para operadoraId | TI | Testes de isolamento passando |
| Configurar Supabase Auth (provedores: email) | TI | Login funcional no staging |
| Executar scripts de validação do banco legado | DBA | Relatório de inconsistências gerado |
| Definir janela de manutenção (fim de semana) | Gestão | Comunicação enviada aos usuários |

**Entregável**: ambiente de staging com schema vazio e validado.

---

### Fase 1 — Tabelas de Referência (Semana 3–4)

**Objetivo**: migrar dados estáticos que não mudam durante a operação.

**Tabelas migradas**:
- `Estado`, `Cidade` (dados de IBGE)
- `GrauParentesco`, `TipoVinculo`
- `ProcedimentoGrupo`, `ProcedimentoSubgrupo`, `Procedimento`, `Cid`
- `CbhpmEdicao`, `Cbhpm`, `ComunicadoEdicao`, `ComunicadoPorte`
- `MedicamentoEdicao`, `Medicamento`, `MedicamentoBrasindice`
- `MaterialEdicao`, `Material`, `MaterialItem`, `Laboratorio`, `Taxa`

**Script ETL — Exemplo (Procedimentos)**:
```sql
-- Executar no banco novo após truncar a tabela
INSERT INTO "Procedimento" (
    id, "operadoraId", codigo, "codigoTuss", nome,
    "subgrupoId", "requerAutorizacao", ativo, "criadoEm", "atualizadoEm"
)
SELECT
    p.id,
    1 AS operadora_id,  -- operadora padrão da migração
    p.codigo,
    p.codigo_tuss,
    p.nome,
    p.subgrupo_id,
    p.requer_autorizacao::boolean,
    p.ativo::boolean,
    COALESCE(p.created_at, NOW()),
    COALESCE(p.updated_at, NOW())
FROM legado.procedimentos p
WHERE p.deleted_at IS NULL;
```

**Validação**:
```sql
-- Contar registros em ambos os bancos
SELECT 'legado' AS banco, COUNT(*) FROM legado.procedimentos WHERE deleted_at IS NULL
UNION ALL
SELECT 'novo', COUNT(*) FROM "Procedimento";
-- Diferença deve ser 0
```

**Rollback**: sem impacto — tabelas de referência não recebem escrita em produção.

---

### Fase 2 — Usuários e Permissões (Semana 5–6)

**Objetivo**: migrar usuários para Supabase Auth e configurar RBAC.

**Estratégia de usuários**:
1. Criar usuários no Supabase Auth via Admin API (sem expor senhas)
2. Enviar e-mail de redefinição de senha para todos os usuários ativos
3. Mapear `users.id` legado → `auth.uid()` Supabase em tabela de transição

**Tabelas migradas**: `Operadora`, `Perfil`, `Permissao`, `RolePermissao`, `UsuarioRole`, `OperadoraUsuario`, `EmpresaUsuario`, `PrestadorUsuario`

**Script de criação de usuários (Node.js)**:
```typescript
// scripts/migrate-users.ts
import { createClient } from '@supabase/supabase-js'

const supabaseAdmin = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

async function migrateUser(legacyUser: LegacyUser) {
  const { data, error } = await supabaseAdmin.auth.admin.createUser({
    email: legacyUser.email,
    email_confirm: true,
    user_metadata: {
      nome: legacyUser.name,
      legacy_id: legacyUser.id,
    },
  })

  if (error) throw error

  // Guardar mapeamento legacyId → supabaseUid
  await db.userMapping.create({
    data: { legacyId: legacyUser.id, supabaseUid: data.user.id }
  })
}
```

**Validação**: login funcional para 3 usuários por perfil (admin, operador, prestador).

---

### Fase 3 — Entidades Principais (Semana 7–10)

**Objetivo**: migrar cadastros de beneficiários, empresas e prestadores.

**Tabelas migradas**:
- `Empresa`, `Secretaria`, `Cargo`
- `Conveniado`, `ConveniadoSalario`, `Gestante`
- `Endereco`, `DadoBancario`
- `Prestador`, `PrestadorEspecialidade`, `PrestadorContrato`, `PrestadorContratoItem`
- `TipoVinculo`, `Produto`, `ProdutoPreco`, `EmpresaProduto`
- `RegraCoparticipacao`, `RegraCoparticipacaoItem`, `RegraCoparticipacaoProcedimento`
- `Adesao`, `AdesaoReducaoMargem`

**Desafio — Polimórficos**: endereços e dados bancários no legado usam `tabela + origem_id`. O ETL deve resolver esse polimorfismo:

```sql
-- Migrar endereços de conveniados
INSERT INTO "Endereco" (id, "conveniadoId", logradouro, numero, bairro, cep, "cidadeId", "criadoEm")
SELECT
    e.id,
    e.origem_id AS conveniado_id,
    e.logradouro,
    e.numero,
    e.bairro,
    e.cep,
    e.cidade_id,
    COALESCE(e.created_at, NOW())
FROM legado.enderecos e
WHERE e.tabela = 'conveniados'
  AND e.deleted_at IS NULL;

-- Migrar endereços de prestadores
INSERT INTO "Endereco" (id, "prestadorId", logradouro, numero, bairro, cep, "cidadeId", "criadoEm")
SELECT e.id + 1000000,  -- offset para evitar conflito de id
    e.origem_id, e.logradouro, e.numero, e.bairro, e.cep, e.cidade_id, COALESCE(e.created_at, NOW())
FROM legado.enderecos e
WHERE e.tabela = 'prestadores'
  AND e.deleted_at IS NULL;
```

**Conversão de Enums**:
```sql
-- sexo: 1=M, 2=F, 0=? → enum PostgreSQL
CASE c.sexo
    WHEN 1 THEN 'MASCULINO'::"SexoEnum"
    WHEN 2 THEN 'FEMININO'::"SexoEnum"
    ELSE 'NAO_INFORMADO'::"SexoEnum"
END
```

**Validação após Fase 3**:
- Contagem de conveniados: legado vs novo (diferença ≤ 0,01%)
- Todos os conveniados têm adesão ativa correspondente
- Nenhum endereço órfão (sem conveniadoId nem prestadorId)

---

### Fase 4 — Guias e Financeiro (Semana 11–16)

**Objetivo**: migrar o núcleo transacional — guias e lançamentos financeiros. Esta é a fase mais crítica.

**Estratégia**:
1. Migrar guias históricas (> 12 meses) primeiro — risco zero, dados imutáveis
2. Migrar guias recentes (≤ 12 meses) durante janela de manutenção (fim de semana)
3. Validar contagens e valores antes de ativar o novo sistema

**Tabelas migradas**:
- `Guia`, `GuiaItem`, `GuiaHistorico`, `GuiaAuditoria`, `GuiaAtendimento`, `GuiaAnexo`
- `Lancamento`, `LancamentoGuia`, `LotePagamento`
- `Boleto`, `BoletoPagamento`, `Mensalidade`
- `RemessaDesconto`, `RemessaDescontoItem`

**Script de validação financeira**:
```sql
-- Conferir totais financeiros entre legado e novo
SELECT
    'legado' AS banco,
    COUNT(*) AS total_lancamentos,
    SUM(valor) AS valor_total,
    SUM(CASE WHEN status = 2 THEN valor ELSE 0 END) AS total_pago  -- status 2 = pago no legado
FROM legado.lancamentos
WHERE deleted_at IS NULL

UNION ALL

SELECT
    'novo',
    COUNT(*),
    SUM(valor),
    SUM(CASE WHEN status = 'PAGO' THEN valor ELSE 0 END)
FROM "Lancamento";
```

**Critério de go-live para Fase 4**:
- Diferença de totais financeiros ≤ R$ 0,00 (centavo a centavo)
- 100% das guias com status AUTORIZADA migradas e validadas
- Zero guias órfãs (sem conveniadoId ou prestadorId válidos)

---

### Fase 5 — Go-live e Desativação do Legado (Semana 17–18)

**Objetivo**: desligar o sistema legado e operar 100% no novo sistema.

| Etapa | Ação |
|---|---|
| D-7 | Comunicar usuários sobre janela de corte |
| D-1 | Congelar escrita no legado (modo leitura) |
| D-0 06h | Iniciar sincronização final (delta dos últimos 7 dias) |
| D-0 08h | Executar validação completa (scripts de conferência) |
| D-0 10h | Apontar DNS do sistema legado para o novo (se aprovado) |
| D-0 12h | Monitorar por 2h — reverter se crítico |
| D+7 | Desativar servidores legados (manter backup por 90 dias) |

---

## 4. Scripts ETL Completos

Os scripts ETL estão organizados em:

```
scripts/
├── etl/
│   ├── 01-referencias.sql      -- Fase 1: estados, cidades, procedimentos, CID
│   ├── 02-usuarios.ts          -- Fase 2: migração para Supabase Auth
│   ├── 03-cadastros.sql        -- Fase 3: conveniados, prestadores, adesões
│   ├── 04-guias.sql            -- Fase 4a: guias históricas (> 12 meses)
│   ├── 04-guias-recentes.sql   -- Fase 4b: guias recentes (janela manutenção)
│   ├── 04-financeiro.sql       -- Fase 4c: lançamentos, boletos, mensalidades
│   └── 05-validacao-final.sql  -- Fase 5: conferência total
└── validate/
    ├── contagens.sql            -- Conta registros em cada tabela
    ├── orfaos.sql               -- Detecta registros sem FK válida
    ├── financeiro.sql           -- Confere totais financeiros
    └── enums.sql                -- Verifica valores de enum inválidos
```

---

## 5. Rollback por Fase

| Fase | Estratégia de Rollback | Tempo estimado |
|---|---|---|
| Fase 0 | Desligar staging; sem impacto em produção | < 5 min |
| Fase 1 | Truncar tabelas de referência; re-executar ETL | < 30 min |
| Fase 2 | Deletar usuários no Supabase Auth; sem impacto no legado | < 1h |
| Fase 3 | Truncar tabelas de cadastro; re-executar ETL | < 2h |
| Fase 4 | Redirecionar DNS de volta ao legado; legado manteve dados | < 15 min |
| Fase 5 | Reativar legado (backup 90 dias); redirecionar DNS | < 30 min |

---

## 6. Critérios de Aceite por Fase

| Fase | Critério obrigatório |
|---|---|
| Fase 1 | Contagem de procedimentos/CID = 100% do legado |
| Fase 2 | Login funcional com e-mail/senha para todos os perfis |
| Fase 3 | Contagem de conveniados/adesões ≥ 99,99% do legado |
| Fase 4 | Soma de lançamentos pagos = valor exato do legado |
| Fase 5 | Zero erros críticos em 2h de monitoramento pós-go-live |
