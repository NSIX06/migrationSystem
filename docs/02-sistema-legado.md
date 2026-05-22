# 02 - Sistema Legado

## Apresentacao do ServSaude

O ServSaude e um sistema de gestao de operadora de plano de saude. A finalidade observada no banco legado e administrar o ciclo completo entre operadora, empresas conveniadas, beneficiarios e prestadores: cadastro, adesao a produtos, autorizacao de atendimento, auditoria, faturamento, cobranca e credenciamento.

O dump legado evidencia uma aplicacao PHP/Laravel com tabelas como `users`, `roles`, `permissions`, `role_user`, `permission_role`, `failed_jobs`, `migrations`, `menus` e `personal_access_tokens`. O dominio de negocio esta no mesmo banco das estruturas tecnicas do framework.

## Area atendida

O sistema atua em saude suplementar e possui operacoes ligadas a:

- beneficiarios vinculados a empresas, secretarias e produtos;
- prestadores pessoa fisica ou juridica;
- autorizacoes de consulta, SADT, internacao, honorario e outros atendimentos;
- tabelas clinicas e de precificacao como CBHPM, CID, Brasindice, materiais e taxas;
- mensalidade, coparticipacao, boleto, remessa de desconto e pagamento a prestadores;
- solicitacoes e documentos de credenciamento.

## Usuarios envolvidos

| Usuario ou ator | Uso observado |
|---|---|
| Administracao da operadora | Parametros, usuarios, produtos, permissao e auditoria |
| Atendimento | Beneficiarios, consultas cadastrais e abertura de guias |
| Autorizacao e auditoria | Analise de guias, itens, justificativas e historico |
| Financeiro | Lancamentos, boletos, mensalidades, lotes e verbas |
| Credenciamento | Editais, documentos e solicitacoes de prestadores |
| Prestador | Emissao ou acompanhamento de guias e contratos |
| Beneficiario | Dados proprios, guias e cobrancas no portal alvo |

## Funcionamento atual identificado no banco

O legado organiza o negocio em oito blocos:

1. cadastros basicos: `estados`, `cidades`, `empresas`, `secretarias`, `cargos`;
2. beneficiarios: `conveniados`, `adesoes`, salarios e gestantes;
3. produtos: `produtos`, `produtos_precos`, regras de coparticipacao;
4. prestadores: tipos, classificacao, contratos e especialidades;
5. guias: cabecalho, itens, anexos, historico, auditoria e importacao;
6. financeiro: lancamentos, boletos, mensalidades e lotes;
7. credenciamento: editais, documentos, solicitacoes e historicos;
8. seguranca/configuracao: usuarios, roles, permissions, menus, parametros e logs.

## Limitacoes encontradas

| Limitacao | Evidencia | Impacto |
|---|---|---|
| Estrutura acoplada ao framework | `failed_jobs`, `migrations`, `personal_access_tokens` | Migra tecnologia junto com dado de negocio |
| Relacoes polimorficas | `enderecos`, `documentos`, `dados_bancarios` com origem generica no legado | Dificulta FK, validacao e ETL |
| Status pouco expressivos | campos integer para sexo, status, tipo e origem | Regra fica escondida no codigo antigo |
| Segredos no dominio | colunas bancarias na tabela de operadora | Aumenta superficie de exposicao |
| Auditoria fragmentada | `log_acessos` e `log_operacoes` separados | Rastreabilidade heterogenea |

## Direcao da modernizacao

O novo sistema separa autenticacao do dominio com Supabase Auth, substitui tabelas de seguranca legadas por `Profile`, `Role`, `Permissao`, `UsuarioRole` e `AuditLog`, tipa status com enums Prisma e mantem os modulos de negocio essenciais em PostgreSQL.
