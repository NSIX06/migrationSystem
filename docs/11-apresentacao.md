# 11 — Estrutura da Apresentação Acadêmica

> Roteiro de 16 slides para apresentação do projeto de migração de sistema no contexto acadêmico do 5° semestre. Duração estimada: 20–25 minutos.

---

## Informações Gerais

| Campo | Valor |
|---|---|
| **Projeto** | Migração do Sistema ServSaúde |
| **Curso** | Análise e Desenvolvimento de Sistemas — 5° Semestre |
| **Disciplina** | Projeto Integrador / Engenharia de Software |
| **Tema** | Análise, Modelagem e Estratégia de Migração de Sistema Legado |
| **Duração** | 20–25 minutos + 5 min perguntas |
| **Ferramenta** | Google Slides / PowerPoint |

---

## Slide 1 — Capa

**Título**: Migração de Sistema Legado com Banco de Dados Real  
**Subtítulo**: Do PHP/Laravel/MySQL para Next.js/Prisma/Supabase  
**Sistema analisado**: ServSaúde — Gestão de Operadora de Plano de Saúde  

**Elementos visuais**:
- Logo fictício da operadora
- Seta de transição: "LEGADO → NOVO"
- Stack legada (PHP, MySQL) → Stack nova (Next.js, TypeScript, PostgreSQL)

**Fala sugerida**: _"Hoje apresentamos um projeto de migração baseado em um banco de dados real de uma operadora de plano de saúde. Diferente de projetos genéricos, todo o diagnóstico, modelagem e estratégia foi construído a partir de análise direta do SQL do sistema legado."_

---

## Slide 2 — O Sistema Analisado

**Título**: ServSaúde — Sistema de Missão Crítica

**Conteúdo**:
- O que é: gestão completa de operadora de plano de saúde municipal
- Regulado pela ANS (Agência Nacional de Saúde Suplementar)
- Stack legada: PHP 8 (Laravel 10) + MySQL + Sanctum
- Tamanho: 44+ tabelas, 8 módulos de negócio
- Volume estimado: 12.000+ beneficiários, 500.000+ guias históricas

**Dados dos documentos**:
- Módulos: Beneficiários, Prestadores, Produtos, Guias, Financeiro, Tabelas Médicas, Credenciamento, Administração
- Usuários: 8 perfis (super_admin → beneficiário)
- Dependências externas: CBHPM, Brasindice, TISS (ANS), API Bancária, CID-10

**Fala sugerida**: _"O ServSaúde não é um sistema simples. Ele gerencia autorização de procedimentos médicos, boletos bancários, desconto em folha de pagamento e atende à regulação ANS. Uma migração aqui tem impacto direto na saúde de beneficiários reais."_

---

## Slide 3 — O Problema: Por Que Migrar?

**Título**: 14 Problemas Identificados no Banco Legado

**Conteúdo (duas colunas)**:

_Estruturais_:
- P03 ⚠️ CRÍTICO: Polimórficos sem FK (tabela + origem_id)
- P05: Timestamps hardcoded como default (`DEFAULT '2024-01-19'`)
- P09: Enums como inteiros sem documentação
- P01: Artefatos do Laravel no schema de produção

_Segurança_:
- S01 ⚠️ CRÍTICO: Credenciais bancárias em texto claro no banco
- S02: Sem Row Level Security (qualquer usuário vê todos os dados)
- S03: Logs de auditoria deletáveis

**Visual**: tabela de severidade (2 Críticos, 6 Altos, 5 Médios, 2 Baixos)

**Fala sugerida**: _"Ao analisar o SQL do sistema, encontramos dois problemas críticos: relacionamentos sem integridade referencial real e credenciais bancárias armazenadas em texto claro no banco de dados. Isso viola LGPD e PCI-DSS."_

---

## Slide 4 — Metodologia: Análise do Banco Real

**Título**: De Onde Vieram os Dados

**Conteúdo**:
- Arquivo: `servsaude_banco_completo.sql` (526KB, 10.513 linhas)
- Origem: dump completo do banco de produção (MySQL → PostgreSQL)
- Análise direta: sem suposições — tudo baseado no SQL
- Ferramentas usadas: PostgreSQL, análise manual de constraints e índices

**Fluxo de análise**:
```
servsaude_banco_completo.sql
        │
        ▼
  Análise estrutural
  (tabelas, FKs, índices)
        │
        ▼
  Identificação de problemas
  (14 issues documentados)
        │
        ▼
  Modelagem do novo schema
  (Prisma schema.prisma)
```

**Fala sugerida**: _"Este projeto foi feito de baixo para cima. Primeiro analisamos o banco real, depois modelamos o novo sistema. Não partimos de um template genérico."_

---

## Slide 5 — A Nova Arquitetura

**Título**: Stack Moderna para um Sistema Crítico

**Conteúdo**:

| Camada | Legado | Novo |
|---|---|---|
| Frontend | PHP/Blade + jQuery | Next.js 15 App Router + React |
| Linguagem | PHP 8 | TypeScript 5 |
| ORM | Eloquent | Prisma ORM |
| Banco | MySQL | PostgreSQL (Supabase) |
| Auth | Laravel Sanctum | Supabase Auth (JWT) |
| Storage | Disco local (`disk=public`) | Supabase Storage |
| Segurança | Sem RLS | Row Level Security ativo |
| Deploy | Servidor próprio | Vercel + Supabase Cloud |

**Visual**: diagrama de arquitetura (usuário → Vercel → Supabase)

---

## Slide 6 — Modelagem: O Novo Schema Prisma

**Título**: 80+ Modelos, 19 Enums Tipados

**Destaques**:
1. **Sem polimórficos**: `documentos` com `tabela+origem_id` → `ConveniadoDocumento`, `PrestadorDocumento` com FK real
2. **Enums tipados**: `sexo smallint` → `SexoEnum { MASCULINO, FEMININO, NAO_INFORMADO }`
3. **Auth via Supabase**: sem tabela `users` no schema de negócio
4. **Soft delete padrão**: `deletedAt DateTime?` em todas as entidades
5. **Timestamps corretos**: `@default(now())` em todos os campos de data

**Trecho de código real**:
```prisma
model Conveniado {
  id            Int       @id @default(autoincrement())
  operadoraId   Int
  cpf           String    @unique @db.VarChar(14)
  nome          String    @db.VarChar(255)
  sexo          SexoEnum  @default(NAO_INFORMADO)
  deletedAt     DateTime?
  criadoEm      DateTime  @default(now())
  @@index([operadoraId, deletedAt])
  @@map("Conveniado")
}
```

---

## Slide 7 — Segurança: Três Camadas

**Título**: Segurança em Profundidade

**Conteúdo**:

**Camada 1 — Autenticação** (Supabase Auth)
- JWT com expiração 1h + refresh token rotacionado
- E-mail confirmado obrigatório
- Substitui Sanctum (tabela incompleta no legado)

**Camada 2 — Autorização** (RBAC + RLS)
- RBAC: `Perfil → Permissao → ação` verificada em cada Server Action
- RLS: PostgreSQL garante `operadoraId` do usuário = linha acessada
- Sem código extra — banco rejeita queries não autorizadas

**Camada 3 — Dados Sensíveis** (LGPD)
- CPF mascarado em listagens (exibição completa só no detalhe com permissão)
- Credenciais bancárias → Supabase Vault (criptografado em repouso)
- Logs imutáveis: INSERT-only via RLS, sem DELETE

**Fala sugerida**: _"No sistema legado, qualquer usuário autenticado poderia executar uma query e ver dados de qualquer beneficiário, de qualquer operadora. No novo sistema, o próprio banco de dados rejeita isso na camada RLS."_

---

## Slide 8 — Estratégia de Migração: Strangler Fig

**Título**: Por Que Strangler Fig e Não Big Bang?

**Conteúdo**:

```
LEGADO ──────────────────────────────────────────────► DESATIVADO
  │         Fase 1    Fase 2    Fase 3    Fase 4    Fase 5
  │         Referên.  Usuários  Cadastros Guias     Go-Live
  │
  └── NOVO ──────────────────────────────────────────────────────►
              (módulos migrados vão ao ar incrementalmente)
```

**Por que não Big Bang**:
- Sistema regulado pela ANS — downtime viola prazos de autorização (Art. 20, RN 259)
- Rollback por módulo (< 15 min) vs rollback total (horas/dias)
- Validação incremental vs validação massiva no final

**Fala sugerida**: _"Não dá para desligar o sistema de saúde de uma cidade no sábado e rezar para dar certo na segunda. O Strangler Fig nos dá um caminho de volta a qualquer momento."_

---

## Slide 9 — As 5 Fases da Migração

**Título**: Roadmap de 18 Semanas

**Conteúdo** (linha do tempo):

| Fase | Semanas | O que migra | Critério de saída |
|---|---|---|---|
| 0 — Preparação | 1–2 | Infraestrutura | Schema vazio e validado |
| 1 — Referências | 3–4 | CID, CBHPM, Procedimentos | Contagem = 100% do legado |
| 2 — Usuários | 5–6 | Supabase Auth + RBAC | Login funcional todos os perfis |
| 3 — Cadastros | 7–10 | Beneficiários, Prestadores | Contagem ≥ 99,99% + zero órfãos |
| 4 — Núcleo | 11–16 | Guias + Financeiro | Total financeiro centavo a centavo |
| 5 — Go-Live | 17–18 | DNS, desativação legado | Smoke test 9/9 ✓ |

---

## Slide 10 — Desafio ETL: Polimórficos

**Título**: Resolvendo o Problema Mais Complexo da Migração

**Problema no legado**:
```sql
-- enderecos (legado)
tabela text,      -- "conveniados", "prestadores", "empresas"
origem_id integer -- ID do registro em qualquer tabela (sem FK!)
```

**Solução no novo schema**:
```sql
-- Endereco (novo) — FK explícita por entidade
"conveniadoId" Int?  REFERENCES "Conveniado"(id)
"prestadorId"  Int?  REFERENCES "Prestador"(id)
"empresaId"    Int?  REFERENCES "Empresa"(id)
```

**Script ETL real**:
```sql
-- Endereços de conveniados (WHERE tabela = 'conveniados')
INSERT INTO "Endereco" ("conveniadoId", logradouro, ...)
SELECT e.origem_id, e.logradouro, ...
FROM legado.enderecos e
WHERE e.tabela = 'conveniados' AND e.deleted_at IS NULL;
```

**Resultado**: de um relacionamento sem integridade para FK real com índice eficiente.

---

## Slide 11 — Matriz de Riscos

**Título**: 10 Riscos Identificados e Mitigados

**Visual**: matriz probabilidade × impacto

```
Impacto
  5 │ R03    ▲ R01,R02    ■ R07
    │             R06
  4 │ R09,R10
    │                  R05,R04
  3 │         R08
    └─────────────────────────────
      1    2    3    4    5    Prob.

■ Crítico   ▲ Alto   ● Médio   ○ Baixo
```

**Top 3 Riscos com mitigação**:

1. **R01 — Inconsistência de dados** (Crítico): validação por script SQL antes de cada fase
2. **R02 — Downtime de guias** (Alto): janela de manutenção + rollback < 15 min
3. **R07 — Exposição de dados sensíveis** (Alto): ETL em rede privada + sem dados reais no staging

---

## Slide 12 — Plano de Testes (45 Casos)

**Título**: Qualidade em Todas as Camadas

**Distribuição**:

| Categoria | Qtd | Ferramenta |
|---|---|---|
| Autenticação (AUTH) | 6 | Vitest + Supabase Auth |
| RBAC e RLS (RBAC) | 7 | Vitest + RLS policies |
| CRUD de Entidades | 12 | Vitest + Prisma |
| Regras de Negócio (RN) | 8 | Vitest |
| Migração de Dados (MIG) | 5 | Scripts SQL |
| Performance (PERF) | 4 | k6 |
| Segurança (SEC) | 3 | OWASP ZAP |

**Exemplo de teste crítico (RN-05)**:
> _Beneficiário com boleto vencido há 35 dias NÃO consegue autorizar guia eletiva. Guia de urgência/emergência continua sendo liberada._

**Fala sugerida**: _"O teste RN-05 representa uma regra de negócio que salva vidas: mesmo inadimplente, o beneficiário tem acesso a urgência e emergência. Isso está na lei (RN ANS) e precisava estar testado."_

---

## Slide 13 — Interface: Mockups Principais

**Título**: Design Baseado em Shadcn/ui + Tailwind

**Mostrar**: capturas ou desenhos das 7 telas (docs/09-mockups.md):
1. Login
2. Dashboard com KPIs
3. Lista de Beneficiários (CPF mascarado)
4. Detalhe do Beneficiário com abas
5. Wizard de Emissão de Guia
6. Fila de Autorização com Drawer
7. Relatório Financeiro

**Decisões de design relevantes**:
- CPF mascarado em listagens (LGPD)
- Drawer lateral para detalhes (sem troca de página)
- Wizard multi-step com validação Zod por passo
- Mobile-first para beneficiários e prestadores

---

## Slide 14 — Implantação e Infra

**Título**: Deploy em Nuvem com Custo Controlado

**Arquitetura de produção**:
```
Usuário → Vercel (Next.js SSR) → Supabase PostgreSQL
                                → Supabase Auth
                                → Supabase Storage
                                → Supabase Vault
```

**Custo mensal estimado**:
- Vercel Pro: ~$20/mês
- Supabase Pro: ~$25/mês
- Total: ~R$ 225/mês (uma operadora pequena/média)

**CI/CD**: GitHub Actions → testes → `prisma migrate deploy` → deploy Vercel automático

**Backup**: PITR (Point in Time Recovery) no Supabase Pro — restauração até 7 dias atrás

---

## Slide 15 — Resultados e Comparativo

**Título**: O Que o Novo Sistema Resolve

| Problema | Legado | Novo Sistema |
|---|---|---|
| Credenciais bancárias | Texto claro no banco | Supabase Vault (criptografado) |
| Isolamento de dados | Sem RLS | RLS por operadoraId |
| Enums sem documentação | `status = 2` (o que é 2?) | `status = 'AUTORIZADA'` |
| Polimórficos sem FK | `tabela='conveniados', origem_id=42` | `conveniadoId = 42` (FK real) |
| Timestamps hardcoded | `DEFAULT '2024-01-19'` | `@default(now())` |
| Auth vulnerável | Sanctum incompleto | Supabase Auth com JWT |
| Logs deletáveis | `deleted_at` no log | INSERT-only via RLS |
| Menu no banco | `menus` table | TypeScript config |

**Impacto mensurável**:
- De 0 para 45 casos de teste documentados
- De 0 para 19 enums tipados (zero "números mágicos")
- De 0 para RLS em todas as tabelas de negócio
- Estratégia com rollback < 15 min em qualquer fase

---

## Slide 16 — Conclusão e Próximos Passos

**Título**: Migração como Engenharia de Software

**O que foi feito neste projeto**:
1. ✅ Análise completa do banco legado (44+ tabelas, 14 problemas identificados)
2. ✅ Modelagem do novo schema (80+ modelos Prisma, 19 enums)
3. ✅ Estratégia de migração (Strangler Fig, 5 fases, 18 semanas)
4. ✅ Matriz de riscos com mitigação (10 riscos)
5. ✅ Plano de testes (45 casos)
6. ✅ Scripts de validação SQL
7. ✅ Mockups de 7 telas
8. ✅ Plano de implantação (Vercel + Supabase)

**Próximos passos (implementação)**:
- Implementar os Server Actions e componentes Next.js
- Executar ETL em staging com dados reais mascarados
- Realizar testes de carga com k6
- Executar go-live conforme cronograma

**Mensagem final**:

> _"Migração de sistema legado não é só trocar tecnologia. É entender o domínio, documentar o que existe, planejar o que vem, e garantir que nenhum dado seja perdido — nem nenhum paciente fique sem autorização durante a transição."_

---

## Apêndice — Perguntas Comuns

**P: Por que não reescrever do zero?**  
R: O domínio de negócio (ANS, TISS, CBHPM, Brasindice) é complexo e está correto no legado. Reescrever arriscaria perder regras de negócio não documentadas. O Strangler Fig preserva o que funciona e corrige o que não funciona.

**P: Como garantir que os dados financeiros não se perdem?**  
R: Script de validação centavo a centavo (docs/08-validacao.md, seção 6.2). Se `SUM(legado.lancamentos.valor) ≠ SUM(novo.Lancamento.valor)`, o ETL falhou e não avançamos.

**P: Qual o risco de o Supabase ficar fora do ar?**  
R: SLA Pro = 99,9% (~8,7h/ano). Mitigado com PITR backup e possibilidade de restaurar em novo projeto em < 4h (R09 na matriz de riscos).

**P: O sistema atende à LGPD?**  
R: Sim. CPF mascarado em listagens, dados sensíveis criptografados no Vault, logs imutáveis de auditoria, RLS impedindo acesso cross-tenant. As credenciais bancárias (violação S01 do legado) são resolvidas no novo sistema.
