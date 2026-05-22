# Documentacao Final - ServSaude

## Como usar esta pasta

Esta pasta contem duas camadas complementares:

1. a serie final solicitada para apresentacao, de `01-introducao.md` a `16-conclusao.md`;
2. os documentos tecnicos anteriores, que aprofundam diagnostico, modelagem, riscos, testes, validacao, mockups, implantacao e fala da apresentacao.

## Serie final

| Ordem | Arquivo | Tema |
|---|---|---|
| 1 | `01-introducao.md` | contexto e objetivo |
| 2 | `02-sistema-legado.md` | apresentacao do legado |
| 3 | `03-diagnostico.md` | problemas e impactos |
| 4 | `04-setores.md` | setores envolvidos |
| 5 | `05-funcoes.md` | funcionalidades reais |
| 6 | `06-banco-legado.md` | banco, tabelas e modelagem |
| 7 | `07-dados-migracao.md` | dados criticos e tratamento |
| 8 | `08-arquitetura.md` | stack e arquitetura nova |
| 9 | `09-permissoes.md` | autenticacao, RBAC e auditoria |
| 10 | `10-migracao.md` | estrategia e fases |
| 11 | `11-riscos.md` | matriz resumida |
| 12 | `12-testes.md` | plano de testes |
| 13 | `13-validacao.md` | validacao e homologacao |
| 14 | `14-mockups.md` | prints e mockups |
| 15 | `15-implantacao.md` | go-live e suporte |
| 16 | `16-conclusao.md` | conclusao |
| Slides | `17-roteiro-slides.md` | topicos da apresentacao |

## Evidencias do projeto

- banco legado: `../servsaude_banco_completo.sql`;
- modelo alvo: `../prisma/schema.prisma`;
- MVP funcional: rotas em `../app`;
- acesso e Auth: `../lib/auth.ts`, `../lib/permissions.ts`, `../lib/supabase`;
- operacoes server-side: `../actions`.

## Documentos tecnicos de apoio

| Arquivo existente | Uso |
|---|---|
| `01-diagnostico.md` | identificacao profunda do legado |
| `02-problemas-legado.md` | problemas catalogados por severidade |
| `03-modelagem.md` | mapeamento legado para Prisma |
| `04-modulos.md` | regras e KPIs por modulo |
| `05-migracao.md` | fases e rollback detalhados |
| `06-riscos.md` | matriz estendida |
| `07-testes.md` | casos de teste detalhados |
| `08-validacao.md` | queries e checklists |
| `09-mockups.md` | mockups ASCII |
| `10-implantacao.md` | ambiente e checklist go-live |
| `11-apresentacao.md` | roteiro narrativo de slides |
