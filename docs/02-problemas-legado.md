# 02 — Problemas do Sistema Legado ServSaúde

> Todos os problemas listados foram identificados diretamente pela análise do arquivo `servsaude_banco_completo.sql`.

---

## 1. Problemas Estruturais do Banco de Dados

### P01 — Artefatos do Framework no Schema de Produção

**Severidade**: Alta  
**Tabelas afetadas**: `failed_jobs`, `migrations`, `personal_access_tokens`

Estas tabelas são geradas automaticamente pelo Laravel e não representam dados de negócio. Estão no mesmo schema que tabelas críticas como `guias` e `lancamentos`, poluindo o modelo e causando confusão.

```sql
-- Tabelas que NÃO deveriam existir em um schema de negócio:
CREATE TABLE public.failed_jobs (...)    -- controle interno do Laravel Queue
CREATE TABLE public.migrations (...)    -- controle de versão do Eloquent
CREATE TABLE public.personal_access_tokens (...) -- tokens Sanctum
```

**Impacto**: Dificulta análise, gera ruído em backups e documentação.  
**Solução**: Eliminar do schema de negócio no novo sistema. Auth via Supabase Auth.

---

### P02 — Menu Dinâmico Armazenado no Banco

**Severidade**: Média  
**Tabela afetada**: `menus`

A tabela `menus` contém a estrutura de navegação da aplicação (ícones, links, permissões, pai/filho). Isso acopla lógica de apresentação ao banco de dados.

```sql
CREATE TABLE public.menus (
    name, is_divisor, parameter, link, permission,
    fixed_id, parent_id, icon_family, icon, deleted_at
);
```

**Impacto**: Qualquer mudança no menu exige migration de banco. Dificulta versionamento e testes.  
**Solução**: Menus definidos em código (TypeScript), controlados por permissões via middleware.

---

### P03 — Relacionamentos Polimórficos sem Foreign Key

**Severidade**: Crítica  
**Tabelas afetadas**: `documentos`, `enderecos`, `dados_bancarios`

Estas tabelas usam o padrão Laravel de polimorfismo com colunas `tabela` (string) + `origem_id` (integer), sem FK real:

```sql
-- documentos
tabela text,        -- ex: "conveniados", "prestadores"
origem_id integer,  -- ID do registro em qualquer tabela

-- enderecos
tabela text,
origem_id integer,

-- dados_bancarios
tabela character varying(255),
origem_id bigint NOT NULL,
```

**Impacto**:
- Impossível criar FK — banco não pode garantir integridade referencial
- Impossível criar índice composto eficiente
- Queries exigem `WHERE tabela = 'conveniados'` — propenso a erros de digitação
- Dados órfãos indetectáveis sem query manual

**Solução**: Separar em tabelas específicas por entidade (`DocumentoConveniado`, `EnderecoEmpresa`, etc.) ou usar coluna de FK tipada por entidade.

---

### P04 — FKs Auto-referenciais Sem Sentido de Negócio

**Severidade**: Alta  
**Tabelas afetadas**: `documentos_credenciamento`, `motivo_encerramentos`

O script `04_aplicar_foreign_keys_not_valid.sql` adiciona FKs onde uma tabela referencia a si própria:

```sql
SELECT public._add_fk_if_valid('documentos_credenciamento', 'id', 'documentos_credenciamento', 'id', ...);
SELECT public._add_fk_if_valid('motivo_encerramentos', 'id', 'motivo_encerramentos', 'id', ...);
```

Uma tabela referenciar seu próprio `id` com FK não tem propósito funcional — é um artefato de geração automática equivocado.

**Impacto**: Constraints inúteis que podem causar falhas em operações de UPDATE/DELETE.  
**Solução**: Remover essas FKs no novo schema.

---

### P05 — Timestamps Hardcoded nos Defaults

**Severidade**: Média  
**Tabelas afetadas**: `guias`, `guias_itens`, `guias_auditoria`, `guias_atendimentos`, `guias_historico`, `lancamentos`, `fiscal_contratos`, `gestantes`, `solicitacoes_atualizacao_cadastral`

```sql
-- Exemplos reais encontrados no banco:
data_hora timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp
data_hora timestamptz DEFAULT '2024-01-19 13:56:01'::timestamp
data_inicio date DEFAULT '2024-01-19'::date
data_solicitacao date DEFAULT '2024-04-10'::date
```

**Impacto**: Novos registros inseridos sem informar a data recebem um valor de 2024 fixo, corrompendo dados silenciosamente.  
**Solução**: Todos os defaults de data/hora devem ser `DEFAULT now()` ou `DEFAULT CURRENT_DATE`.

---

### P06 — Campo `disk` Acoplado ao Storage do Laravel

**Severidade**: Média  
**Tabelas afetadas**: `conveniados`, `boletos`, `guias_anexos`, `documentos`, `solicitacoes_atualizacao_cadastral`, `solicitacoes_credenciamento_documentos`

```sql
disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
```

Este campo controla qual "disk" do Laravel (local, s3, public) armazena o arquivo. É uma coluna de infraestrutura interna do framework armazenada no banco.

**Impacto**: Acoplamento total entre storage e banco. Migrar de disco exige UPDATE em massa no banco.  
**Solução**: Storage gerenciado pelo Supabase Storage; URL do arquivo armazenada no banco como path relativo.

---

### P07 — Tabela de Controle de Migração no Schema de Produção

**Severidade**: Baixa  
**Tabela afetada**: `_migration_validation_issues`

Esta tabela foi criada pelo script de migração para registrar problemas encontrados durante a validação. É uma tabela temporária de diagnóstico que não deveria existir permanentemente.

**Solução**: Remover após a validação. Não incluir no schema do novo sistema.

---

### P08 — Desnormalização do Endereço do Pagador em `boletos`

**Severidade**: Alta  
**Tabela afetada**: `boletos`

Os dados de endereço do pagador estão embutidos diretamente na tabela `boletos`:

```sql
pagador_tipo_inscricao character varying(255) NOT NULL,
pagador_numero_inscricao character varying(255) NOT NULL,
pagador_nome character varying(255) NOT NULL,
pagador_endereco character varying(255) NOT NULL,
pagador_cep character varying(255) NOT NULL,
pagador_cidade_id bigint NOT NULL,    -- FK existe aqui
pagador_bairro character varying(255) NOT NULL,
-- Mas cidade e UF também em texto livre:
cidade character varying(255),
uf character varying(255),
```

**Impacto**: Atualizar endereço de um beneficiário não atualiza boletos existentes. Dados de endereço duplicados (em `enderecos` e em `boletos`).  
**Solução**: Manter snapshot do endereço no boleto (correto para boleto bancário — deve refletir o endereço no momento da emissão), mas documentar essa decisão claramente.

---

### P09 — Enums como Integers Sem Documentação

**Severidade**: Alta  
**Tabelas afetadas**: praticamente todas

O banco usa `integer` para representar enums em toda a aplicação, sem documentação no schema:

```sql
-- adesoes
tipo_cliente integer NOT NULL,   -- o que é 1, 2, 3?
status integer DEFAULT 1,        -- 1=ativo? 2=suspenso? 3=encerrado?

-- guias
tipo smallint,                   -- 1=consulta? 2=exame? 3=internação?
tipo_autorizacao smallint,
carater_atendimento smallint,
status smallint,

-- boletos
status integer,                  -- 1=emitido? 2=pago? 3=cancelado? 4=vencido? 5=?
codigo_estado_titulo integer,

-- conveniados
sexo smallint,                   -- 1=M? 2=F?
estado_civil integer,            -- 1=solteiro... 7=?
pcd integer,                     -- 1=sim? 2=não?
```

**Impacto**: Código da aplicação precisa conhecer esses valores "mágicos". Bugs silenciosos quando alguém usa 0 em vez de 1. Impossível entender queries no banco sem o código-fonte.  
**Solução**: Criar enums PostgreSQL tipados no Prisma para cada campo de status/tipo.

---

### P10 — Mistura de Idiomas no Schema

**Severidade**: Baixa  
**Tabelas afetadas**: `roles`, `permissions`, `menus`

```sql
-- Inglês:
roles: name, slug, active
permissions: module, name, slug, active, description
menus: name, is_divisor, parameter, link, permission, icon_family, icon

-- Português (resto do sistema):
conveniados: nome, cpf, data_nascimento, ativo
prestadores: nome, razao_social, cpf_cnpj, ativo
```

**Impacto**: Inconsistência na leitura do schema e nas queries. Indica adoção de pacote Laravel de terceiros (Bouncer ou similar) sem adaptação.  
**Solução**: Padronizar tudo em português no novo schema.

---

### P11 — `personal_access_tokens` Incompleto (Sanctum)

**Severidade**: Alta  
**Tabela afetada**: `personal_access_tokens`

```sql
CREATE TABLE public.personal_access_tokens (
    id, name, token, abilities, last_used_at, created_at, updated_at
    -- FALTAM: tokenable_type, tokenable_id
);
```

O schema padrão do Laravel Sanctum exige `tokenable_type` e `tokenable_id` para o polimorfismo. A ausência indica que a tabela foi modificada ou está incompleta, o que pode causar falhas na autenticação.

**Solução**: Substituir completamente por Supabase Auth no novo sistema.

---

### P12 — Inconsistência no Soft Delete

**Severidade**: Média

Algumas tabelas têm `deleted_at` (soft delete); outras não, sem critério claro:

**Com soft delete**: `conveniados`, `prestadores`, `guias`, `lancamentos`, `boletos`, `adesoes`, `empresas`  
**Sem soft delete**: `cid`, `historico_credenciamentos`, `medicamento_brasindice`, `remessa_desconto_item`, `tabela_precos_itens`, `log_acessos`, `log_operacoes`

**Impacto**: Comportamento inconsistente — alguns dados são "apagados" de forma reversível, outros de forma permanente, sem justificativa de negócio.  
**Solução**: Definir política clara: tabelas de negócio têm soft delete; tabelas de log nunca apagam; tabelas de referência (CID, CBHPM) são versionadas por edição.

---

## 2. Problemas de Segurança

### S01 — Credenciais em Texto Simples na Tabela `operadoras`

**Severidade**: Crítica

```sql
certificado character varying(255),        -- caminho do certificado digital
senha_certificado character varying(255),  -- senha do certificado em TEXTO CLARO
boleto_client_id character varying(255),   -- credencial de API bancária
boleto_client_secret text,                 -- SECRET da API bancária em TEXTO CLARO
boleto_gw_dev_app_key character varying(255), -- chave de API
```

**Impacto**: Um vazamento do banco expõe as credenciais bancárias da operadora diretamente. Viola PCI-DSS e LGPD.  
**Solução**: Armazenar apenas referências criptografadas. Secrets de API devem ficar em variáveis de ambiente ou vault (ex: Supabase Vault / AWS Secrets Manager).

---

### S02 — Ausência de Row Level Security (RLS)

**Severidade**: Alta

O schema não define nenhuma política de RLS (Row Level Security). No contexto de multi-tenant (múltiplas operadoras potencialmente no mesmo banco), qualquer usuário autenticado poderia acessar dados de outra operadora via query direta.

**Solução**: Implementar RLS no Supabase para garantir que cada usuário só acessa dados da sua operadora.

---

### S03 — Logs sem Proteção contra Adulteração

**Severidade**: Média  
**Tabelas afetadas**: `log_acessos`, `log_operacoes`

Os logs são tabelas comuns sem qualquer mecanismo de proteção contra alteração. Um usuário com acesso ao banco pode modificar ou apagar registros de auditoria.

```sql
-- log_operacoes tem deleted_at — log NUNCA deveria ser deletável
deleted_at timestamptz
```

**Solução**: Logs imutáveis (INSERT-only, sem UPDATE/DELETE via RLS). Considerar trigger de append-only.

---

## 3. Problemas de Performance

### Perf01 — Tabelas de Log sem Particionamento

**Severidade**: Média  
**Tabelas afetadas**: `log_acessos`, `log_operacoes`

Crescimento contínuo sem particionamento por data. Com anos de dados, queries nestas tabelas se tornam lentas.

**Solução**: Particionamento por mês (`PARTITION BY RANGE (data_hora)`).

---

### Perf02 — `guias_itens` com 30+ Colunas Opcionais

**Severidade**: Média

```sql
-- Colunas opcionais em guias_itens que só fazem sentido para tipos específicos:
hora_inicial, hora_final,           -- só para internações
codigo_tabela, codigo_despesa,      -- só para importação TISS
codigo_procedimento,                -- duplicado de referencia_id
grau_part,                         -- só para cirurgias
```

Uma tabela única com 30+ colunas sendo usadas apenas parcialmente causa bloat e confusão.  
**Solução**: Separar em subtipos especializados ou usar JSONB para dados variáveis por tipo de guia.

---

### Perf03 — Índices Adicionados Post-hoc

O arquivo `02_indices_auxiliares.sql` adiciona centenas de índices após a criação das tabelas, com 2–4 índices por tabela mesmo em colunas raramente usadas em WHERE (ex: `idx_bancos_ativo`, `idx_cargos_ativo`).

**Impacto**: Excesso de índices desacelera INSERTs/UPDATEs sem benefício correspondente em SELECTs.  
**Solução**: Índices seletivos baseados em queries reais. Usar EXPLAIN ANALYZE antes de criar cada índice.

---

## 4. Resumo dos Problemas por Severidade

| Severidade | Qtd | Problemas |
|---|---|---|
| **Crítica** | 2 | P03 (polimórficos), S01 (credenciais texto claro) |
| **Alta** | 6 | P01, P04, P08, P09, P11, S02 |
| **Média** | 5 | P02, P05, P06, P12, S03, Perf01, Perf02 |
| **Baixa** | 2 | P07, P10 |

---

## 5. O que o Novo Sistema Resolve

| Problema | Solução no Novo Sistema |
|---|---|
| Artefatos Laravel | Supabase Auth substitui Sanctum; sem `failed_jobs` no schema |
| Polimórficos sem FK | Tabelas específicas por entidade com FK tipada |
| Credenciais em texto | Supabase Vault / variáveis de ambiente |
| Enums inteiros | `enum` tipado no Prisma schema |
| Sem RLS | Políticas RLS no Supabase por operadora_id |
| Logs deletáveis | INSERT-only via RLS + trigger |
| Timestamps hardcoded | `@default(now())` em todo Prisma schema |
| Menu no banco | Configuração em TypeScript, controlada por permissão |
