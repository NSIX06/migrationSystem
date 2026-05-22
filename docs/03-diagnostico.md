# 03 - Diagnostico

## Metodo de diagnostico

O diagnostico foi produzido por leitura do dump legado e comparacao com o schema alvo. Foram observadas tabelas, colunas, indices, relacionamentos, dados sensiveis, artefatos de framework e fluxos exigidos pelos modulos de negocio.

## Problemas tecnicos e estruturais

| Problema | Diagnostico especifico | Impacto |
|---|---|---|
| Banco misto | Estruturas Laravel convivem com tabelas assistenciais | Dificulta evolucao e migracao seletiva |
| Polimorfismo | Enderecos, documentos e dados bancarios dependem de tipo/origem no legado | Relacionamentos orfaos podem passar despercebidos |
| Soft delete irregular | Tabelas de negocio usam exclusao logica de modo desigual | Consultas e historicos podem divergir |
| Nomenclatura heterogenea | Ingles, portugues e nomes de pivots diferentes | Custo de manutencao e onboarding |
| Tabelas densas | `guias_itens` concentra muitas possibilidades de item | Queries, validacao e UX ficam complexas |

## Problemas de seguranca

O banco legado contem dados pessoais, financeiros e assistenciais. O principal risco nao e a simples existencia desses dados, mas sua combinacao com desenho tecnico antigo:

- credenciais e parametros bancarios aparecem acoplados a registros de operadora;
- o controle de acesso esta centrado em tabelas legadas de roles, tokens e menus;
- nao ha evidencias no dump de politicas PostgreSQL RLS para isolamento no banco;
- logs legados existem, mas nao formam uma trilha unificada e imutavel de auditoria;
- documentos e anexos exigem politica clara de storage, acesso e retenção.

## Usabilidade e operacao

O dump nao mede experiencia visual, mas revela complexidade operacional: uma guia atravessa historico, auditoria, atendimento, anexos e faturamento; um beneficiario depende de adesao, produto, salario, cargo e empresa. Sem telas setoriais, filtros, indicadores e permissoes visiveis, o operador tende a navegar por formularios extensos e consultas dispersas.

O novo MVP ja endereca parte disso com:

- login;
- dashboard com indicadores de beneficiarios, guias pendentes e financeiro em aberto;
- listagens e detalhes de beneficiarios, prestadores, guias e financeiro;
- relatorios;
- telas administrativas de usuarios, perfis, permissoes e logs.

## Logs, dashboards e manutencao

Nao se deve afirmar que o legado nao possui logs: o SQL possui `log_acessos` e `log_operacoes`. O problema diagnosticado e a falta de uma trilha de auditoria padronizada para o modelo novo e protegida por politica operacional. A solucao alvo adota `AuditLog` e registra operacoes administrativas e de workflow.

Tambem nao ha tabela que represente dashboards no legado. O novo sistema gera indicadores por consultas controladas sobre `Adesao`, `Guia` e `Lancamento`, reduzindo a dependencia de planilhas e contagens manuais.

## Performance e horario de pico

Os pontos de maior risco de pico sao:

1. fila de guias solicitadas e autorizacoes;
2. importacao TISS e anexos;
3. emissao/baixa de boletos e remessas;
4. dashboards e relatorios sobre lancamentos e historicos.

Indices, filtros por operadora, paginacao, agregacoes controladas e migracao por fases reduzem a chance de degradacao. A validacao deve medir P95 das listagens criticas e nao apenas sucesso funcional.

## Conclusao diagnostica

O dominio do legado e rico e reaproveitavel. A fragilidade esta na base tecnica: seguranca, integridade, padronizacao, operabilidade e custo de manutencao. A migracao preserva a regra de negocio e substitui os pontos de risco por modelagem explicita, autenticacao moderna e documentacao verificavel.
