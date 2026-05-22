# 11 - Riscos

## Matriz resumida

| Risco | Impacto | Probabilidade | Mitigacao |
|---|---|---|---|
| Perda de dados criticos | Muito alto | Media | backup, ETL idempotente e conciliacao |
| Indisponibilidade no go-live | Alto | Media | janela controlada e rollback por fase |
| Inconsistencia de relacoes | Alto | Alta | validar FKs e orfaos antes/depois |
| Falha de autenticacao | Alto | Media | piloto Auth, profile e roles |
| Permissao incorreta | Alto | Media | testes RBAC por perfil e rota |
| Falha de integracao bancaria | Alto | Media | sandbox, secrets e contrato de retorno |
| Lentidao de guias/financeiro | Alto | Media | indices, paginacao e teste de carga |
| Importacao TISS invalida | Medio | Media | validacao por lote e trilha de erro |
| Exposicao LGPD | Muito alto | Baixa/Media | mascaramento, storage privado e acesso minimo |
| Resistência operacional | Medio | Media | treinamento e homologacao setorial |

## Riscos destacados

### Dados e relacionamentos

Polimorfismos e enums do legado elevam risco de conversao incorreta. O ETL deve registrar qualquer origem sem destino e qualquer codigo de status sem mapeamento.

### Autenticacao e autorizacao

O projeto comprovou na pratica que Auth e profile interno sao camadas distintas. Um usuario pode existir no Supabase Auth e ainda nao ter permissoes internas. A migracao deve reconciliar usuarios Auth, profiles e roles antes do aceite.

### Financeiro

Lancamentos e boletos exigem comparacao de valor, competencia, vencimento e status. O risco nao se encerra em contagem de linhas.

### Operacao

Guias pendentes em horario de pico nao podem ficar inacessiveis durante a virada. Fila, anexos, historico e autorizacao devem compor o smoke test.

O detalhamento com responsaveis e plano de resposta esta em `docs/06-riscos.md`.
