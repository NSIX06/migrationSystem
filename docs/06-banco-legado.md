# 06 - Banco Legado

## Estrutura analisada

O arquivo `servsaude_banco_completo.sql` possui centenas de kilobytes de DDL e dados e define tabelas de dominio e infraestrutura. A analise identificou cadastros de referencia, tabelas transacionais, pivots de relacionamento, logs e artefatos do framework Laravel.

## Tabelas principais

| Grupo | Tabelas legadas representativas | Papel |
|---|---|---|
| Beneficiarios | `conveniados`, `adesoes`, `conveniado_salarios`, `gestantes` | Cadastro e vinculo ao plano |
| Prestadores | `prestadores`, `prestador_contratos`, `prestador_especialidades` | Rede assistencial |
| Guias | `guias`, `guias_itens`, `guias_historico`, `guias_auditoria` | Autorizacao e auditoria |
| Financeiro | `lancamentos`, `boletos`, `mensalidades`, `lote_pagamentos` | Cobranca e pagamento |
| Produtos | `produtos`, `produtos_precos`, regras de coparticipacao | Oferta e precificacao |
| Tabelas medicas | `procedimentos`, `cbhpm`, `cid`, `medicamentos`, `materiais` | Referencia tecnica |
| Credenciamento | editais, documentos, solicitacoes, historicos | Entrada de prestadores |
| Seguranca legado | `users`, `roles`, `permissions`, pivots | Acesso anterior |

## Relacionamentos e problemas

O banco tem muitos relacionamentos de negocio validos, mas tambem padroes de risco:

- pivots como `role_user`, `permission_role`, `empresa_user`, `prestador_user`;
- tabelas com origem generica que substituem FK por convencao;
- campos de status sem enum legivel;
- dados tecnicos de framework dentro do dump produtivo;
- tabela `boletos` intencionalmente desnormaliza endereco do pagador, que deve ser tratada como snapshot financeiro e nao como erro simples.

## Tabelas auxiliares e criticas

Tabelas auxiliares como `estados`, `cidades`, `cargos`, `tipo_vinculos`, `grau_parentesco`, bancos, grupos e classificacoes sao migradas antes das transacoes. Tabelas criticas sao as que combinam volume e impacto: `conveniados`, `adesoes`, `guias`, `guias_itens`, `lancamentos`, `boletos` e contratos.

## Dados sensiveis

| Dado | Local de origem | Tratamento alvo |
|---|---|---|
| CPF/RG/CNS | beneficiarios e usuarios | minimizar exposicao e mascarar listagens |
| Conta bancaria | dados bancarios e boletos | restringir acesso |
| Anexos e documentos | guias e credenciamento | storage privado e referencia controlada |
| Credenciais de integracao | operadora e ambiente | variaveis/secret manager, nao tabela comum |

## Reaproveitar, normalizar e descartar

| Tratamento | Exemplos |
|---|---|
| Reaproveitar | beneficiarios, adesoes, guias, prestadores, produtos, financeiro, CID e CBHPM |
| Normalizar/remodelar | users para Supabase Auth + `Profile`; permissions para RBAC novo; origens polimorficas para FKs explicitas |
| Descartar da migracao de dominio | `failed_jobs`, `migrations`, `menus`, `personal_access_tokens` |
| Arquivar conforme politica | logs antigos e historicos de baixa relevancia operacional apos homologacao |

## Modelo alvo

O `schema.prisma` novo possui modelos explicitos, enums tipados e mapeamentos `@@map` para tabelas PostgreSQL. Ele cobre administracao, empresas, beneficiarios, produtos, prestadores, tabelas medicas, guias, financeiro, credenciamento, auditoria, mensagens e parametros.

### Relacoes centrais do modelo novo

| Relacao | Leitura de negocio |
|---|---|
| `Operadora -> Produto -> ProdutoPreco` | plano e precificacao |
| `Conveniado -> Adesao -> Produto` | beneficiario inscrito em plano |
| `Adesao -> Empresa/Secretaria` | origem do vinculo coletivo |
| `Prestador -> PrestadorContrato -> ContratoItem` | rede contratada e valores |
| `Guia -> GuiaItem -> GuiaAuditoria/Historico` | fluxo assistencial rastreavel |
| `Guia -> LancamentoGuia -> Lancamento` | ponte assistencial-financeira |
| `Lancamento -> Boleto/Mensalidade/LotePagamento` | cobranca e pagamento |
| `Profile -> UsuarioRole -> Role -> Permissao` | acesso interno |

O desenho novo evita uma tabela de usuario com senha no dominio de negocio. `Profile.userId` referencia o UUID da identidade Auth administrada pelo Supabase.
