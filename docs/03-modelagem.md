# 03 — Modelagem do Novo Sistema ServSaúde

> Decisões arquiteturais do novo schema, mapeamento do legado para o novo modelo e estrutura de entidades.

---

## 1. Princípios de Design Adotados

| Princípio | Aplicação |
|---|---|
| **Auth via Supabase Auth** | Sem tabela `users` própria no Prisma — UUID do Supabase em cada modelo |
| **Sem polimórficos** | `tabela + origem_id` eliminados; FKs explícitas por entidade |
| **Enums tipados** | Todos os `integer` de status/tipo viram `enum` PostgreSQL |
| **Soft delete padrão** | `deletedAt DateTime?` em toda tabela de negócio |
| **Timestamps corretos** | `@default(now())` em vez de datas hardcoded |
| **Storage desacoplado** | Campo `disk` eliminado; URL/path armazenado diretamente |
| **Sem artefatos de framework** | `failed_jobs`, `migrations`, `personal_access_tokens`, `menus` removidos |
| **Idioma único** | Tudo em português; `roles`/`permissions` renomeados para `perfis`/`permissoes` |
| **Multi-tenant por operadora** | `operadoraId` como âncora de RLS em todas as entidades |
| **Logs imutáveis** | `AuditLog` sem `deletedAt`, INSERT-only via RLS |

---

## 2. Mapeamento Legado → Novo Schema

### 2.1 Tabelas Eliminadas

| Tabela legada | Motivo da eliminação |
|---|---|
| `failed_jobs` | Artefato Laravel Queue — não é dado de negócio |
| `migrations` | Controle interno do Eloquent — irrelevante no novo sistema |
| `personal_access_tokens` | Substituído por Supabase Auth |
| `menus` | Menu definido em TypeScript; controlado por permissão via middleware |
| `_migration_validation_issues` | Tabela temporária de diagnóstico |

### 2.2 Tabelas Renomeadas

| Nome legado | Nome novo | Motivo |
|---|---|---|
| `conveniados` | `Conveniado` | Padronização PascalCase Prisma |
| `adesoes` | `Adesao` | — |
| `prestadores` | `Prestador` | — |
| `guias` | `Guia` | — |
| `guias_itens` | `GuiaItem` | Singular consistente |
| `guias_historico` | `GuiaHistorico` | — |
| `guias_auditoria` | `GuiaAuditoria` | — |
| `guias_atendimentos` | `GuiaAtendimento` | — |
| `guias_anexos` | `GuiaAnexo` | — |
| `lancamentos` | `Lancamento` | — |
| `lancamentos_guias` | `LancamentoGuia` | — |
| `lote_pagamentos` | `LotePagamento` | — |
| `boleto_lancamentos` | `BoletoPagamento` | Nome mais descritivo |
| `roles` | `Perfil` | Tradução para português |
| `permissions` | `Permissao` | Tradução + acento normalizado |
| `role_user` | `UsuarioRole` | Convenção de junção Prisma |
| `permission_role` | `RolePermissao` | — |
| `operadora_user` | `OperadoraUsuario` | — |
| `empresa_user` | `EmpresaUsuario` | — |
| `prestador_user` | `PrestadorUsuario` | — |
| `dados_bancarios` | `DadoBancario` | Singular |
| `log_acessos` | `AuditLog` | Unificação + nome semântico |
| `log_operacoes` | `AuditLog` | Unificado em modelo único |
| `medicamento_brasindice` | `MedicamentoBrasindice` | — |
| `cbhpm_edicoes` | `CbhpmEdicao` | — |
| `comunicado_edicoes` | `ComunicadoEdicao` | — |
| `material_edicoes` | `MaterialEdicao` | — |
| `medicamento_edicoes` | `MedicamentoEdicao` | — |
| `solicitacoes_credenciamento` | `SolicitacaoCredenciamento` | — |
| `historico_credenciamentos` | `HistoricoCredenciamento` | — |
| `regra_cooparticipacao` | `RegraCoparticipacao` | Correção ortográfica (co → co) |

### 2.3 Campos Eliminados por Modelo

| Modelo | Campo legado | Motivo |
|---|---|---|
| Todos | `disk` | Artefato Laravel Storage |
| `Guia`, `Conveniado` | timestamps hardcoded | Substituído por `@default(now())` |
| `Conveniado` | `foto` (path relativo) | Renomeado para `fotoUrl` (URL completa Supabase Storage) |
| `Boleto` | `arquivo` | Renomeado para `arquivoUrl` |
| `GuiaAnexo` | `arquivo` | Renomeado para `arquivoUrl` |
| `Operadora` | `senha_certificado`, `boleto_client_secret` | Movido para Supabase Vault / env vars |
| `Operadora` | `certificado` | Movido para Supabase Storage (path) |
| `DocumentoCredenciamento` | FK auto-referencial `id → id` | Sem propósito funcional |
| `MotivoEncerramento` | FK auto-referencial `id → id` | Sem propósito funcional |

### 2.4 Polimórficos Resolvidos

| Tabela legada | Padrão polimórfico | Solução adotada |
|---|---|---|
| `documentos` | `tabela + origem_id` | `ConveniadoDocumento`, `PrestadorDocumento` (modelos separados) ou campo direto por entidade |
| `enderecos` | `tabela + origem_id` | `Endereco` com FK opcional por entidade: `conveniadoId?`, `prestadorId?`, `empresaId?` |
| `dados_bancarios` | `tabela + origem_id` | `DadoBancario` com `conveniadoId?`, `prestadorId?`, `operadoraId?` |

---

## 3. Enums Criados (19 tipos)

| Enum | Campo legado | Valores definidos |
|---|---|---|
| `SexoEnum` | `sexo smallint` | MASCULINO, FEMININO, NAO_INFORMADO |
| `EstadoCivilEnum` | `estado_civil integer` | SOLTEIRO, CASADO, DIVORCIADO, VIUVO, UNIAO_ESTAVEL, SEPARADO, NAO_INFORMADO |
| `PcdEnum` | `pcd integer` | NAO, SIM, NAO_INFORMADO |
| `StatusAdesaoEnum` | `status integer` | ATIVO, SUSPENSO, ENCERRADO, AGUARDANDO_APROVACAO, INADIMPLENTE |
| `TipoClienteEnum` | `tipo_cliente integer` | TITULAR, DEPENDENTE, AGREGADO |
| `TipoPrestadorEnum` | `tipo_id integer` | CLINICA, HOSPITAL, LABORATORIO, PROFISSIONAL_AUTONOMO, OUTROS |
| `StatusGuiaEnum` | `status smallint` | SOLICITADA, AUTORIZADA, NEGADA, CANCELADA, FATURADA, AUDITADA, EM_RECURSO |
| `TipoGuiaEnum` | `tipo smallint` | CONSULTA, SADT, INTERNACAO, ODONTOLOGIA, QUIMIOTERAPIA, RADIOTERAPIA, OUTRAS |
| `CaraterAtendimentoEnum` | `carater_atendimento smallint` | ELETIVO, URGENCIA, EMERGENCIA |
| `TipoGuiaItemEnum` | `tipo smallint` em guias_itens | PROCEDIMENTO, MEDICAMENTO, MATERIAL, TAXA, DIARIA |
| `StatusLancamentoEnum` | `status integer` | ABERTO, PAGO, CANCELADO, ESTORNADO, VENCIDO |
| `TipoLancamentoEnum` | `tipo integer` | RECEITA, DESPESA, MENSALIDADE, COPARTICIPACAO, PAGAMENTO_PRESTADOR |
| `StatusBoletoEnum` | `status integer` | EMITIDO, PAGO, CANCELADO, VENCIDO, BAIXADO_MANUALMENTE |
| `StatusLoteEnum` | `status integer` | ABERTO, FECHADO, PAGO, CANCELADO |
| `TipoAbrangenciaEnum` | `tipo_abrangencia integer` | MUNICIPAL, ESTADUAL, NACIONAL, GRUPO_ESPECIFICO |
| `TipoAcomodacaoEnum` | `tipo_acomodacao integer` | ENFERMARIA, APARTAMENTO, UTI |
| `TipoContratacaoEnum` | `tipo_contratacao integer` | COLETIVO_EMPRESARIAL, COLETIVO_POR_ADESAO, INDIVIDUAL |
| `TipoCarenciaEnum` | `tipo_carencia integer` | CONSULTA, EXAME, INTERNACAO, URGENCIA, TRANSPLANTE |
| `StatusCredenciamentoEnum` | `status integer` | PENDENTE, EM_ANALISE, APROVADO, REPROVADO, SUSPENSO, ENCERRADO |

---

## 4. Diagrama de Entidades (ASCII)

```
┌─────────────────────────────────────────────────────────────────────────┐
│                           OPERADORA (âncora multi-tenant)               │
└────────────────────────────────┬────────────────────────────────────────┘
                                 │ 1:N
         ┌───────────────────────┼───────────────────────┐
         │                       │                       │
         ▼                       ▼                       ▼
    ┌─────────┐           ┌────────────┐          ┌────────────┐
    │ Empresa │           │ Prestador  │          │ Conveniado │
    └────┬────┘           └─────┬──────┘          └─────┬──────┘
         │ 1:N                  │ 1:N                    │ 1:N
         ▼                      ▼                        ▼
    ┌─────────┐      ┌──────────────────┐         ┌──────────┐
    │ Adesao  │      │ PrestadorContrato│         │  Guia    │
    └────┬────┘      └──────┬───────────┘         └────┬─────┘
         │ via adesaoId     │ 1:N                       │ 1:N
         │                  ▼                           ▼
         │      ┌─────────────────────┐        ┌──────────────┐
         │      │PrestadorContratoItem│        │   GuiaItem   │
         │      └─────────────────────┘        └──────────────┘
         │
    ┌────┴────────────────────────────────────┐
    │              FINANCEIRO                  │
    │                                          │
    │  Lancamento ─── LancamentoGuia ─── Guia │
    │       │                                  │
    │  Boleto ─── BoletoPagamento              │
    │       │                                  │
    │  Mensalidade                             │
    │       │                                  │
    │  LotePagamento ─── Lancamento            │
    │       │                                  │
    │  RemessaDesconto ─── RemessaDescontoItem │
    └──────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────┐
│                   TABELAS MÉDICAS                           │
│                                                            │
│  CbhpmEdicao ─── Cbhpm ─── Procedimento ─── GuiaItem      │
│  MedicamentoEdicao ─── Medicamento ─── MedicamentoBrasindice│
│  MaterialEdicao ─── Material ─── MaterialItem              │
│  TabelaPreco ─── TabelaPrecoItem                           │
│  Cid (referência)                                          │
└────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                  CREDENCIAMENTO                              │
│                                                              │
│  EditalCredenciamento ─── EditalCredenciamentoDocumento     │
│       │                          │                          │
│       ▼                          ▼                          │
│  SolicitacaoCredenciamento ─── SolicitacaoCredenciamentoDoc │
│       │                                                     │
│       ▼                                                     │
│  HistoricoCredenciamento                                    │
└─────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────┐
│              RBAC (Auth via Supabase)             │
│                                                   │
│  usuarioId (UUID Supabase) ─── UsuarioRole ─── Perfil│
│                                      │           │
│                              RolePermissao ─── Permissao│
│                                                   │
│  usuarioId ─── OperadoraUsuario ─── Operadora    │
│  usuarioId ─── EmpresaUsuario   ─── Empresa      │
│  usuarioId ─── PrestadorUsuario ─── Prestador    │
└──────────────────────────────────────────────────┘
```

---

## 5. Índices Adicionados (além das PKs/FKs automáticas)

| Modelo | Campo(s) | Justificativa |
|---|---|---|
| `Conveniado` | `cpf` (unique) | Busca por CPF é operação primária de autenticação/localização |
| `Conveniado` | `cns` (unique) | Cartão Nacional de Saúde — busca regulatória |
| `Conveniado` | `operadoraId, deletedAt` | Filtros de listagem multi-tenant |
| `Adesao` | `conveniadoId, status` | Dashboard de situação do beneficiário |
| `Adesao` | `empresaId, competencia` | Relatório financeiro por empresa/mês |
| `Guia` | `conveniadoId, status` | Histórico do beneficiário + workflow |
| `Guia` | `prestadorId, dataEmissao` | Produção do prestador por período |
| `Guia` | `operadoraId, status, dataEmissao` | Fila de autorização centralizada |
| `GuiaItem` | `guiaId, tipo` | Agrupamento por tipo em relatórios |
| `Lancamento` | `operadoraId, status, dataVencimento` | Inadimplência e fluxo de caixa |
| `Boleto` | `conveniadoId, status` | Consulta de situação do boleto pelo beneficiário |
| `Boleto` | `nossoNumero` (unique) | Retorno bancário por nosso número |
| `Prestador` | `cpfCnpj` (unique) | Busca de prestador por documento |
| `SolicitacaoCredenciamento` | `prestadorId, status` | Gestão do processo de credenciamento |
| `AuditLog` | `usuarioId, criadoEm` | Rastreabilidade por usuário + período |
| `AuditLog` | `tabela, registroId` | Histórico de alterações de um registro específico |

---

## 6. Decisões Pendentes / Trade-offs Documentados

### 6.1 Snapshot do Endereço em Boletos (P08)
O campo de endereço do pagador em `Boleto` foi **mantido desnormalizado intencionalmente**. Boleto bancário exige o endereço do momento da emissão — alterar o endereço do beneficiário não deve alterar boletos já emitidos. Isso é correto para o domínio.

### 6.2 GuiaItem — Tabela Única vs Subtipos
Optou-se por manter **tabela única** com campos opcionais por tipo de item, evitando complexidade de herança de tabela. Os campos `horaInicial`/`horaFinal` (internações), `grauPart` (cirurgias) e `codigoTabela` (TISS) ficam `null` quando não aplicáveis. Para evolução futura, usar coluna `metadados Json?` para dados variáveis por tipo.

### 6.3 Log Unificado
`log_acessos` e `log_operacoes` foram unificados em `AuditLog` com campo `tipo` discriminando acesso vs operação. Simplifica RLS e particionamento. Sem `deletedAt` — INSERT-only.

### 6.4 Multi-tenant
O campo `operadoraId` está presente em todas as entidades principais. O RLS do Supabase garantirá que `auth.uid()` só acessa linhas onde `operadoraId` corresponde ao operador vinculado ao usuário logado via `OperadoraUsuario`.
