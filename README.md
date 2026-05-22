# ServSaude - Documentacao Final de Migracao

## Sumario

1. [Introducao](#1-introducao)
2. [Sistema legado](#2-sistema-legado)
3. [Diagnostico](#3-diagnostico)
4. [Setores envolvidos](#4-setores-envolvidos)
5. [Funcoes do sistema](#5-funcoes-do-sistema)
6. [Banco de dados legado](#6-banco-de-dados-legado)
7. [Dados que precisam ser migrados](#7-dados-que-precisam-ser-migrados)
8. [Nova arquitetura](#8-nova-arquitetura)
9. [Usuarios e permissoes](#9-usuarios-e-permissoes)
10. [Estrategia de migracao](#10-estrategia-de-migracao)
11. [Riscos](#11-riscos)
12. [Testes obrigatorios](#12-testes-obrigatorios)
13. [Validacao de dados](#13-validacao-de-dados)
14. [Mockups e prints](#14-mockups-e-prints)
15. [Plano de implantacao](#15-plano-de-implantacao)
16. [Conclusao](#16-conclusao)
17. [Roteiro de slides](#17-roteiro-de-slides)
18. [Tecnologias utilizadas](#tecnologias-utilizadas)

## Evidencias usadas

Esta documentacao nao foi produzida a partir de um modelo generico. Ela usa como base:

- banco legado real em `servsaude_banco_completo.sql`;
- schema alvo em `prisma/schema.prisma`;
- seed de roles, permissoes e dados de demonstracao em `prisma/seed.ts`;
- aplicacao Next.js em `app/`, `actions/`, `components/` e `lib/`;
- documentos tecnicos de apoio mantidos em `docs/`.

O dump legado evidencia dominio de saude suplementar com beneficiarios, adesoes, prestadores, guias, tabelas medicas, boletos, lancamentos, contratos, credenciamento, logs e seguranca legada.

# Tecnologias Utilizadas

## Visao geral da stack

O ServSaude foi reestruturado como uma aplicacao web full stack em TypeScript. A stack concentra interface, rotas, renderizacao server-side, actions de escrita, autenticacao e acesso ao banco em um projeto Next.js, mantendo o dominio persistente em PostgreSQL por meio do Prisma.

| Camada | Tecnologia principal | Responsabilidade no ServSaude |
|---|---|---|
| Aplicacao web | Next.js 15 + React 19 | rotas, layouts, renderizacao e composicao da UI |
| Linguagem | TypeScript | tipagem do codigo, forms, actions, paginas e dados |
| UI | Tailwind CSS + componentes shadcn/ui | layout administrativo, tabelas, cards, badges e formularios |
| Formularios e validacao | forms HTML, React Actions, Zod; React Hook Form instalado | envio server-side, feedback de estado e schemas de entrada |
| Backend | Server Components, Server Actions e Route Handlers | leitura Prisma, mutacoes e callback Auth |
| Banco | Supabase PostgreSQL | persistencia relacional do dominio migrado |
| ORM | Prisma ORM | schema, relations, queries, migrations e seed |
| Auth | Supabase Auth + `@supabase/ssr` | login, sessao baseada em cookies e gerenciamento admin |
| Seguranca | middleware, RBAC e AuditLog | protecao de rotas, permissoes e rastreabilidade |
| Ferramentas | npm, Prisma CLI, TypeScript, ESLint, Vitest, PostCSS | execucao, build, validacao e testes |

O desenho e adequado a um sistema administrativo porque dados sensiveis e consultas Prisma permanecem no servidor sempre que a tela nao precisa de interatividade de navegador.

## Frontend

### Next.js

Next.js e o framework React utilizado para construir a aplicacao full stack. No ServSaude ele aparece na organizacao `app/`, nas paginas `page.tsx`, nos layouts, nos segmentos de rota `(auth)` e `(dashboard)` e no Route Handler `app/auth/callback/route.ts`.

O projeto usa o **App Router**, roteamento baseado em arquivos que permite compor paginas, layouts, rotas dinamicas e handlers dentro de `app/`. As paginas do dashboard sao Server Components por padrao: elas podem consultar Prisma e Supabase no servidor antes de enviar a interface ao navegador. Formularios e controles interativos sao Client Components quando usam `"use client"`, como os formularios de login, cadastro de usuarios, permissoes e autorizacao de guias.

| Recurso | Como aparece no projeto | Beneficio |
|---|---|---|
| App Router | `app/(dashboard)/...` e `app/(auth)/...` | separa fluxos autenticados e publicos |
| Layouts | `app/layout.tsx` e `app/(dashboard)/layout.tsx` | aplica shell, sidebar e protecao comum |
| Server Components | dashboard, listagens e detalhes | consultas server-side sem expor banco ao browser |
| Client Components | forms em `components/servsaude` | estado de submissao e feedback interativo |
| SSR/renderizacao hibrida | paginas autenticadas carregadas no servidor | dados atualizados e menor logica sensivel no cliente |
| Route Handler | callback Auth | endpoint server-side dentro do App Router |

Next.js foi escolhido porque reduz a separacao artificial entre frontend e backend no MVP, permite renderizacao hibrida e organiza o crescimento modular do sistema por rotas.

### React

React fornece a camada de componentizacao. A UI do projeto e montada com componentes reutilizaveis como `Button`, `Card`, `Badge`, `Input`, `Table`, sidebar, formularios e blocos de informacao. Essa composicao evita duplicar markup e torna interfaces administrativas extensas mais consistentes.

Hooks e Actions do ecossistema React aparecem em componentes client-side com `useActionState`, usado para exibir estados de envio, erros e sucesso em login, usuarios, permissoes e guias. Para um sistema corporativo isso melhora previsibilidade visual e permite evoluir telas sem reescrever a estrutura inteira.

### TypeScript

TypeScript adiciona tipagem ao JavaScript. No ServSaude ele tipa parametros de rota, props dos componentes, retorno de actions, estados de formulario e uso do Prisma Client gerado. Isso reduz erros comuns em campos financeiros, IDs `bigint`, enums de status e objetos retornados pelo banco.

Os beneficios no projeto sao:

- autocomplete e navegacao de codigo mais confiaveis;
- verificacao com `npm run type-check`;
- maior seguranca ao remodelar tabelas e paginas;
- melhor manutencao para dupla, banca e equipe futura.

### Tailwind CSS

Tailwind CSS e o framework de estilos utility-first usado nas classes dos componentes e paginas. Classes como grid, espacamento, estados de hover, cores, bordas e responsividade ficam proximas do markup da UI.

No ServSaude ele acelera telas operacionais: filtros, tabelas, formularios, cards de KPI, sidebar e detalhe de registros compartilham uma linguagem visual previsivel. A configuracao reside em `tailwind.config.ts`, `postcss.config.mjs` e `app/globals.css`.

### shadcn/ui, Radix UI e utilitarios visuais

O projeto utiliza componentes no estilo shadcn/ui copiados para `components/ui/` e configurados por `components.json`. Esses componentes ficam no codigo do projeto, permitindo customizacao visual sem depender de uma caixa-preta.

Radix UI fornece primitives usadas por componentes como label, select, dialog, sheet, separator, tooltip, tabs e dropdown. `class-variance-authority`, `clsx` e `tailwind-merge` ajudam a combinar variantes e classes Tailwind; `lucide-react` fornece icones usados em botoes, menus e indicadores.

### React Hook Form

`react-hook-form` e `@hookform/resolvers` estao instalados para formularios complexos e integracao com schemas. Essa biblioteca e adequada quando uma tela precisa controlar muitos campos, reduzir rerenders e compartilhar validacao com Zod.

No estado atual do ServSaude, os formularios implementados priorizam forms HTML enviados para Server Actions e estado de submissao via `useActionState`. Portanto React Hook Form e uma capacidade disponivel para evolucao de cadastros extensos, nao a base obrigatoria de todos os formularios ja entregues.

### Zod

Zod e a biblioteca de validacao de schemas usada nas Server Actions. Arquivos como `actions/auth.ts`, `actions/usuarios.ts` e `actions/guias.ts` definem schemas para login, criacao/edicao de usuario e decisao de guia.

O uso de Zod protege a fronteira de entrada do servidor: o formulario pode ser manipulado pelo navegador, mas a action valida tipos, obrigatoriedade e formatos antes de gravar no Supabase Auth ou PostgreSQL. A proximidade com TypeScript torna as regras de entrada mais legiveis e menos sujeitas a divergencia.

# Backend

## Next.js Server Actions

Server Actions sao funcoes executadas no servidor para tratar mutacoes. No projeto elas vivem em `actions/` e sao marcadas com `"use server"`.

| Action | Responsabilidade |
|---|---|
| `actions/auth.ts` | login e logout |
| `actions/usuarios.ts` | criar, editar, ativar, inativar e excluir logicamente usuarios |
| `actions/perfis.ts` | atualizar permissoes de roles |
| `actions/guias.ts` | autorizar e negar guias |

Essa abordagem integra formularios React ao backend sem criar um endpoint REST para cada botao do MVP. A validacao roda no servidor, o Prisma nao e exposto ao cliente e caminhos alterados podem ser revalidados apos mutacoes.

## Route Handlers e API Routes

No App Router, endpoints customizados sao implementados por arquivos `route.ts`. O projeto ja usa esse padrao em `app/auth/callback/route.ts` para concluir o fluxo de callback do Supabase Auth.

Para integracoes futuras, Route Handlers podem receber webhooks, retornos bancarios, importacoes TISS, APIs externas e respostas nao-UI. O README usa o termo API Routes como conceito de endpoints backend; no App Router deste projeto o mecanismo correto e o **Route Handler**.

# Banco de Dados

## Supabase PostgreSQL

O banco alvo e PostgreSQL hospedado no Supabase. PostgreSQL preserva relacoes, constraints, indices, transacoes, tipos e integridade necessarios a dominios com beneficiarios, guias, prestadores e financeiro.

Supabase foi escolhido porque combina banco PostgreSQL gerenciado com Auth e recursos de plataforma que podem ser usados conforme o sistema cresce, como storage para anexos/documentos e recursos realtime quando houver caso operacional validado. No projeto atual, a aplicacao ja usa Supabase Auth e PostgreSQL; storage e realtime aparecem como direcao arquitetural para modulos documentais e filas.

## Prisma ORM

Prisma e o ORM que conecta o codigo TypeScript ao PostgreSQL. Ele fornece Prisma Client tipado, sistema de migrations e ferramentas de desenvolvimento.

| Artefato | Papel no projeto |
|---|---|
| `prisma/schema.prisma` | modelos, enums, relations, datasource e generator |
| `prisma/migrations/` | historico de mudancas de schema |
| `lib/prisma.ts` | singleton do Prisma Client usado no servidor |
| `prisma/seed.ts` | dados iniciais e demonstracao |

O Prisma ajuda a expressar relacoes do modelo migrado, reduz SQL manual em paginas comuns e aproxima schema, queries e tipos. `prisma generate` gera o cliente conforme o schema; migrations aplicam evolucao do banco; seed prepara roles, permissoes e dados necessarios para desenvolvimento/homologacao.

# Autenticação e Segurança

## Supabase Auth

Supabase Auth gerencia identidade, login e sessoes. O projeto usa clientes SSR em `lib/supabase/server.ts`, cliente de navegador em `lib/supabase/client.ts` e middleware em `lib/supabase/middleware.ts`.

O Auth trabalha separado do dominio interno: existir no Auth nao basta para acessar menus. O usuario precisa de `Profile` e role no banco do sistema. Operacoes administrativas de Auth, como criar usuario, usam um cliente server-side com `SUPABASE_SERVICE_ROLE_KEY`, nunca a chave publica.

## Middleware

`middleware.ts` chama a rotina Supabase que atualiza a sessao e redireciona usuarios sem autenticacao para `/login`. O layout do dashboard reforca essa protecao ao consultar o usuario e seu profile antes de renderizar a area autenticada.

## Controle de permissoes

O ServSaude implementa RBAC:

- `Role` representa perfis;
- `Permissao` representa acao por modulo;
- `RolePermissao` define permissoes do perfil;
- `UsuarioRole` vincula profile a perfil;
- `PermissaoUsuario` aplica excecoes individuais.

O sidebar filtra modulos por permissao e as Server Actions/paginas sensiveis checam autorizacao no servidor com `can(actor, slug)`. Assim, menu oculto e rota protegida trabalham em conjunto.

## Logs e auditoria

O modelo `AuditLog` registra operacoes relevantes, especialmente administracao de usuarios e alteracoes de workflow. Para o dominio de saude e financeiro, logs apoiam investigacao, conformidade, responsabilizacao e validacao pos-migracao.

# Interface e Experiência do Usuário

## UX administrativa

A interface prioriza leitura rapida e trabalho repetitivo:

- sidebar com modulos liberados por permissao;
- dashboard com cards de indicadores e fila resumida;
- listagens tabulares para beneficiarios, prestadores, guias, financeiro e usuarios;
- formularios com feedback de erro/sucesso;
- badges de status para leitura operacional;
- botoes e icones coerentes por acao.

## Responsividade, feedback e acessibilidade

Tailwind e os components UI permitem grades responsivas, espacos consistentes e estados de hover/focus. Os componentes base apoiados em Radix e labels apropriados favorecem acessibilidade, enquanto estados `pending`, alertas de erro e redirecionamentos tornam o fluxo mais claro para o usuario.

# Arquitetura do Projeto

## Separacao de responsabilidades

| Area | Responsabilidade |
|---|---|
| `app/` | rotas, layouts, paginas e route handlers |
| `components/ui/` | componentes visuais reutilizaveis |
| `components/servsaude/` | componentes de dominio e formularios |
| `actions/` | mutacoes server-side e validacao de entrada |
| `lib/` | Prisma, Auth, permissoes, Supabase e utilitarios |
| `prisma/` | schema, migrations e seed |
| `middleware.ts` | protecao de sessao antes das rotas |
| `docs/` | documentacao tecnica e academica |

O projeto nao usa uma pasta `src/` no estado atual. Tambem nao existem hoje pastas `services/`, `hooks/` ou `types/` separadas; caso o codigo cresca, elas podem ser introduzidas para integrações externas, hooks client-side compartilhados e contratos de tipos que nao pertençam ao Prisma ou as paginas.

## Estrutura de pastas

```text
migrationSystem/
  actions/
    auth.ts
    guias.ts
    perfis.ts
    usuarios.ts
  app/
    (auth)/
    (dashboard)/
    auth/callback/route.ts
    acesso-negado/
    globals.css
    layout.tsx
  components/
    servsaude/
    ui/
  docs/
  lib/
    supabase/
    auth.ts
    permissions.ts
    prisma.ts
    utils.ts
  prisma/
    migrations/
    schema.prisma
    seed.ts
  middleware.ts
  next.config.ts
  tailwind.config.ts
  package.json
```

### Estrutura alvo quando houver `src/`

Caso a equipe adote `src/` no futuro, a equivalencia recomendada e:

```text
src/
  app/         # rotas e layouts
  components/  # UI e componentes de dominio
  services/    # clientes/integracoes externas
  lib/         # utilitarios e infraestrutura
  actions/     # Server Actions
  hooks/       # hooks compartilhados de Client Components
  types/       # contratos independentes do Prisma
prisma/        # schema, migrations e seed
```

# Variáveis de Ambiente

| Variavel | Escopo | Funcao e cuidado |
|---|---|---|
| `DATABASE_URL` | servidor/Prisma | conexao runtime PostgreSQL; nunca expor no frontend |
| `DIRECT_URL` | servidor/Prisma CLI | conexao direta usada para migrations e desenvolvimento conforme configuracao |
| `NEXT_PUBLIC_SUPABASE_URL` | publico | URL do projeto Supabase usada pelos clientes |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | publico | chave publica para fluxos autorizados pelo Supabase |
| `SUPABASE_SERVICE_ROLE_KEY` | somente servidor | operacoes admin; nao deve ir para navegador, log ou repositorio |

O prefixo `NEXT_PUBLIC_` indica variaveis que podem chegar ao bundle do navegador. Segredos, senhas de banco e service role devem permanecer no ambiente server-side e em arquivos ignorados pelo Git.

# Scripts do Projeto

| Comando | Funcao |
|---|---|
| `npm install` | instala dependencias do projeto |
| `npm run dev` | inicia Next.js em desenvolvimento com Turbopack |
| `npm run build` | gera build de producao |
| `npm run start` | serve o build produzido |
| `npm run type-check` | valida tipos TypeScript sem emitir arquivos |
| `npm run test` | executa testes Vitest configurados |
| `npm run lint` | executa verificacao ESLint/Next |
| `npm run db:generate` ou `npx prisma generate` | gera Prisma Client a partir do schema |
| `npm run db:migrate` ou `npx prisma migrate dev` | cria/aplica migrations em desenvolvimento |
| `npm run db:migrate:deploy` | aplica migrations em ambiente implantado |
| `npm run db:seed` ou `npx prisma db seed` | executa seed configurado do Prisma |
| `npm run db:studio` | abre Prisma Studio local |

# Deploy

## Publicacao

A documentacao de implantacao propoe Vercel para executar o frontend/backend Next.js e Supabase para PostgreSQL/Auth. Em producao, deploy exige:

1. build validado;
2. migrations aplicadas no banco correto;
3. variaveis de ambiente configuradas na plataforma;
4. chaves publicas e secrets separados;
5. smoke test em login, dashboard, guias e administracao.

## CI/CD basico

Um pipeline basico deve instalar dependencias, validar tipos/testes, executar build, aplicar migrations controladas e publicar somente quando as variaveis de ambiente e o banco alvo estiverem corretos. Migrations destrutivas exigem revisao e plano de rollback.

# Benefícios da Stack

| Beneficio | Razao |
|---|---|
| Performance | renderizacao server-side e consultas Prisma no servidor |
| Escalabilidade | App Router modular e PostgreSQL gerenciado |
| Seguranca | Auth, cookies SSR, RBAC, service role isolada e AuditLog |
| Produtividade | TypeScript, Prisma Client, Tailwind e componentes reutilizaveis |
| Manutencao | schema explicito, migrations e separacao por pastas |
| UX | dashboard, tabelas, feedback visual e consistencia de UI |
| Evolucao | Route Handlers, storage, integrações e modulos adicionais |

# Conclusão Técnica

A stack foi escolhida para modernizar um sistema de dominio sensivel sem dispersar responsabilidades em varias bases desconectadas. Next.js e React entregam a interface e os fluxos server-side; TypeScript e Zod reforcam confiabilidade; Prisma e PostgreSQL organizam o modelo relacional; Supabase oferece identidade e infraestrutura adequada ao crescimento do sistema.

Essa arquitetura torna o ServSaude mais compreensivel para onboarding, mais seguro para operacao administrativa e mais preparado para evoluir de MVP de migracao para plataforma com modulos financeiros, assistenciais e documentais completos.

## 1. Introducao

### Objetivo do trabalho

O projeto documenta a migracao do sistema ServSaude para uma arquitetura moderna. O objetivo academico e demonstrar analise de legado, diagnostico, modelagem, migracao, validacao, testes e implantacao a partir de evidencias reais. O objetivo tecnico e preservar dados assistenciais, cadastrais e financeiros enquanto se reduz risco de manutencao, seguranca e operacao.

### Contexto

O ServSaude atende processos de operadora de plano de saude. O banco possui dados pessoais como CPF, RG, CNS, contatos e fotos; dados assistenciais como guias, CID, anexos e auditoria; e dados financeiros como mensalidades, boletos, verbas, remessas e lotes de pagamento.

| Dimensao | Evidencia no banco | Consequencia |
|---|---|---|
| Cadastral | `conveniados`, `adesoes`, `empresas` | busca e vinculo precisam permanecer integros |
| Assistencial | `guias`, itens, historico e auditoria | decisao medica deve ser rastreavel |
| Financeira | `lancamentos`, `boletos`, `mensalidades` | valores exigem conciliacao precisa |
| Contratual | produtos, precos e contratos | regras nao podem se perder no ETL |

### Motivacao

A migracao nao se limita a trocar tecnologia. Ela corrige acoplamento com estruturas legadas, padroes de dados pouco expressivos, relacionamentos genericos, exposicao de segredos operacionais e custo alto de evolucao.

## 2. Sistema legado

### Apresentacao

O ServSaude gerencia o ciclo entre operadora, empresas conveniadas, beneficiarios e prestadores. O banco legado mostra uma aplicacao PHP/Laravel ao lado de tabelas de negocio. Estruturas como `users`, `roles`, `permissions`, `role_user`, `permission_role`, `failed_jobs`, `migrations`, `menus` e `personal_access_tokens` convivem com dados assistenciais.

### Areas atendidas

- cadastro de beneficiarios e adesoes;
- prestadores, especialidades e contratos;
- produtos, precos e coparticipacao;
- autorizacao e auditoria de guias;
- tabelas CID, CBHPM, Brasindice, materiais, medicamentos e taxas;
- boletos, mensalidades, lancamentos e lotes;
- credenciamento e documentos.

### Usuarios

| Ator | Uso principal |
|---|---|
| Administracao | usuarios, parametros, produtos, seguranca e logs |
| Atendimento | beneficiarios e consultas operacionais |
| Autorizacao/Auditoria | guias, historicos, anexos e decisoes |
| Financeiro | boletos, mensalidades, lancamentos e lotes |
| Credenciamento | editais, documentos e solicitacoes |
| Prestador | guias, contratos e pagamentos no desenho alvo |
| Beneficiario | dados proprios, guias e cobrancas no desenho alvo |

### Modulos reais identificados

1. Beneficiarios e adesoes.
2. Prestadores de saude.
3. Produtos e planos.
4. Autorizações medicas e guias.
5. Financeiro.
6. Tabelas medicas.
7. Credenciamento.
8. Administracao e seguranca.

## 3. Diagnostico

### Problemas tecnicos

| Problema | Evidencia | Impacto |
|---|---|---|
| Acoplamento ao framework | tabelas tecnicas Laravel no schema | dificulta migracao de dominio |
| Relacoes genericas | origens polimorficas no legado | risco de orfaos e ETL ambíguo |
| Status pouco expressivos | codigos e tipos antigos | regra escondida no codigo |
| Soft delete irregular | uso heterogeneo de exclusao logica | consultas divergentes |
| Tabelas densas | guias e itens com muitos cenarios | manutencao e UX complexas |

### Problemas de seguranca

- dados pessoais, assistenciais e bancarios coexistem no mesmo dominio;
- credenciais operacionais precisam sair de tabelas comuns;
- o legado usa modelo de roles/tokens antigo;
- nao ha evidencia no dump de politica PostgreSQL RLS aplicada ao legado;
- anexos e documentos exigem armazenamento privado e controle de acesso.

### Logs e dashboard

O legado possui `log_acessos` e `log_operacoes`; o problema e a auditoria fragmentada. O modelo novo adota `AuditLog` para operacoes relevantes. O MVP tambem introduz dashboard com total de beneficiarios ativos, guias pendentes e financeiro em aberto.

### Performance e pico

Pontos criticos sao fila de autorizacao, importacao TISS, fechamento financeiro, emissao/baixa de boletos e relatorios sobre historico. A migracao deve validar latencia e estabilidade em volume, nao apenas telas abertas.

## 4. Setores envolvidos

| Setor | Responsabilidade | Importancia na migracao |
|---|---|---|
| Atendimento/Cadastro | consultar beneficiarios e adesoes | valida busca e cadastro operacional |
| Autorizacao/Auditoria | analisar guias e itens | valida workflow, historico e justificativa |
| Financeiro | cobranca e pagamento | valida totais, boleto e lote |
| Administracao/TI | acesso, ambiente e auditoria | valida Auth, roles, backup e rollback |
| Credenciamento | documentos e prestadores | valida solicitacoes e storage |

## 5. Funcoes do sistema

| Funcao | Objetivo | Melhoria nova |
|---|---|---|
| Login | autenticar sessao | Supabase Auth e middleware |
| Usuarios | criar e gerir contas | Server Actions e profile/role |
| Permissoes | controlar telas e acoes | RBAC por modulo |
| Beneficiarios | cadastro e consulta | listagem, filtros e detalhe |
| Adesoes | vincular plano e vigencia | relacoes tipadas |
| Prestadores | manter rede assistencial | detalhe e contratos no schema |
| Guias | emitir e autorizar | workflow e historico |
| Auditoria | revisar itens | estrutura propria |
| Importacao TISS | processar lotes | entidade de importacao |
| Financeiro | lancamentos | agregacoes e filtros |
| Boletos | cobranca | secrets fora do dominio |
| Pagamento | lotes de prestador | rastreabilidade |
| Relatorios | apoio gerencial | consultas consolidadas |
| Logs | auditoria | `AuditLog` |
| Credenciamento | entrada de prestador | documentos e historico |
| Parametros | configuracao | controle administrativo |

### Funcionalidades ja visiveis no MVP

```text
/login
/dashboard
/conveniados
/prestadores
/guias
/financeiro
/relatorios
/admin
/admin/usuarios
/admin/perfis
/admin/logs
```

## 6. Banco de dados legado

### Tabelas principais

| Grupo | Tabelas representativas |
|---|---|
| Beneficiarios | `conveniados`, `adesoes`, `conveniado_salarios`, `gestantes` |
| Prestadores | `prestadores`, contratos, especialidades e classificacoes |
| Guias | `guias`, `guias_itens`, historico, auditoria e anexos |
| Financeiro | `lancamentos`, `boletos`, `mensalidades`, lotes e remessas |
| Produtos | `produtos`, `produtos_precos`, coparticipacao |
| Referencias | CID, CBHPM, procedimentos, materiais e medicamentos |
| Credenciamento | editais, documentos, solicitacoes e historicos |
| Seguranca | users, roles, permissions e pivots |

### Dados sensiveis

| Dado | Tratamento alvo |
|---|---|
| CPF, RG e CNS | minimizacao e mascaramento em listagens |
| Dados bancarios | acesso restrito |
| Anexos assistenciais | storage privado |
| Segredos de integracao | variaveis/secret manager |

### Reaproveitamento e descarte

| Tratamento | Exemplos |
|---|---|
| Reaproveitar | beneficiarios, adesoes, guias, financeiro, prestadores e tabelas medicas |
| Normalizar | users para Supabase Auth + `Profile`; permissoes para RBAC novo |
| Remodelar | origens polimorficas para FKs explicitas quando aplicavel |
| Descartar do dominio | `failed_jobs`, `migrations`, `menus`, `personal_access_tokens` |

### Relacoes do modelo alvo

| Relacao | Significado |
|---|---|
| `Conveniado -> Adesao -> Produto` | beneficiario inscrito em plano |
| `Adesao -> Empresa/Secretaria` | vinculo coletivo |
| `Prestador -> Contrato -> Item` | rede e precificacao |
| `Guia -> GuiaItem -> Historico/Auditoria` | autorizacao rastreavel |
| `Guia -> Lancamento` | impacto financeiro |
| `Profile -> Role -> Permissao` | autorizacao interna |

## 7. Dados que precisam ser migrados

| Classe | Dados | Regra |
|---|---|---|
| Criticos cadastrais | beneficiarios, adesoes, produtos, prestadores | migrar antes do nucleo |
| Criticos assistenciais | guias, itens, historicos, anexos | preservar status e vinculos |
| Criticos financeiros | lancamentos, boletos, mensalidades, lotes | validar valores |
| Referencia | CID, CBHPM, procedimentos, bancos | carregar previamente |
| Acesso | usuarios, profiles e roles | transformar para Auth + RBAC |
| Historicos | logs e solicitacoes | migrar ou arquivar por politica |

### Ordem de carga

1. referencias geograficas e medicas;
2. operadora, empresas, secretarias, cargos, produtos e precos;
3. Auth, profiles, roles e permissoes;
4. beneficiarios, adesoes, prestadores e contratos;
5. guias, itens e historicos;
6. financeiro;
7. credenciamento e documentos.

## 8. Nova arquitetura

### Frontend

- Next.js App Router;
- React;
- TypeScript;
- Tailwind CSS;
- componentes Shadcn/ui.

### Backend

- Next.js Server Actions;
- Server Components para leitura segura;
- Route handlers quando integracoes exigirem endpoint;
- Prisma ORM.

### Banco

- Supabase PostgreSQL;
- Prisma Schema;
- Prisma Migrations;
- `DATABASE_URL` e `DIRECT_URL` configuradas por ambiente.

### Seguranca

- Supabase Auth;
- middleware de sessao;
- layout autenticado;
- RBAC com roles e permissoes;
- cliente admin Supabase restrito ao servidor;
- logs de auditoria.

```text
Usuario -> Middleware -> Supabase Auth
        -> Profile + Permissoes
        -> Server Component/Action
        -> Prisma -> PostgreSQL
```

## 9. Usuarios e permissoes

### Modelo

Uma identidade autenticada precisa de registro de aplicacao:

1. Supabase Auth autentica;
2. `Profile` guarda nome, email, tipo e status;
3. `UsuarioRole` vincula profile a `Role`;
4. `RolePermissao` define acoes;
5. `PermissaoUsuario` permite excecoes.

### Perfis

| Perfil | Acesso caracteristico |
|---|---|
| Administrador | acesso total |
| Gestor | operacao e gestao |
| Atendimento | beneficiarios, guias e documentos |
| Financeiro | lancamentos, boletos e relatorios |
| Auditoria | guias, prestadores, relatorios e logs |
| Credenciamento | rede e documentos |
| Beneficiario | dados proprios no portal alvo |
| Prestador | operacoes proprias no portal alvo |
| Visualizador | leitura ampla |

### Protecao

Menus usam permissoes como `beneficiarios.view`, `guias.view`, `financeiro.view` e `settings.view`. Paginas administrativas e Server Actions checam `can(actor, slug)` no servidor.

## 10. Estrategia de migracao

### Escolha

A estrategia recomendada e gradual, no padrao Strangler Fig. Big Bang ampliaria risco em autorizacao medica, financeiro e Auth.

| Fase | Conteudo | Criterio |
|---|---|---|
| 0 | ambiente, backup, schema e scripts | base pronta |
| 1 | referencias | contagens e integridade |
| 2 | acesso | login e RBAC |
| 3 | cadastros | consultas setoriais |
| 4 | guias e financeiro | totais e workflow |
| 5 | virada | smoke test e suporte |

### Rollback

Manter legado como fonte de verdade ate aceite da fase. Preservar backup, carga delta e plano de retorno de trafego.

## 11. Riscos

| Risco | Impacto | Probabilidade | Mitigacao |
|---|---|---|---|
| Perda de dados | Muito alto | Media | backup e conciliacao |
| Indisponibilidade | Alto | Media | janela e rollback |
| Relacoes inconsistentes | Alto | Alta | validacao FK/orfaos |
| Falha Auth | Alto | Media | piloto com profiles e roles |
| Permissoes erradas | Alto | Media | matriz RBAC |
| Falha bancaria | Alto | Media | sandbox e secrets |
| Lentidao | Alto | Media | indices e carga |
| TISS invalido | Medio | Media | validacao por lote |
| Exposicao LGPD | Muito alto | Baixa/Media | acesso minimo e storage privado |

## 12. Testes obrigatorios

| Categoria | Objetivo | Resultado esperado |
|---|---|---|
| Funcional | abrir fluxos reais | operacao correta |
| Login | sessao valida/invalida | protecao de rota |
| Permissao | perfis por tela | acesso minimo |
| CRUD | criar/editar/inativar | persistencia auditavel |
| Dashboard | comparar KPIs | totais coerentes |
| Relatorios | filtros e soma | reproducibilidade |
| Carga | volume critico | latencia aceitavel |
| Backup/restauracao | recuperar ambiente | copia utilizavel |
| Seguranca | dados e rotas | sem exposicao indevida |
| Integridade | FK, enum e orfaos | zero bloqueante |

## 13. Validacao de dados

### Validacoes

- contagem legado x novo;
- soma financeira por competencia e status;
- relacionamentos de guia, beneficiario, prestador e lancamento;
- enums convertidos;
- profiles e roles;
- documentos e anexos;
- amostra homologada por setor.

### Piloto

Executar piloto com operadora, beneficiarios em status diferentes, prestadores PF/PJ, guias variadas, financeiro aberto/pago/cancelado e usuarios de varios setores.

## 14. Mockups e prints

### Telas para apresentacao

| Tela | Objetivo |
|---|---|
| Login | mostrar autenticacao |
| Dashboard | mostrar KPIs |
| Usuarios | mostrar administracao |
| Perfis/permissoes | mostrar RBAC |
| Beneficiarios | mostrar consulta e detalhe |
| Guias | mostrar workflow |
| Financeiro | mostrar lancamentos |
| Relatorios/analytics | mostrar decisao |
| Logs | mostrar auditoria |

### Rotas para prints reais

```text
/login
/dashboard
/admin/usuarios
/admin/usuarios/novo
/admin/perfis
/admin/logs
/conveniados
/prestadores
/guias
/financeiro
/relatorios
```

## 15. Plano de implantacao

1. preparar ambientes, migrations e secrets;
2. gerar backup e testar restauracao;
3. executar ETL por dependencia;
4. homologar por setor;
5. treinar usuarios;
6. congelar janela critica e executar delta;
7. liberar virada;
8. monitorar Auth, Prisma, guias, financeiro e acessos negados;
9. manter suporte pos-go-live.

## 16. Conclusao

O projeto mostra que migrar o ServSaude exige preservar dominio real e corrigir base tecnica. O banco legado contem regras valiosas, mas sua evolucao fica mais segura com PostgreSQL, Prisma, Next.js, Supabase Auth, RBAC, logs, validacao e migracao gradual.

| Beneficio | Resultado esperado |
|---|---|
| Seguranca | acesso controlado e segredos tratados |
| Escalabilidade | evolucao modular e banco gerenciado |
| Manutencao | schema tipado e migrations |
| UX | dashboard, filtros e telas setoriais |
| Confiabilidade | testes, validacao e rollback |

## 17. Roteiro de slides

| Slide | Tema |
|---|---|
| 1 | Tema e objetivo |
| 2 | Sistema legado |
| 3 | Problemas encontrados |
| 4 | Banco de dados |
| 5 | Setores |
| 6 | Funcoes |
| 7 | Nova arquitetura |
| 8 | Seguranca |
| 9 | Usuarios e permissoes |
| 10 | Estrategia de migracao |
| 11 | Riscos |
| 12 | Testes |
| 13 | Validacao |
| 14 | Mockups e prints |
| 15 | Implantacao |
| 16 | Conclusao |

## Documentos tecnicos de apoio

Os arquivos em `docs/` mantem detalhes adicionais:

| Arquivo | Conteudo |
|---|---|
| `docs/02-problemas-legado.md` | problemas catalogados por severidade |
| `docs/03-modelagem.md` | mapeamento legado para Prisma |
| `docs/04-modulos.md` | regras e KPIs por modulo |
| `docs/05-migracao.md` | fases e rollback detalhados |
| `docs/06-riscos.md` | matriz estendida |
| `docs/07-testes.md` | casos de teste |
| `docs/08-validacao.md` | queries e checklists |
| `docs/09-mockups.md` | mockups ASCII |
| `docs/10-implantacao.md` | ambiente e go-live |
| `docs/11-apresentacao.md` | roteiro narrativo da apresentacao |
