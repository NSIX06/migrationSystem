# 08 - Arquitetura

## Visao da nova solucao

O novo ServSaude adota aplicacao web full stack em Next.js com banco PostgreSQL gerenciado no Supabase. A escolha reduz dispersao de tecnologias no MVP e permite que renderizacao, autorizacao de rotas, Server Actions e acesso Prisma convivam em um projeto TypeScript.

## Frontend

| Tecnologia | Uso no repositorio |
|---|---|
| Next.js App Router | rotas em `app/` e layouts autenticados |
| React | componentes de tela e formularios |
| TypeScript | tipagem de paginas, actions e dados |
| Tailwind CSS | composicao visual utilitaria |
| Shadcn/ui | componentes base como card, button, badge, input e table |

As telas implementadas priorizam interface operacional: sidebar por permissao, cards de indicador, tabelas filtraveis, detalhes e formularios administrativos.

## Backend

- Server Actions para login, usuarios, perfis e autorizacao de guias.
- Server Components para consultas Prisma em dashboards, listagens e detalhes.
- Route handler de callback Auth.
- Prisma ORM como camada de modelo e migrations.

O projeto pode incorporar API Routes quando integracoes externas exigirem endpoint proprio, por exemplo retorno bancario, importacao assíncrona ou webhooks.

## Banco de dados

O schema novo usa Supabase PostgreSQL e Prisma:

- `DATABASE_URL` para runtime configurado;
- `DIRECT_URL` para conexao direta/migrations;
- `schema.prisma` com modelos mapeados e enums;
- migrations versionadas em `prisma/migrations`.

## Seguranca

| Camada | Implementacao |
|---|---|
| Autenticacao | Supabase Auth por email/senha |
| Sessao SSR | clientes Supabase em `lib/supabase` |
| Protecao de rota | middleware e layout autenticado |
| Autorizacao | `getCurrentUser`, `can`, roles e permissoes |
| Administracao Auth | cliente server-side com service role |
| Auditoria | `AuditLog` para operacoes relevantes |

## Fluxo resumido

```text
Usuario -> Next.js middleware -> Supabase Auth
        -> layout/dashboard -> Profile + permissoes
        -> Server Component/Action -> Prisma -> PostgreSQL
        -> AuditLog quando a operacao altera estado relevante
```

## Delimitacao do MVP e arquitetura alvo

O MVP ja cobre modulos de painel, consulta e administracao. O schema alvo e mais amplo que as telas prontas e preserva financeiro completo, boletos, tabelas medicas, contratos, credenciamento, documentos e mensagens para evolucao incremental.
