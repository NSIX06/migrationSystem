# 08 — Plano de Validação de Dados

> Scripts SQL de validação a executar antes e depois de cada fase do ETL. Garantem que a migração de dados do banco MySQL legado para o PostgreSQL novo está íntegra e completa.

---

## 1. Como Usar Este Documento

1. Executar os scripts da **Seção 2 (Diagnóstico)** no banco legado antes de iniciar o ETL
2. Após cada fase ETL, executar os scripts da seção correspondente
3. Resultado aceitável: todas as queries da coluna "Esperado" satisfeitas
4. Qualquer desvio: registrar em `_migration_validation_issues`, investigar causa raiz antes de prosseguir

---

## 2. Diagnóstico Pré-Migração (Banco Legado)

### 2.1 — Contagem Geral de Tabelas

```sql
-- Executar no banco legado (MySQL/PostgreSQL do legado)
-- Retorna o número de registros ativos em cada tabela crítica
SELECT 'conveniados'      AS tabela, COUNT(*) AS ativos FROM conveniados WHERE deleted_at IS NULL
UNION ALL SELECT 'adesoes',         COUNT(*) FROM adesoes WHERE deleted_at IS NULL
UNION ALL SELECT 'guias',           COUNT(*) FROM guias WHERE deleted_at IS NULL
UNION ALL SELECT 'guias_itens',     COUNT(*) FROM guias_itens WHERE deleted_at IS NULL
UNION ALL SELECT 'lancamentos',     COUNT(*) FROM lancamentos WHERE deleted_at IS NULL
UNION ALL SELECT 'boletos',         COUNT(*) FROM boletos WHERE deleted_at IS NULL
UNION ALL SELECT 'prestadores',     COUNT(*) FROM prestadores WHERE deleted_at IS NULL
UNION ALL SELECT 'empresas',        COUNT(*) FROM empresas WHERE deleted_at IS NULL
UNION ALL SELECT 'procedimentos',   COUNT(*) FROM procedimentos WHERE deleted_at IS NULL
UNION ALL SELECT 'medicamentos',    COUNT(*) FROM medicamentos WHERE deleted_at IS NULL
UNION ALL SELECT 'cid',             COUNT(*) FROM cid
ORDER BY tabela;
```

**Guardar esses números** — serão comparados após cada fase ETL.

---

### 2.2 — Diagnóstico de Enums Inteiros

```sql
-- Descobrir todos os valores de 'sexo' em conveniados
SELECT sexo, COUNT(*) AS qtd FROM conveniados GROUP BY sexo ORDER BY sexo;
-- Esperado: apenas 1 e 2; qualquer outro valor é dado anômalo

-- Valores de 'status' em adesoes
SELECT status, COUNT(*) AS qtd FROM adesoes GROUP BY status ORDER BY status;

-- Valores de 'status' em guias
SELECT status, COUNT(*) AS qtd FROM guias GROUP BY status ORDER BY status;

-- Valores de 'status' em boletos
SELECT status, COUNT(*) AS qtd FROM boletos GROUP BY status ORDER BY status;

-- Valores de 'tipo' em guias
SELECT tipo, COUNT(*) AS qtd FROM guias GROUP BY tipo ORDER BY tipo;

-- Valores de 'carater_atendimento' em guias
SELECT carater_atendimento, COUNT(*) AS qtd FROM guias GROUP BY carater_atendimento ORDER BY carater_atendimento;
```

**Ação**: documentar mapeamento `inteiro → enum` antes de executar ETL.

---

### 2.3 — Diagnóstico de Polimórficos

```sql
-- Valores únicos da coluna 'tabela' em enderecos
SELECT tabela, COUNT(*) FROM enderecos GROUP BY tabela ORDER BY tabela;
-- Esperado: 'conveniados', 'prestadores', 'empresas' — qualquer outro valor precisa de ETL especial

-- Valores únicos em documentos
SELECT tabela, COUNT(*) FROM documentos GROUP BY tabela ORDER BY tabela;

-- Valores únicos em dados_bancarios
SELECT tabela, COUNT(*) FROM dados_bancarios GROUP BY tabela ORDER BY tabela;
```

---

### 2.4 — Detectar Timestamps Hardcoded

```sql
-- Identificar registros com timestamps padrão incorretos
SELECT 'guias' AS tabela, COUNT(*) AS qtd_com_data_hardcoded
FROM guias
WHERE data_hora IN (
    '2024-03-06 09:46:05',
    '2024-01-19 13:56:01'
)
UNION ALL
SELECT 'guias_itens', COUNT(*)
FROM guias_itens
WHERE data_hora IN ('2024-03-06 09:46:05', '2024-01-19 13:56:01');
-- Registros retornados precisam ter data_hora corrigida no ETL (usar data_autorizacao como fallback)
```

---

### 2.5 — Detectar Registros Órfãos

```sql
-- Adesões sem conveniado válido
SELECT COUNT(*) AS orfaos_adesao
FROM adesoes a
LEFT JOIN conveniados c ON c.id = a.conveniado_id AND c.deleted_at IS NULL
WHERE c.id IS NULL AND a.deleted_at IS NULL;

-- Guias sem conveniado válido
SELECT COUNT(*) AS orfaos_guias
FROM guias g
LEFT JOIN adesoes a ON a.id = g.adesao_id AND a.deleted_at IS NULL
WHERE a.id IS NULL AND g.deleted_at IS NULL;

-- Lancamentos sem guia quando tipo exige guia
SELECT COUNT(*) AS lancamentos_sem_guia
FROM lancamentos l
WHERE l.tipo IN (3, 4)  -- tipos que requerem guia (coparticipação, etc.)
  AND NOT EXISTS (SELECT 1 FROM lancamentos_guias lg WHERE lg.lancamento_id = l.id)
  AND l.deleted_at IS NULL;
```

**Resultado esperado**: todos devem retornar `0`. Registros órfãos devem ser investigados e corrigidos antes do ETL.

---

## 3. Validação Pós-ETL — Fase 1 (Referências)

```sql
-- Conferir procedimentos
SELECT
    (SELECT COUNT(*) FROM legado.procedimentos WHERE deleted_at IS NULL) AS legado,
    (SELECT COUNT(*) FROM "Procedimento") AS novo;
-- Diferença deve ser 0

-- Conferir CID
SELECT
    (SELECT COUNT(*) FROM legado.cid) AS legado,
    (SELECT COUNT(*) FROM "Cid") AS novo;
-- Diferença deve ser 0

-- Conferir CBHPM
SELECT
    (SELECT COUNT(*) FROM legado.cbhpm) AS legado,
    (SELECT COUNT(*) FROM "Cbhpm") AS novo;

-- Conferir medicamentos Brasindice
SELECT
    (SELECT COUNT(*) FROM legado.medicamento_brasindice) AS legado,
    (SELECT COUNT(*) FROM "MedicamentoBrasindice") AS novo;
```

---

## 4. Validação Pós-ETL — Fase 2 (Usuários)

```sql
-- Verificar que todos os usuários legados têm mapeamento para Supabase
SELECT COUNT(*) AS usuarios_sem_mapeamento
FROM legado.users u
WHERE u.ativo = 1
  AND NOT EXISTS (
    SELECT 1 FROM user_migration_mapping m WHERE m.legacy_id = u.id
  );
-- Esperado: 0

-- Verificar perfis migrados
SELECT
    (SELECT COUNT(*) FROM legado.roles WHERE deleted_at IS NULL) AS legado_perfis,
    (SELECT COUNT(*) FROM "Perfil") AS novo_perfis;

-- Verificar permissões migradas
SELECT
    (SELECT COUNT(*) FROM legado.permissions) AS legado_permissoes,
    (SELECT COUNT(*) FROM "Permissao") AS novo_permissoes;
```

---

## 5. Validação Pós-ETL — Fase 3 (Cadastros)

### 5.1 — Contagens Principais

```sql
SELECT 'Conveniado' AS entidade,
    (SELECT COUNT(*) FROM legado.conveniados WHERE deleted_at IS NULL) AS legado,
    (SELECT COUNT(*) FROM "Conveniado" WHERE "deletedAt" IS NULL) AS novo,
    ABS(
        (SELECT COUNT(*) FROM legado.conveniados WHERE deleted_at IS NULL) -
        (SELECT COUNT(*) FROM "Conveniado" WHERE "deletedAt" IS NULL)
    ) AS diferenca

UNION ALL SELECT 'Adesao',
    (SELECT COUNT(*) FROM legado.adesoes WHERE deleted_at IS NULL),
    (SELECT COUNT(*) FROM "Adesao" WHERE "deletedAt" IS NULL),
    ABS(
        (SELECT COUNT(*) FROM legado.adesoes WHERE deleted_at IS NULL) -
        (SELECT COUNT(*) FROM "Adesao" WHERE "deletedAt" IS NULL)
    )

UNION ALL SELECT 'Prestador',
    (SELECT COUNT(*) FROM legado.prestadores WHERE deleted_at IS NULL),
    (SELECT COUNT(*) FROM "Prestador" WHERE "deletedAt" IS NULL),
    ABS(
        (SELECT COUNT(*) FROM legado.prestadores WHERE deleted_at IS NULL) -
        (SELECT COUNT(*) FROM "Prestador" WHERE "deletedAt" IS NULL)
    )

UNION ALL SELECT 'Empresa',
    (SELECT COUNT(*) FROM legado.empresas WHERE deleted_at IS NULL),
    (SELECT COUNT(*) FROM "Empresa" WHERE "deletedAt" IS NULL),
    ABS(
        (SELECT COUNT(*) FROM legado.empresas WHERE deleted_at IS NULL) -
        (SELECT COUNT(*) FROM "Empresa" WHERE "deletedAt" IS NULL)
    );
-- Coluna 'diferenca' deve ser 0 em todas as linhas
```

### 5.2 — Zero Endereços Órfãos

```sql
SELECT COUNT(*) AS enderecos_orfaos
FROM "Endereco"
WHERE "conveniadoId" IS NULL
  AND "prestadorId" IS NULL
  AND "empresaId" IS NULL
  AND "operadoraId" IS NULL;
-- Esperado: 0
```

### 5.3 — Enums Válidos

```sql
-- Verificar se todos os sexos são válidos (sem NULL onde não deveria)
SELECT COUNT(*) AS invalidos
FROM "Conveniado"
WHERE sexo NOT IN ('MASCULINO', 'FEMININO', 'NAO_INFORMADO');
-- Esperado: 0

-- Verificar status de adesão
SELECT COUNT(*) AS invalidos
FROM "Adesao"
WHERE status NOT IN ('ATIVO', 'SUSPENSO', 'ENCERRADO', 'AGUARDANDO_APROVACAO', 'INADIMPLENTE');
-- Esperado: 0
```

---

## 6. Validação Pós-ETL — Fase 4 (Guias e Financeiro)

### 6.1 — Contagem de Guias por Status

```sql
-- Comparar distribuição de status entre legado e novo
-- Legado: status 1=SOLICITADA, 2=AUTORIZADA, 3=NEGADA, 4=CANCELADA, 5=FATURADA, 6=AUDITADA
SELECT
    status_legado,
    status_novo,
    COUNT(*) AS qtd_legado,
    qtd_novo
FROM (
    SELECT
        g.status AS status_legado,
        CASE g.status
            WHEN 1 THEN 'SOLICITADA'
            WHEN 2 THEN 'AUTORIZADA'
            WHEN 3 THEN 'NEGADA'
            WHEN 4 THEN 'CANCELADA'
            WHEN 5 THEN 'FATURADA'
            WHEN 6 THEN 'AUDITADA'
            ELSE 'DESCONHECIDO'
        END AS status_novo
    FROM legado.guias g WHERE g.deleted_at IS NULL
) legado_mapeado
JOIN (
    SELECT status AS status_novo, COUNT(*) AS qtd_novo
    FROM "Guia"
    GROUP BY status
) novo_contagem USING (status_novo)
GROUP BY status_legado, status_novo, qtd_novo
ORDER BY status_legado;
```

### 6.2 — Validação Financeira (Centavo a Centavo)

```sql
-- Total de lançamentos pagos: legado vs novo
WITH legado_totais AS (
    SELECT
        SUM(CASE WHEN status = 2 THEN valor ELSE 0 END) AS total_pago,
        SUM(CASE WHEN status = 1 THEN valor ELSE 0 END) AS total_aberto,
        COUNT(*) AS total_registros
    FROM legado.lancamentos
    WHERE deleted_at IS NULL
),
novo_totais AS (
    SELECT
        SUM(CASE WHEN status = 'PAGO' THEN valor ELSE 0 END) AS total_pago,
        SUM(CASE WHEN status = 'ABERTO' THEN valor ELSE 0 END) AS total_aberto,
        COUNT(*) AS total_registros
    FROM "Lancamento"
)
SELECT
    ROUND(l.total_pago::numeric, 2) AS legado_pago,
    ROUND(n.total_pago::numeric, 2) AS novo_pago,
    ROUND(ABS(l.total_pago - n.total_pago)::numeric, 2) AS diferenca_pago,
    l.total_registros AS legado_registros,
    n.total_registros AS novo_registros
FROM legado_totais l, novo_totais n;
-- diferenca_pago deve ser 0.00
```

### 6.3 — Zero GuiaItens Órfãos

```sql
SELECT COUNT(*) AS itens_orfaos
FROM "GuiaItem" gi
LEFT JOIN "Guia" g ON g.id = gi."guiaId"
WHERE g.id IS NULL;
-- Esperado: 0
```

### 6.4 — Boletos com NossoNumero Único

```sql
SELECT "nossoNumero", COUNT(*) AS duplicatas
FROM "Boleto"
WHERE "nossoNumero" IS NOT NULL
GROUP BY "nossoNumero"
HAVING COUNT(*) > 1;
-- Esperado: 0 linhas (nenhum nossoNumero duplicado)
```

---

## 7. Validação Final — Pré Go-Live (Fase 5)

### 7.1 — Checklist de Integridade Referencial

```sql
-- Guias sem conveniado válido
SELECT COUNT(*) AS guias_sem_conveniado
FROM "Guia" g
LEFT JOIN "Conveniado" c ON c.id = g."conveniadoId"
WHERE c.id IS NULL;

-- Guias sem prestador válido
SELECT COUNT(*) AS guias_sem_prestador
FROM "Guia" g
LEFT JOIN "Prestador" p ON p.id = g."prestadorId"
WHERE p.id IS NULL;

-- Lancamentos sem adesão válida quando tipo = MENSALIDADE
SELECT COUNT(*) AS lancamentos_sem_adesao
FROM "Lancamento" l
WHERE l.tipo = 'MENSALIDADE'
  AND l."adesaoId" IS NULL;

-- Todos devem retornar 0
```

### 7.2 — Checklist de Configuração (verificação manual)

| Item | Verificação | Status |
|---|---|---|
| Supabase Auth | Login funcional para cada perfil | ___ |
| RLS policies | Usuário da empresa A não vê dados da empresa B | ___ |
| API Bancária | Emissão de boleto em sandbox retorna código de barras válido | ___ |
| Storage | Upload de foto do conveniado retorna URL pública | ___ |
| Variáveis de ambiente | Todas as vars do `.env.local.example` configuradas em produção | ___ |
| Backup | pg_dump funcional e restauração testada no staging | ___ |
| DNS | Certificado TLS válido para o domínio de produção | ___ |
| Monitoramento | Alertas de erro 5xx configurados (Sentry/Supabase Logs) | ___ |

### 7.3 — Smoke Test Pós Go-Live

Executar na ordem exata após apontar o DNS para o novo sistema:

1. [ ] Acessar URL de produção → página de login carrega em < 3s
2. [ ] Login com admin da operadora → dashboard carrega
3. [ ] Buscar conveniado por CPF → retorna dados corretos
4. [ ] Emitir guia de teste (consulta) → status SOLICITADA criado
5. [ ] Autorizar guia → status AUTORIZADA, histórico registrado
6. [ ] Acessar tela de lançamentos → total financeiro correto
7. [ ] Login com perfil prestador → vê apenas suas guias
8. [ ] Login com perfil beneficiário → vê apenas seus dados
9. [ ] Verificar AuditLog → ações acima registradas corretamente

**Critério**: todos os 9 itens passando em < 30 minutos. Qualquer falha → acionar rollback.

---

## 8. Relatório de Validação

Ao final de cada fase, preencher:

```
RELATÓRIO DE VALIDAÇÃO — FASE [N]
Data/hora: _______________
Responsável: _____________

Contagens:
  Tabela             | Legado | Novo   | Diferença | Status
  -------------------|--------|--------|-----------|-------
  Conveniado         |        |        |           |
  Adesao             |        |        |           |
  Guia               |        |        |           |
  Lancamento         |        |        |           |

Validações financeiras:
  Total pago legado:   R$ ___________
  Total pago novo:     R$ ___________
  Diferença:           R$ ___________ (deve ser R$ 0,00)

Integridade referencial:
  Órfãos detectados: ___ (deve ser 0)
  Enums inválidos:   ___ (deve ser 0)

Decisão: [ ] APROVAR FASE  [ ] REJEITAR — INVESTIGAR
Justificativa: _______________________________________________
```
