# 06 — Matriz de Riscos

> Riscos identificados para o projeto de migração do ServSaúde, classificados por probabilidade × impacto, com mitigação e plano de contingência.

---

## 1. Metodologia

**Escala de probabilidade**: 1 (raro) → 5 (quase certo)  
**Escala de impacto**: 1 (desprezível) → 5 (catastrófico)  
**Score = Probabilidade × Impacto**

| Score | Classificação | Cor |
|---|---|---|
| 1–4 | Baixo | Verde |
| 5–9 | Médio | Amarelo |
| 10–19 | Alto | Laranja |
| 20–25 | Crítico | Vermelho |

---

## 2. Matriz de Riscos

| # | Risco | Prob | Impacto | Score | Nível |
|---|---|---|---|---|---|
| R01 | Inconsistência de dados entre legado e novo banco | 4 | 5 | 20 | Crítico |
| R02 | Downtime não planejado durante migração de guias | 3 | 5 | 15 | Alto |
| R03 | Perda de dados financeiros (lançamentos/boletos) | 2 | 5 | 10 | Alto |
| R04 | Enums legados com valores não mapeados (NULL/inválido) | 4 | 3 | 12 | Alto |
| R05 | Resistência dos usuários ao novo sistema | 4 | 3 | 12 | Alto |
| R06 | Falha na integração com API bancária (boletos) | 3 | 4 | 12 | Alto |
| R07 | Dados sensíveis expostos durante a migração | 2 | 5 | 10 | Alto |
| R08 | Performance insuficiente para volume de guias (500k+) | 3 | 3 | 9 | Médio |
| R09 | Dependência de terceiros: Supabase indisponível | 2 | 4 | 8 | Médio |
| R10 | Mudança regulatória ANS durante o projeto | 1 | 4 | 4 | Baixo |

---

## 3. Detalhamento dos Riscos

---

### R01 — Inconsistência de Dados Legado → Novo

**Probabilidade**: 4 (alta) — banco legado tem 14 problemas estruturais documentados (P01–P12, S01–S03)  
**Impacto**: 5 (catastrófico) — dados errados no sistema de saúde podem causar negativa indevida de guias

**Causas identificadas no banco legado**:
- Timestamps hardcoded: `DEFAULT '2024-01-19'` em vez de `now()` (P05) — registros com datas erradas
- Polimórficos sem FK (P03) — registros órfãos indetectáveis sem query manual
- Enums inteiros sem documentação (P09) — valores 0, NULL, ou fora do range podem existir
- FKs auto-referenciais (P04) — documentos_credenciamento referencia seu próprio id

**Mitigação**:
1. Executar `docs/08-validacao.md` antes de cada fase ETL
2. Relatório de inconsistências gerado em `_migration_validation_issues` no banco legado
3. Regra de aceite: contagem de discrepâncias = 0 antes de avançar de fase

**Plano de contingência**:
- Manter legado em modo leitura durante toda a Fase 3 e 4
- Rollback por fase (< 2h para Fase 3, < 15 min para Fase 4)
- Log detalhado de cada linha rejeitada pelo ETL com motivo

**Indicador de alerta**: qualquer diferença de contagem > 0,01% em entidades críticas (guias, lançamentos)

---

### R02 — Downtime Não Planejado Durante Migração de Guias

**Probabilidade**: 3 (moderada) — Fase 4 é complexa e envolve o maior volume de dados  
**Impacto**: 5 (catastrófico) — interrupção da emissão de guias viola prazos ANS

**Causas possíveis**:
- Script ETL com erro de constraint (FK não satisfeita na ordem de inserção)
- Timeout na conexão com banco legado (MySQL) durante leitura em massa
- Lock de tabela no legado durante a janela de migração

**Mitigação**:
1. Executar migrações em lotes de 10.000 registros com COMMIT incremental
2. Janela de manutenção planejada: sábado 00h–06h (menor volume de atendimentos)
3. Ambiente de staging com cópia real dos dados para dry run completo (D-7)
4. Monitoramento em tempo real: queries de contagem a cada 15 min durante o ETL

**Plano de contingência**:
- Rollback: redirecionar DNS de volta ao legado em < 15 min
- Manter equipe de plantão durante toda a janela de migração
- Comunicar prestadores e beneficiários sobre a janela de manutenção com 7 dias de antecedência

**Indicador de alerta**: ETL de guias > 4h de duração → acionar rollback

---

### R03 — Perda de Dados Financeiros

**Probabilidade**: 2 (baixa) — com validação adequada, improvável  
**Impacto**: 5 (catastrófico) — perda de histórico de pagamentos gera problemas legais e regulatórios

**Causas possíveis**:
- Lançamentos com FKs para guias inexistentes (dados corrompidos no legado)
- Diferença de timezone entre MySQL (legado) e PostgreSQL (novo) em timestamps
- Arredondamento de valores decimais (DECIMAL(10,2) vs Numeric Prisma)

**Mitigação**:
1. Backup completo do MySQL legado (mysqldump) antes de qualquer ETL financeiro
2. Script de validação de totais financeiros centavo a centavo (ver `docs/08-validacao.md`)
3. Timezone: padronizar UTC em ambos os bancos antes do ETL
4. Decimal: usar `Decimal` do Prisma (não `Float`) para todos os campos financeiros

**Plano de contingência**:
- Backup do MySQL restaurável em < 1h
- Histórico financeiro disponível em modo leitura no legado por 90 dias após go-live

**Indicador de alerta**: qualquer diferença de R$ 0,01 ou mais no total de lançamentos

---

### R04 — Enums Legados com Valores Não Mapeados

**Probabilidade**: 4 (alta) — banco legado usa integers sem documentação; valores inválidos prováveis  
**Impacto**: 3 (moderado) — ETL falha ou dados são migrados incorretamente

**Exemplo real do banco legado**:
```sql
sexo smallint  -- valores esperados: 1=M, 2=F — e se houver 0, 3, ou NULL?
status integer -- no adesoes: valores esperados 1-5 — e se houver 6 ou NULL?
```

**Mitigação**:
1. Executar query de diagnóstico antes de cada ETL de enum:
```sql
-- Descobrir todos os valores únicos de 'sexo' no legado
SELECT sexo, COUNT(*) FROM legado.conveniados GROUP BY sexo ORDER BY 1;
```
2. Mapear valores inesperados para `NAO_INFORMADO` (enums têm fallback definido)
3. Logar cada linha com valor inesperado no relatório de ETL

**Plano de contingência**:
- Inserir linhas com valores inválidos com enum = `NAO_INFORMADO` + flag `migradoComErro = true`
- Gerar relatório de registros que precisam de revisão manual pós-migração

---

### R05 — Resistência dos Usuários ao Novo Sistema

**Probabilidade**: 4 (alta) — mudança de interface e fluxo impacta operadores habituados ao legado  
**Impacto**: 3 (moderado) — adoção lenta, suporte elevado, erros operacionais

**Perfis mais afetados**:
- `operadora_autorizacoes`: usa o sistema para emitir/autorizar guias diariamente
- `prestador`: portal diferente do habitual
- `operadora_financeiro`: fluxo de boletos e lotes de pagamento alterado

**Mitigação**:
1. Treinamento por perfil (1 sessão por grupo, 2h) antes do go-live
2. Mockups validados com usuários reais nas Fases 1 e 2 (ver `docs/09-mockups.md`)
3. Manual de uso por módulo (PDF) entregue 2 semanas antes do go-live
4. Canal de suporte dedicado (WhatsApp/Teams) nas primeiras 4 semanas

**Plano de contingência**:
- Legado disponível em modo leitura por 30 dias após go-live para consulta
- Rollback por módulo possível graças ao Strangler Fig

---

### R06 — Falha na Integração com API Bancária

**Probabilidade**: 3 (moderada) — credenciais e endpoint bancário precisam ser reconfigurados no novo sistema  
**Impacto**: 4 (alto) — sem emissão de boletos, cobrança de mensalidades para

**Contexto**: banco legado armazena `boleto_client_id`, `boleto_client_secret` na tabela `operadoras` em texto claro (S01). No novo sistema, essas credenciais vão para Supabase Vault / variáveis de ambiente.

**Mitigação**:
1. Testar integração bancária em sandbox antes do go-live (D-30)
2. Validar nosso número único e geração de código de barras em ambiente de homologação
3. Armazenar credenciais no Supabase Vault (não no banco e não no `.env` em produção)

**Plano de contingência**:
- Emissão manual de boletos pelo sistema bancário como fallback
- Contato com suporte técnico do banco (Itaú/BB) identificado antes do go-live

---

### R07 — Dados Sensíveis Expostos Durante Migração

**Probabilidade**: 2 (baixa) — com controles adequados, risco reduzido  
**Impacto**: 5 (catastrófico) — CPF, dados bancários, credenciais bancárias = LGPD + PCI-DSS

**Dados sensíveis identificados**:
- `senha_certificado` (certificado digital em texto claro)
- `boleto_client_secret` (API bancária em texto claro)
- `conveniados.cpf`, `rg`, `foto`
- `dados_bancarios.agencia`, `conta`

**Mitigação**:
1. ETL executado em rede privada (VPN ou conexão direta entre servidores)
2. Banco de staging não contém dados reais de CPF (mascarados: `123.456.XXX-XX`)
3. `senha_certificado` e `boleto_client_secret` migrados para Supabase Vault — não para o banco
4. Logs de ETL não registram valores de campos sensíveis
5. Conexões com TLS obrigatório (SSL mode = verify-full)

**Plano de contingência**:
- Incidente: notificar ANPD em 72h (LGPD, Art. 48)
- Revogar credenciais bancárias imediatamente e solicitar novas ao banco

---

### R08 — Performance Insuficiente para Volume de Guias

**Probabilidade**: 3 (moderada) — 500k guias + 2M guias_itens é carga significativa  
**Impacto**: 3 (moderado) — lentidão no sistema afeta produtividade; não é downtime

**Mitigação**:
1. Índices definidos no Prisma schema para queries críticas (ver `docs/03-modelagem.md`)
2. Testes de carga com k6 antes do go-live: 100 usuários simultâneos, cenário de pico
3. Paginação em todas as listagens (cursor-based pagination no Prisma)
4. `AuditLog` particionado por mês (reduz scans em queries de período)

**Plano de contingência**:
- Connection pooling via PgBouncer (disponível no Supabase)
- Upgrade de plano Supabase se necessário (Pro → Team)

---

### R09 — Supabase Indisponível

**Probabilidade**: 2 (baixa) — SLA Supabase Pro = 99,9%  
**Impacto**: 4 (alto) — sistema inteiro indisponível

**Mitigação**:
1. Supabase tem backup automático diário (PITR no plano Pro)
2. Read replicas configuradas para queries de leitura (mitigação parcial)

**Plano de contingência**:
- Manter backup local do PostgreSQL (pg_dump semanal em storage externo)
- Plano de DR: restaurar em novo projeto Supabase em < 4h

---

### R10 — Mudança Regulatória ANS Durante o Projeto

**Probabilidade**: 1 (raro) — ciclo regulatório ANS é previsível; próxima revisão da RN 465 não prevista  
**Impacto**: 4 (alto) — exige adaptação do schema e ETL

**Mitigação**:
- Schema flexível: campos `metadados Json?` em `GuiaItem` para acomodar campos TISS novos sem migration
- Monitorar publicações no Diário Oficial / portal ANS durante o projeto

---

## 4. Resumo Visual da Matriz

```
Impacto
  5 │ R03    R01,R02    R07
    │        R06
  4 │ R09,R10
    │              R05,R04
  3 │        R08
    │
  2 │
    │
  1 │
    └─────────────────────────
      1    2    3    4    5   Probabilidade

Legenda: Crítico(■) Alto(▲) Médio(●) Baixo(○)
R01■ R02▲ R03▲ R04▲ R05▲ R06▲ R07▲ R08● R09● R10○
```

---

## 5. Responsáveis e Frequência de Revisão

| Risco | Responsável | Revisão |
|---|---|---|
| R01, R04 | DBA / Desenvolvedor ETL | A cada fase de migração |
| R02, R03 | Líder técnico | Semanal na Fase 4 |
| R05 | Gestor do projeto | Quinzenal |
| R06 | Desenvolvedor backend + equipe bancária | D-30 e D-7 |
| R07 | Segurança da informação | A cada fase |
| R08 | Desenvolvedor + DevOps | D-14 (testes de carga) |
| R09 | DevOps | Monitoramento contínuo |
| R10 | Gestor do projeto | Mensal |
