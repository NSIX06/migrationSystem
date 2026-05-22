# 05 - Funcoes

## Funcionalidades reais e evolucao proposta

| Funcao | Objetivo e funcionamento | Melhoria na nova versao |
|---|---|---|
| 1. Login | Autenticar usuario antes de acessar rotas internas | Supabase Auth, sessao SSR e middleware |
| 2. Cadastro de usuarios | Criar conta, perfil interno e role | Server Action, cliente admin seguro e RBAC |
| 3. Perfis e permissoes | Definir acesso por modulo e acao | `Role`, `Permissao`, vinculos e tela de gestao |
| 4. Cadastro de beneficiarios | Manter dados pessoais e documentais do conveniado | Busca estruturada, detalhe e schema tipado |
| 5. Gestao de adesoes | Vincular beneficiario a produto, empresa e vigencia | Relacionamentos Prisma explicitos |
| 6. Cadastro de prestadores | Manter clinicas, hospitais, laboratorios e profissionais | Detalhe com tipo, especialidade e contrato |
| 7. Autorizar guias | Consultar fila, aprovar ou negar autorizacao | Workflow por status e historico auditavel |
| 8. Auditar itens de guia | Revisar atendimento, glosa e justificativas | Separacao entre guia, item e auditoria |
| 9. Importar guias | Receber lotes TISS do prestador | `GuiaImportacao` e validacao por lote |
| 10. Financeiro | Listar lancamentos e agregados por status | Tela setorial e filtros |
| 11. Boletos e mensalidades | Cobrar mensalidade e coparticipacao | Segredos fora do dominio e validacao financeira |
| 12. Pagamento de prestadores | Lotes e vinculo de guias faturadas | Rastreabilidade por lote e lancamento |
| 13. Relatorios | Consolidar indicadores assistenciais e financeiros | Agregacoes sobre banco novo |
| 14. Logs | Registrar alteracoes relevantes | `AuditLog` unificado |
| 15. Credenciamento | Analisar solicitacao e documentos do prestador | Storage e historico de decisao |
| 16. Parametros | Controlar comportamento operacional | Parametros centralizados e auditaveis |

## Funcoes ja visiveis no MVP

As rotas implementadas confirmam a materializacao inicial de:

- `/login`;
- `/dashboard`;
- `/conveniados` e detalhe;
- `/prestadores` e detalhe;
- `/guias` e detalhe/autorizacao;
- `/financeiro`;
- `/relatorios`;
- `/admin`, usuarios, perfis, permissoes e logs.

## Funcoes preservadas no modelo alvo

Nem todo modulo do banco legado ja possui tela final no MVP. Ainda assim, o schema novo preserva entidades para produtos, precos, contratos, boletos, credenciamento, mensagens, fiscalizacao contratual e solicitacoes cadastrais. Isso impede que a demonstracao reduza o sistema a apenas telas ja prontas.
