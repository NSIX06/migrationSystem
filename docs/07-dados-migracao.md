# 07 - Dados de Migracao

## Classificacao dos dados

| Classe | Dados | Regra de migracao |
|---|---|---|
| Criticos cadastrais | beneficiarios, adesoes, empresas, prestadores, produtos | migrar antes do nucleo transacional |
| Criticos assistenciais | guias, itens, historico, auditoria, anexos | preservar vinculos e status |
| Criticos financeiros | lancamentos, boletos, mensalidades, lotes, remessas | validar totais por competencia e centavos |
| Referencia | CID, procedimentos, CBHPM, materiais, medicamentos, bancos | carregar previamente e versionar |
| Seguranca | usuarios, roles, permissoes | transformar para Auth + RBAC novo |
| Historicos | logs, mensagens, solicitacoes e historicos de credenciamento | migrar conforme uso e retenção |

## Dados que devem permanecer integros

1. CPF e identificadores de beneficiario usados para busca e deduplicacao.
2. Relacao entre `Conveniado`, `Adesao`, `Produto`, `Empresa` e `Operadora`.
3. Relacao entre `Guia`, `GuiaItem`, prestador e beneficiario.
4. Valores financeiros, status, datas de vencimento e pagamentos.
5. Contratos de prestador e tabelas de precificacao associadas.
6. Historicos que justificam negacao, auditoria ou pagamento.

## Transformacoes relevantes

- `users` legado nao e copiado como tabela de senha para o dominio novo; contas sao provisionadas no Supabase Auth e mapeadas em `Profile`.
- Codigos inteiros de status/tipo sao convertidos para enums Prisma.
- Relacoes por `tabela`/`origem_id` sao separadas em FKs explicitas quando o schema alvo suporta o vinculo.
- Segredos e caminhos de storage antigos sao substituidos por referencias e variaveis seguras.

## Arquivamento e descarte

Artefatos tecnicos de execucao do legado nao devem poluir o schema novo. `failed_jobs`, `migrations`, `menus` e tokens antigos sao descartados do dominio migrado. Logs antigos podem ir para arquivo de consulta apos criterios de retenção e auditoria definidos pela operadora.

## Ordem de carga recomendada

1. referencias geograficas e tabelas medicas;
2. operadora, empresas, secretarias, cargos, produtos e precos;
3. usuarios, profiles, roles e permissao;
4. beneficiarios, adesoes, prestadores e contratos;
5. guias e historicos;
6. lancamentos, mensalidades, boletos, lotes e remessas;
7. credenciamento, documentos, mensagens e arquivos arquivados.
