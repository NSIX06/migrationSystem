# 15 - Implantacao

## Plano de implantacao

### Preparacao

- fechar escopo de fase;
- revisar migrations Prisma;
- configurar Supabase Auth, banco e storage;
- validar variaveis de ambiente e secrets;
- selecionar usuarios homologadores.

### Backup

- gerar backup completo do legado;
- testar restauracao em ambiente isolado;
- preservar copia de dumps e scripts utilizados;
- registrar checksum e horario da copia.

### Migracao

- executar carga por ordem de dependencia;
- registrar rejeicoes;
- aplicar carga delta quando necessario;
- bloquear alteracoes criticas durante a janela final.

### Homologacao e treinamento

- smoke test tecnico;
- roteiro por setor;
- treinamento de atendimento, financeiro, auditoria e administracao;
- guia rapido de acesso e escalonamento.

### Virada

| Momento | Acao |
|---|---|
| Antes | backup, freeze, confirmacao de equipe |
| Durante | ETL final, validacao, liberacao de DNS/acesso |
| Depois | monitoramento, plantao e correcao priorizada |

### Monitoramento e suporte

Monitorar erros de autenticacao, consultas lentas, falhas Prisma, volume de guias pendentes, importacoes, criacao de boletos e tentativas de acesso negado. Manter suporte pos-implantacao com responsavel tecnico e responsavel de negocio.

## Infraestrutura proposta

O desenho atual usa Next.js para aplicacao e Supabase PostgreSQL/Auth. Migrations e schema sao controlados por Prisma. Storage privado deve receber anexos e documentos de credenciamento quando o modulo estiver habilitado.

O plano operacional completo de ambiente, Supabase, Vercel, checklist D-14 a D+7 e CI/CD esta em `docs/10-implantacao.md`.
