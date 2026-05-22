# 13 - Validacao de Dados

## Principios

Validar migracao significa provar que a informacao relevante continua correta depois da transformacao. A estrategia combina comparacao quantitativa, integridade relacional, amostragem operacional e homologacao setorial.

## Checklist de validacao

| Validacao | Exemplo |
|---|---|
| Contagem de registros | total de conveniados ativos legado x novo |
| Totais financeiros | soma de lancamentos e boletos por status/competencia |
| Relacionamentos | guia com beneficiario e prestador validos |
| Status/enums | nenhum codigo legado sem enum alvo |
| Permissoes | profile com role e permissoes esperadas |
| Documentos | arquivo referenciado e acessivel ao perfil correto |
| Amostra funcional | atendimento abre detalhe e financeiro confere boleto |

## Migracao piloto

Antes da virada, executar piloto com fatia representativa:

- uma operadora;
- beneficiarios ativos, suspensos e encerrados;
- prestadores PF e PJ;
- guias em status diferentes;
- financeiro pago, aberto e cancelado;
- usuarios de setores distintos.

## Homologacao

Atendimento valida cadastros e busca. Auditoria valida guias e historicos. Financeiro valida totais e cobrancas. Administracao valida usuarios e permissoes.

## Evidencias

O relatorio final deve anexar:

1. queries comparativas;
2. registros rejeitados e correcao;
3. prints das telas homologadas;
4. aceite por setor;
5. decisao de go/no-go.

Consultas e checklists detalhados estao em `docs/08-validacao.md`.
