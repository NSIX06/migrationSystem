# 04 - Setores

## Setores envolvidos na migracao

### Atendimento e cadastro

O atendimento consulta beneficiarios, identifica adesoes ativas, confere CPF, matricula, produto e dados de contato e auxilia na abertura de guias. Este setor depende diretamente de `Conveniado`, `Adesao`, `Produto`, `Cargo`, `Empresa` e `Secretaria`.

Na migracao, a prioridade e preservar rapidez de busca e confiabilidade cadastral. Um beneficiario sem adesao correta ou com status migrado incorretamente impacta autorizacao e cobranca.

### Autorizacoes e auditoria medica

Este setor opera o nucleo assistencial: `Guia`, `GuiaItem`, historico, auditoria, anexos e atendimentos. Autorizar ou negar uma guia exige contexto de beneficiario, prestador, tipo de procedimento, justificativa e status.

Na nova versao, a fila de guias e a trilha de decisoes precisam ser rastreaveis. O setor tambem homologa status e regras de workflow durante a migracao.

### Financeiro

O financeiro administra `Lancamento`, `Mensalidade`, `Boleto`, pagamentos, lote de prestador, verbas e remessas. Sua validacao exige totais monetarios exatos por competencia, status e origem.

A migracao nao pode tratar financeiro como cadastro comum. Divergencia de centavos, boleto sem vinculo ou lote duplicado gera impacto operacional e reputacional.

### Administracao e TI

Administracao controla usuarios, perfis, permissoes, parametros e auditoria. TI prepara ambiente, backup, conexoes, migrations, observabilidade e rollback.

O novo sistema torna esse setor responsavel por provisionar usuarios no Supabase Auth e no dominio interno (`Profile`, `Role`, `UsuarioRole`) de modo coerente.

### Credenciamento

Credenciamento avalia prestadores por editais, documentos, solicitacoes e historicos. O setor depende de storage seguro e de rastreabilidade documental.

Durante a migracao, documentos obrigatorios e historico de decisao precisam manter referencia ao prestador e ao edital correspondente.

## Matriz de responsabilidade

| Setor | Responsabilidade de negocio | Evidencia de dados | Papel na homologacao |
|---|---|---|---|
| Atendimento | Cadastro e consulta operacional | `conveniados`, `adesoes` | Validar buscas e detalhes |
| Autorizacao/Auditoria | Decisao assistencial | `guias`, `guias_itens`, `guias_auditoria` | Validar workflow e historico |
| Financeiro | Cobranca e pagamento | `lancamentos`, `boletos`, `mensalidades` | Validar totais e baixa |
| Administracao/TI | Acesso e configuracao | roles, permissions, parametros, logs | Validar seguranca e rollback |
| Credenciamento | Entrada de prestadores | editais, documentos e solicitacoes | Validar documentos e status |
