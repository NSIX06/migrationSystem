# 14 - Mockups e Prints

## Catalogo de telas para apresentacao

| Tela | Objetivo | Funcionalidade a demonstrar |
|---|---|---|
| Login | iniciar sessao segura | email/senha, erro e redirecionamento |
| Dashboard | visao operacional | beneficiarios ativos, guias pendentes e financeiro |
| Usuarios | administracao | lista, filtros, status e cadastro |
| Perfis/permissoes | RBAC | permissoes por modulo |
| Beneficiarios | atendimento | busca, lista e detalhe de adesoes |
| Prestadores | rede assistencial | lista, classificacao e detalhe |
| Guias | autorizacao | fila, status, detalhe e decisao |
| Financeiro | cobranca | lancamentos e agregados |
| Relatorios | gestao | indicadores por modulo |
| Analytics | decisao gerencial | KPIs de guias, beneficiarios e financeiro |
| Logs | auditoria | trilha administrativa |

## Prints recomendados

Capturar no ambiente local as rotas ja implementadas:

```text
/login
/dashboard
/admin/usuarios
/admin/usuarios/novo
/admin/perfis
/admin/logs
/conveniados
/guias
/financeiro
/relatorios
```

## Descricoes para legenda

### Login

Tela de entrada que evidencia a separacao entre autenticacao Supabase e acesso ao dominio interno.

### Dashboard

Resume demandas imediatas: total de beneficiarios ativos, guias solicitadas e valor financeiro em aberto.

### Beneficiarios

Exibe consulta operacional com nome, CPF, plano, matricula, status e data de cadastro; o detalhe mostra dados pessoais e adesoes.

### Usuarios e permissoes

Mostra como administracao cria contas, define tipo de usuario e vincula perfil de acesso.

### Guias e financeiro

Relacionam o fluxo assistencial ao impacto financeiro, mostrando que a migracao cobre transacao e nao apenas cadastro.

## Mockups adicionais

O arquivo `docs/09-mockups.md` contem mockups ASCII detalhados para login, dashboard, lista/detalhe de beneficiario, emissao e fila de guias e relatorio financeiro. Para defesa, usar prints reais do MVP junto desses mockups para telas ainda em evolucao.
