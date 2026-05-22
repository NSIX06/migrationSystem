# 09 — Mockups de Interface (ASCII)

> Protótipos das telas principais do novo sistema ServSaúde. Stack: Next.js App Router + Tailwind CSS + Shadcn/ui.

---

## Tela 1 — Login

```
┌──────────────────────────────────────────────────────────────────┐
│                                                                    │
│                    ╔══════════════════════╗                        │
│                    ║   🏥  ServSaúde      ║                        │
│                    ║  Gestão de Operadora ║                        │
│                    ╚══════════════════════╝                        │
│                                                                    │
│              ┌─────────────────────────────────┐                  │
│              │            ENTRAR               │                  │
│              │                                 │                  │
│              │  E-mail                         │                  │
│              │  ┌─────────────────────────┐    │                  │
│              │  │ admin@operadora.com      │    │                  │
│              │  └─────────────────────────┘    │                  │
│              │                                 │                  │
│              │  Senha                          │                  │
│              │  ┌─────────────────────────┐    │                  │
│              │  │ ••••••••••••            │ 👁 │                  │
│              │  └─────────────────────────┘    │                  │
│              │                                 │                  │
│              │  ┌─────────────────────────┐    │                  │
│              │  │      ENTRAR             │    │                  │
│              │  └─────────────────────────┘    │                  │
│              │                                 │                  │
│              │  Esqueceu a senha?              │                  │
│              └─────────────────────────────────┘                  │
│                                                                    │
└──────────────────────────────────────────────────────────────────┘
```

**Comportamento**:
- Supabase Auth — e-mail + senha
- Token armazenado em cookie httpOnly (não localStorage)
- Erro genérico: "Credenciais inválidas" (não revela campo errado)
- Redireciona para `/dashboard` após login bem-sucedido
- Redireciona para `/login` se token expirado

---

## Tela 2 — Dashboard Principal (Perfil: operadora_admin)

```
┌──────────────────────────────────────────────────────────────────────────────┐
│  🏥 ServSaúde  │  Operadora Municipal de Saúde             [Admin] ▼  [Sair] │
├──────────────────────────────────────────────────────────────────────────────┤
│                │                                                              │
│  📋 Dashboard  │  Bom dia, Douglas.  Hoje: 20/05/2025                        │
│  👥 Benefic.   │                                                              │
│  🏥 Prestadores│  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐        │
│  📄 Guias      │  │ Beneficiários│ │  Guias Hoje  │ │  Financeiro  │        │
│  💰 Financeiro │  │    12.847    │ │     143      │ │  R$ 48.920   │        │
│  📊 Relatórios │  │  ↑ 23 novos  │ │  ↑ 12 pend.  │ │  em aberto   │        │
│  ⚙️ Admin      │  └──────────────┘ └──────────────┘ └──────────────┘        │
│                │                                                              │
│                │  ┌──────────────────────────────────────────────┐           │
│                │  │  GUIAS PENDENTES DE AUTORIZAÇÃO (12)          │           │
│                │  ├──────────────────────────────────────────────┤           │
│                │  │  #10547  João Silva     Consulta   Clín.Geral │ [Ver]    │
│                │  │  #10548  Maria Santos   Exame      Lab.Silva  │ [Ver]    │
│                │  │  #10549  Pedro Lima     Consulta   Cardio.    │ [Ver]    │
│                │  │  #10550  Ana Costa      SADT       Orto.      │ [Ver]    │
│                │  │  ...                              [Ver todas] │           │
│                │  └──────────────────────────────────────────────┘           │
│                │                                                              │
│                │  ┌──────────────────────────────────────────────┐           │
│                │  │  BOLETOS VENCENDO EM 7 DIAS (89)             │           │
│                │  ├──────────────────────────────────────────────┤           │
│                │  │  Competência 2025-05  │ 89 boletos │ R$ 12.450│[Exportar]│
│                │  └──────────────────────────────────────────────┘           │
└──────────────────────────────────────────────────────────────────────────────┘
```

**Comportamento**:
- KPIs calculados por Server Action no carregamento
- "Guias pendentes" usa query com índice `(operadoraId, status, dataEmissao)`
- Botão [Ver] abre guia em drawer lateral (não nova página)
- Sidebar: links ativos conforme permissões do perfil (RBAC)

---

## Tela 3 — Lista de Beneficiários

```
┌──────────────────────────────────────────────────────────────────────────────┐
│  🏥 ServSaúde  │  Beneficiários                                   [Admin] ▼ │
├────────────────────────────────────────────────────────────────────────────  │
│                │                                                              │
│  👥 Benefic. ◄ │  Beneficiários                          [+ Novo Beneficiário]│
│                │                                                              │
│                │  ┌────────────────────────────────────────────────────────┐ │
│                │  │ 🔍 Buscar por nome, CPF ou matrícula...     [Filtros ▼]│ │
│                │  └────────────────────────────────────────────────────────┘ │
│                │                                                              │
│                │  Filtros ativos: Empresa: Prefeitura Municipal  [✕]         │
│                │                  Status: Ativo                 [✕]         │
│                │                                                              │
│                │  ┌────┬────────────────────┬─────────────┬───────┬────────┐ │
│                │  │ #  │ Nome               │ CPF         │Status │ Ações  │ │
│                │  ├────┼────────────────────┼─────────────┼───────┼────────┤ │
│                │  │ 1  │ Ana Paula Ferreira  │ ***.***.789 │ Ativo │[Ver][✏]│ │
│                │  │ 2  │ Carlos Mendes       │ ***.***.012 │ Ativo │[Ver][✏]│ │
│                │  │ 3  │ Fernanda Costa      │ ***.***.345 │Suspen.│[Ver][✏]│ │
│                │  │ 4  │ João Pedro Sousa    │ ***.***.678 │ Ativo │[Ver][✏]│ │
│                │  │ 5  │ Maria Auxiliadora   │ ***.***.901 │ Ativo │[Ver][✏]│ │
│                │  ├────┴────────────────────┴─────────────┴───────┴────────┤ │
│                │  │  Mostrando 1–20 de 847  ←  [1] [2] [3] ... [43]  →    │ │
│                │  └───────────────────────────────────────────────────────-─┘ │
└──────────────────────────────────────────────────────────────────────────────┘
```

**Comportamento**:
- CPF mascarado em tela de lista (LGPD — exibição completa só no detalhe)
- Busca via URL params (`?q=joao&empresa=1&status=ATIVO`)
- Paginação cursor-based (Prisma `cursor` + `take`)
- Filtros persistem na URL (compartilháveis)
- RLS filtra automaticamente por `operadoraId` do usuário logado

---

## Tela 4 — Detalhe do Beneficiário

```
┌──────────────────────────────────────────────────────────────────────────────┐
│  🏥 ServSaúde  │  Beneficiários / Ana Paula Ferreira              [Admin] ▼ │
├──────────────────────────────────────────────────────────────────────────────│
│  ← Voltar      │                                                              │
│                │  ┌──────────────────────────────────────────────────────┐   │
│                │  │  [Foto]  Ana Paula Ferreira             [✏ Editar]  │   │
│                │  │          CPF: 123.456.789-09                          │   │
│                │  │          Matrícula: 00842 | Cargo: Professora        │   │
│                │  │          Empresa: Prefeitura Municipal               │   │
│                │  │          Status: ● Ativo  desde 15/03/2020           │   │
│                │  └──────────────────────────────────────────────────────┘   │
│                │                                                              │
│                │  [Dados Pessoais] [Adesão] [Guias] [Financeiro] [Documentos]│
│                │  ───────────────────────────────────────────────────────    │
│                │                                                              │
│                │  ABA: GUIAS                                                  │
│                │  ┌──────────┬──────────────┬─────────────┬──────┬────────┐  │
│                │  │  Nº      │  Data        │  Tipo       │Status│  Valor │  │
│                │  ├──────────┼──────────────┼─────────────┼──────┼────────┤  │
│                │  │  10.435  │  10/05/2025  │  Consulta   │ ✅ Aut│ R$ 45  │  │
│                │  │  10.201  │  02/04/2025  │  Exame SADT │ ✅ Fat│R$ 180  │  │
│                │  │   9.887  │  15/02/2025  │  Consulta   │ ✅ Aud│ R$ 45  │  │
│                │  └──────────┴──────────────┴─────────────┴──────┴────────┘  │
│                │                                                              │
│                │                              [Ver todas as guias (47)]      │
└──────────────────────────────────────────────────────────────────────────────┘
```

**Comportamento**:
- Tabs renderizam conteúdo sob demanda (lazy load via Suspense)
- Histórico de guias mostra últimas 3; link "Ver todas" navega para `/guias?conveniadoId=X`
- Edição abre Sheet lateral (Shadcn Sheet) — não navega para outra página
- Perfil `beneficiario` vê apenas suas próprias abas (sem aba Financeiro completo)

---

## Tela 5 — Emissão de Guia Médica

```
┌──────────────────────────────────────────────────────────────────────────────┐
│  🏥 ServSaúde  │  Nova Guia de Autorização                        [Admin] ▼ │
├──────────────────────────────────────────────────────────────────────────────│
│                │                                                              │
│  📄 Guias ◄   │  STEP 1 ──── STEP 2 ──── STEP 3                             │
│                │  Beneficiário  Prestador   Procedimentos                     │
│                │                                                              │
│                │  ┌──────────────────────────────────────────────────────┐   │
│                │  │  STEP 1: BENEFICIÁRIO                                │   │
│                │  │                                                      │   │
│                │  │  Buscar beneficiário:                                │   │
│                │  │  ┌────────────────────────────────────────────────┐ │   │
│                │  │  │ 🔍 Digite CPF ou nome...                       │ │   │
│                │  │  └────────────────────────────────────────────────┘ │   │
│                │  │                                                      │   │
│                │  │  ✓ Ana Paula Ferreira (CPF: ***.***.789-09)          │   │
│                │  │    Plano: Básico Plus | Adesão: Ativa                │   │
│                │  │    ⚠ Carência: Internação — 45 dias restantes       │   │
│                │  │                                                      │   │
│                │  │  Tipo de Atendimento:                                │   │
│                │  │  ( ) Consulta  (●) SADT  ( ) Internação              │   │
│                │  │                                                      │   │
│                │  │  Caráter: (●) Eletivo  ( ) Urgência  ( ) Emergência │   │
│                │  │                                                      │   │
│                │  │                            [Cancelar]  [Próximo →]  │   │
│                │  └──────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────────────────┘
```

```
STEP 3: PROCEDIMENTOS (após selecionar prestador)
┌──────────────────────────────────────────────────────────────────┐
│  Adicionar procedimento:                                          │
│  ┌─────────────────────────────────────────────────────┐         │
│  │ 🔍 Buscar por código TUSS ou descrição...          │         │
│  └─────────────────────────────────────────────────────┘         │
│                                                                   │
│  ┌────┬──────────────────────┬──────────┬───────────┬──────────┐ │
│  │ #  │ Procedimento         │ Qtd      │ Vlr.Unit. │  Total   │ │
│  ├────┼──────────────────────┼──────────┼───────────┼──────────┤ │
│  │ 1  │ 40301012 Ultrassom   │ [  1  ] +│ R$ 80,00  │ R$ 80,00 │ │
│  │    │ abdominal total      │         │           │       [✕] │ │
│  ├────┼──────────────────────┼──────────┼───────────┼──────────┤ │
│  │ 2  │ 40601048 Hemograma   │ [  1  ] +│ R$ 25,00  │ R$ 25,00 │ │
│  ├────┴──────────────────────┴──────────┴───────────┴──────────┤ │
│  │                                      TOTAL: R$ 105,00       │ │
│  └──────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  CID-10: [Buscar CID...]   Obs.: [                             ] │
│                                                                   │
│                         [← Anterior]  [Enviar Guia para Análise]│
└──────────────────────────────────────────────────────────────────┘
```

**Comportamento**:
- Wizard multi-step com validação Zod em cada step (React Hook Form)
- Step 1: busca conveniado em tempo real (debounce 300ms)
- Alerta de carência aparece automaticamente ao selecionar tipo INTERNAÇÃO
- Step 3: busca procedimentos por código TUSS ou nome (índice full-text Supabase)
- Valor preenchido automaticamente da tabela contratada do prestador
- Submissão via Server Action — cria `Guia`, `GuiaItem[]` e `GuiaHistorico` em transação

---

## Tela 6 — Fila de Autorização de Guias

```
┌──────────────────────────────────────────────────────────────────────────────┐
│  🏥 ServSaúde  │  Autorizações                                    [Admin] ▼ │
├──────────────────────────────────────────────────────────────────────────────│
│                │                                                              │
│  📄 Guias      │  Fila de Autorização                                        │
│   └ Autorizar ◄│                                                              │
│                │  Filtros: [Todas ▼] [Tipo ▼] [Prestador ▼] [Data ▼]        │
│                │                                                              │
│                │ ┌─────┬────────────────────┬──────────────┬───────┬───────┐ │
│                │ │  #  │  Beneficiário       │  Prestador   │  Tipo │       │ │
│                │ ├─────┼────────────────────┼──────────────┼───────┼───────┤ │
│                │ │10547│ João Silva          │ Clín. Geral  │Consul.│[Abrir]│ │
│                │ │     │  ⚠ 2° solicit. mês │ Dr. Almeida  │       │       │ │
│                │ ├─────┼────────────────────┼──────────────┼───────┼───────┤ │
│                │ │10548│ Maria Santos        │ Lab. Silva   │  SADT │[Abrir]│ │
│                │ ├─────┼────────────────────┼──────────────┼───────┼───────┤ │
│                │ │10549│ Pedro Lima          │ Cardio Total │Consul.│[Abrir]│ │
│                │ └─────┴────────────────────┴──────────────┴───────┴───────┘ │
│                │                                                              │
│                │  ─── DRAWER LATERAL (ao clicar [Abrir]) ───────────────── │ │
│                │  │  Guia #10547 — João Silva                             │ │ │
│                │  │  Beneficiário: João Silva | Plano: Básico Plus        │ │ │
│                │  │  Prestador: Dr. Carlos Almeida — CRM 12345/SP         │ │ │
│                │  │  Solicitação: 20/05/2025 10:32                        │ │ │
│                │  │                                                       │ │ │
│                │  │  Procedimentos:                                       │ │ │
│                │  │  • 10101012 Consulta Médica — R$ 45,00                │ │ │
│                │  │                                                       │ │ │
│                │  │  CID: J00 — Nasofaringite aguda                       │ │ │
│                │  │                                                       │ │ │
│                │  │  ┌────────────────┐  ┌────────────────────────────┐  │ │ │
│                │  │  │  ✅ AUTORIZAR  │  │  ❌ NEGAR  [motivo...]     │  │ │ │
│                │  │  └────────────────┘  └────────────────────────────┘  │ │ │
└──────────────────────────────────────────────────────────────────────────────┘
```

**Comportamento**:
- Alerta "2° solicit. mês" calculado por query: guias do conveniado no mês corrente
- Drawer usa Shadcn `Sheet` (slide do lado direito)
- Autorizar/Negar via Server Action — atualiza status + cria GuiaHistorico
- Após ação, drawer fecha e lista revalida automaticamente (revalidatePath)
- Atualização em tempo real opcional: Supabase Realtime para operadoras com alto volume

---

## Tela 7 — Relatório Financeiro

```
┌──────────────────────────────────────────────────────────────────────────────┐
│  🏥 ServSaúde  │  Financeiro / Relatório Mensal                   [Admin] ▼ │
├──────────────────────────────────────────────────────────────────────────────│
│                │                                                              │
│  💰 Financeiro │  Relatório Financeiro                                        │
│   └ Relatório ◄│                                                              │
│                │  Competência: [Maio 2025 ▼]  Empresa: [Todas ▼]            │
│                │                                                    [Exportar PDF]│
│                │  ┌──────────────────────────────────────────────────────┐   │
│                │  │                   RESUMO                             │   │
│                │  │  Mensalidades emitidas:   R$  287.450,00             │   │
│                │  │  Mensalidades pagas:       R$  231.200,00  (80,4%)   │   │
│                │  │  Coparticipação:           R$   18.320,00            │   │
│                │  │  Pagamento a prestadores:  R$  (142.800,00)          │   │
│                │  │  ─────────────────────────────────────               │   │
│                │  │  Resultado bruto:          R$  106.720,00            │   │
│                │  └──────────────────────────────────────────────────────┘   │
│                │                                                              │
│                │  ┌──────────────────────────────────────────────────────┐   │
│                │  │  POR EMPRESA                                         │   │
│                │  ├──────────────────┬──────────┬──────────┬────────────┤   │
│                │  │  Empresa         │ Benef.   │ Mensalid.│ Inadimpl.  │   │
│                │  ├──────────────────┼──────────┼──────────┼────────────┤   │
│                │  │  Prefeitura Mun. │  8.432   │ R$189.720│   12,3%    │   │
│                │  │  SAEMAE          │  2.847   │  R$63.580│    8,1%    │   │
│                │  │  FUMAS           │  1.568   │  R$34.150│    5,7%    │   │
│                │  └──────────────────┴──────────┴──────────┴────────────┘   │
│                │                                                              │
│                │  ┌──────────────────────────────────────────────────────┐   │
│                │  │  GRÁFICO: Evolução de Mensalidades (últimos 6 meses) │   │
│                │  │  350k ┤                              ████████████    │   │
│                │  │  300k ┤                    ██████████              │   │   │
│                │  │  250k ┤     ████████████                           │   │   │
│                │  │       └──────────────────────────────────────────  │   │   │
│                │  │         Dez    Jan    Fev    Mar    Abr    Mai      │   │   │
│                │  └──────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────────────────┘
```

**Comportamento**:
- Dados calculados por Server Action (agregações no PostgreSQL, não no cliente)
- Gráfico renderizado com Recharts (client component dentro de `<Suspense>`)
- Exportar PDF: gera PDF via `@react-pdf/renderer` ou redireciona para `/relatorio/financeiro.pdf`
- Filtro de competência altera URL params (`?competencia=2025-05`) — URL compartilhável

---

## 8. Componentes Reutilizáveis Identificados

| Componente | Uso |
|---|---|
| `<StatusBadge status="AUTORIZADA">` | Todas as telas com status de guia/boleto/adesão |
| `<BeneficiarioSearch>` | Emissão de guia, busca rápida no header |
| `<GuiaDrawer guiaId={id}>` | Detalhes da guia sem trocar de página |
| `<DataTable columns={...} data={...}>` | Todas as listagens (paginação, filtros, sort) |
| `<FinancialCard value={...} label={...}>` | Cards do dashboard |
| `<CpfMasked cpf={...}>` | CPF mascarado em listagens |
| `<WizardStep>` | Emissão de guia, credenciamento |
| `<ConfirmDialog>` | Autorizar/negar/excluir (confirmação antes de ação) |

---

## 9. Responsividade

Todas as telas são responsivas:
- **Desktop** (≥1280px): sidebar fixa + conteúdo central
- **Tablet** (768–1279px): sidebar colapsável via hamburger
- **Mobile** (< 768px): bottom navigation; tabelas viram cards; wizard ocupa tela cheia

Beneficiários e prestadores acessam principalmente via mobile — priorizados no design.
