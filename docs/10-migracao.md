# 10 - Estrategia de Migracao

## Estrategia escolhida

A recomendacao e migracao gradual no padrao Strangler Fig, nao Big Bang. O sistema possui processos assistenciais e financeiros com risco operacional alto; desligar tudo em uma unica virada ampliaria rollback, homologacao e impacto em horario de pico.

## Fases

| Fase | Conteudo | Saida esperada |
|---|---|---|
| 0. Preparacao | backup, ambientes, schema, scripts e mascaramento de dados de teste | base pronta |
| 1. Referencias | cidades, CID, procedimentos, CBHPM, bancos e tabelas auxiliares | referencias consistentes |
| 2. Acesso | Supabase Auth, profiles, roles e permissoes | login e RBAC homologados |
| 3. Cadastros | operadora, empresas, produtos, beneficiarios e prestadores | consultas setoriais confiaveis |
| 4. Nucleo | guias, historicos, financeiro, boletos e lotes | operacao critica validada |
| 5. Virada | congelamento, carga delta, DNS, smoke test e suporte | novo sistema oficial |

## Validacao e homologacao

Cada fase deve encerrar com:

- contagem de registros;
- validação de chaves e orfaos;
- amostra funcional por setor;
- log de excecoes ETL;
- aceite do responsavel de negocio.

## Rollback

Rollback deve ser por fase. Enquanto um modulo nao estiver aceito, o legado continua fonte de verdade. Na virada, manter backup imutavel, janela de congelamento e plano documentado de retorno de trafego e restauracao de delta.

## Horario de pico

Evitar migrar guias e financeiro em periodo de autorizacao intensa, fechamento de mensalidade, emissao de boletos ou remessa de folha. Cargas pesadas devem ocorrer em janela controlada; validacoes de leitura podem ocorrer antes.

## Evitar perda de dados

- backups testados antes da carga;
- scripts idempotentes;
- mapeamento de IDs legado/nova base;
- trilha de rejeicoes;
- comparacao financeira;
- congelamento ou captura delta antes do go-live.

O detalhamento tecnico de scripts e criterios de fase permanece em `docs/05-migracao.md`.
