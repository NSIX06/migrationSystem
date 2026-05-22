# 04 — Módulos do Sistema ServSaúde

> Especificação funcional dos 8 módulos identificados no banco legado, com tabelas envolvidas, operações CRUD, regras de negócio, permissões e indicadores.

---

## Módulo 1 — Beneficiários (Conveniados)

### Objetivo
Cadastrar e manter o ciclo de vida dos beneficiários: dados pessoais, documentos, vínculos com empresas/secretarias, adesão ao plano e dependentes.

### Tabelas Envolvidas

| Tabela nova | Tabela legada | Papel |
|---|---|---|
| `Conveniado` | `conveniados` | Dados pessoais e documentais |
| `ConveniadoSalario` | `conveniado_salarios` | Histórico salarial para cálculo de mensalidade |
| `Adesao` | `adesoes` | Vínculo conveniado–produto–empresa |
| `AdesaoReducaoMargem` | `adesao_reducao_margem` | Reduções de margem consignável |
| `Gestante` | `gestantes` | Controle de gestações (impacta carência) |
| `GrauParentesco` | `grau_parentesco` | Tabela de referência: titular, cônjuge, filho |
| `Cargo` | `cargos` | Cargo do servidor/funcionário |
| `Endereco` | `enderecos` (polimórfico) | Endereço vinculado ao conveniado |

### Operações CRUD

| Operação | Ação | Regras |
|---|---|---|
| **Criar** | Cadastrar novo beneficiário | CPF único por operadora; CNS único quando informado |
| **Ler** | Buscar por CPF, nome, matrícula | Filtro por empresa, status de adesão, PCD |
| **Atualizar** | Editar dados pessoais | Alterações geram `SolicitacaoAtualizacaoCadastral` se via portal |
| **Excluir** | Soft delete (deletedAt) | Nunca excluir com guias ativas ou mensalidades em aberto |
| **Adesão** | Vincular a produto/empresa | Verificar carência, vigência do produto, teto de dependentes |
| **Encerrar** | Desligar do plano | Requer motivo (MotivoEncerramento); gera lançamentos de liquidação |

### Regras de Negócio Críticas

1. **Carência**: novo beneficiário cumpre carência conforme `ProdutoPreco.tipoCarencia`; gestantes têm carência reduzida (RN ANS 465/2021)
2. **Cálculo de mensalidade**: baseado em `ConveniadoSalario.salario` × `ProdutoPreco.percentual` por faixa salarial
3. **Margem consignável**: desconto em folha limitado a 30% do salário líquido; `AdesaoReducaoMargem` registra reduções temporárias
4. **Titular obrigatório**: dependente exige adesão ativa do titular na mesma operadora
5. **Soft delete em cascata**: encerrar adesão não exclui o conveniado, apenas marca status

### Permissões por Perfil

| Perfil | Criar | Ver | Editar | Encerrar |
|---|---|---|---|---|
| `operadora_admin` | ✓ | ✓ | ✓ | ✓ |
| `operadora_financeiro` | — | ✓ | Parcial (dados financeiros) | — |
| `empresa` | — | Próprios | — | — |
| `beneficiario` | — | Próprios | Via solicitação | — |

### KPIs do Módulo

- Total de beneficiários ativos por operadora
- Taxa de inadimplência por empresa
- Beneficiários com carência ativa
- Gestantes cadastradas no mês

---

## Módulo 2 — Prestadores de Saúde

### Objetivo
Cadastrar e contratar clínicas, hospitais, laboratórios e profissionais autônomos. Controlar especialidades, contratos e itens contratados (procedimentos com preço).

### Tabelas Envolvidas

| Tabela nova | Tabela legada | Papel |
|---|---|---|
| `Prestador` | `prestadores` | Dados do prestador (PJ ou PF) |
| `PrestadorTipo` | `prestador_tipos` | Tipo: hospital, clínica, laboratório |
| `PrestadorClassificacaoEstabelecimento` | `prestadores_classificacao_estabelecimento` | Classificação ANS |
| `PrestadorContrato` | `prestador_contratos` | Contrato firmado com vigência |
| `PrestadorContratoItem` | `prestador_contrato_itens` | Procedimentos/itens contratados com preço |
| `ContratoProfissional` | `contrato_profissionais` | Profissionais vinculados ao contrato |
| `PrestadorEspecialidade` | `prestador_especialidades` | Especialidades oferecidas |
| `Deflator` | `deflatores` | Percentuais de deflação por competência |
| `DadoBancario` | `dados_bancarios` (polimórfico) | Conta bancária para pagamento |

### Operações CRUD

| Operação | Ação | Regras |
|---|---|---|
| **Criar prestador** | Cadastrar PJ/PF | CNPJ/CPF único; CNES obrigatório para estabelecimentos |
| **Criar contrato** | Formalizar contrato | Exige prestador ativo; define tabela de preços e vigência |
| **Adicionar itens** | Adicionar procedimentos ao contrato | Preço unitário por item; referência à `Procedimento` ou `TabelaPreco` |
| **Encerrar contrato** | Definir data de encerramento | Guias em andamento continuam; novas guias bloqueadas após encerramento |
| **Deflação** | Aplicar deflator por competência | Afeta pagamentos do período; registrado em `Deflator` |

### Regras de Negócio Críticas

1. **CNES**: estabelecimentos de saúde exigem Cadastro Nacional de Estabelecimentos de Saúde
2. **Tabela de preços**: `PrestadorContratoItem.valorContratado` prevalece sobre `TabelaPrecoItem.valor`; se ausente, usa tabela do contrato
3. **Deflator**: percentual de desconto negociado aplicado sobre o valor bruto da guia no pagamento em lote
4. **Credenciamento**: prestador passa por `SolicitacaoCredenciamento` antes de receber status `CREDENCIADO`

### Permissões por Perfil

| Perfil | Criar | Ver | Contratar | Pagar |
|---|---|---|---|---|
| `operadora_admin` | ✓ | ✓ | ✓ | ✓ |
| `operadora_financeiro` | — | ✓ | — | ✓ |
| `prestador` | — | Próprios | — | — |

### KPIs do Módulo

- Total de prestadores ativos por especialidade
- Contratos vigentes vs contratos vencendo em 30/60/90 dias
- Valor total pago por prestador no mês/trimestre

---

## Módulo 3 — Produtos e Planos

### Objetivo
Definir os planos de saúde comercializados, suas faixas de preço (por idade/vínculo/salário) e regras de coparticipação por tipo de procedimento.

### Tabelas Envolvidas

| Tabela nova | Tabela legada | Papel |
|---|---|---|
| `Produto` | `produtos` | Plano de saúde (ex: Básico, Plus, Empresarial) |
| `ProdutoPreco` | `produtos_precos` | Faixa etária × percentual/valor |
| `TipoVinculo` | `tipo_vinculos` | Titular, cônjuge, filho, agregado |
| `RegraCoparticipacao` | `regra_cooparticipacao` | Conjunto de regras para um produto |
| `RegraCoparticipacaoItem` | `regra_cooparticipacao_itens` | Regra por grupo de procedimento |
| `RegraCoparticipacaoProcedimento` | `regra_cooparticipacao_procedimentos` | Regra por procedimento específico |
| `EmpresaProduto` | `empresa_produto` | Quais produtos cada empresa comercializa |

### Regras de Negócio Críticas

1. **Faixa etária**: preço calculado pela idade do beneficiário na data de referência; RN ANS define faixas obrigatórias (0–18, 19–23, ..., 59+)
2. **Coparticipação**: percentual ou valor fixo por procedimento descontado do beneficiário; calculado na auditoria da guia
3. **Reajuste ANS**: produtos têm `percentualReajuste` aplicado anualmente conforme portaria ANS; gera novos `ProdutoPreco`
4. **Produto ativo**: apenas produtos com `ativo = true` aceitam novas adesões

---

## Módulo 4 — Autorizações Médicas (Guias)

### Objetivo
Núcleo operacional do sistema. Emitir, autorizar, auditar e faturar guias médicas de consultas, exames, SADT e internações. Suporta importação de XML TISS.

### Tabelas Envolvidas

| Tabela nova | Tabela legada | Papel |
|---|---|---|
| `Guia` | `guias` | Cabeçalho da autorização médica |
| `GuiaItem` | `guias_itens` | Procedimentos/itens da guia |
| `GuiaHistorico` | `guias_historico` | Linha do tempo de mudanças de status |
| `GuiaAuditoria` | `guias_auditoria` | Revisão técnica dos itens (glosa) |
| `GuiaAtendimento` | `guias_atendimentos` | Data/hora efetiva do atendimento |
| `GuiaAnexo` | `guias_anexos` | Arquivos anexados (laudos, relatórios) |
| `GuiaImportacao` | `guia_importacoes` | Lote de guias importado via XML TISS |
| `GuiaMotivoEncerramento` | `guia_motivo_encerramento` | Motivos para negar/cancelar guias |

### Workflow de Status

```
SOLICITADA
    │
    ├─→ AUTORIZADA ──→ FATURADA ──→ AUDITADA
    │        │
    │        └─→ EM_RECURSO ──→ AUDITADA
    │
    ├─→ NEGADA
    │
    └─→ CANCELADA
```

### Operações Principais

| Operação | Ator | Ação |
|---|---|---|
| Emitir | Prestador / Operadora_autorizacoes | Criar guia com itens; status → SOLICITADA |
| Autorizar | Operadora_autorizacoes | Aprovar guia; status → AUTORIZADA |
| Negar | Operadora_autorizacoes | Registrar motivo; status → NEGADA |
| Importar TISS | Operadora_admin | Processar XML; criar guias em lote via `GuiaImportacao` |
| Auditar | Operadora_auditoria | Revisar itens; glosar procedimentos; status → AUDITADA |
| Faturar | Sistema (automático) | Agregar guias auditadas em lote de pagamento; status → FATURADA |
| Cancelar | Operadora_admin | Status → CANCELADA; registrar motivo |

### Regras de Negócio Críticas

1. **Autorização prévia**: procedimentos com `Procedimento.requerAutorizacao = true` precisam de aprovação antes do atendimento
2. **Validade da guia**: guia autorizada tem prazo (`dataValidade`) definido pelo produto
3. **Coparticipação**: calculada na auditoria; lança `Lancamento` de cobrança ao beneficiário
4. **Glosa**: item glosado em `GuiaAuditoria` reduz o valor a pagar ao prestador; beneficiário pode recorrer
5. **TISS**: XML deve seguir padrão ANS; `GuiaImportacao` registra status do processamento e erros

### Permissões por Perfil

| Perfil | Emitir | Autorizar | Auditar | Importar TISS |
|---|---|---|---|---|
| `operadora_autorizacoes` | ✓ | ✓ | — | ✓ |
| `operadora_auditoria` | — | — | ✓ | — |
| `prestador` | ✓ | — | — | — |
| `beneficiario` | — | — | — | — (consulta) |

### KPIs do Módulo

- Total de guias por status no mês
- Tempo médio de autorização (SOLICITADA → AUTORIZADA)
- Taxa de glosa por prestador/especialidade
- Volume de atendimentos por tipo de guia

---

## Módulo 5 — Financeiro

### Objetivo
Controlar o ciclo financeiro completo: mensalidades, boletos, pagamento a prestadores em lote, remessa de desconto em folha e lançamentos de coparticipação.

### Tabelas Envolvidas

| Tabela nova | Tabela legada | Papel |
|---|---|---|
| `Lancamento` | `lancamentos` | Evento financeiro (receita/despesa) |
| `LancamentoGuia` | `lancamentos_guias` | Vínculo entre lançamento e guia |
| `LotePagamento` | `lote_pagamentos` | Lote de pagamento a prestador |
| `Boleto` | `boletos` | Boleto bancário emitido |
| `BoletoPagamento` | `boleto_lancamentos` | Liquidação do boleto |
| `Mensalidade` | `mensalidades` | Mensalidade por competência |
| `RemessaDesconto` | `remessa_desconto` | Lote de desconto em folha |
| `RemessaDescontoItem` | `remessa_desconto_item` | Linha por matrícula |
| `GrupoVerba` | `grupo_verbas` | Grupo de verbas para desconto em folha |
| `EmpresaVerba` | `empresas_verbas` | Verba específica por empresa |
| `Banco` | `bancos` | Banco para integração de boletos |
| `DadoBancario` | `dados_bancarios` | Conta para crédito de pagamento |

### Fluxo Financeiro

```
Adesão ativa
    │
    ▼
Mensalidade (por competência)
    │
    ├─→ Boleto bancário ──→ Pago (API retorno) ──→ Lancamento PAGO
    │
    └─→ Desconto em folha (RemessaDesconto) ──→ Lancamento PAGO

Guia AUDITADA
    │
    ├─→ Coparticipação ──→ Lancamento beneficiário
    │
    └─→ Lote pagamento ──→ Lancamento prestador ──→ Transferência bancária
```

### Regras de Negócio Críticas

1. **Boleto**: `nossoNumero` único por banco; API bancária (Itaú/BB) identificada no schema legado
2. **Retorno bancário**: arquivo de retorno (CNAB 240/400) baixa boletos pagos automaticamente
3. **Lote de pagamento**: agrupa guias faturadas por prestador/competência; deflator aplicado
4. **Remessa de folha**: exporta arquivo com `matricula`, `valor`, `grupoVerba` por empresa para RH
5. **Inadimplência**: beneficiário com boleto vencido > N dias tem adesão suspensa (configurável em `Parametro`)

### KPIs do Módulo

- Receita de mensalidades por competência
- Taxa de inadimplência (boletos vencidos / total emitidos)
- Pagamento a prestadores por mês
- Coparticipação arrecadada por tipo de procedimento

---

## Módulo 6 — Tabelas Médicas (CBHPM / Brasindice)

### Objetivo
Manter as tabelas regulatórias de procedimentos médicos (CBHPM), medicamentos (Brasindice) e tabelas de preço customizadas por contrato de prestador.

### Tabelas Envolvidas

| Tabela nova | Tabela legada | Papel |
|---|---|---|
| `CbhpmEdicao` | `cbhpm_edicoes` | Edição da CBHPM (ex: 5ª ed. 2018) |
| `Cbhpm` | `cbhpm` | Procedimento CBHPM com porte/UCO |
| `ComunicadoEdicao` | `comunicado_edicoes` | Edição do Comunicado de Portes |
| `ComunicadoPorte` | `comunicado_portes` | Porte anestésico por procedimento |
| `ProcedimentoGrupo` | `procedimentos_grupos` | Agrupamento de procedimentos |
| `ProcedimentoSubgrupo` | `procedimento_subgrupos` | Subgrupo CBHPM |
| `Procedimento` | `procedimentos` | Procedimento com código TUSS |
| `MedicamentoEdicao` | `medicamento_edicoes` | Edição do Brasindice |
| `Medicamento` | `medicamentos` | Medicamento (princípio ativo) |
| `MedicamentoBrasindice` | `medicamento_brasindice` | Preço PMC/Pfab por edição |
| `MaterialEdicao` | `material_edicoes` | Edição de tabela de materiais |
| `Material` | `materiais` | Material hospitalar/OPME |
| `MaterialItem` | `materiais_itens` | Variante de material com preço |
| `Laboratorio` | `laboratorios` | Fabricante/laboratório farmacêutico |
| `Taxa` | `taxas` | Taxa hospitalar (diária UTI, gases) |
| `TabelaPreco` | `tabela_precos` | Tabela customizada por contrato |
| `TabelaPrecoItem` | `tabela_precos_itens` | Item com valor na tabela customizada |
| `Cid` | `cid` | CID-10 — Classificação de doenças |

### Regras de Negócio Críticas

1. **Versionamento por edição**: cada atualização da CBHPM/Brasindice cria nova edição; preços históricos preservados
2. **Precedência de tabela**: Tabela customizada do contrato > CBHPM da edição vigente
3. **TUSS**: `Procedimento.codigoTuss` é o código padrão ANS usado nas guias TISS
4. **Brasindice PMC vs Pfab**: PMC é preço máximo ao consumidor; Pfab é preço fábrica; operadora negocia percentual sobre um deles

---

## Módulo 7 — Credenciamento de Prestadores

### Objetivo
Gerenciar o processo de credenciamento de novos prestadores: publicação de editais, recebimento de documentação, análise e decisão.

### Tabelas Envolvidas

| Tabela nova | Tabela legada | Papel |
|---|---|---|
| `EditalCredenciamento` | `editais_credenciamento` | Edital publicado com prazo e regras |
| `DocumentoCredenciamento` | `documentos_credenciamento` | Documentos obrigatórios por edital |
| `EditalCredenciamentoDocumento` | `edital_credenciamento_documentos` | Vínculo edital–documento obrigatório |
| `SolicitacaoCredenciamento` | `solicitacoes_credenciamento` | Solicitação enviada pelo prestador |
| `SolicitacaoCredenciamentoDocumento` | `solicitacoes_credenciamento_documentos` | Documentos enviados na solicitação |
| `HistoricoCredenciamento` | `historico_credenciamentos` | Registro de cada decisão/parecer |

### Workflow

```
Edital publicado (ABERTO)
    │
    ▼
Prestador envia SolicitacaoCredenciamento (PENDENTE)
    │
    ▼
Análise documental (EM_ANALISE)
    │
    ├─→ APROVADO ──→ Prestador cadastrado com status CREDENCIADO
    │
    └─→ REPROVADO ──→ HistoricoCredenciamento com justificativa
```

---

## Módulo 8 — Administração e Segurança

### Objetivo
Controlar acesso ao sistema (RBAC), parâmetros de configuração, auditoria de operações e comunicação interna.

### Tabelas Envolvidas

| Tabela nova | Tabela legada | Papel |
|---|---|---|
| `Operadora` | `operadoras` | Entidade raiz do multi-tenant |
| `Perfil` | `roles` | Papéis de acesso (operadora_admin, etc.) |
| `Permissao` | `permissions` | Permissão granular (módulo + ação) |
| `RolePermissao` | `permission_role` | Vínculo perfil–permissão |
| `UsuarioRole` | `role_user` | Perfil atribuído ao usuário |
| `OperadoraUsuario` | `operadora_user` | Usuário vinculado à operadora |
| `EmpresaUsuario` | `empresa_user` | Usuário vinculado à empresa |
| `PrestadorUsuario` | `prestador_user` | Usuário vinculado ao prestador |
| `AuditLog` | `log_acessos` + `log_operacoes` | Log imutável de acessos e operações |
| `Parametro` | `parametros` | Configurações da operadora |
| `Mensagem` | `mensagens` | Comunicados internos |
| `CanalAtendimento` | `canais_atendimento` | Canais (WhatsApp, e-mail, etc.) |

### Regras de Negócio Críticas

1. **Supabase Auth**: usuário existe no Supabase Auth (UUID); `OperadoraUsuario.usuarioId` referencia esse UUID
2. **RBAC**: toda ação verifica `UsuarioRole → RolePermissao → Permissao.slug` antes de executar
3. **RLS**: PostgreSQL Row Level Security garante que `operadoraId` do usuário é o mesmo da linha consultada
4. **AuditLog imutável**: INSERT-only via policy RLS; sem UPDATE/DELETE; particionado por mês para performance
5. **Parâmetros**: `Parametro` armazena configurações como dias de inadimplência, percentual de multa, CNPJ da operadora

### KPIs do Módulo

- Usuários ativos por perfil
- Operações auditadas por módulo no período
- Tentativas de acesso negado (segurança)
