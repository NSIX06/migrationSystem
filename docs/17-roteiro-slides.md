# 17 - Roteiro de Slides

## Estrutura recomendada

| Slide | Tema | Mensagem central |
|---|---|---|
| 1 | Tema | Migracao do ServSaude baseada em banco real |
| 2 | Sistema legado | Operadora de saude com dominio assistencial e financeiro |
| 3 | Problemas encontrados | Integridade, seguranca, manutencao e operacao |
| 4 | Banco de dados | Tabelas principais, dados sensiveis e remapeamento |
| 5 | Setores | Atendimento, auditoria, financeiro, admin e credenciamento |
| 6 | Funcoes | Cadastros, guias, boletos, relatorios, logs e permisos |
| 7 | Nova arquitetura | Next.js, Prisma, Supabase e PostgreSQL |
| 8 | Seguranca | Auth, middleware, RBAC, audit log e secrets |
| 9 | Usuarios e permissoes | Profiles, roles e telas protegidas |
| 10 | Estrategia de migracao | Strangler Fig e fases |
| 11 | Riscos | matriz probabilidade x impacto |
| 12 | Testes | funcional, integridade, carga e seguranca |
| 13 | Validacao | contagens, totais, piloto e homologacao |
| 14 | Mockups | prints reais e telas alvo |
| 15 | Implantacao | backup, virada, monitoramento e suporte |
| 16 | Conclusao | beneficios e justificativa da modernizacao |

## Materiais por slide

- usar tabelas dos documentos finais como base de bullet points;
- incluir prints reais de `/login`, `/dashboard`, `/conveniados`, `/guias`, `/financeiro` e `/admin`;
- reservar um slide com exemplo de transformacao legado para Prisma;
- manter detalhes extensos de ETL, queries e checklist no PDF, nao no slide.

## Referencia ampliada

O roteiro narrativo com fala sugerida e apendice de perguntas permanece em `docs/11-apresentacao.md`.
