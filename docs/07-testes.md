# 07 — Plano de Testes

> Casos de teste para o novo sistema ServSaúde, cobrindo autenticação, RBAC, CRUD de entidades, regras de negócio, migração, carga e segurança. Total: 45 casos de teste.

---

## 1. Estrutura dos Testes

### Categorias

| Categoria | Sigla | Qtd | Ferramenta |
|---|---|---|---|
| Autenticação e Auth | AUTH | 6 | Vitest + Supabase Auth |
| Controle de Acesso (RBAC) | RBAC | 7 | Vitest + RLS policies |
| CRUD de Entidades | CRUD | 12 | Vitest + Prisma |
| Regras de Negócio | RN | 8 | Vitest |
| Migração de Dados | MIG | 5 | SQL scripts |
| Performance e Carga | PERF | 4 | k6 |
| Segurança | SEC | 3 | Manual + OWASP ZAP |
| **Total** | | **45** | |

### Convenção de Status

| Status | Significado |
|---|---|
| PASS | Teste passou |
| FAIL | Teste falhou |
| BLOCK | Bloqueado por dependência |
| N/A | Não aplicável neste ambiente |

---

## 2. Testes de Autenticação (AUTH)

### AUTH-01 — Login com e-mail e senha válidos

**Pré-condição**: usuário cadastrado no Supabase Auth com `email_confirm = true`  
**Entrada**: `email: admin@operadora.com`, `senha: SenhaForte@123`  
**Ação**: POST `/api/auth/login`  
**Resultado esperado**: HTTP 200, `access_token` válido no header `Set-Cookie`  
**Resultado obtido**: ___  
**Status**: ___

---

### AUTH-02 — Login com senha incorreta

**Entrada**: `email: admin@operadora.com`, `senha: senhaErrada`  
**Resultado esperado**: HTTP 401, mensagem "Credenciais inválidas" sem revelar qual campo está errado  
**Status**: ___

---

### AUTH-03 — Token expirado é rejeitado

**Pré-condição**: token com `exp` no passado  
**Ação**: GET `/api/conveniados` com token expirado  
**Resultado esperado**: HTTP 401, redirecionamento para `/login`  
**Status**: ___

---

### AUTH-04 — Refresh token renova acesso

**Pré-condição**: `access_token` expirado, `refresh_token` válido  
**Ação**: POST `/api/auth/refresh`  
**Resultado esperado**: HTTP 200, novo `access_token` válido, `refresh_token` rotacionado  
**Status**: ___

---

### AUTH-05 — Logout invalida sessão

**Ação**: POST `/api/auth/logout`  
**Resultado esperado**: cookies limpos, tentativa de usar o token anterior retorna 401  
**Status**: ___

---

### AUTH-06 — Usuário inativo não consegue logar

**Pré-condição**: usuário com `ativo = false` no Supabase Auth  
**Resultado esperado**: HTTP 403, mensagem "Usuário inativo"  
**Status**: ___

---

## 3. Testes de Controle de Acesso (RBAC)

### RBAC-01 — Perfil `operadora_admin` acessa todos os módulos

**Ação**: GET em `/api/conveniados`, `/api/guias`, `/api/lancamentos`, `/api/prestadores`  
**Resultado esperado**: HTTP 200 em todos  
**Status**: ___

---

### RBAC-02 — Perfil `beneficiario` vê apenas seus próprios dados

**Pré-condição**: beneficiário João, `conveniadoId = 42`  
**Ação**: GET `/api/conveniados` (listagem geral)  
**Resultado esperado**: HTTP 200, retorna apenas os dados do conveniado 42 (RLS filtra)  
**Status**: ___

---

### RBAC-03 — Beneficiário não acessa dados de outro beneficiário

**Ação**: GET `/api/conveniados/99` (onde 99 é outro conveniado)  
**Resultado esperado**: HTTP 404 (RLS oculta o registro — não revela que existe)  
**Status**: ___

---

### RBAC-04 — Perfil `operadora_financeiro` não emite guias

**Ação**: POST `/api/guias` com token de `operadora_financeiro`  
**Resultado esperado**: HTTP 403, mensagem "Permissão negada"  
**Status**: ___

---

### RBAC-05 — Perfil `empresa` não acessa dados de outra empresa

**Pré-condição**: usuário vinculado à empresa A (`empresaId = 1`)  
**Ação**: GET `/api/conveniados?empresaId=2`  
**Resultado esperado**: HTTP 200, lista vazia (RLS filtra por operadoraId vinculado ao usuário)  
**Status**: ___

---

### RBAC-06 — Prestador acessa apenas suas próprias guias

**Pré-condição**: prestador B, `prestadorId = 7`  
**Ação**: GET `/api/guias` com token de prestador B  
**Resultado esperado**: retorna apenas guias onde `prestadorId = 7`  
**Status**: ___

---

### RBAC-07 — Isolamento multi-tenant: operadora A não acessa dados da operadora B

**Pré-condição**: dois projetos Supabase com `operadoraId` distintos, ou RLS por `operadoraId`  
**Ação**: admin da operadora A tenta GET `/api/conveniados` (que inclui conveniados da operadora B)  
**Resultado esperado**: retorna apenas conveniados da operadora A  
**Status**: ___

---

## 4. Testes CRUD de Entidades (CRUD)

### CRUD-01 — Criar conveniado com dados válidos

**Entrada**:
```json
{
  "cpf": "123.456.789-09",
  "nome": "Maria da Silva",
  "dataNascimento": "1985-03-15",
  "sexo": "FEMININO",
  "cargoId": 1
}
```
**Resultado esperado**: HTTP 201, conveniado criado com `id` gerado, `criadoEm` = now()  
**Status**: ___

---

### CRUD-02 — Criar conveniado com CPF duplicado

**Pré-condição**: CPF `123.456.789-09` já cadastrado na operadora  
**Resultado esperado**: HTTP 422, mensagem "CPF já cadastrado"  
**Status**: ___

---

### CRUD-03 — Buscar conveniado por CPF

**Ação**: GET `/api/conveniados?cpf=123.456.789-09`  
**Resultado esperado**: HTTP 200, retorna o conveniado correspondente  
**Status**: ___

---

### CRUD-04 — Soft delete de conveniado

**Ação**: DELETE `/api/conveniados/42`  
**Resultado esperado**: HTTP 200, `deletedAt` preenchido; GET `/api/conveniados/42` retorna 404; dados ainda existem no banco  
**Status**: ___

---

### CRUD-05 — Impedir delete de conveniado com guia ativa

**Pré-condição**: conveniado 42 tem guia com `status = AUTORIZADA`  
**Ação**: DELETE `/api/conveniados/42`  
**Resultado esperado**: HTTP 409, mensagem "Conveniado possui guias ativas"  
**Status**: ___

---

### CRUD-06 — Criar guia médica (consulta)

**Entrada**: guia com `tipo = CONSULTA`, `conveniadoId`, `prestadorId`, `cidId`, 1 item de procedimento  
**Resultado esperado**: HTTP 201, `status = SOLICITADA`, `GuiaHistorico` criado automaticamente  
**Status**: ___

---

### CRUD-07 — Autorizar guia

**Pré-condição**: guia com `status = SOLICITADA`  
**Ação**: PATCH `/api/guias/100/autorizar`  
**Resultado esperado**: HTTP 200, `status = AUTORIZADA`, novo `GuiaHistorico` registrado, `dataAutorizacao` preenchida  
**Status**: ___

---

### CRUD-08 — Negar guia com motivo

**Ação**: PATCH `/api/guias/100/negar` com `{ "motivoId": 3, "observacao": "Procedimento não coberto" }`  
**Resultado esperado**: HTTP 200, `status = NEGADA`, `GuiaMotivoEncerramento` vinculado  
**Status**: ___

---

### CRUD-09 — Emitir boleto

**Pré-condição**: adesão ativa com mensalidade calculada  
**Ação**: POST `/api/boletos` com `{ "mensalidadeId": 55, "dataVencimento": "2025-07-10" }`  
**Resultado esperado**: HTTP 201, boleto com `nossoNumero` único, `codigoBarras` válido, `status = EMITIDO`  
**Status**: ___

---

### CRUD-10 — Pagar boleto via retorno bancário

**Ação**: POST `/api/boletos/retorno` com payload de retorno bancário (CNAB 240)  
**Resultado esperado**: boleto com `nossoNumero` correspondente → `status = PAGO`, `BoletoPagamento` criado, `Lancamento` atualizado para `PAGO`  
**Status**: ___

---

### CRUD-11 — Criar prestador com CNPJ válido

**Entrada**: `{ "cpfCnpj": "12.345.678/0001-95", "nome": "Clínica Saúde Total", "tipoId": 1, "cnes": "1234567" }`  
**Resultado esperado**: HTTP 201, prestador criado com `ativo = true`  
**Status**: ___

---

### CRUD-12 — Listar guias com paginação

**Ação**: GET `/api/guias?page=1&pageSize=20&status=SOLICITADA`  
**Resultado esperado**: HTTP 200, array com até 20 itens, `total` e `nextCursor` no body  
**Status**: ___

---

## 5. Testes de Regras de Negócio (RN)

### RN-01 — Carência impede autorização de internação em beneficiário novo

**Pré-condição**: conveniado com adesão criada há 15 dias; produto com `carenciaInternacao = 180 dias`  
**Ação**: criar guia com `tipo = INTERNACAO`  
**Resultado esperado**: HTTP 422, mensagem "Beneficiário em período de carência para internação (165 dias restantes)"  
**Status**: ___

---

### RN-02 — Cálculo de mensalidade por faixa salarial

**Pré-condição**: conveniado com salário R$ 3.500, produto com `percentual = 4%` para faixa R$3.000–R$5.000  
**Ação**: POST `/api/mensalidades/calcular` com `{ "adesaoId": 10, "competencia": "2025-07" }`  
**Resultado esperado**: `valor = 140.00` (3500 × 0.04)  
**Status**: ___

---

### RN-03 — Coparticipação calculada corretamente na auditoria

**Pré-condição**: guia com consulta (procedimento código 10101012); regra de coparticipação = 20%  
**Ação**: POST `/api/guias/100/auditar` aprovando o item  
**Resultado esperado**: `Lancamento` de coparticipação criado com `valor = 20% do valor do procedimento`  
**Status**: ___

---

### RN-04 — Dependente exige titular ativo

**Pré-condição**: titular com adesão encerrada  
**Ação**: criar adesão para dependente com `titularAdesaoId` apontando para adesão encerrada  
**Resultado esperado**: HTTP 422, mensagem "Titular não possui adesão ativa"  
**Status**: ___

---

### RN-05 — Boleto vencido bloqueia novas guias eletivas

**Pré-condição**: beneficiário com boleto vencido há 35 dias; parâmetro `diasBloqueioInadimplencia = 30`  
**Ação**: criar guia com `caraterAtendimento = ELETIVO`  
**Resultado esperado**: HTTP 422, mensagem "Beneficiário inadimplente — autorização eletiva bloqueada"  
**Exceção**: guia com `caraterAtendimento = URGENCIA` ou `EMERGENCIA` deve ser aceita  
**Status**: ___

---

### RN-06 — Guia TISS — XML inválido rejeitado

**Ação**: POST `/api/guias/importar-tiss` com XML malformado  
**Resultado esperado**: HTTP 422, `GuiaImportacao` com `status = ERRO`, detalhes do erro no campo `erros`  
**Status**: ___

---

### RN-07 — Deflator aplicado corretamente no lote de pagamento

**Pré-condição**: prestador com `Deflator.percentual = 5%` para competência 2025-07  
**Ação**: POST `/api/lote-pagamentos/fechar` com guias da competência 2025-07  
**Resultado esperado**: `LotePagamento.valorLiquido = valorBruto × 0.95`  
**Status**: ___

---

### RN-08 — Usuário sem permissão recebe 403, não 404

**Ação**: GET `/api/operadoras/configuracoes` com token de perfil `beneficiario`  
**Resultado esperado**: HTTP 403 (recurso existe mas usuário não tem acesso)  
**Justificativa**: retornar 404 seria information disclosure — informa que o endpoint existe  
**Status**: ___

---

## 6. Testes de Migração de Dados (MIG)

### MIG-01 — Contagem de conveniados após ETL Fase 3

**Script**:
```sql
SELECT
    (SELECT COUNT(*) FROM legado.conveniados WHERE deleted_at IS NULL) AS legado,
    (SELECT COUNT(*) FROM "Conveniado" WHERE "deletedAt" IS NULL) AS novo,
    ABS(
        (SELECT COUNT(*) FROM legado.conveniados WHERE deleted_at IS NULL) -
        (SELECT COUNT(*) FROM "Conveniado" WHERE "deletedAt" IS NULL)
    ) AS diferenca;
```
**Resultado esperado**: `diferenca = 0`  
**Status**: ___

---

### MIG-02 — Total financeiro de lançamentos após ETL Fase 4

**Script**:
```sql
SELECT
    ROUND(SUM(CASE WHEN status = 2 THEN valor ELSE 0 END)::numeric, 2) AS legado_pago
FROM legado.lancamentos WHERE deleted_at IS NULL;
-- vs
SELECT
    ROUND(SUM(valor)::numeric, 2) AS novo_pago
FROM "Lancamento" WHERE status = 'PAGO';
```
**Resultado esperado**: valores idênticos (diferença = R$ 0,00)  
**Status**: ___

---

### MIG-03 — Zero endereços órfãos após resolução de polimórficos

**Script**:
```sql
SELECT COUNT(*) AS orfaos
FROM "Endereco"
WHERE "conveniadoId" IS NULL
  AND "prestadorId" IS NULL
  AND "empresaId" IS NULL;
```
**Resultado esperado**: `orfaos = 0`  
**Status**: ___

---

### MIG-04 — Enums válidos em todos os conveniados

**Script**:
```sql
-- Verificar se algum enum tem valor NULL onde não deveria
SELECT COUNT(*) FROM "Conveniado"
WHERE sexo IS NULL OR "estadoCivil" IS NULL;
-- Esperado: 0 (enum tem valor NAO_INFORMADO como fallback)
```
**Resultado esperado**: `0`  
**Status**: ___

---

### MIG-05 — Login de usuário migrado funcional

**Pré-condição**: usuário migrado via script de Fase 2, senha redefinida  
**Ação**: login com nova senha  
**Resultado esperado**: autenticação bem-sucedida, perfil correto carregado  
**Status**: ___

---

## 7. Testes de Performance (PERF)

### PERF-01 — Listagem de guias com 500k registros (P95 < 500ms)

**Ferramenta**: k6  
**Script**:
```javascript
// k6 script
import http from 'k6/http'
export default function () {
  const res = http.get('https://app.servsaude.com/api/guias?status=SOLICITADA&pageSize=20', {
    headers: { Authorization: `Bearer ${__ENV.TOKEN}` }
  })
  check(res, { 'status 200': r => r.status === 200, 'P95 < 500ms': r => r.timings.duration < 500 })
}
export const options = { vus: 100, duration: '2m' }
```
**Resultado esperado**: P95 < 500ms, P99 < 1000ms, zero erros HTTP 5xx  
**Status**: ___

---

### PERF-02 — Emissão simultânea de 50 guias

**Cenário**: 50 usuários (perfil prestador) submetendo guias ao mesmo tempo  
**Resultado esperado**: todas processadas em < 3s, sem deadlock no banco  
**Status**: ___

---

### PERF-03 — Dashboard financeiro com 200k lançamentos

**Ação**: GET `/api/relatorios/financeiro?competencia=2025-07` (agrega lançamentos do mês)  
**Resultado esperado**: resposta em < 2s (com cache Supabase/CDN para relatórios)  
**Status**: ___

---

### PERF-04 — AuditLog não degrada queries após 1M registros

**Pré-condição**: tabela `AuditLog` populada com 1M registros  
**Ação**: GET `/api/auditlog?usuarioId=XYZ&dataInicio=2025-01-01`  
**Resultado esperado**: < 200ms (índice composto em `usuarioId, criadoEm`)  
**Status**: ___

---

## 8. Testes de Segurança (SEC)

### SEC-01 — Campos sensíveis não retornados na API

**Ação**: GET `/api/conveniados/42`  
**Resultado esperado**: resposta NÃO contém `cpf` completo (mascarado: `***.***.789-09`), NÃO contém campo `fotoUrl` para outros perfis  
**Status**: ___

---

### SEC-02 — SQL Injection rejeitado

**Ação**: GET `/api/conveniados?cpf=1' OR '1'='1`  
**Resultado esperado**: HTTP 422 (validação Zod rejeita formato de CPF), zero queries não autorizadas executadas  
**Justificativa**: Prisma usa prepared statements — SQL injection impossível via ORM  
**Status**: ___

---

### SEC-03 — Headers de segurança presentes

**Ação**: GET em qualquer endpoint público  
**Resultado esperado**:
- `X-Content-Type-Options: nosniff`
- `X-Frame-Options: DENY`
- `Strict-Transport-Security: max-age=31536000`
- `Content-Security-Policy` configurado
- `X-Powered-By` ausente (não revelar stack)

**Status**: ___

---

## 9. Ambiente de Testes

| Ambiente | URL | Dados |
|---|---|---|
| **Unitário** | localhost (Vitest) | Mocks / banco de teste isolado |
| **Integração** | staging.servsaude.com | Cópia mascarada do banco legado |
| **Carga** | staging.servsaude.com | Dataset gerado com 500k guias sintéticas |
| **Segurança** | staging.servsaude.com | OWASP ZAP + manual |

### Dados de Teste

- CPF de teste válido: `529.982.247-25` (validador online)
- CNPJ de teste válido: `11.222.333/0001-81`
- Usuários de teste por perfil: criados via script `scripts/seed-test-users.ts`
- Guias de teste: geradas via `scripts/seed-guias.ts` (10k consultas, 2k exames, 500 internações)
