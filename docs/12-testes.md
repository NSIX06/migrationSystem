# 12 - Testes

## Plano obrigatorio

| Categoria | Objetivo | Execucao | Resultado esperado |
|---|---|---|---|
| Login | autenticar sessao valida e rejeitar senha incorreta | contas piloto por perfil | rota interna protegida |
| Permissoes | validar RBAC e bloqueios | matriz usuario x modulo | acesso minimo correto |
| CRUD | cadastro/edicao/inativacao | usuarios, beneficiarios, guias e prestadores | persistencia e auditoria |
| Dashboard | validar indicadores | comparar agregacoes com queries | totais coerentes |
| Relatorios | filtros e somatorios | amostras por status e competencia | valores reproduziveis |
| Carga | medir consultas criticas | volume de guias/lancamentos | latencia aceitavel |
| Backup | garantir recuperacao | gerar copia e restaurar ambiente piloto | restauracao utilizavel |
| Seguranca | rotas, secrets e dados sensiveis | acesso negado e mascaramento | nenhuma exposicao indevida |
| Integridade | FK, enums e orfaos | queries de validacao | zero erro bloqueante |

## Casos essenciais para a apresentacao

1. login de administrador e logout;
2. usuario sem `users.create` tentando abrir cadastro;
3. cadastro de usuario cria Auth, profile e role;
4. lista de beneficiarios filtra nome/CPF/email;
5. detalhe de guia invalida responde de forma controlada;
6. autorizacao ou negacao registra alteracao;
7. financeiro agrega aberto/pago por status;
8. migration piloto confere contagem e somatorios;
9. restauracao de backup em ambiente isolado.

## Resultado esperado

O aceite depende de sucesso funcional e evidencias: capturas, logs de execucao, queries comparativas e lista de defeitos corrigidos. Teste sem evidencia nao encerra risco de migracao.

O catalogo detalhado de casos AUTH, RBAC, CRUD, regras de negocio, migracao, performance e seguranca esta em `docs/07-testes.md`.
