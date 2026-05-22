# 01 - Introducao

## Objetivo do trabalho

Este documento apresenta a documentacao final do projeto de migracao do sistema ServSaude. O trabalho foi elaborado a partir de tres fontes reais do repositorio: o dump legado `servsaude_banco_completo.sql`, o novo modelo `prisma/schema.prisma` e a aplicacao Next.js atualmente implementada em `app/`, `actions/`, `components/` e `lib/`.

O objetivo academico e demonstrar como um banco legado de dominio complexo pode ser analisado, diagnosticado, remodelado e migrado com controle de risco. O objetivo tecnico e propor uma nova base para operacao de uma operadora de saude, preservando historico assistencial, financeiro e cadastral enquanto se modernizam seguranca, manutenibilidade e experiencia de uso.

## Contexto do sistema

O ServSaude atende processos de saude suplementar. O banco legado contem tabelas de beneficiarios (`conveniados`, `adesoes`), prestadores (`prestadores`, contratos e especialidades), autorizacoes (`guias`, itens, historico, auditoria), financeiro (`lancamentos`, `boletos`, `mensalidades`, lotes de pagamento) e tabelas tecnicas como CID, CBHPM, medicamentos, materiais e taxas.

Trata-se de um dominio sensivel porque combina:

| Dimensao | Evidencia no banco | Consequencia para a migracao |
|---|---|---|
| Dados pessoais | CPF, RG, CNS, contatos, fotos e enderecos | Protecao LGPD e mascaramento em logs |
| Dados assistenciais | Guias, CID, auditoria e anexos | Integridade historica e rastreabilidade |
| Dados financeiros | Boletos, mensalidades, lotes e verbas | Conferencia monetaria precisa |
| Regras contratuais | Produtos, precos, contratos e coparticipacao | Migracao orientada a relacionamentos |

## Motivacao

A migracao nao foi proposta apenas para trocar tecnologia. O diagnostico do banco legado mostra acoplamento com artefatos do framework anterior, relacionamentos polimorficos sem integridade referencial direta, credenciais operacionais em estruturas de negocio, padroes de soft delete inconsistentes e enums representados por codigos inteiros de dificil leitura.

A nova solucao busca reduzir esses riscos com PostgreSQL, Prisma Schema tipado, autenticacao Supabase, controle de perfis e permissoes, rotas protegidas, logs de auditoria unificados e uma interface orientada aos setores operacionais.

## Escopo da documentacao final

A colecao final cobre:

1. sistema legado e diagnostico;
2. setores e funcoes reais;
3. banco legado, dados criticos e modelagem alvo;
4. arquitetura Next.js, Prisma e Supabase;
5. controle de acesso e auditoria;
6. estrategia de migracao, riscos, testes, validacao e implantacao;
7. catalogo de telas, mockups e roteiro de apresentacao.

Os documentos tecnicos anteriores permanecem em `docs/` como material aprofundado. Esta serie final organiza o conteudo na ordem solicitada para apresentacao, impressao e defesa.
