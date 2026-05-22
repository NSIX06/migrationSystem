# 09 - Usuarios e Permissoes

## Modelo de acesso

O novo sistema separa identidade e autorizacao:

1. Supabase Auth autentica a conta;
2. `Profile` guarda dados internos e status;
3. `Role` e `Permissao` definem acesso;
4. `UsuarioRole` vincula usuario a perfil;
5. `PermissaoUsuario` permite ajuste individual;
6. `AuditLog` registra operacoes relevantes.

Uma conta existente apenas no Supabase Auth nao possui acesso funcional ate ter `Profile` e role no banco do sistema.

## CRUD administrativo

| Operacao | Comportamento |
|---|---|
| Criar usuario | cria ou reaproveita Auth, cria profile e role |
| Editar usuario | altera nome, telefone, tipo, status e perfil |
| Inativar/ativar | controla acesso sem remover historico |
| Excluir logicamente | marca `deletedAt` e status inativo |
| Gerenciar perfil | altera permissoes de roles ativos |

## Perfis do sistema

O seed e a configuracao de permissoes definem perfis como administrador, gestor, atendimento, financeiro, auditoria, credenciamento, beneficiario, prestador e visualizador.

Exemplos:

| Perfil | Acesso caracteristico |
|---|---|
| Administrador | todos os modulos |
| Atendimento | beneficiarios, prestadores, guias e documentos operacionais |
| Financeiro | financeiro, boletos, relatorios e consulta de beneficiarios |
| Auditoria | guias, prestadores, relatorios e logs |
| Beneficiario | portal e dados proprios no desenho alvo |

## Protecao de telas

O sidebar usa permissoes como `beneficiarios.view`, `guias.view`, `financeiro.view` e `settings.view` para mostrar modulos. Server Actions e paginas administrativas chamam `can(actor, slug)` antes de permitir operacoes.

O middleware bloqueia acesso sem sessao e o layout autenticado carrega profile e permissoes. A regra importante e dupla: esconder menu nao substitui checagem no servidor.

## Bloqueios e auditoria

Profiles `INATIVO` ou `BLOQUEADO` nao devem permanecer operando. Alteracoes de usuario, perfil e guia precisam gerar log. A migracao exige validar:

- usuario autenticado sem profile;
- profile sem role;
- role sem permissao esperada;
- permissao negada individualmente;
- beneficiario tentando acessar registro de outro beneficiario.

## Setores e modulos

Permissoes sao nomeadas por modulo e acao, por exemplo `users.create`, `roles.update`, `beneficiarios.view`, `guias.approve`, `financeiro.manage`, `logs.view`. Esse vocabulário permite defesa academica clara: cada setor recebe apenas o conjunto necessario para sua responsabilidade.
