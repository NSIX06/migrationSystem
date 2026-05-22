-- ============================================================
-- ServSaude - Banco de dados completo (todos os arquivos)
-- Gerado em: 2026-05-20 21:44:47
-- IMPORTANTE: scripts 01 a 08 em sequencia para banco novo.
--             Script 99 apaga tudo - usar apenas em dev/hml.
-- ============================================================


-- ============================================================
-- SECAO: SCHEMA EXTRAIDO (dump original)
-- Arquivo: servsaude_schema_extraido.sql
-- ============================================================

-- Estrutura extraída do backup PostgreSQL ServSaúde
-- Observação: este arquivo contém os CREATE TABLE encontrados no texto extraído do dump.
-- O arquivo original .dump também está disponível para download.

-- ============================================================
-- Tabela: public.adesao_reducao_margem
-- ============================================================
CREATE TABLE public.adesao_reducao_margem (
    id bigint NOT NULL,
    adesao_id bigint NOT NULL,
    tipo_reducao integer NOT NULL,
    valor numeric(8,2) NOT NULL,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.adesoes
-- ============================================================
CREATE TABLE public.adesoes (
    id bigint NOT NULL,
    operadora_id bigint NOT NULL,
    empresa_id bigint,
    secretaria_id bigint,
    conveniado_id bigint NOT NULL,
    grupo_familiar integer,
    produto_id bigint NOT NULL,
    produto_preco_id bigint,
    matricula character varying(255),
    tipo_cliente integer NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    data_inicio date NOT NULL,
    data_fim date,
    data_primeiro_pgto date,
    justificativa_encerramento character varying(255),
    dv character varying(255),
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    salario_atual numeric(13,2),
    motivo_encerramento_id integer
);

-- ============================================================
-- Tabela: public.bancos
-- ============================================================
CREATE TABLE public.bancos (
    id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.boleto_lancamentos
-- ============================================================
CREATE TABLE public.boleto_lancamentos (
    id bigint NOT NULL,
    boleto_id bigint NOT NULL,
    lancamento_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.boletos
-- ============================================================
CREATE TABLE public.boletos (
    id bigint NOT NULL,
    operadora_id bigint NOT NULL,
    data_emissao date NOT NULL,
    data_vencimento date NOT NULL,
    valor_original numeric(8,2) NOT NULL,
    nosso_numero integer NOT NULL,
    numero_titulo_cliente character varying(255),
    agencia character varying(255),
    conta character varying(255),
    endereco character varying(255),
    cidade character varying(255),
    uf character varying(255),
    indicador_permissao_recebimento_parcial character varying(255) DEFAULT 'N'::character varying NOT NULL,
    indicador_pix character varying(255) DEFAULT 'S'::character varying NOT NULL,
    pagador_tipo_inscricao character varying(255) NOT NULL,
    pagador_numero_inscricao character varying(255) NOT NULL,
    pagador_nome character varying(255) NOT NULL,
    pagador_endereco character varying(255) NOT NULL,
    pagador_cep character varying(255) NOT NULL,
    pagador_cidade_id bigint NOT NULL,
    pagador_bairro character varying(255) NOT NULL,
    demonstrativo text,
    desconto_tipo integer DEFAULT 0 NOT NULL,
    desconto_data_expiracao date,
    desconto_porcentagem numeric(8,2),
    desconto_valor numeric(8,2),
    multa_tipo integer DEFAULT 0 NOT NULL,
    multa_data date,
    multa_porcentagem numeric(8,2),
    multa_valor numeric(8,2),
    juros_tipo integer DEFAULT 0 NOT NULL,
    juros_porcentagem numeric(8,2),
    juros_valor numeric(8,2),
    pix_qrcode character varying(255),
    instrucoes1 character varying(255),
    instrucoes2 character varying(255),
    instrucoes3 character varying(255),
    instrucoes4 character varying(255),
    status integer DEFAULT 1 NOT NULL,
    codigo_estado_titulo integer DEFAULT 1 NOT NULL,
    error_message text,
    data_baixa date,
    boleto text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.canais_atendimento
-- ============================================================
CREATE TABLE public.canais_atendimento (
    id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255),
    email character varying(255),
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.cargos
-- ============================================================
CREATE TABLE public.cargos (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.cbhpm
-- ============================================================
CREATE TABLE public.cbhpm (
    id bigint NOT NULL,
    cbhpm_edicao_id bigint NOT NULL,
    procedimento_id bigint NOT NULL,
    codigo_porte character varying(255) NOT NULL,
    fracao_porte numeric(8,2) DEFAULT '1'::numeric,
    qtde_uco numeric(13,3) NOT NULL,
    qtde_filme numeric(13,3) NOT NULL,
    porte_anestesico_id bigint,
    nro_auxiliares integer,
    incidencia integer,
    ur boolean DEFAULT false NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.cbhpm_edicoes
-- ============================================================
CREATE TABLE public.cbhpm_edicoes (
    id bigint NOT NULL,
    ano_edicao integer NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.cid
-- ============================================================
CREATE TABLE public.cid (
    id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    sexo_aplicavel character varying(255) NOT NULL,
    grave boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.cidades
-- ============================================================
CREATE TABLE public.cidades (
    id bigint NOT NULL,
    estado_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.comunicado_edicoes
-- ============================================================
CREATE TABLE public.comunicado_edicoes (
    id bigint NOT NULL,
    ano_edicao integer NOT NULL,
    uco numeric(8,2) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.comunicado_portes
-- ============================================================
CREATE TABLE public.comunicado_portes (
    id bigint NOT NULL,
    comunicado_edicao_id bigint NOT NULL,
    codigo_porte character varying(255) NOT NULL,
    valor numeric(8,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.contrato_profissionais
-- ============================================================
CREATE TABLE public.contrato_profissionais (
    id bigint NOT NULL,
    contrato_id bigint NOT NULL,
    prestador_id bigint NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.conveniado_salarios
-- ============================================================
CREATE TABLE public.conveniado_salarios (
    id bigint NOT NULL,
    conveniado_id bigint NOT NULL,
    salario numeric(8,2) NOT NULL,
    data_competencia date NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.conveniados
-- ============================================================
CREATE TABLE public.conveniados (
    id bigint NOT NULL,
    orgao_expedidor_uf_id bigint,
    naturalidade_cidade_id bigint NOT NULL,
    usuario_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date NOT NULL,
    sexo smallint NOT NULL,
    rg character varying(255),
    orgao_expedidor character varying(255),
    cns character varying(255),
    nome_pai character varying(255),
    nome_mae character varying(255) NOT NULL,
    fone1 character varying(255),
    fone2 character varying(255),
    email character varying(255),
    foto text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    estado_civil integer DEFAULT 1 NOT NULL,
    pcd integer DEFAULT 2 NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    cargo_id integer
);

-- ============================================================
-- Tabela: public.dados_bancarios
-- ============================================================
CREATE TABLE public.dados_bancarios (
    id bigint NOT NULL,
    origem_id bigint NOT NULL,
    tabela character varying(255) NOT NULL,
    banco_id bigint NOT NULL,
    tipo smallint NOT NULL,
    agencia character varying(255),
    agencia_dv character varying(255),
    conta character varying(255),
    conta_dv character varying(255),
    operacao character varying(255),
    pix character varying(255),
    pix_tipo character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.deflatores
-- ============================================================
CREATE TABLE public.deflatores (
    id bigint NOT NULL,
    prestadores_contratos_id bigint NOT NULL,
    procedimento_grupo_id bigint NOT NULL,
    tipo smallint NOT NULL,
    percentual numeric(8,2) NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.documentos
-- ============================================================
CREATE TABLE public.documentos (
    id bigint NOT NULL,
    tipo integer NOT NULL,
    tabela text,
    origem_id integer,
    documento text,
    descricao text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.documentos_credenciamento
-- ============================================================
CREATE TABLE public.documentos_credenciamento (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    complemento_descricao character varying(255),
    obrigatorio boolean DEFAULT true NOT NULL,
    active boolean DEFAULT true NOT NULL,
    tipo_pessoa integer DEFAULT 1 NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.editais_credenciamento
-- ============================================================
CREATE TABLE public.editais_credenciamento (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.edital_credenciamento_documentos
-- ============================================================
CREATE TABLE public.edital_credenciamento_documentos (
    edital_id bigint NOT NULL,
    documento_credenciamento_id bigint NOT NULL,
    obrigatorio boolean DEFAULT false NOT NULL,
    updated_at timestamp(0) without time zone DEFAULT '2024-04-22 07:40:35'::timestamp without time zone NOT NULL
);

-- ============================================================
-- Tabela: public.empresa_produto
-- ============================================================
CREATE TABLE public.empresa_produto (
    empresa_id bigint NOT NULL,
    produto_id bigint NOT NULL
);

-- ============================================================
-- Tabela: public.empresa_user
-- ============================================================
CREATE TABLE public.empresa_user (
    user_id bigint NOT NULL,
    empresa_id bigint NOT NULL
);

-- ============================================================
-- Tabela: public.empresas
-- ============================================================
CREATE TABLE public.empresas (
    id bigint NOT NULL,
    tipo smallint NOT NULL,
    cpf_cnpj character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    abreviado text,
    fone character varying(255),
    email character varying(255),
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    contato character varying(255),
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.empresas_verbas
-- ============================================================
CREATE TABLE public.empresas_verbas (
    id bigint NOT NULL,
    empresa_id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    grupo_verba_id bigint
);

-- ============================================================
-- Tabela: public.enderecos
-- ============================================================
CREATE TABLE public.enderecos (
    id bigint NOT NULL,
    cidade_id bigint NOT NULL,
    tabela text,
    origem_id integer,
    tipo integer NOT NULL,
    cep text NOT NULL,
    endereco text NOT NULL,
    numero text,
    complemento text,
    bairro text,
    "default" boolean DEFAULT false NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.especialidades
-- ============================================================
CREATE TABLE public.especialidades (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    cbo character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.estados
-- ============================================================
CREATE TABLE public.estados (
    id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    uf character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.failed_jobs
-- ============================================================
CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- ============================================================
-- Tabela: public.fiscal_contrato_itens
-- ============================================================
CREATE TABLE public.fiscal_contrato_itens (
    id bigint NOT NULL,
    fiscal_contrato_id bigint NOT NULL,
    contrato_id bigint NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.fiscal_contratos
-- ============================================================
CREATE TABLE public.fiscal_contratos (
    id bigint NOT NULL,
    usuario_id bigint NOT NULL,
    data_inicio date DEFAULT '2024-01-19'::date NOT NULL,
    data_fim date NOT NULL,
    portaria character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.gestantes
-- ============================================================
CREATE TABLE public.gestantes (
    id bigint NOT NULL,
    conveniado_id bigint NOT NULL,
    data_inicio_gestacao date DEFAULT '2024-01-19'::date NOT NULL,
    data_final_gestacao date,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.grau_parentesco
-- ============================================================
CREATE TABLE public.grau_parentesco (
    id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.grupo_verbas
-- ============================================================
CREATE TABLE public.grupo_verbas (
    id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.guia_importacoes
-- ============================================================
CREATE TABLE public.guia_importacoes (
    id bigint NOT NULL,
    sequencial_transacao integer NOT NULL,
    lote integer NOT NULL,
    data_hora_arquivo timestamp(0) without time zone NOT NULL,
    prestador_id bigint,
    usuario_id bigint,
    versao_layout character varying(255) NOT NULL,
    arquivo character varying(255) NOT NULL,
    disco character varying(255) NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.guia_motivo_encerramento
-- ============================================================
CREATE TABLE public.guia_motivo_encerramento (
    id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    termo character varying(255) NOT NULL,
    data_inicio_vigencia date,
    data_fim_vigencia date,
    data_fim_implantacao date,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.guias
-- ============================================================
CREATE TABLE public.guias (
    id bigint NOT NULL,
    data_hora timestamp(0) without time zone DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    usuario_emissor_id bigint,
    prestador_id bigint,
    profissional_id bigint,
    conveniado_id bigint,
    solicitante_prestador_id bigint,
    lote_pagamento_id bigint,
    tipo_lancamento smallint DEFAULT '1'::smallint NOT NULL,
    tipo_autorizacao smallint DEFAULT '1'::smallint NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    carater_atendimento smallint DEFAULT '1'::smallint NOT NULL,
    guia_origem_id bigint,
    indicacao_clinica character varying(255),
    observacoes character varying(255),
    observacoes_internas character varying(255),
    urgente boolean DEFAULT false NOT NULL,
    conferido boolean DEFAULT false NOT NULL,
    status smallint DEFAULT '1'::smallint NOT NULL,
    data_hora_cancalamento timestamp(0) without time zone,
    cancelado_por_user_id bigint,
    motivo_cancelamento character varying(255),
    justifica_para_auditoria character varying(255),
    guia_importacao_id bigint,
    lote_importacao integer,
    numero_guia_prestador integer,
    data_autorizacao date,
    senha integer,
    data_validade_senha date,
    atendimento_rn character varying(255),
    cnes integer,
    tipo_faturamento integer,
    data_inicio_faturamento date,
    data_final_faturamento date,
    tipo_internacao integer,
    regime_internacao integer,
    diagnostico character varying(255),
    indicador_acidente integer,
    motivo_encerramento integer,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    tipo_autenticacao smallint,
    codigo_autenticacao character varying(255),
    autenticada boolean DEFAULT false NOT NULL
);

-- ============================================================
-- Tabela: public.guias_anexos
-- ============================================================
CREATE TABLE public.guias_anexos (
    id bigint NOT NULL,
    guia_id bigint,
    nome character varying(255),
    arquivo character varying(255),
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.guias_atendimentos
-- ============================================================
CREATE TABLE public.guias_atendimentos (
    id bigint NOT NULL,
    data_hora timestamp(0) without time zone DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    guia_itens_id bigint,
    quantidade numeric(8,2),
    usuario_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.guias_auditoria
-- ============================================================
CREATE TABLE public.guias_auditoria (
    id bigint NOT NULL,
    data_hora_analise timestamp(0) without time zone DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    guia_itens_id bigint NOT NULL,
    quantidade_autorizada numeric(8,2) NOT NULL,
    justificativa character varying(255),
    analise_usuario_id bigint NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.guias_historico
-- ============================================================
CREATE TABLE public.guias_historico (
    id bigint NOT NULL,
    data_hora timestamp(0) without time zone DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    guia_id bigint NOT NULL,
    guia_item_id bigint,
    historico character varying(255) NOT NULL,
    usuario_id bigint NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.guias_itens
-- ============================================================
CREATE TABLE public.guias_itens (
    id bigint NOT NULL,
    data_hora_emissao timestamp(0) without time zone DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    data_hora_autorizacao timestamp(0) without time zone,
    data_hora_atendimento timestamp(0) without time zone,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    guia_id bigint,
    referencia_tabela character varying(255) NOT NULL,
    referencia_id integer,
    quantidade_solicitada numeric(8,2),
    quantidade_atendida numeric(8,2),
    quantidade_glosa numeric(8,2),
    valor_unitario numeric(8,2),
    valor_unitario_glosa numeric(8,2),
    percentual_cooparticipacao numeric(8,2),
    valor_unitario_coparticipacao numeric(8,2),
    valor_total_coparticipacao numeric(8,2),
    percentual_item numeric(8,2),
    quantidade_faturada numeric(8,2),
    valor_unitario_faturado numeric(8,2),
    valor_total_faturado numeric(8,2),
    status smallint DEFAULT '1'::smallint NOT NULL,
    data_execucao date,
    hora_inicial time(0) without time zone,
    hora_final time(0) without time zone,
    codigo_tabela integer,
    codigo_despesa integer,
    codigo_procedimento character varying(255),
    quantidade_autorizada numeric(8,2),
    reducao_acrescimo numeric(8,2),
    valor_total numeric(8,2),
    grau_part integer,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.historico_credenciamentos
-- ============================================================
CREATE TABLE public.historico_credenciamentos (
    id bigint NOT NULL,
    solicitacao_credencimento_id bigint NOT NULL,
    user_id bigint NOT NULL,
    motivo character varying(255) NOT NULL,
    status integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.laboratorios
-- ============================================================
CREATE TABLE public.laboratorios (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.lancamentos
-- ============================================================
CREATE TABLE public.lancamentos (
    id bigint NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    boleto_id integer,
    operadora_id bigint NOT NULL,
    prestador_id bigint,
    conveniado_id bigint,
    tipo_lancamento smallint DEFAULT '2'::smallint NOT NULL,
    data_hora timestamp(0) without time zone DEFAULT '2024-01-19 13:56:01'::timestamp without time zone NOT NULL,
    data_vencimento timestamp(0) without time zone NOT NULL,
    data_baixa timestamp(0) without time zone,
    tipo_pagamento smallint DEFAULT '1'::smallint NOT NULL,
    competencia_folha character varying(255),
    descricao character varying(255),
    valor numeric(8,2) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    grupo_verba_id bigint
);

-- ============================================================
-- Tabela: public.lancamentos_guias
-- ============================================================
CREATE TABLE public.lancamentos_guias (
    id bigint NOT NULL,
    lancamento_id bigint NOT NULL,
    guia_id bigint NOT NULL,
    valor numeric(8,2) NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.log_acessos
-- ============================================================
CREATE TABLE public.log_acessos (
    id bigint NOT NULL,
    data_hora timestamp(0) without time zone,
    usuario_id integer,
    usuario_nome text,
    ip text,
    navegador text,
    recurso text,
    registro_id integer,
    url character varying(255),
    action smallint,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.log_operacoes
-- ============================================================
CREATE TABLE public.log_operacoes (
    id bigint NOT NULL,
    data_hora timestamp(0) without time zone,
    usuario_id integer,
    usuario_nome text,
    ip text,
    navegador text,
    recurso text,
    registro_id integer,
    log text,
    action smallint,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.lote_pagamentos
-- ============================================================
CREATE TABLE public.lote_pagamentos (
    id bigint NOT NULL,
    prestador_id bigint NOT NULL,
    usuario_id bigint NOT NULL,
    lancamento_id bigint,
    data_hora timestamp(0) without time zone NOT NULL,
    referencia_pagamento date NOT NULL,
    status smallint DEFAULT '1'::smallint NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.materiais
-- ============================================================
CREATE TABLE public.materiais (
    id bigint NOT NULL,
    tipo integer NOT NULL,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.materiais_itens
-- ============================================================
CREATE TABLE public.materiais_itens (
    id bigint NOT NULL,
    material_edicao_id bigint NOT NULL,
    material_id bigint NOT NULL,
    valor numeric(8,2) NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.material_edicoes
-- ============================================================
CREATE TABLE public.material_edicoes (
    id bigint NOT NULL,
    edicao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.medicamento_brasindice
-- ============================================================
CREATE TABLE public.medicamento_brasindice (
    id bigint NOT NULL,
    medicamento_edicao_id bigint NOT NULL,
    medicamento_id bigint NOT NULL,
    pmc numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    pfab numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    fracao_pfab numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    fracao_pmc numeric(15,2) DEFAULT '0'::numeric NOT NULL
);

-- ============================================================
-- Tabela: public.medicamento_edicoes
-- ============================================================
CREATE TABLE public.medicamento_edicoes (
    id bigint NOT NULL,
    edicao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.medicamentos
-- ============================================================
CREATE TABLE public.medicamentos (
    id bigint NOT NULL,
    laboratorio_id bigint NOT NULL,
    medicamento_edicao_id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    bras character varying(255) NOT NULL,
    in_ character varying(255) NOT NULL,
    dice character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    apresentacao character varying(255) NOT NULL,
    qtde_embalagem integer NOT NULL,
    ultima_versao integer NOT NULL,
    ean character varying(255) NOT NULL,
    ggrem character varying(255) NOT NULL,
    anvisa character varying(255) NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.mensagens
-- ============================================================
CREATE TABLE public.mensagens (
    id bigint NOT NULL,
    perfil_id bigint,
    tipo integer NOT NULL,
    titulo character varying(255) NOT NULL,
    corpo text NOT NULL,
    idade_inicial integer,
    idade_final integer,
    data_inicial_exibicao date,
    data_final_exibicao date,
    visivel boolean DEFAULT true NOT NULL,
    fixado boolean DEFAULT false NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.mensalidades
-- ============================================================
CREATE TABLE public.mensalidades (
    id bigint NOT NULL,
    conveniado_id bigint NOT NULL,
    competencia date NOT NULL,
    produto_preco_id bigint NOT NULL,
    grupo_verba_id bigint,
    salario numeric(8,2) NOT NULL,
    percentual numeric(8,2) NOT NULL,
    valor numeric(8,2) NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.menus
-- ============================================================
CREATE TABLE public.menus (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    is_divisor boolean DEFAULT false NOT NULL,
    parameter character varying(255),
    link character varying(255),
    permission character varying(255),
    fixed_id integer,
    parent_id integer,
    icon_family character varying(255),
    icon character varying(255),
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.migrations
-- ============================================================
CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);

-- ============================================================
-- Tabela: public.motivo_encerramentos
-- ============================================================
CREATE TABLE public.motivo_encerramentos (
    id bigint NOT NULL,
    motivo character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    tipo smallint DEFAULT '1'::smallint NOT NULL
);

-- ============================================================
-- Tabela: public.operadora_user
-- ============================================================
CREATE TABLE public.operadora_user (
    operadora_id bigint NOT NULL,
    user_id bigint NOT NULL
);

-- ============================================================
-- Tabela: public.operadoras
-- ============================================================
CREATE TABLE public.operadoras (
    id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    tipo smallint NOT NULL,
    cpf_cnpj character varying(255) NOT NULL,
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    fone character varying(255),
    email character varying(255),
    certificado character varying(255),
    senha_certificado character varying(255),
    codigo_ans character varying(6),
    tipo_declarante integer NOT NULL,
    cpf_responsavel character varying(255) NOT NULL,
    indicador_situacao_declaracao character varying(255) NOT NULL,
    cnes character varying(7),
    ativo boolean DEFAULT true NOT NULL,
    percentual_max_desconto_coparticipacao numeric(8,2) DEFAULT 24.9 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    boleto_nr_convenio integer,
    boleto_nr_carteira integer,
    boleto_nr_variacao_carteira integer,
    boleto_nr_controle integer,
    boleto_client_id character varying(255),
    boleto_client_secret text,
    boleto_gw_dev_app_key character varying(255),
    boleto_recebimento_parcial character varying(255) DEFAULT 'N'::character varying NOT NULL,
    boleto_indicador_pix character varying(255) DEFAULT 'S'::character varying NOT NULL,
    boleto_multa_tipo integer DEFAULT 0 NOT NULL,
    boleto_multa_dias_apos_vencimento integer DEFAULT 1,
    boleto_multa_porcentagem numeric(8,2),
    boleto_multa_valor numeric(8,2),
    boleto_juros_tipo integer DEFAULT 0 NOT NULL,
    boleto_juros_porcentagem numeric(8,2),
    boleto_juros_valor numeric(8,2),
    boleto_ambiente integer DEFAULT 1,
    boleto_cancelar_dias_apos_vencimento integer,
    boleto_forma_pagamento_apos_cancelar integer
);

-- ============================================================
-- Tabela: public.parametros
-- ============================================================
CREATE TABLE public.parametros (
    id bigint NOT NULL,
    parameter character varying(255) NOT NULL,
    field_label character varying(255) NOT NULL,
    component text,
    value character varying(255),
    possible_values character varying(255),
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.permission_role
-- ============================================================
CREATE TABLE public.permission_role (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);

-- ============================================================
-- Tabela: public.permissions
-- ============================================================
CREATE TABLE public.permissions (
    id bigint NOT NULL,
    module character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    description character varying(255)
);

-- ============================================================
-- Tabela: public.personal_access_tokens
-- ============================================================
CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.porte_anestesicos
-- ============================================================
CREATE TABLE public.porte_anestesicos (
    porte_anestesico character varying(255) DEFAULT '0'::character varying NOT NULL,
    porte character varying(255)
);

-- ============================================================
-- Tabela: public.prestador_contrato_itens
-- ============================================================
CREATE TABLE public.prestador_contrato_itens (
    id bigint NOT NULL,
    prestadores_contratos_id bigint NOT NULL,
    edicao_medicamento_id bigint NOT NULL,
    acrescimo_medicamentos numeric(8,2),
    tabela_precos_id bigint,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    tipo smallint NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    orcamento_previsto numeric(8,2),
    motivo_encerramento_id bigint,
    data_encerramento timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.prestador_contratos
-- ============================================================
CREATE TABLE public.prestador_contratos (
    id bigint NOT NULL,
    prestador_id bigint NOT NULL,
    data date NOT NULL,
    codigo character varying(255) NOT NULL,
    ocorrencia character varying(255),
    objeto character varying(255) NOT NULL,
    observacoes character varying(255),
    reclamacoes character varying(255),
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.prestador_especialidades
-- ============================================================
CREATE TABLE public.prestador_especialidades (
    prestador_id bigint NOT NULL,
    especialidade_id bigint NOT NULL
);

-- ============================================================
-- Tabela: public.prestador_tipos
-- ============================================================
CREATE TABLE public.prestador_tipos (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.prestador_user
-- ============================================================
CREATE TABLE public.prestador_user (
    prestador_id bigint NOT NULL,
    user_id bigint NOT NULL
);

-- ============================================================
-- Tabela: public.prestadores
-- ============================================================
CREATE TABLE public.prestadores (
    id bigint NOT NULL,
    usuario_id bigint,
    prestadores_classificacao_estabelecimento_id bigint NOT NULL,
    orgao_expedidor_uf_id bigint,
    naturalidade_cidade_id bigint,
    tipo smallint NOT NULL,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    abreviado text,
    cpf_cnpj character varying(255) NOT NULL,
    data_nascimento date,
    rg character varying(255),
    orgao_expedidor character varying(255),
    nome_mae character varying(255),
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    fone character varying(255),
    email character varying(255),
    financeiro_contato_nome character varying(255),
    financeiro_contato_fone character varying(255),
    financeiro_contato_email character varying(255),
    faturamento_contato_nome character varying(255),
    faturamento_contato_fone character varying(255),
    faturamento_contato_email character varying(255),
    tipo_conselho_classe smallint,
    numero_conselho_classe character varying(255),
    procedimentos boolean DEFAULT false NOT NULL,
    material boolean DEFAULT false NOT NULL,
    taxa boolean DEFAULT false NOT NULL,
    medicamentos boolean DEFAULT false NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    prestador_tipo_id integer
);

-- ============================================================
-- Tabela: public.prestadores_classificacao_estabelecimento
-- ============================================================
CREATE TABLE public.prestadores_classificacao_estabelecimento (
    id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    codigo character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.procedimento_subgrupos
-- ============================================================
CREATE TABLE public.procedimento_subgrupos (
    id integer NOT NULL,
    grupo_id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    perc_reducao_segundo_procedimento numeric(8,2) NOT NULL,
    perc_reducao_terceiro_procedimento_em_diante numeric(8,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.procedimentos
-- ============================================================
CREATE TABLE public.procedimentos (
    id integer NOT NULL,
    codigo text NOT NULL,
    procedimento_subgrupo_id integer,
    descricao text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.procedimentos_grupos
-- ============================================================
CREATE TABLE public.procedimentos_grupos (
    id integer NOT NULL,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.produtos
-- ============================================================
CREATE TABLE public.produtos (
    id bigint NOT NULL,
    operadora_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    abrangencia smallint NOT NULL,
    tipo_contratacao integer NOT NULL,
    tipo_carencia smallint NOT NULL,
    tipo_acomodacao integer NOT NULL,
    data_inicio date NOT NULL,
    data_fim date,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.produtos_precos
-- ============================================================
CREATE TABLE public.produtos_precos (
    id bigint NOT NULL,
    produto_id bigint NOT NULL,
    tipo_vinculo_id bigint,
    idade_inicial integer NOT NULL,
    idade_final integer NOT NULL,
    tipo_cobranca integer NOT NULL,
    tipo_cliente integer NOT NULL,
    descricao character varying(255) NOT NULL,
    valor numeric(8,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    grupo_verba_id bigint
);

-- ============================================================
-- Tabela: public.regra_cooparticipacao
-- ============================================================
CREATE TABLE public.regra_cooparticipacao (
    id bigint NOT NULL,
    produto_id bigint NOT NULL,
    nome text NOT NULL,
    tempo_carencia integer,
    carencia boolean NOT NULL,
    sem_limite_para_gestante boolean DEFAULT false NOT NULL,
    auditoria boolean NOT NULL,
    ativo boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.regra_cooparticipacao_itens
-- ============================================================
CREATE TABLE public.regra_cooparticipacao_itens (
    id bigint NOT NULL,
    regra_cooparticipacao_id bigint NOT NULL,
    qtde_inicial integer NOT NULL,
    qtde_final integer NOT NULL,
    percentual_cooparticipacao numeric(8,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.regra_cooparticipacao_procedimentos
-- ============================================================
CREATE TABLE public.regra_cooparticipacao_procedimentos (
    id bigint NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    regra_cooparticipacao_id bigint NOT NULL,
    grupo_procedimento_id integer NOT NULL,
    subgrupo_procedimento_id integer,
    procedimento_id integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.remessa_desconto
-- ============================================================
CREATE TABLE public.remessa_desconto (
    id bigint NOT NULL,
    empresa_id bigint NOT NULL,
    competencia date NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.remessa_desconto_item
-- ============================================================
CREATE TABLE public.remessa_desconto_item (
    id bigint NOT NULL,
    remessa_desconto_id bigint NOT NULL,
    adesao_id bigint NOT NULL,
    matricula character varying(255) NOT NULL,
    salario numeric(8,2) NOT NULL,
    desconto_maximo numeric(8,2) NOT NULL,
    valor_divida numeric(8,2) NOT NULL,
    coparticipacao numeric(8,2) NOT NULL,
    codigo_evento character varying(255) NOT NULL,
    valor numeric(8,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.role_user
-- ============================================================
CREATE TABLE public.role_user (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);

-- ============================================================
-- Tabela: public.roles
-- ============================================================
CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.secretarias
-- ============================================================
CREATE TABLE public.secretarias (
    id bigint NOT NULL,
    empresa_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    cpf_cnpj character varying(255),
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    fone character varying(255),
    email character varying(255),
    contato character varying(255),
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    abreviado character varying(255)
);

-- ============================================================
-- Tabela: public.solicitacoes_atualizacao_cadastral
-- ============================================================
CREATE TABLE public.solicitacoes_atualizacao_cadastral (
    id bigint NOT NULL,
    data_solicitacao date DEFAULT '2024-04-10'::date NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    prestador_id bigint,
    conveniado_id bigint,
    cidade_id bigint NOT NULL,
    endereco character varying(255),
    endereco_nro character varying(255),
    complemento character varying(255),
    bairro character varying(255),
    cep character varying(255),
    email character varying(255),
    telefone character varying(255),
    celular character varying(255),
    observacoes character varying(255),
    comprovante_endereco character varying(255),
    foto character varying(255),
    disk character varying(255),
    status smallint DEFAULT '1'::smallint NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.solicitacoes_credenciamento
-- ============================================================
CREATE TABLE public.solicitacoes_credenciamento (
    id bigint NOT NULL,
    edital_credenciamento_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    tipo integer DEFAULT 1 NOT NULL,
    cpf_cnpj character varying(255) NOT NULL,
    responsavel character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.solicitacoes_credenciamento_documentos
-- ============================================================
CREATE TABLE public.solicitacoes_credenciamento_documentos (
    id bigint NOT NULL,
    solicitacoes_credenciamento_id bigint NOT NULL,
    documento_credenciamento_id bigint NOT NULL,
    arquivo text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    nome_arquivo character varying(255)
);

-- ============================================================
-- Tabela: public.tabela_precos
-- ============================================================
CREATE TABLE public.tabela_precos (
    id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    comunicado_edicao_id bigint NOT NULL,
    cbhpm_edicao_id bigint NOT NULL,
    material_edicao_id bigint NOT NULL,
    valor_uco numeric(8,2) NOT NULL,
    valor_filme numeric(8,2) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.tabela_precos_itens
-- ============================================================
CREATE TABLE public.tabela_precos_itens (
    id bigint NOT NULL,
    tabela_preco_id bigint NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    referencia_id integer NOT NULL,
    valor_porte numeric(8,2) NOT NULL,
    fracao_porte numeric(8,2) NOT NULL,
    qtde_uco numeric(8,2) NOT NULL,
    valor_uco numeric(8,2) NOT NULL,
    qtde_filme numeric(8,2) NOT NULL,
    valor_filme numeric(8,2) NOT NULL,
    valor_total numeric(8,2) NOT NULL,
    valor_customizado numeric(8,2),
    valor_final numeric(8,2) NOT NULL,
    preco_customizado boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.taxas
-- ============================================================
CREATE TABLE public.taxas (
    id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    descricao character varying(255),
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.tipo_vinculos
-- ============================================================
CREATE TABLE public.tipo_vinculos (
    id bigint NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    descricao text NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

-- ============================================================
-- Tabela: public.users
-- ============================================================
CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email text,
    password character varying(255) NOT NULL,
    fone character varying(255),
    cpf character varying(255),
    forget_token text,
    foto text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    active boolean DEFAULT true NOT NULL,
    colaborador boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


-- ============================================================
-- SECAO: SCHEMA CORRIGIDO SUPABASE
-- Arquivo: servsaude_schema_corrigido_supabase.sql
-- ============================================================

-- ============================================================
-- Schema corrigido — ServSaúde
-- Compatível com PostgreSQL / Supabase
-- Gerado a partir do SQL extraído do dump legado
-- ============================================================

CREATE SCHEMA IF NOT EXISTS public;
CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;

-- ============================================================
-- Tabela: public.adesao_reducao_margem
-- ============================================================
CREATE TABLE IF NOT EXISTS public.adesao_reducao_margem (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    adesao_id bigint NOT NULL,
    tipo_reducao integer NOT NULL,
    valor numeric(8,2) NOT NULL,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.adesoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.adesoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    operadora_id bigint NOT NULL,
    empresa_id bigint,
    secretaria_id bigint,
    conveniado_id bigint NOT NULL,
    grupo_familiar integer,
    produto_id bigint NOT NULL,
    produto_preco_id bigint,
    matricula character varying(255),
    tipo_cliente integer NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    data_inicio date NOT NULL,
    data_fim date,
    data_primeiro_pgto date,
    justificativa_encerramento character varying(255),
    dv character varying(255),
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    salario_atual numeric(13,2),
    motivo_encerramento_id integer
);

-- ============================================================
-- Tabela: public.bancos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.bancos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.boleto_lancamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.boleto_lancamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    boleto_id bigint NOT NULL,
    lancamento_id bigint NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.boletos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.boletos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    operadora_id bigint NOT NULL,
    data_emissao date NOT NULL,
    data_vencimento date NOT NULL,
    valor_original numeric(8,2) NOT NULL,
    nosso_numero integer NOT NULL,
    numero_titulo_cliente character varying(255),
    agencia character varying(255),
    conta character varying(255),
    endereco character varying(255),
    cidade character varying(255),
    uf character varying(255),
    indicador_permissao_recebimento_parcial character varying(255) DEFAULT 'N'::character varying NOT NULL,
    indicador_pix character varying(255) DEFAULT 'S'::character varying NOT NULL,
    pagador_tipo_inscricao character varying(255) NOT NULL,
    pagador_numero_inscricao character varying(255) NOT NULL,
    pagador_nome character varying(255) NOT NULL,
    pagador_endereco character varying(255) NOT NULL,
    pagador_cep character varying(255) NOT NULL,
    pagador_cidade_id bigint NOT NULL,
    pagador_bairro character varying(255) NOT NULL,
    demonstrativo text,
    desconto_tipo integer DEFAULT 0 NOT NULL,
    desconto_data_expiracao date,
    desconto_porcentagem numeric(8,2),
    desconto_valor numeric(8,2),
    multa_tipo integer DEFAULT 0 NOT NULL,
    multa_data date,
    multa_porcentagem numeric(8,2),
    multa_valor numeric(8,2),
    juros_tipo integer DEFAULT 0 NOT NULL,
    juros_porcentagem numeric(8,2),
    juros_valor numeric(8,2),
    pix_qrcode character varying(255),
    instrucoes1 character varying(255),
    instrucoes2 character varying(255),
    instrucoes3 character varying(255),
    instrucoes4 character varying(255),
    status integer DEFAULT 1 NOT NULL,
    codigo_estado_titulo integer DEFAULT 1 NOT NULL,
    error_message text,
    data_baixa date,
    boleto text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.canais_atendimento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.canais_atendimento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    telefone character varying(255),
    email character varying(255),
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.cargos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cargos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.cbhpm
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cbhpm (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    cbhpm_edicao_id bigint NOT NULL,
    procedimento_id bigint NOT NULL,
    codigo_porte character varying(255) NOT NULL,
    fracao_porte numeric(8,2) DEFAULT '1'::numeric,
    qtde_uco numeric(13,3) NOT NULL,
    qtde_filme numeric(13,3) NOT NULL,
    porte_anestesico_id bigint,
    nro_auxiliares integer,
    incidencia integer,
    ur boolean DEFAULT false NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.cbhpm_edicoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cbhpm_edicoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    ano_edicao integer NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.cid
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cid (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    sexo_aplicavel character varying(255) NOT NULL,
    grave boolean DEFAULT false NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.cidades
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cidades (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    estado_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.comunicado_edicoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.comunicado_edicoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    ano_edicao integer NOT NULL,
    uco numeric(8,2) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.comunicado_portes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.comunicado_portes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    comunicado_edicao_id bigint NOT NULL,
    codigo_porte character varying(255) NOT NULL,
    valor numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.contrato_profissionais
-- ============================================================
CREATE TABLE IF NOT EXISTS public.contrato_profissionais (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    contrato_id bigint NOT NULL,
    prestador_id bigint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.conveniado_salarios
-- ============================================================
CREATE TABLE IF NOT EXISTS public.conveniado_salarios (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    conveniado_id bigint NOT NULL,
    salario numeric(8,2) NOT NULL,
    data_competencia date NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.conveniados
-- ============================================================
CREATE TABLE IF NOT EXISTS public.conveniados (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    orgao_expedidor_uf_id bigint,
    naturalidade_cidade_id bigint NOT NULL,
    usuario_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date NOT NULL,
    sexo smallint NOT NULL,
    rg character varying(255),
    orgao_expedidor character varying(255),
    cns character varying(255),
    nome_pai character varying(255),
    nome_mae character varying(255) NOT NULL,
    fone1 character varying(255),
    fone2 character varying(255),
    email character varying(255),
    foto text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    estado_civil integer DEFAULT 1 NOT NULL,
    pcd integer DEFAULT 2 NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    cargo_id integer
);

-- ============================================================
-- Tabela: public.dados_bancarios
-- ============================================================
CREATE TABLE IF NOT EXISTS public.dados_bancarios (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    origem_id bigint NOT NULL,
    tabela character varying(255) NOT NULL,
    banco_id bigint NOT NULL,
    tipo smallint NOT NULL,
    agencia character varying(255),
    agencia_dv character varying(255),
    conta character varying(255),
    conta_dv character varying(255),
    operacao character varying(255),
    pix character varying(255),
    pix_tipo character varying(255),
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.deflatores
-- ============================================================
CREATE TABLE IF NOT EXISTS public.deflatores (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    prestadores_contratos_id bigint NOT NULL,
    procedimento_grupo_id bigint NOT NULL,
    tipo smallint NOT NULL,
    percentual numeric(8,2) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.documentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.documentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo integer NOT NULL,
    tabela text,
    origem_id integer,
    documento text,
    descricao text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.documentos_credenciamento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.documentos_credenciamento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    complemento_descricao character varying(255),
    obrigatorio boolean DEFAULT true NOT NULL,
    active boolean DEFAULT true NOT NULL,
    tipo_pessoa integer DEFAULT 1 NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.editais_credenciamento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.editais_credenciamento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.edital_credenciamento_documentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.edital_credenciamento_documentos (
    edital_id bigint NOT NULL,
    documento_credenciamento_id bigint NOT NULL,
    obrigatorio boolean DEFAULT false NOT NULL,
    updated_at timestamptz DEFAULT '2024-04-22 07:40:35'::timestamp without time zone NOT NULL,
    PRIMARY KEY (edital_id, documento_credenciamento_id)
);

-- ============================================================
-- Tabela: public.empresa_produto
-- ============================================================
CREATE TABLE IF NOT EXISTS public.empresa_produto (
    empresa_id bigint NOT NULL,
    produto_id bigint NOT NULL,
    PRIMARY KEY (empresa_id, produto_id)
);

-- ============================================================
-- Tabela: public.empresa_user
-- ============================================================
CREATE TABLE IF NOT EXISTS public.empresa_user (
    user_id bigint NOT NULL,
    empresa_id bigint NOT NULL,
    PRIMARY KEY (user_id, empresa_id)
);

-- ============================================================
-- Tabela: public.empresas
-- ============================================================
CREATE TABLE IF NOT EXISTS public.empresas (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo smallint NOT NULL,
    cpf_cnpj character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    abreviado text,
    fone character varying(255),
    email character varying(255),
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    contato character varying(255),
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.empresas_verbas
-- ============================================================
CREATE TABLE IF NOT EXISTS public.empresas_verbas (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    empresa_id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    grupo_verba_id bigint
);

-- ============================================================
-- Tabela: public.enderecos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.enderecos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    cidade_id bigint NOT NULL,
    tabela text,
    origem_id integer,
    tipo integer NOT NULL,
    cep text NOT NULL,
    endereco text NOT NULL,
    numero text,
    complemento text,
    bairro text,
    "default" boolean DEFAULT false NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.especialidades
-- ============================================================
CREATE TABLE IF NOT EXISTS public.especialidades (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    cbo character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.estados
-- ============================================================
CREATE TABLE IF NOT EXISTS public.estados (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    uf character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.failed_jobs
-- ============================================================
CREATE TABLE IF NOT EXISTS public.failed_jobs (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- ============================================================
-- Tabela: public.fiscal_contrato_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.fiscal_contrato_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    fiscal_contrato_id bigint NOT NULL,
    contrato_id bigint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.fiscal_contratos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.fiscal_contratos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    usuario_id bigint NOT NULL,
    data_inicio date DEFAULT CURRENT_DATE NOT NULL,
    data_fim date NOT NULL,
    portaria character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.gestantes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.gestantes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    conveniado_id bigint NOT NULL,
    data_inicio_gestacao date DEFAULT CURRENT_DATE NOT NULL,
    data_final_gestacao date,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.grau_parentesco
-- ============================================================
CREATE TABLE IF NOT EXISTS public.grau_parentesco (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.grupo_verbas
-- ============================================================
CREATE TABLE IF NOT EXISTS public.grupo_verbas (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guia_importacoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guia_importacoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    sequencial_transacao integer NOT NULL,
    lote integer NOT NULL,
    data_hora_arquivo timestamptz NOT NULL,
    prestador_id bigint,
    usuario_id bigint,
    versao_layout character varying(255) NOT NULL,
    arquivo character varying(255) NOT NULL,
    disco character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guia_motivo_encerramento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guia_motivo_encerramento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    termo character varying(255) NOT NULL,
    data_inicio_vigencia date,
    data_fim_vigencia date,
    data_fim_implantacao date,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guias
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    usuario_emissor_id bigint,
    prestador_id bigint,
    profissional_id bigint,
    conveniado_id bigint,
    solicitante_prestador_id bigint,
    lote_pagamento_id bigint,
    tipo_lancamento smallint DEFAULT '1'::smallint NOT NULL,
    tipo_autorizacao smallint DEFAULT '1'::smallint NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    carater_atendimento smallint DEFAULT '1'::smallint NOT NULL,
    guia_origem_id bigint,
    indicacao_clinica character varying(255),
    observacoes character varying(255),
    observacoes_internas character varying(255),
    urgente boolean DEFAULT false NOT NULL,
    conferido boolean DEFAULT false NOT NULL,
    status smallint DEFAULT '1'::smallint NOT NULL,
    data_hora_cancalamento timestamptz,
    cancelado_por_user_id bigint,
    motivo_cancelamento character varying(255),
    justifica_para_auditoria character varying(255),
    guia_importacao_id bigint,
    lote_importacao integer,
    numero_guia_prestador integer,
    data_autorizacao date,
    senha integer,
    data_validade_senha date,
    atendimento_rn character varying(255),
    cnes integer,
    tipo_faturamento integer,
    data_inicio_faturamento date,
    data_final_faturamento date,
    tipo_internacao integer,
    regime_internacao integer,
    diagnostico character varying(255),
    indicador_acidente integer,
    motivo_encerramento integer,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    tipo_autenticacao smallint,
    codigo_autenticacao character varying(255),
    autenticada boolean DEFAULT false NOT NULL
);

-- ============================================================
-- Tabela: public.guias_anexos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_anexos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    guia_id bigint,
    nome character varying(255),
    arquivo character varying(255),
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guias_atendimentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_atendimentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    guia_itens_id bigint,
    quantidade numeric(8,2),
    usuario_id bigint,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.guias_auditoria
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_auditoria (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora_analise timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    guia_itens_id bigint NOT NULL,
    quantidade_autorizada numeric(8,2) NOT NULL,
    justificativa character varying(255),
    analise_usuario_id bigint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guias_historico
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_historico (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    guia_id bigint NOT NULL,
    guia_item_id bigint,
    historico character varying(255) NOT NULL,
    usuario_id bigint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guias_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora_emissao timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    data_hora_autorizacao timestamptz,
    data_hora_atendimento timestamptz,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    guia_id bigint,
    referencia_tabela character varying(255) NOT NULL,
    referencia_id integer,
    quantidade_solicitada numeric(8,2),
    quantidade_atendida numeric(8,2),
    quantidade_glosa numeric(8,2),
    valor_unitario numeric(8,2),
    valor_unitario_glosa numeric(8,2),
    percentual_cooparticipacao numeric(8,2),
    valor_unitario_coparticipacao numeric(8,2),
    valor_total_coparticipacao numeric(8,2),
    percentual_item numeric(8,2),
    quantidade_faturada numeric(8,2),
    valor_unitario_faturado numeric(8,2),
    valor_total_faturado numeric(8,2),
    status smallint DEFAULT '1'::smallint NOT NULL,
    data_execucao date,
    hora_inicial time(0) without time zone,
    hora_final time(0) without time zone,
    codigo_tabela integer,
    codigo_despesa integer,
    codigo_procedimento character varying(255),
    quantidade_autorizada numeric(8,2),
    reducao_acrescimo numeric(8,2),
    valor_total numeric(8,2),
    grau_part integer,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.historico_credenciamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.historico_credenciamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    solicitacao_credencimento_id bigint NOT NULL,
    user_id bigint NOT NULL,
    motivo character varying(255) NOT NULL,
    status integer NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.laboratorios
-- ============================================================
CREATE TABLE IF NOT EXISTS public.laboratorios (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.lancamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.lancamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    boleto_id integer,
    operadora_id bigint NOT NULL,
    prestador_id bigint,
    conveniado_id bigint,
    tipo_lancamento smallint DEFAULT '2'::smallint NOT NULL,
    data_hora timestamptz DEFAULT '2024-01-19 13:56:01'::timestamp without time zone NOT NULL,
    data_vencimento timestamptz NOT NULL,
    data_baixa timestamptz,
    tipo_pagamento smallint DEFAULT '1'::smallint NOT NULL,
    competencia_folha character varying(255),
    descricao character varying(255),
    valor numeric(8,2) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    grupo_verba_id bigint
);

-- ============================================================
-- Tabela: public.lancamentos_guias
-- ============================================================
CREATE TABLE IF NOT EXISTS public.lancamentos_guias (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    lancamento_id bigint NOT NULL,
    guia_id bigint NOT NULL,
    valor numeric(8,2) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.log_acessos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.log_acessos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz,
    usuario_id integer,
    usuario_nome text,
    ip text,
    navegador text,
    recurso text,
    registro_id integer,
    url character varying(255),
    action smallint,
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.log_operacoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.log_operacoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz,
    usuario_id integer,
    usuario_nome text,
    ip text,
    navegador text,
    recurso text,
    registro_id integer,
    log text,
    action smallint,
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.lote_pagamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.lote_pagamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    prestador_id bigint NOT NULL,
    usuario_id bigint NOT NULL,
    lancamento_id bigint,
    data_hora timestamptz NOT NULL,
    referencia_pagamento date NOT NULL,
    status smallint DEFAULT '1'::smallint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.materiais
-- ============================================================
CREATE TABLE IF NOT EXISTS public.materiais (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo integer NOT NULL,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.materiais_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.materiais_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    material_edicao_id bigint NOT NULL,
    material_id bigint NOT NULL,
    valor numeric(8,2) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.material_edicoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.material_edicoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    edicao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.medicamento_brasindice
-- ============================================================
CREATE TABLE IF NOT EXISTS public.medicamento_brasindice (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    medicamento_edicao_id bigint NOT NULL,
    medicamento_id bigint NOT NULL,
    pmc numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    pfab numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    fracao_pfab numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    fracao_pmc numeric(15,2) DEFAULT '0'::numeric NOT NULL
);

-- ============================================================
-- Tabela: public.medicamento_edicoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.medicamento_edicoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    edicao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.medicamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.medicamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    laboratorio_id bigint NOT NULL,
    medicamento_edicao_id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    bras character varying(255) NOT NULL,
    in_ character varying(255) NOT NULL,
    dice character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    apresentacao character varying(255) NOT NULL,
    qtde_embalagem integer NOT NULL,
    ultima_versao integer NOT NULL,
    ean character varying(255) NOT NULL,
    ggrem character varying(255) NOT NULL,
    anvisa character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.mensagens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.mensagens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    perfil_id bigint,
    tipo integer NOT NULL,
    titulo character varying(255) NOT NULL,
    corpo text NOT NULL,
    idade_inicial integer,
    idade_final integer,
    data_inicial_exibicao date,
    data_final_exibicao date,
    visivel boolean DEFAULT true NOT NULL,
    fixado boolean DEFAULT false NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.mensalidades
-- ============================================================
CREATE TABLE IF NOT EXISTS public.mensalidades (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    conveniado_id bigint NOT NULL,
    competencia date NOT NULL,
    produto_preco_id bigint NOT NULL,
    grupo_verba_id bigint,
    salario numeric(8,2) NOT NULL,
    percentual numeric(8,2) NOT NULL,
    valor numeric(8,2) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.menus
-- ============================================================
CREATE TABLE IF NOT EXISTS public.menus (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(255) NOT NULL,
    is_divisor boolean DEFAULT false NOT NULL,
    parameter character varying(255),
    link character varying(255),
    permission character varying(255),
    fixed_id integer,
    parent_id integer,
    icon_family character varying(255),
    icon character varying(255),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.migrations
-- ============================================================
CREATE TABLE IF NOT EXISTS public.migrations (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);

-- ============================================================
-- Tabela: public.motivo_encerramentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.motivo_encerramentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    motivo character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    tipo smallint DEFAULT '1'::smallint NOT NULL
);

-- ============================================================
-- Tabela: public.operadora_user
-- ============================================================
CREATE TABLE IF NOT EXISTS public.operadora_user (
    operadora_id bigint NOT NULL,
    user_id bigint NOT NULL,
    PRIMARY KEY (operadora_id, user_id)
);

-- ============================================================
-- Tabela: public.operadoras
-- ============================================================
CREATE TABLE IF NOT EXISTS public.operadoras (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    tipo smallint NOT NULL,
    cpf_cnpj character varying(255) NOT NULL,
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    fone character varying(255),
    email character varying(255),
    certificado character varying(255),
    senha_certificado character varying(255),
    codigo_ans character varying(6),
    tipo_declarante integer NOT NULL,
    cpf_responsavel character varying(255) NOT NULL,
    indicador_situacao_declaracao character varying(255) NOT NULL,
    cnes character varying(7),
    ativo boolean DEFAULT true NOT NULL,
    percentual_max_desconto_coparticipacao numeric(8,2) DEFAULT 24.9 NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    boleto_nr_convenio integer,
    boleto_nr_carteira integer,
    boleto_nr_variacao_carteira integer,
    boleto_nr_controle integer,
    boleto_client_id character varying(255),
    boleto_client_secret text,
    boleto_gw_dev_app_key character varying(255),
    boleto_recebimento_parcial character varying(255) DEFAULT 'N'::character varying NOT NULL,
    boleto_indicador_pix character varying(255) DEFAULT 'S'::character varying NOT NULL,
    boleto_multa_tipo integer DEFAULT 0 NOT NULL,
    boleto_multa_dias_apos_vencimento integer DEFAULT 1,
    boleto_multa_porcentagem numeric(8,2),
    boleto_multa_valor numeric(8,2),
    boleto_juros_tipo integer DEFAULT 0 NOT NULL,
    boleto_juros_porcentagem numeric(8,2),
    boleto_juros_valor numeric(8,2),
    boleto_ambiente integer DEFAULT 1,
    boleto_cancelar_dias_apos_vencimento integer,
    boleto_forma_pagamento_apos_cancelar integer
);

-- ============================================================
-- Tabela: public.parametros
-- ============================================================
CREATE TABLE IF NOT EXISTS public.parametros (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    parameter character varying(255) NOT NULL,
    field_label character varying(255) NOT NULL,
    component text,
    value character varying(255),
    possible_values character varying(255),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.permission_role
-- ============================================================
CREATE TABLE IF NOT EXISTS public.permission_role (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL,
    PRIMARY KEY (permission_id, role_id)
);

-- ============================================================
-- Tabela: public.permissions
-- ============================================================
CREATE TABLE IF NOT EXISTS public.permissions (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    module character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    description character varying(255)
);

-- ============================================================
-- Tabela: public.personal_access_tokens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.personal_access_tokens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.porte_anestesicos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.porte_anestesicos (
    porte_anestesico character varying(255) DEFAULT '0'::character varying NOT NULL,
    porte character varying(255),
    PRIMARY KEY (porte_anestesico)
);

-- ============================================================
-- Tabela: public.prestador_contrato_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_contrato_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    prestadores_contratos_id bigint NOT NULL,
    edicao_medicamento_id bigint NOT NULL,
    acrescimo_medicamentos numeric(8,2),
    tabela_precos_id bigint,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    tipo smallint NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    orcamento_previsto numeric(8,2),
    motivo_encerramento_id bigint,
    data_encerramento timestamptz
);

-- ============================================================
-- Tabela: public.prestador_contratos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_contratos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    prestador_id bigint NOT NULL,
    data date NOT NULL,
    codigo character varying(255) NOT NULL,
    ocorrencia character varying(255),
    objeto character varying(255) NOT NULL,
    observacoes character varying(255),
    reclamacoes character varying(255),
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.prestador_especialidades
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_especialidades (
    prestador_id bigint NOT NULL,
    especialidade_id bigint NOT NULL,
    PRIMARY KEY (prestador_id, especialidade_id)
);

-- ============================================================
-- Tabela: public.prestador_tipos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_tipos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.prestador_user
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_user (
    prestador_id bigint NOT NULL,
    user_id bigint NOT NULL,
    PRIMARY KEY (prestador_id, user_id)
);

-- ============================================================
-- Tabela: public.prestadores
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestadores (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    usuario_id bigint,
    prestadores_classificacao_estabelecimento_id bigint NOT NULL,
    orgao_expedidor_uf_id bigint,
    naturalidade_cidade_id bigint,
    tipo smallint NOT NULL,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    abreviado text,
    cpf_cnpj character varying(255) NOT NULL,
    data_nascimento date,
    rg character varying(255),
    orgao_expedidor character varying(255),
    nome_mae character varying(255),
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    fone character varying(255),
    email character varying(255),
    financeiro_contato_nome character varying(255),
    financeiro_contato_fone character varying(255),
    financeiro_contato_email character varying(255),
    faturamento_contato_nome character varying(255),
    faturamento_contato_fone character varying(255),
    faturamento_contato_email character varying(255),
    tipo_conselho_classe smallint,
    numero_conselho_classe character varying(255),
    procedimentos boolean DEFAULT false NOT NULL,
    material boolean DEFAULT false NOT NULL,
    taxa boolean DEFAULT false NOT NULL,
    medicamentos boolean DEFAULT false NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    prestador_tipo_id integer
);

-- ============================================================
-- Tabela: public.prestadores_classificacao_estabelecimento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestadores_classificacao_estabelecimento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    codigo character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.procedimento_subgrupos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.procedimento_subgrupos (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    grupo_id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    perc_reducao_segundo_procedimento numeric(8,2) NOT NULL,
    perc_reducao_terceiro_procedimento_em_diante numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.procedimentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.procedimentos (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo text NOT NULL,
    procedimento_subgrupo_id integer,
    descricao text,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.procedimentos_grupos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.procedimentos_grupos (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.produtos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.produtos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    operadora_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    abrangencia smallint NOT NULL,
    tipo_contratacao integer NOT NULL,
    tipo_carencia smallint NOT NULL,
    tipo_acomodacao integer NOT NULL,
    data_inicio date NOT NULL,
    data_fim date,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.produtos_precos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.produtos_precos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    produto_id bigint NOT NULL,
    tipo_vinculo_id bigint,
    idade_inicial integer NOT NULL,
    idade_final integer NOT NULL,
    tipo_cobranca integer NOT NULL,
    tipo_cliente integer NOT NULL,
    descricao character varying(255) NOT NULL,
    valor numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    grupo_verba_id bigint
);

-- ============================================================
-- Tabela: public.regra_cooparticipacao
-- ============================================================
CREATE TABLE IF NOT EXISTS public.regra_cooparticipacao (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    produto_id bigint NOT NULL,
    nome text NOT NULL,
    tempo_carencia integer,
    carencia boolean NOT NULL,
    sem_limite_para_gestante boolean DEFAULT false NOT NULL,
    auditoria boolean NOT NULL,
    ativo boolean NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.regra_cooparticipacao_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.regra_cooparticipacao_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    regra_cooparticipacao_id bigint NOT NULL,
    qtde_inicial integer NOT NULL,
    qtde_final integer NOT NULL,
    percentual_cooparticipacao numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.regra_cooparticipacao_procedimentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.regra_cooparticipacao_procedimentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    regra_cooparticipacao_id bigint NOT NULL,
    grupo_procedimento_id integer NOT NULL,
    subgrupo_procedimento_id integer,
    procedimento_id integer,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.remessa_desconto
-- ============================================================
CREATE TABLE IF NOT EXISTS public.remessa_desconto (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    empresa_id bigint NOT NULL,
    competencia date NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.remessa_desconto_item
-- ============================================================
CREATE TABLE IF NOT EXISTS public.remessa_desconto_item (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    remessa_desconto_id bigint NOT NULL,
    adesao_id bigint NOT NULL,
    matricula character varying(255) NOT NULL,
    salario numeric(8,2) NOT NULL,
    desconto_maximo numeric(8,2) NOT NULL,
    valor_divida numeric(8,2) NOT NULL,
    coparticipacao numeric(8,2) NOT NULL,
    codigo_evento character varying(255) NOT NULL,
    valor numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.role_user
-- ============================================================
CREATE TABLE IF NOT EXISTS public.role_user (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL,
    PRIMARY KEY (user_id, role_id)
);

-- ============================================================
-- Tabela: public.roles
-- ============================================================
CREATE TABLE IF NOT EXISTS public.roles (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.secretarias
-- ============================================================
CREATE TABLE IF NOT EXISTS public.secretarias (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    empresa_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    cpf_cnpj character varying(255),
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    fone character varying(255),
    email character varying(255),
    contato character varying(255),
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    abreviado character varying(255)
);

-- ============================================================
-- Tabela: public.solicitacoes_atualizacao_cadastral
-- ============================================================
CREATE TABLE IF NOT EXISTS public.solicitacoes_atualizacao_cadastral (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_solicitacao date DEFAULT CURRENT_DATE NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    prestador_id bigint,
    conveniado_id bigint,
    cidade_id bigint NOT NULL,
    endereco character varying(255),
    endereco_nro character varying(255),
    complemento character varying(255),
    bairro character varying(255),
    cep character varying(255),
    email character varying(255),
    telefone character varying(255),
    celular character varying(255),
    observacoes character varying(255),
    comprovante_endereco character varying(255),
    foto character varying(255),
    disk character varying(255),
    status smallint DEFAULT '1'::smallint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.solicitacoes_credenciamento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.solicitacoes_credenciamento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    edital_credenciamento_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    tipo integer DEFAULT 1 NOT NULL,
    cpf_cnpj character varying(255) NOT NULL,
    responsavel character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.solicitacoes_credenciamento_documentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.solicitacoes_credenciamento_documentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    solicitacoes_credenciamento_id bigint NOT NULL,
    documento_credenciamento_id bigint NOT NULL,
    arquivo text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    nome_arquivo character varying(255)
);

-- ============================================================
-- Tabela: public.tabela_precos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.tabela_precos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    comunicado_edicao_id bigint NOT NULL,
    cbhpm_edicao_id bigint NOT NULL,
    material_edicao_id bigint NOT NULL,
    valor_uco numeric(8,2) NOT NULL,
    valor_filme numeric(8,2) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.tabela_precos_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.tabela_precos_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tabela_preco_id bigint NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    referencia_id integer NOT NULL,
    valor_porte numeric(8,2) NOT NULL,
    fracao_porte numeric(8,2) NOT NULL,
    qtde_uco numeric(8,2) NOT NULL,
    valor_uco numeric(8,2) NOT NULL,
    qtde_filme numeric(8,2) NOT NULL,
    valor_filme numeric(8,2) NOT NULL,
    valor_total numeric(8,2) NOT NULL,
    valor_customizado numeric(8,2),
    valor_final numeric(8,2) NOT NULL,
    preco_customizado boolean DEFAULT false NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.taxas
-- ============================================================
CREATE TABLE IF NOT EXISTS public.taxas (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    descricao character varying(255),
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.tipo_vinculos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.tipo_vinculos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    descricao text NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.users
-- ============================================================
CREATE TABLE IF NOT EXISTS public.users (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(255) NOT NULL,
    email text,
    password character varying(255) NOT NULL,
    fone character varying(255),
    cpf character varying(255),
    forget_token text,
    foto text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    active boolean DEFAULT true NOT NULL,
    colaborador boolean DEFAULT false NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Índices auxiliares recomendados
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_adesao_reducao_margem_adesao_id ON public.adesao_reducao_margem (adesao_id);
CREATE INDEX IF NOT EXISTS idx_adesao_reducao_margem_deleted_at ON public.adesao_reducao_margem (deleted_at);
CREATE INDEX IF NOT EXISTS idx_adesao_reducao_margem_created_at ON public.adesao_reducao_margem (created_at);
CREATE INDEX IF NOT EXISTS idx_adesoes_operadora_id ON public.adesoes (operadora_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_empresa_id ON public.adesoes (empresa_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_secretaria_id ON public.adesoes (secretaria_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_conveniado_id ON public.adesoes (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_produto_id ON public.adesoes (produto_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_produto_preco_id ON public.adesoes (produto_preco_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_status ON public.adesoes (status);
CREATE INDEX IF NOT EXISTS idx_adesoes_deleted_at ON public.adesoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_adesoes_created_at ON public.adesoes (created_at);
CREATE INDEX IF NOT EXISTS idx_adesoes_motivo_encerramento_id ON public.adesoes (motivo_encerramento_id);
CREATE INDEX IF NOT EXISTS idx_bancos_ativo ON public.bancos (ativo);
CREATE INDEX IF NOT EXISTS idx_bancos_created_at ON public.bancos (created_at);
CREATE INDEX IF NOT EXISTS idx_bancos_deleted_at ON public.bancos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_boleto_lancamentos_boleto_id ON public.boleto_lancamentos (boleto_id);
CREATE INDEX IF NOT EXISTS idx_boleto_lancamentos_lancamento_id ON public.boleto_lancamentos (lancamento_id);
CREATE INDEX IF NOT EXISTS idx_boleto_lancamentos_created_at ON public.boleto_lancamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_boletos_operadora_id ON public.boletos (operadora_id);
CREATE INDEX IF NOT EXISTS idx_boletos_pagador_cidade_id ON public.boletos (pagador_cidade_id);
CREATE INDEX IF NOT EXISTS idx_boletos_status ON public.boletos (status);
CREATE INDEX IF NOT EXISTS idx_boletos_deleted_at ON public.boletos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_boletos_created_at ON public.boletos (created_at);
CREATE INDEX IF NOT EXISTS idx_canais_atendimento_email ON public.canais_atendimento (email);
CREATE INDEX IF NOT EXISTS idx_canais_atendimento_deleted_at ON public.canais_atendimento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_canais_atendimento_created_at ON public.canais_atendimento (created_at);
CREATE INDEX IF NOT EXISTS idx_cargos_ativo ON public.cargos (ativo);
CREATE INDEX IF NOT EXISTS idx_cargos_deleted_at ON public.cargos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_cargos_created_at ON public.cargos (created_at);
CREATE INDEX IF NOT EXISTS idx_cbhpm_cbhpm_edicao_id ON public.cbhpm (cbhpm_edicao_id);
CREATE INDEX IF NOT EXISTS idx_cbhpm_procedimento_id ON public.cbhpm (procedimento_id);
CREATE INDEX IF NOT EXISTS idx_cbhpm_porte_anestesico_id ON public.cbhpm (porte_anestesico_id);
CREATE INDEX IF NOT EXISTS idx_cbhpm_deleted_at ON public.cbhpm (deleted_at);
CREATE INDEX IF NOT EXISTS idx_cbhpm_created_at ON public.cbhpm (created_at);
CREATE INDEX IF NOT EXISTS idx_cbhpm_edicoes_ativo ON public.cbhpm_edicoes (ativo);
CREATE INDEX IF NOT EXISTS idx_cbhpm_edicoes_created_at ON public.cbhpm_edicoes (created_at);
CREATE INDEX IF NOT EXISTS idx_cbhpm_edicoes_deleted_at ON public.cbhpm_edicoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_cid_created_at ON public.cid (created_at);
CREATE INDEX IF NOT EXISTS idx_cidades_estado_id ON public.cidades (estado_id);
CREATE INDEX IF NOT EXISTS idx_cidades_created_at ON public.cidades (created_at);
CREATE INDEX IF NOT EXISTS idx_cidades_deleted_at ON public.cidades (deleted_at);
CREATE INDEX IF NOT EXISTS idx_comunicado_edicoes_ativo ON public.comunicado_edicoes (ativo);
CREATE INDEX IF NOT EXISTS idx_comunicado_edicoes_created_at ON public.comunicado_edicoes (created_at);
CREATE INDEX IF NOT EXISTS idx_comunicado_edicoes_deleted_at ON public.comunicado_edicoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_comunicado_portes_comunicado_edicao_id ON public.comunicado_portes (comunicado_edicao_id);
CREATE INDEX IF NOT EXISTS idx_comunicado_portes_created_at ON public.comunicado_portes (created_at);
CREATE INDEX IF NOT EXISTS idx_comunicado_portes_deleted_at ON public.comunicado_portes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_contrato_profissionais_contrato_id ON public.contrato_profissionais (contrato_id);
CREATE INDEX IF NOT EXISTS idx_contrato_profissionais_prestador_id ON public.contrato_profissionais (prestador_id);
CREATE INDEX IF NOT EXISTS idx_contrato_profissionais_deleted_at ON public.contrato_profissionais (deleted_at);
CREATE INDEX IF NOT EXISTS idx_contrato_profissionais_created_at ON public.contrato_profissionais (created_at);
CREATE INDEX IF NOT EXISTS idx_conveniado_salarios_conveniado_id ON public.conveniado_salarios (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_conveniado_salarios_created_at ON public.conveniado_salarios (created_at);
CREATE INDEX IF NOT EXISTS idx_conveniado_salarios_deleted_at ON public.conveniado_salarios (deleted_at);
CREATE INDEX IF NOT EXISTS idx_conveniados_orgao_expedidor_uf_id ON public.conveniados (orgao_expedidor_uf_id);
CREATE INDEX IF NOT EXISTS idx_conveniados_naturalidade_cidade_id ON public.conveniados (naturalidade_cidade_id);
CREATE INDEX IF NOT EXISTS idx_conveniados_usuario_id ON public.conveniados (usuario_id);
CREATE INDEX IF NOT EXISTS idx_conveniados_cpf ON public.conveniados (cpf);
CREATE INDEX IF NOT EXISTS idx_conveniados_email ON public.conveniados (email);
CREATE INDEX IF NOT EXISTS idx_conveniados_ativo ON public.conveniados (ativo);
CREATE INDEX IF NOT EXISTS idx_conveniados_created_at ON public.conveniados (created_at);
CREATE INDEX IF NOT EXISTS idx_conveniados_deleted_at ON public.conveniados (deleted_at);
CREATE INDEX IF NOT EXISTS idx_conveniados_cargo_id ON public.conveniados (cargo_id);
CREATE INDEX IF NOT EXISTS idx_dados_bancarios_origem_id ON public.dados_bancarios (origem_id);
CREATE INDEX IF NOT EXISTS idx_dados_bancarios_banco_id ON public.dados_bancarios (banco_id);
CREATE INDEX IF NOT EXISTS idx_dados_bancarios_created_at ON public.dados_bancarios (created_at);
CREATE INDEX IF NOT EXISTS idx_dados_bancarios_deleted_at ON public.dados_bancarios (deleted_at);
CREATE INDEX IF NOT EXISTS idx_deflatores_prestadores_contratos_id ON public.deflatores (prestadores_contratos_id);
CREATE INDEX IF NOT EXISTS idx_deflatores_procedimento_grupo_id ON public.deflatores (procedimento_grupo_id);
CREATE INDEX IF NOT EXISTS idx_deflatores_deleted_at ON public.deflatores (deleted_at);
CREATE INDEX IF NOT EXISTS idx_deflatores_created_at ON public.deflatores (created_at);
CREATE INDEX IF NOT EXISTS idx_documentos_origem_id ON public.documentos (origem_id);
CREATE INDEX IF NOT EXISTS idx_documentos_deleted_at ON public.documentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_documentos_created_at ON public.documentos (created_at);
CREATE INDEX IF NOT EXISTS idx_documentos_credenciamento_active ON public.documentos_credenciamento (active);
CREATE INDEX IF NOT EXISTS idx_documentos_credenciamento_deleted_at ON public.documentos_credenciamento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_documentos_credenciamento_created_at ON public.documentos_credenciamento (created_at);
CREATE INDEX IF NOT EXISTS idx_editais_credenciamento_ativo ON public.editais_credenciamento (ativo);
CREATE INDEX IF NOT EXISTS idx_editais_credenciamento_deleted_at ON public.editais_credenciamento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_editais_credenciamento_created_at ON public.editais_credenciamento (created_at);
CREATE INDEX IF NOT EXISTS idx_edital_credenciamento_documentos_edital_id ON public.edital_credenciamento_documentos (edital_id);
CREATE INDEX IF NOT EXISTS idx_edital_credenciamento_documentos_documento_credenciamento_id ON public.edital_credenciamento_documentos (documento_credenciamento_id);
CREATE INDEX IF NOT EXISTS idx_empresa_produto_empresa_id ON public.empresa_produto (empresa_id);
CREATE INDEX IF NOT EXISTS idx_empresa_produto_produto_id ON public.empresa_produto (produto_id);
CREATE INDEX IF NOT EXISTS idx_empresa_user_user_id ON public.empresa_user (user_id);
CREATE INDEX IF NOT EXISTS idx_empresa_user_empresa_id ON public.empresa_user (empresa_id);
CREATE INDEX IF NOT EXISTS idx_empresas_cpf_cnpj ON public.empresas (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_empresas_email ON public.empresas (email);
CREATE INDEX IF NOT EXISTS idx_empresas_ativo ON public.empresas (ativo);
CREATE INDEX IF NOT EXISTS idx_empresas_created_at ON public.empresas (created_at);
CREATE INDEX IF NOT EXISTS idx_empresas_deleted_at ON public.empresas (deleted_at);
CREATE INDEX IF NOT EXISTS idx_empresas_verbas_empresa_id ON public.empresas_verbas (empresa_id);
CREATE INDEX IF NOT EXISTS idx_empresas_verbas_created_at ON public.empresas_verbas (created_at);
CREATE INDEX IF NOT EXISTS idx_empresas_verbas_deleted_at ON public.empresas_verbas (deleted_at);
CREATE INDEX IF NOT EXISTS idx_empresas_verbas_grupo_verba_id ON public.empresas_verbas (grupo_verba_id);
CREATE INDEX IF NOT EXISTS idx_enderecos_cidade_id ON public.enderecos (cidade_id);
CREATE INDEX IF NOT EXISTS idx_enderecos_origem_id ON public.enderecos (origem_id);
CREATE INDEX IF NOT EXISTS idx_enderecos_ativo ON public.enderecos (ativo);
CREATE INDEX IF NOT EXISTS idx_enderecos_created_at ON public.enderecos (created_at);
CREATE INDEX IF NOT EXISTS idx_enderecos_deleted_at ON public.enderecos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_especialidades_ativo ON public.especialidades (ativo);
CREATE INDEX IF NOT EXISTS idx_especialidades_created_at ON public.especialidades (created_at);
CREATE INDEX IF NOT EXISTS idx_especialidades_deleted_at ON public.especialidades (deleted_at);
CREATE INDEX IF NOT EXISTS idx_estados_ativo ON public.estados (ativo);
CREATE INDEX IF NOT EXISTS idx_estados_created_at ON public.estados (created_at);
CREATE INDEX IF NOT EXISTS idx_estados_deleted_at ON public.estados (deleted_at);
CREATE INDEX IF NOT EXISTS idx_fiscal_contrato_itens_fiscal_contrato_id ON public.fiscal_contrato_itens (fiscal_contrato_id);
CREATE INDEX IF NOT EXISTS idx_fiscal_contrato_itens_contrato_id ON public.fiscal_contrato_itens (contrato_id);
CREATE INDEX IF NOT EXISTS idx_fiscal_contrato_itens_deleted_at ON public.fiscal_contrato_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_fiscal_contrato_itens_created_at ON public.fiscal_contrato_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_fiscal_contratos_usuario_id ON public.fiscal_contratos (usuario_id);
CREATE INDEX IF NOT EXISTS idx_fiscal_contratos_ativo ON public.fiscal_contratos (ativo);
CREATE INDEX IF NOT EXISTS idx_fiscal_contratos_deleted_at ON public.fiscal_contratos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_fiscal_contratos_created_at ON public.fiscal_contratos (created_at);
CREATE INDEX IF NOT EXISTS idx_gestantes_conveniado_id ON public.gestantes (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_gestantes_created_at ON public.gestantes (created_at);
CREATE INDEX IF NOT EXISTS idx_gestantes_deleted_at ON public.gestantes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_grau_parentesco_ativo ON public.grau_parentesco (ativo);
CREATE INDEX IF NOT EXISTS idx_grau_parentesco_created_at ON public.grau_parentesco (created_at);
CREATE INDEX IF NOT EXISTS idx_grau_parentesco_deleted_at ON public.grau_parentesco (deleted_at);
CREATE INDEX IF NOT EXISTS idx_grupo_verbas_deleted_at ON public.grupo_verbas (deleted_at);
CREATE INDEX IF NOT EXISTS idx_grupo_verbas_created_at ON public.grupo_verbas (created_at);
CREATE INDEX IF NOT EXISTS idx_guia_importacoes_prestador_id ON public.guia_importacoes (prestador_id);
CREATE INDEX IF NOT EXISTS idx_guia_importacoes_usuario_id ON public.guia_importacoes (usuario_id);
CREATE INDEX IF NOT EXISTS idx_guia_importacoes_deleted_at ON public.guia_importacoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guia_importacoes_created_at ON public.guia_importacoes (created_at);
CREATE INDEX IF NOT EXISTS idx_guia_motivo_encerramento_deleted_at ON public.guia_motivo_encerramento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guia_motivo_encerramento_created_at ON public.guia_motivo_encerramento (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_usuario_emissor_id ON public.guias (usuario_emissor_id);
CREATE INDEX IF NOT EXISTS idx_guias_prestador_id ON public.guias (prestador_id);
CREATE INDEX IF NOT EXISTS idx_guias_profissional_id ON public.guias (profissional_id);
CREATE INDEX IF NOT EXISTS idx_guias_conveniado_id ON public.guias (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_guias_solicitante_prestador_id ON public.guias (solicitante_prestador_id);
CREATE INDEX IF NOT EXISTS idx_guias_lote_pagamento_id ON public.guias (lote_pagamento_id);
CREATE INDEX IF NOT EXISTS idx_guias_guia_origem_id ON public.guias (guia_origem_id);
CREATE INDEX IF NOT EXISTS idx_guias_status ON public.guias (status);
CREATE INDEX IF NOT EXISTS idx_guias_cancelado_por_user_id ON public.guias (cancelado_por_user_id);
CREATE INDEX IF NOT EXISTS idx_guias_guia_importacao_id ON public.guias (guia_importacao_id);
CREATE INDEX IF NOT EXISTS idx_guias_deleted_at ON public.guias (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_created_at ON public.guias (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_anexos_guia_id ON public.guias_anexos (guia_id);
CREATE INDEX IF NOT EXISTS idx_guias_anexos_deleted_at ON public.guias_anexos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_anexos_created_at ON public.guias_anexos (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_atendimentos_guia_itens_id ON public.guias_atendimentos (guia_itens_id);
CREATE INDEX IF NOT EXISTS idx_guias_atendimentos_usuario_id ON public.guias_atendimentos (usuario_id);
CREATE INDEX IF NOT EXISTS idx_guias_atendimentos_created_at ON public.guias_atendimentos (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_atendimentos_deleted_at ON public.guias_atendimentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_auditoria_guia_itens_id ON public.guias_auditoria (guia_itens_id);
CREATE INDEX IF NOT EXISTS idx_guias_auditoria_analise_usuario_id ON public.guias_auditoria (analise_usuario_id);
CREATE INDEX IF NOT EXISTS idx_guias_auditoria_deleted_at ON public.guias_auditoria (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_auditoria_created_at ON public.guias_auditoria (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_historico_guia_id ON public.guias_historico (guia_id);
CREATE INDEX IF NOT EXISTS idx_guias_historico_guia_item_id ON public.guias_historico (guia_item_id);
CREATE INDEX IF NOT EXISTS idx_guias_historico_usuario_id ON public.guias_historico (usuario_id);
CREATE INDEX IF NOT EXISTS idx_guias_historico_deleted_at ON public.guias_historico (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_historico_created_at ON public.guias_historico (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_itens_guia_id ON public.guias_itens (guia_id);
CREATE INDEX IF NOT EXISTS idx_guias_itens_referencia_id ON public.guias_itens (referencia_id);
CREATE INDEX IF NOT EXISTS idx_guias_itens_status ON public.guias_itens (status);
CREATE INDEX IF NOT EXISTS idx_guias_itens_deleted_at ON public.guias_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_itens_created_at ON public.guias_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_historico_credenciamentos_solicitacao_credencimento_id ON public.historico_credenciamentos (solicitacao_credencimento_id);
CREATE INDEX IF NOT EXISTS idx_historico_credenciamentos_user_id ON public.historico_credenciamentos (user_id);
CREATE INDEX IF NOT EXISTS idx_historico_credenciamentos_status ON public.historico_credenciamentos (status);
CREATE INDEX IF NOT EXISTS idx_historico_credenciamentos_created_at ON public.historico_credenciamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_laboratorios_created_at ON public.laboratorios (created_at);
CREATE INDEX IF NOT EXISTS idx_laboratorios_deleted_at ON public.laboratorios (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lancamentos_boleto_id ON public.lancamentos (boleto_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_operadora_id ON public.lancamentos (operadora_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_prestador_id ON public.lancamentos (prestador_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_conveniado_id ON public.lancamentos (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_active ON public.lancamentos (active);
CREATE INDEX IF NOT EXISTS idx_lancamentos_deleted_at ON public.lancamentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lancamentos_created_at ON public.lancamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_lancamentos_grupo_verba_id ON public.lancamentos (grupo_verba_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_guias_lancamento_id ON public.lancamentos_guias (lancamento_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_guias_guia_id ON public.lancamentos_guias (guia_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_guias_deleted_at ON public.lancamentos_guias (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lancamentos_guias_created_at ON public.lancamentos_guias (created_at);
CREATE INDEX IF NOT EXISTS idx_log_acessos_usuario_id ON public.log_acessos (usuario_id);
CREATE INDEX IF NOT EXISTS idx_log_acessos_registro_id ON public.log_acessos (registro_id);
CREATE INDEX IF NOT EXISTS idx_log_acessos_deleted_at ON public.log_acessos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_log_operacoes_usuario_id ON public.log_operacoes (usuario_id);
CREATE INDEX IF NOT EXISTS idx_log_operacoes_registro_id ON public.log_operacoes (registro_id);
CREATE INDEX IF NOT EXISTS idx_log_operacoes_deleted_at ON public.log_operacoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_prestador_id ON public.lote_pagamentos (prestador_id);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_usuario_id ON public.lote_pagamentos (usuario_id);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_lancamento_id ON public.lote_pagamentos (lancamento_id);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_status ON public.lote_pagamentos (status);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_deleted_at ON public.lote_pagamentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_created_at ON public.lote_pagamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_materiais_deleted_at ON public.materiais (deleted_at);
CREATE INDEX IF NOT EXISTS idx_materiais_created_at ON public.materiais (created_at);
CREATE INDEX IF NOT EXISTS idx_materiais_itens_material_edicao_id ON public.materiais_itens (material_edicao_id);
CREATE INDEX IF NOT EXISTS idx_materiais_itens_material_id ON public.materiais_itens (material_id);
CREATE INDEX IF NOT EXISTS idx_materiais_itens_deleted_at ON public.materiais_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_materiais_itens_created_at ON public.materiais_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_material_edicoes_ativo ON public.material_edicoes (ativo);
CREATE INDEX IF NOT EXISTS idx_material_edicoes_deleted_at ON public.material_edicoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_material_edicoes_created_at ON public.material_edicoes (created_at);
CREATE INDEX IF NOT EXISTS idx_medicamento_brasindice_medicamento_edicao_id ON public.medicamento_brasindice (medicamento_edicao_id);
CREATE INDEX IF NOT EXISTS idx_medicamento_brasindice_medicamento_id ON public.medicamento_brasindice (medicamento_id);
CREATE INDEX IF NOT EXISTS idx_medicamento_brasindice_ativo ON public.medicamento_brasindice (ativo);
CREATE INDEX IF NOT EXISTS idx_medicamento_brasindice_created_at ON public.medicamento_brasindice (created_at);
CREATE INDEX IF NOT EXISTS idx_medicamento_edicoes_ativo ON public.medicamento_edicoes (ativo);
CREATE INDEX IF NOT EXISTS idx_medicamento_edicoes_deleted_at ON public.medicamento_edicoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_medicamento_edicoes_created_at ON public.medicamento_edicoes (created_at);
CREATE INDEX IF NOT EXISTS idx_medicamentos_laboratorio_id ON public.medicamentos (laboratorio_id);
CREATE INDEX IF NOT EXISTS idx_medicamentos_medicamento_edicao_id ON public.medicamentos (medicamento_edicao_id);
CREATE INDEX IF NOT EXISTS idx_medicamentos_deleted_at ON public.medicamentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_medicamentos_created_at ON public.medicamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_mensagens_perfil_id ON public.mensagens (perfil_id);
CREATE INDEX IF NOT EXISTS idx_mensagens_deleted_at ON public.mensagens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_mensagens_created_at ON public.mensagens (created_at);
CREATE INDEX IF NOT EXISTS idx_mensalidades_conveniado_id ON public.mensalidades (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_mensalidades_produto_preco_id ON public.mensalidades (produto_preco_id);
CREATE INDEX IF NOT EXISTS idx_mensalidades_grupo_verba_id ON public.mensalidades (grupo_verba_id);
CREATE INDEX IF NOT EXISTS idx_mensalidades_deleted_at ON public.mensalidades (deleted_at);
CREATE INDEX IF NOT EXISTS idx_mensalidades_created_at ON public.mensalidades (created_at);
CREATE INDEX IF NOT EXISTS idx_menus_fixed_id ON public.menus (fixed_id);
CREATE INDEX IF NOT EXISTS idx_menus_parent_id ON public.menus (parent_id);
CREATE INDEX IF NOT EXISTS idx_menus_deleted_at ON public.menus (deleted_at);
CREATE INDEX IF NOT EXISTS idx_motivo_encerramentos_ativo ON public.motivo_encerramentos (ativo);
CREATE INDEX IF NOT EXISTS idx_motivo_encerramentos_deleted_at ON public.motivo_encerramentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_motivo_encerramentos_created_at ON public.motivo_encerramentos (created_at);
CREATE INDEX IF NOT EXISTS idx_operadora_user_operadora_id ON public.operadora_user (operadora_id);
CREATE INDEX IF NOT EXISTS idx_operadora_user_user_id ON public.operadora_user (user_id);
CREATE INDEX IF NOT EXISTS idx_operadoras_cpf_cnpj ON public.operadoras (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_operadoras_email ON public.operadoras (email);
CREATE INDEX IF NOT EXISTS idx_operadoras_ativo ON public.operadoras (ativo);
CREATE INDEX IF NOT EXISTS idx_operadoras_created_at ON public.operadoras (created_at);
CREATE INDEX IF NOT EXISTS idx_operadoras_deleted_at ON public.operadoras (deleted_at);
CREATE INDEX IF NOT EXISTS idx_operadoras_boleto_client_id ON public.operadoras (boleto_client_id);
CREATE INDEX IF NOT EXISTS idx_parametros_deleted_at ON public.parametros (deleted_at);
CREATE INDEX IF NOT EXISTS idx_permission_role_permission_id ON public.permission_role (permission_id);
CREATE INDEX IF NOT EXISTS idx_permission_role_role_id ON public.permission_role (role_id);
CREATE INDEX IF NOT EXISTS idx_permissions_active ON public.permissions (active);
CREATE INDEX IF NOT EXISTS idx_permissions_created_at ON public.permissions (created_at);
CREATE INDEX IF NOT EXISTS idx_personal_access_tokens_created_at ON public.personal_access_tokens (created_at);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_prestadores_contratos_id ON public.prestador_contrato_itens (prestadores_contratos_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_edicao_medicamento_id ON public.prestador_contrato_itens (edicao_medicamento_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_tabela_precos_id ON public.prestador_contrato_itens (tabela_precos_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_ativo ON public.prestador_contrato_itens (ativo);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_deleted_at ON public.prestador_contrato_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_created_at ON public.prestador_contrato_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_motivo_encerramento_id ON public.prestador_contrato_itens (motivo_encerramento_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contratos_prestador_id ON public.prestador_contratos (prestador_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contratos_ativo ON public.prestador_contratos (ativo);
CREATE INDEX IF NOT EXISTS idx_prestador_contratos_deleted_at ON public.prestador_contratos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_prestador_contratos_created_at ON public.prestador_contratos (created_at);
CREATE INDEX IF NOT EXISTS idx_prestador_especialidades_prestador_id ON public.prestador_especialidades (prestador_id);
CREATE INDEX IF NOT EXISTS idx_prestador_especialidades_especialidade_id ON public.prestador_especialidades (especialidade_id);
CREATE INDEX IF NOT EXISTS idx_prestador_tipos_active ON public.prestador_tipos (active);
CREATE INDEX IF NOT EXISTS idx_prestador_tipos_deleted_at ON public.prestador_tipos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_prestador_tipos_created_at ON public.prestador_tipos (created_at);
CREATE INDEX IF NOT EXISTS idx_prestador_user_prestador_id ON public.prestador_user (prestador_id);
CREATE INDEX IF NOT EXISTS idx_prestador_user_user_id ON public.prestador_user (user_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_usuario_id ON public.prestadores (usuario_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_prestadores_classificacao_estabelecimento_id ON public.prestadores (prestadores_classificacao_estabelecimento_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_orgao_expedidor_uf_id ON public.prestadores (orgao_expedidor_uf_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_naturalidade_cidade_id ON public.prestadores (naturalidade_cidade_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_cpf_cnpj ON public.prestadores (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_prestadores_email ON public.prestadores (email);
CREATE INDEX IF NOT EXISTS idx_prestadores_ativo ON public.prestadores (ativo);
CREATE INDEX IF NOT EXISTS idx_prestadores_created_at ON public.prestadores (created_at);
CREATE INDEX IF NOT EXISTS idx_prestadores_deleted_at ON public.prestadores (deleted_at);
CREATE INDEX IF NOT EXISTS idx_prestadores_prestador_tipo_id ON public.prestadores (prestador_tipo_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_classificacao_estabelecimento_ativo ON public.prestadores_classificacao_estabelecimento (ativo);
CREATE INDEX IF NOT EXISTS idx_prestadores_classificacao_estabelecimento_created_at ON public.prestadores_classificacao_estabelecimento (created_at);
CREATE INDEX IF NOT EXISTS idx_prestadores_classificacao_estabelecimento_deleted_at ON public.prestadores_classificacao_estabelecimento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_procedimento_subgrupos_grupo_id ON public.procedimento_subgrupos (grupo_id);
CREATE INDEX IF NOT EXISTS idx_procedimento_subgrupos_created_at ON public.procedimento_subgrupos (created_at);
CREATE INDEX IF NOT EXISTS idx_procedimento_subgrupos_deleted_at ON public.procedimento_subgrupos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_procedimentos_procedimento_subgrupo_id ON public.procedimentos (procedimento_subgrupo_id);
CREATE INDEX IF NOT EXISTS idx_procedimentos_created_at ON public.procedimentos (created_at);
CREATE INDEX IF NOT EXISTS idx_procedimentos_deleted_at ON public.procedimentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_procedimentos_grupos_ativo ON public.procedimentos_grupos (ativo);
CREATE INDEX IF NOT EXISTS idx_procedimentos_grupos_created_at ON public.procedimentos_grupos (created_at);
CREATE INDEX IF NOT EXISTS idx_procedimentos_grupos_deleted_at ON public.procedimentos_grupos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_produtos_operadora_id ON public.produtos (operadora_id);
CREATE INDEX IF NOT EXISTS idx_produtos_ativo ON public.produtos (ativo);
CREATE INDEX IF NOT EXISTS idx_produtos_created_at ON public.produtos (created_at);
CREATE INDEX IF NOT EXISTS idx_produtos_deleted_at ON public.produtos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_produto_id ON public.produtos_precos (produto_id);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_tipo_vinculo_id ON public.produtos_precos (tipo_vinculo_id);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_created_at ON public.produtos_precos (created_at);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_deleted_at ON public.produtos_precos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_grupo_verba_id ON public.produtos_precos (grupo_verba_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_produto_id ON public.regra_cooparticipacao (produto_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_ativo ON public.regra_cooparticipacao (ativo);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_created_at ON public.regra_cooparticipacao (created_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_deleted_at ON public.regra_cooparticipacao (deleted_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_itens_regra_cooparticipacao_id ON public.regra_cooparticipacao_itens (regra_cooparticipacao_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_itens_created_at ON public.regra_cooparticipacao_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_itens_deleted_at ON public.regra_cooparticipacao_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_regra_cooparticipacao_id ON public.regra_cooparticipacao_procedimentos (regra_cooparticipacao_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_grupo_procedimento_id ON public.regra_cooparticipacao_procedimentos (grupo_procedimento_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_subgrupo_procedimento_id ON public.regra_cooparticipacao_procedimentos (subgrupo_procedimento_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_procedimento_id ON public.regra_cooparticipacao_procedimentos (procedimento_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_created_at ON public.regra_cooparticipacao_procedimentos (created_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_deleted_at ON public.regra_cooparticipacao_procedimentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_empresa_id ON public.remessa_desconto (empresa_id);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_deleted_at ON public.remessa_desconto (deleted_at);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_created_at ON public.remessa_desconto (created_at);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_item_remessa_desconto_id ON public.remessa_desconto_item (remessa_desconto_id);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_item_adesao_id ON public.remessa_desconto_item (adesao_id);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_item_created_at ON public.remessa_desconto_item (created_at);
CREATE INDEX IF NOT EXISTS idx_role_user_user_id ON public.role_user (user_id);
CREATE INDEX IF NOT EXISTS idx_role_user_role_id ON public.role_user (role_id);
CREATE INDEX IF NOT EXISTS idx_roles_active ON public.roles (active);
CREATE INDEX IF NOT EXISTS idx_roles_created_at ON public.roles (created_at);
CREATE INDEX IF NOT EXISTS idx_secretarias_empresa_id ON public.secretarias (empresa_id);
CREATE INDEX IF NOT EXISTS idx_secretarias_cpf_cnpj ON public.secretarias (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_secretarias_email ON public.secretarias (email);
CREATE INDEX IF NOT EXISTS idx_secretarias_ativo ON public.secretarias (ativo);
CREATE INDEX IF NOT EXISTS idx_secretarias_created_at ON public.secretarias (created_at);
CREATE INDEX IF NOT EXISTS idx_secretarias_deleted_at ON public.secretarias (deleted_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_prestador_id ON public.solicitacoes_atualizacao_cadastral (prestador_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_conveniado_id ON public.solicitacoes_atualizacao_cadastral (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_cidade_id ON public.solicitacoes_atualizacao_cadastral (cidade_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_email ON public.solicitacoes_atualizacao_cadastral (email);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_status ON public.solicitacoes_atualizacao_cadastral (status);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_deleted_at ON public.solicitacoes_atualizacao_cadastral (deleted_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_created_at ON public.solicitacoes_atualizacao_cadastral (created_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_edital_credenciamento_id ON public.solicitacoes_credenciamento (edital_credenciamento_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_cpf_cnpj ON public.solicitacoes_credenciamento (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_email ON public.solicitacoes_credenciamento (email);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_deleted_at ON public.solicitacoes_credenciamento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_created_at ON public.solicitacoes_credenciamento (created_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_documentos_solicitacoes_credenciamento_id ON public.solicitacoes_credenciamento_documentos (solicitacoes_credenciamento_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_documentos_documento_credenciamento_id ON public.solicitacoes_credenciamento_documentos (documento_credenciamento_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_documentos_created_at ON public.solicitacoes_credenciamento_documentos (created_at);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_comunicado_edicao_id ON public.tabela_precos (comunicado_edicao_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_cbhpm_edicao_id ON public.tabela_precos (cbhpm_edicao_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_material_edicao_id ON public.tabela_precos (material_edicao_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_ativo ON public.tabela_precos (ativo);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_deleted_at ON public.tabela_precos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_created_at ON public.tabela_precos (created_at);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_itens_tabela_preco_id ON public.tabela_precos_itens (tabela_preco_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_itens_referencia_id ON public.tabela_precos_itens (referencia_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_itens_created_at ON public.tabela_precos_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_taxas_deleted_at ON public.taxas (deleted_at);
CREATE INDEX IF NOT EXISTS idx_taxas_created_at ON public.taxas (created_at);
CREATE INDEX IF NOT EXISTS idx_tipo_vinculos_ativo ON public.tipo_vinculos (ativo);
CREATE INDEX IF NOT EXISTS idx_tipo_vinculos_deleted_at ON public.tipo_vinculos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_tipo_vinculos_created_at ON public.tipo_vinculos (created_at);
CREATE INDEX IF NOT EXISTS idx_users_email ON public.users (email);
CREATE INDEX IF NOT EXISTS idx_users_cpf ON public.users (cpf);
CREATE INDEX IF NOT EXISTS idx_users_active ON public.users (active);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON public.users (created_at);
CREATE INDEX IF NOT EXISTS idx_users_deleted_at ON public.users (deleted_at);

-- ============================================================
-- Observações importantes
-- ============================================================
-- 1. Este script corrige estrutura básica, chaves primárias e compatibilidade.
-- 2. As FOREIGN KEYS não foram adicionadas automaticamente para evitar erros por tabelas ausentes ou relações ambíguas.
-- 3. Recomenda-se validar as relações antes de aplicar constraints definitivas.
-- 4. Para Supabase, habilite RLS manualmente por módulo após definir perfis e permissões.


-- ============================================================
-- SECAO: FOREIGN KEYS E VALIDACOES
-- Arquivo: servsaude_foreign_keys_validacoes.sql
-- ============================================================

-- ============================================================
-- FOREIGN KEYS + VALIDAÇÕES PRÉVIAS — ServSaúde
-- PostgreSQL / Supabase
-- Execute primeiro a seção de validação. Só aplique as FKs se não houver órfãos.
-- ============================================================

-- ============================================================
-- 1) VALIDAÇÃO PRÉVIA: registros órfãos
-- Se alguma consulta retornar linhas, corrija os dados antes de validar a FK.
-- ============================================================

-- Validação: public.adesao_reducao_margem.adesao_id -> public.adesoes.id
SELECT 'adesao_reducao_margem.adesao_id -> adesoes.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.adesao_reducao_margem s
LEFT JOIN public.adesoes t ON t.id = s.adesao_id
WHERE s.adesao_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.adesoes.operadora_id -> public.operadoras.id
SELECT 'adesoes.operadora_id -> operadoras.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.adesoes s
LEFT JOIN public.operadoras t ON t.id = s.operadora_id
WHERE s.operadora_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.adesoes.empresa_id -> public.empresas.id
SELECT 'adesoes.empresa_id -> empresas.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.adesoes s
LEFT JOIN public.empresas t ON t.id = s.empresa_id
WHERE s.empresa_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.adesoes.secretaria_id -> public.secretarias.id
SELECT 'adesoes.secretaria_id -> secretarias.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.adesoes s
LEFT JOIN public.secretarias t ON t.id = s.secretaria_id
WHERE s.secretaria_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.adesoes.conveniado_id -> public.conveniados.id
SELECT 'adesoes.conveniado_id -> conveniados.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.adesoes s
LEFT JOIN public.conveniados t ON t.id = s.conveniado_id
WHERE s.conveniado_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.adesoes.produto_id -> public.produtos.id
SELECT 'adesoes.produto_id -> produtos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.adesoes s
LEFT JOIN public.produtos t ON t.id = s.produto_id
WHERE s.produto_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.adesoes.produto_preco_id -> public.produtos_precos.id
SELECT 'adesoes.produto_preco_id -> produtos_precos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.adesoes s
LEFT JOIN public.produtos_precos t ON t.id = s.produto_preco_id
WHERE s.produto_preco_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.adesoes.motivo_encerramento_id -> public.motivo_encerramentos.id
SELECT 'adesoes.motivo_encerramento_id -> motivo_encerramentos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.adesoes s
LEFT JOIN public.motivo_encerramentos t ON t.id = s.motivo_encerramento_id
WHERE s.motivo_encerramento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.boleto_lancamentos.boleto_id -> public.boletos.id
SELECT 'boleto_lancamentos.boleto_id -> boletos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.boleto_lancamentos s
LEFT JOIN public.boletos t ON t.id = s.boleto_id
WHERE s.boleto_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.boleto_lancamentos.lancamento_id -> public.lancamentos.id
SELECT 'boleto_lancamentos.lancamento_id -> lancamentos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.boleto_lancamentos s
LEFT JOIN public.lancamentos t ON t.id = s.lancamento_id
WHERE s.lancamento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.boletos.operadora_id -> public.operadoras.id
SELECT 'boletos.operadora_id -> operadoras.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.boletos s
LEFT JOIN public.operadoras t ON t.id = s.operadora_id
WHERE s.operadora_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.boletos.pagador_cidade_id -> public.cidades.id
SELECT 'boletos.pagador_cidade_id -> cidades.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.boletos s
LEFT JOIN public.cidades t ON t.id = s.pagador_cidade_id
WHERE s.pagador_cidade_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.cbhpm.cbhpm_edicao_id -> public.cbhpm_edicoes.id
SELECT 'cbhpm.cbhpm_edicao_id -> cbhpm_edicoes.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.cbhpm s
LEFT JOIN public.cbhpm_edicoes t ON t.id = s.cbhpm_edicao_id
WHERE s.cbhpm_edicao_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.cbhpm.procedimento_id -> public.procedimentos.id
SELECT 'cbhpm.procedimento_id -> procedimentos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.cbhpm s
LEFT JOIN public.procedimentos t ON t.id = s.procedimento_id
WHERE s.procedimento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.cbhpm.porte_anestesico_id -> public.porte_anestesicos.porte_anestesico
SELECT 'cbhpm.porte_anestesico_id -> porte_anestesicos.porte_anestesico' AS relacao, COUNT(*) AS registros_orfaos
FROM public.cbhpm s
LEFT JOIN public.porte_anestesicos t ON t.porte_anestesico = s.porte_anestesico_id
WHERE s.porte_anestesico_id IS NOT NULL AND t.porte_anestesico IS NULL;

-- Validação: public.cidades.estado_id -> public.estados.id
SELECT 'cidades.estado_id -> estados.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.cidades s
LEFT JOIN public.estados t ON t.id = s.estado_id
WHERE s.estado_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.comunicado_portes.comunicado_edicao_id -> public.comunicado_edicoes.id
SELECT 'comunicado_portes.comunicado_edicao_id -> comunicado_edicoes.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.comunicado_portes s
LEFT JOIN public.comunicado_edicoes t ON t.id = s.comunicado_edicao_id
WHERE s.comunicado_edicao_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.contrato_profissionais.prestador_id -> public.prestadores.id
SELECT 'contrato_profissionais.prestador_id -> prestadores.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.contrato_profissionais s
LEFT JOIN public.prestadores t ON t.id = s.prestador_id
WHERE s.prestador_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.conveniado_salarios.conveniado_id -> public.conveniados.id
SELECT 'conveniado_salarios.conveniado_id -> conveniados.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.conveniado_salarios s
LEFT JOIN public.conveniados t ON t.id = s.conveniado_id
WHERE s.conveniado_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.conveniados.orgao_expedidor_uf_id -> public.estados.id
SELECT 'conveniados.orgao_expedidor_uf_id -> estados.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.conveniados s
LEFT JOIN public.estados t ON t.id = s.orgao_expedidor_uf_id
WHERE s.orgao_expedidor_uf_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.conveniados.naturalidade_cidade_id -> public.cidades.id
SELECT 'conveniados.naturalidade_cidade_id -> cidades.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.conveniados s
LEFT JOIN public.cidades t ON t.id = s.naturalidade_cidade_id
WHERE s.naturalidade_cidade_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.conveniados.usuario_id -> public.users.id
SELECT 'conveniados.usuario_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.conveniados s
LEFT JOIN public.users t ON t.id = s.usuario_id
WHERE s.usuario_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.conveniados.cargo_id -> public.cargos.id
SELECT 'conveniados.cargo_id -> cargos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.conveniados s
LEFT JOIN public.cargos t ON t.id = s.cargo_id
WHERE s.cargo_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.dados_bancarios.banco_id -> public.bancos.id
SELECT 'dados_bancarios.banco_id -> bancos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.dados_bancarios s
LEFT JOIN public.bancos t ON t.id = s.banco_id
WHERE s.banco_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.deflatores.prestadores_contratos_id -> public.prestador_contratos.id
SELECT 'deflatores.prestadores_contratos_id -> prestador_contratos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.deflatores s
LEFT JOIN public.prestador_contratos t ON t.id = s.prestadores_contratos_id
WHERE s.prestadores_contratos_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.deflatores.procedimento_grupo_id -> public.procedimentos_grupos.id
SELECT 'deflatores.procedimento_grupo_id -> procedimentos_grupos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.deflatores s
LEFT JOIN public.procedimentos_grupos t ON t.id = s.procedimento_grupo_id
WHERE s.procedimento_grupo_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.edital_credenciamento_documentos.edital_id -> public.editais_credenciamento.id
SELECT 'edital_credenciamento_documentos.edital_id -> editais_credenciamento.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.edital_credenciamento_documentos s
LEFT JOIN public.editais_credenciamento t ON t.id = s.edital_id
WHERE s.edital_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.edital_credenciamento_documentos.documento_credenciamento_id -> public.documentos_credenciamento.id
SELECT 'edital_credenciamento_documentos.documento_credenciamento_id -> documentos_credenciamento.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.edital_credenciamento_documentos s
LEFT JOIN public.documentos_credenciamento t ON t.id = s.documento_credenciamento_id
WHERE s.documento_credenciamento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.empresa_produto.empresa_id -> public.empresas.id
SELECT 'empresa_produto.empresa_id -> empresas.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.empresa_produto s
LEFT JOIN public.empresas t ON t.id = s.empresa_id
WHERE s.empresa_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.empresa_produto.produto_id -> public.produtos.id
SELECT 'empresa_produto.produto_id -> produtos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.empresa_produto s
LEFT JOIN public.produtos t ON t.id = s.produto_id
WHERE s.produto_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.empresa_user.user_id -> public.users.id
SELECT 'empresa_user.user_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.empresa_user s
LEFT JOIN public.users t ON t.id = s.user_id
WHERE s.user_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.empresa_user.empresa_id -> public.empresas.id
SELECT 'empresa_user.empresa_id -> empresas.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.empresa_user s
LEFT JOIN public.empresas t ON t.id = s.empresa_id
WHERE s.empresa_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.empresas_verbas.empresa_id -> public.empresas.id
SELECT 'empresas_verbas.empresa_id -> empresas.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.empresas_verbas s
LEFT JOIN public.empresas t ON t.id = s.empresa_id
WHERE s.empresa_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.empresas_verbas.grupo_verba_id -> public.grupo_verbas.id
SELECT 'empresas_verbas.grupo_verba_id -> grupo_verbas.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.empresas_verbas s
LEFT JOIN public.grupo_verbas t ON t.id = s.grupo_verba_id
WHERE s.grupo_verba_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.enderecos.cidade_id -> public.cidades.id
SELECT 'enderecos.cidade_id -> cidades.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.enderecos s
LEFT JOIN public.cidades t ON t.id = s.cidade_id
WHERE s.cidade_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.fiscal_contrato_itens.fiscal_contrato_id -> public.fiscal_contratos.id
SELECT 'fiscal_contrato_itens.fiscal_contrato_id -> fiscal_contratos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.fiscal_contrato_itens s
LEFT JOIN public.fiscal_contratos t ON t.id = s.fiscal_contrato_id
WHERE s.fiscal_contrato_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.fiscal_contratos.usuario_id -> public.users.id
SELECT 'fiscal_contratos.usuario_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.fiscal_contratos s
LEFT JOIN public.users t ON t.id = s.usuario_id
WHERE s.usuario_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.gestantes.conveniado_id -> public.conveniados.id
SELECT 'gestantes.conveniado_id -> conveniados.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.gestantes s
LEFT JOIN public.conveniados t ON t.id = s.conveniado_id
WHERE s.conveniado_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guia_importacoes.prestador_id -> public.prestadores.id
SELECT 'guia_importacoes.prestador_id -> prestadores.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guia_importacoes s
LEFT JOIN public.prestadores t ON t.id = s.prestador_id
WHERE s.prestador_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guia_importacoes.usuario_id -> public.users.id
SELECT 'guia_importacoes.usuario_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guia_importacoes s
LEFT JOIN public.users t ON t.id = s.usuario_id
WHERE s.usuario_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias.usuario_emissor_id -> public.users.id
SELECT 'guias.usuario_emissor_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias s
LEFT JOIN public.users t ON t.id = s.usuario_emissor_id
WHERE s.usuario_emissor_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias.prestador_id -> public.prestadores.id
SELECT 'guias.prestador_id -> prestadores.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias s
LEFT JOIN public.prestadores t ON t.id = s.prestador_id
WHERE s.prestador_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias.profissional_id -> public.prestadores.id
SELECT 'guias.profissional_id -> prestadores.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias s
LEFT JOIN public.prestadores t ON t.id = s.profissional_id
WHERE s.profissional_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias.conveniado_id -> public.conveniados.id
SELECT 'guias.conveniado_id -> conveniados.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias s
LEFT JOIN public.conveniados t ON t.id = s.conveniado_id
WHERE s.conveniado_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias.solicitante_prestador_id -> public.prestadores.id
SELECT 'guias.solicitante_prestador_id -> prestadores.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias s
LEFT JOIN public.prestadores t ON t.id = s.solicitante_prestador_id
WHERE s.solicitante_prestador_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias.lote_pagamento_id -> public.lote_pagamentos.id
SELECT 'guias.lote_pagamento_id -> lote_pagamentos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias s
LEFT JOIN public.lote_pagamentos t ON t.id = s.lote_pagamento_id
WHERE s.lote_pagamento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias.guia_origem_id -> public.guias.id
SELECT 'guias.guia_origem_id -> guias.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias s
LEFT JOIN public.guias t ON t.id = s.guia_origem_id
WHERE s.guia_origem_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias.cancelado_por_user_id -> public.users.id
SELECT 'guias.cancelado_por_user_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias s
LEFT JOIN public.users t ON t.id = s.cancelado_por_user_id
WHERE s.cancelado_por_user_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias.guia_importacao_id -> public.guia_importacoes.id
SELECT 'guias.guia_importacao_id -> guia_importacoes.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias s
LEFT JOIN public.guia_importacoes t ON t.id = s.guia_importacao_id
WHERE s.guia_importacao_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias_anexos.guia_id -> public.guias.id
SELECT 'guias_anexos.guia_id -> guias.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias_anexos s
LEFT JOIN public.guias t ON t.id = s.guia_id
WHERE s.guia_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias_atendimentos.guia_itens_id -> public.guias_itens.id
SELECT 'guias_atendimentos.guia_itens_id -> guias_itens.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias_atendimentos s
LEFT JOIN public.guias_itens t ON t.id = s.guia_itens_id
WHERE s.guia_itens_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias_atendimentos.usuario_id -> public.users.id
SELECT 'guias_atendimentos.usuario_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias_atendimentos s
LEFT JOIN public.users t ON t.id = s.usuario_id
WHERE s.usuario_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias_auditoria.guia_itens_id -> public.guias_itens.id
SELECT 'guias_auditoria.guia_itens_id -> guias_itens.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias_auditoria s
LEFT JOIN public.guias_itens t ON t.id = s.guia_itens_id
WHERE s.guia_itens_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias_auditoria.analise_usuario_id -> public.users.id
SELECT 'guias_auditoria.analise_usuario_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias_auditoria s
LEFT JOIN public.users t ON t.id = s.analise_usuario_id
WHERE s.analise_usuario_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias_historico.guia_id -> public.guias.id
SELECT 'guias_historico.guia_id -> guias.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias_historico s
LEFT JOIN public.guias t ON t.id = s.guia_id
WHERE s.guia_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias_historico.guia_item_id -> public.guias_itens.id
SELECT 'guias_historico.guia_item_id -> guias_itens.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias_historico s
LEFT JOIN public.guias_itens t ON t.id = s.guia_item_id
WHERE s.guia_item_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias_historico.usuario_id -> public.users.id
SELECT 'guias_historico.usuario_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias_historico s
LEFT JOIN public.users t ON t.id = s.usuario_id
WHERE s.usuario_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.guias_itens.guia_id -> public.guias.id
SELECT 'guias_itens.guia_id -> guias.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.guias_itens s
LEFT JOIN public.guias t ON t.id = s.guia_id
WHERE s.guia_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.historico_credenciamentos.solicitacao_credencimento_id -> public.solicitacoes_credenciamento.id
SELECT 'historico_credenciamentos.solicitacao_credencimento_id -> solicitacoes_credenciamento.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.historico_credenciamentos s
LEFT JOIN public.solicitacoes_credenciamento t ON t.id = s.solicitacao_credencimento_id
WHERE s.solicitacao_credencimento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.historico_credenciamentos.user_id -> public.users.id
SELECT 'historico_credenciamentos.user_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.historico_credenciamentos s
LEFT JOIN public.users t ON t.id = s.user_id
WHERE s.user_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.lancamentos.boleto_id -> public.boletos.id
SELECT 'lancamentos.boleto_id -> boletos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.lancamentos s
LEFT JOIN public.boletos t ON t.id = s.boleto_id
WHERE s.boleto_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.lancamentos.operadora_id -> public.operadoras.id
SELECT 'lancamentos.operadora_id -> operadoras.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.lancamentos s
LEFT JOIN public.operadoras t ON t.id = s.operadora_id
WHERE s.operadora_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.lancamentos.prestador_id -> public.prestadores.id
SELECT 'lancamentos.prestador_id -> prestadores.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.lancamentos s
LEFT JOIN public.prestadores t ON t.id = s.prestador_id
WHERE s.prestador_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.lancamentos.conveniado_id -> public.conveniados.id
SELECT 'lancamentos.conveniado_id -> conveniados.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.lancamentos s
LEFT JOIN public.conveniados t ON t.id = s.conveniado_id
WHERE s.conveniado_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.lancamentos.grupo_verba_id -> public.grupo_verbas.id
SELECT 'lancamentos.grupo_verba_id -> grupo_verbas.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.lancamentos s
LEFT JOIN public.grupo_verbas t ON t.id = s.grupo_verba_id
WHERE s.grupo_verba_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.lancamentos_guias.lancamento_id -> public.lancamentos.id
SELECT 'lancamentos_guias.lancamento_id -> lancamentos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.lancamentos_guias s
LEFT JOIN public.lancamentos t ON t.id = s.lancamento_id
WHERE s.lancamento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.lancamentos_guias.guia_id -> public.guias.id
SELECT 'lancamentos_guias.guia_id -> guias.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.lancamentos_guias s
LEFT JOIN public.guias t ON t.id = s.guia_id
WHERE s.guia_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.log_acessos.usuario_id -> public.users.id
SELECT 'log_acessos.usuario_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.log_acessos s
LEFT JOIN public.users t ON t.id = s.usuario_id
WHERE s.usuario_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.log_operacoes.usuario_id -> public.users.id
SELECT 'log_operacoes.usuario_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.log_operacoes s
LEFT JOIN public.users t ON t.id = s.usuario_id
WHERE s.usuario_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.lote_pagamentos.prestador_id -> public.prestadores.id
SELECT 'lote_pagamentos.prestador_id -> prestadores.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.lote_pagamentos s
LEFT JOIN public.prestadores t ON t.id = s.prestador_id
WHERE s.prestador_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.lote_pagamentos.usuario_id -> public.users.id
SELECT 'lote_pagamentos.usuario_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.lote_pagamentos s
LEFT JOIN public.users t ON t.id = s.usuario_id
WHERE s.usuario_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.lote_pagamentos.lancamento_id -> public.lancamentos.id
SELECT 'lote_pagamentos.lancamento_id -> lancamentos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.lote_pagamentos s
LEFT JOIN public.lancamentos t ON t.id = s.lancamento_id
WHERE s.lancamento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.materiais_itens.material_edicao_id -> public.material_edicoes.id
SELECT 'materiais_itens.material_edicao_id -> material_edicoes.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.materiais_itens s
LEFT JOIN public.material_edicoes t ON t.id = s.material_edicao_id
WHERE s.material_edicao_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.materiais_itens.material_id -> public.materiais.id
SELECT 'materiais_itens.material_id -> materiais.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.materiais_itens s
LEFT JOIN public.materiais t ON t.id = s.material_id
WHERE s.material_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.medicamento_brasindice.medicamento_edicao_id -> public.medicamento_edicoes.id
SELECT 'medicamento_brasindice.medicamento_edicao_id -> medicamento_edicoes.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.medicamento_brasindice s
LEFT JOIN public.medicamento_edicoes t ON t.id = s.medicamento_edicao_id
WHERE s.medicamento_edicao_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.medicamento_brasindice.medicamento_id -> public.medicamentos.id
SELECT 'medicamento_brasindice.medicamento_id -> medicamentos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.medicamento_brasindice s
LEFT JOIN public.medicamentos t ON t.id = s.medicamento_id
WHERE s.medicamento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.medicamentos.laboratorio_id -> public.laboratorios.id
SELECT 'medicamentos.laboratorio_id -> laboratorios.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.medicamentos s
LEFT JOIN public.laboratorios t ON t.id = s.laboratorio_id
WHERE s.laboratorio_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.medicamentos.medicamento_edicao_id -> public.medicamento_edicoes.id
SELECT 'medicamentos.medicamento_edicao_id -> medicamento_edicoes.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.medicamentos s
LEFT JOIN public.medicamento_edicoes t ON t.id = s.medicamento_edicao_id
WHERE s.medicamento_edicao_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.mensalidades.conveniado_id -> public.conveniados.id
SELECT 'mensalidades.conveniado_id -> conveniados.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.mensalidades s
LEFT JOIN public.conveniados t ON t.id = s.conveniado_id
WHERE s.conveniado_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.mensalidades.produto_preco_id -> public.produtos_precos.id
SELECT 'mensalidades.produto_preco_id -> produtos_precos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.mensalidades s
LEFT JOIN public.produtos_precos t ON t.id = s.produto_preco_id
WHERE s.produto_preco_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.mensalidades.grupo_verba_id -> public.grupo_verbas.id
SELECT 'mensalidades.grupo_verba_id -> grupo_verbas.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.mensalidades s
LEFT JOIN public.grupo_verbas t ON t.id = s.grupo_verba_id
WHERE s.grupo_verba_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.menus.parent_id -> public.menus.id
SELECT 'menus.parent_id -> menus.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.menus s
LEFT JOIN public.menus t ON t.id = s.parent_id
WHERE s.parent_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.operadora_user.operadora_id -> public.operadoras.id
SELECT 'operadora_user.operadora_id -> operadoras.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.operadora_user s
LEFT JOIN public.operadoras t ON t.id = s.operadora_id
WHERE s.operadora_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.operadora_user.user_id -> public.users.id
SELECT 'operadora_user.user_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.operadora_user s
LEFT JOIN public.users t ON t.id = s.user_id
WHERE s.user_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.permission_role.permission_id -> public.permissions.id
SELECT 'permission_role.permission_id -> permissions.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.permission_role s
LEFT JOIN public.permissions t ON t.id = s.permission_id
WHERE s.permission_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.permission_role.role_id -> public.roles.id
SELECT 'permission_role.role_id -> roles.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.permission_role s
LEFT JOIN public.roles t ON t.id = s.role_id
WHERE s.role_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestador_contrato_itens.prestadores_contratos_id -> public.prestador_contratos.id
SELECT 'prestador_contrato_itens.prestadores_contratos_id -> prestador_contratos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestador_contrato_itens s
LEFT JOIN public.prestador_contratos t ON t.id = s.prestadores_contratos_id
WHERE s.prestadores_contratos_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestador_contrato_itens.edicao_medicamento_id -> public.medicamento_edicoes.id
SELECT 'prestador_contrato_itens.edicao_medicamento_id -> medicamento_edicoes.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestador_contrato_itens s
LEFT JOIN public.medicamento_edicoes t ON t.id = s.edicao_medicamento_id
WHERE s.edicao_medicamento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestador_contrato_itens.tabela_precos_id -> public.tabela_precos.id
SELECT 'prestador_contrato_itens.tabela_precos_id -> tabela_precos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestador_contrato_itens s
LEFT JOIN public.tabela_precos t ON t.id = s.tabela_precos_id
WHERE s.tabela_precos_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestador_contrato_itens.motivo_encerramento_id -> public.motivo_encerramentos.id
SELECT 'prestador_contrato_itens.motivo_encerramento_id -> motivo_encerramentos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestador_contrato_itens s
LEFT JOIN public.motivo_encerramentos t ON t.id = s.motivo_encerramento_id
WHERE s.motivo_encerramento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestador_contratos.prestador_id -> public.prestadores.id
SELECT 'prestador_contratos.prestador_id -> prestadores.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestador_contratos s
LEFT JOIN public.prestadores t ON t.id = s.prestador_id
WHERE s.prestador_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestador_especialidades.prestador_id -> public.prestadores.id
SELECT 'prestador_especialidades.prestador_id -> prestadores.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestador_especialidades s
LEFT JOIN public.prestadores t ON t.id = s.prestador_id
WHERE s.prestador_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestador_especialidades.especialidade_id -> public.especialidades.id
SELECT 'prestador_especialidades.especialidade_id -> especialidades.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestador_especialidades s
LEFT JOIN public.especialidades t ON t.id = s.especialidade_id
WHERE s.especialidade_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestador_user.prestador_id -> public.prestadores.id
SELECT 'prestador_user.prestador_id -> prestadores.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestador_user s
LEFT JOIN public.prestadores t ON t.id = s.prestador_id
WHERE s.prestador_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestador_user.user_id -> public.users.id
SELECT 'prestador_user.user_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestador_user s
LEFT JOIN public.users t ON t.id = s.user_id
WHERE s.user_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestadores.usuario_id -> public.users.id
SELECT 'prestadores.usuario_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestadores s
LEFT JOIN public.users t ON t.id = s.usuario_id
WHERE s.usuario_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestadores.prestadores_classificacao_estabelecimento_id -> public.prestadores_classificacao_estabelecimento.id
SELECT 'prestadores.prestadores_classificacao_estabelecimento_id -> prestadores_classificacao_estabelecimento.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestadores s
LEFT JOIN public.prestadores_classificacao_estabelecimento t ON t.id = s.prestadores_classificacao_estabelecimento_id
WHERE s.prestadores_classificacao_estabelecimento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestadores.orgao_expedidor_uf_id -> public.estados.id
SELECT 'prestadores.orgao_expedidor_uf_id -> estados.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestadores s
LEFT JOIN public.estados t ON t.id = s.orgao_expedidor_uf_id
WHERE s.orgao_expedidor_uf_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestadores.naturalidade_cidade_id -> public.cidades.id
SELECT 'prestadores.naturalidade_cidade_id -> cidades.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestadores s
LEFT JOIN public.cidades t ON t.id = s.naturalidade_cidade_id
WHERE s.naturalidade_cidade_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.prestadores.prestador_tipo_id -> public.prestador_tipos.id
SELECT 'prestadores.prestador_tipo_id -> prestador_tipos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.prestadores s
LEFT JOIN public.prestador_tipos t ON t.id = s.prestador_tipo_id
WHERE s.prestador_tipo_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.procedimento_subgrupos.grupo_id -> public.procedimentos_grupos.id
SELECT 'procedimento_subgrupos.grupo_id -> procedimentos_grupos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.procedimento_subgrupos s
LEFT JOIN public.procedimentos_grupos t ON t.id = s.grupo_id
WHERE s.grupo_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.procedimentos.procedimento_subgrupo_id -> public.procedimento_subgrupos.id
SELECT 'procedimentos.procedimento_subgrupo_id -> procedimento_subgrupos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.procedimentos s
LEFT JOIN public.procedimento_subgrupos t ON t.id = s.procedimento_subgrupo_id
WHERE s.procedimento_subgrupo_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.produtos.operadora_id -> public.operadoras.id
SELECT 'produtos.operadora_id -> operadoras.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.produtos s
LEFT JOIN public.operadoras t ON t.id = s.operadora_id
WHERE s.operadora_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.produtos_precos.produto_id -> public.produtos.id
SELECT 'produtos_precos.produto_id -> produtos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.produtos_precos s
LEFT JOIN public.produtos t ON t.id = s.produto_id
WHERE s.produto_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.produtos_precos.tipo_vinculo_id -> public.tipo_vinculos.id
SELECT 'produtos_precos.tipo_vinculo_id -> tipo_vinculos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.produtos_precos s
LEFT JOIN public.tipo_vinculos t ON t.id = s.tipo_vinculo_id
WHERE s.tipo_vinculo_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.produtos_precos.grupo_verba_id -> public.grupo_verbas.id
SELECT 'produtos_precos.grupo_verba_id -> grupo_verbas.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.produtos_precos s
LEFT JOIN public.grupo_verbas t ON t.id = s.grupo_verba_id
WHERE s.grupo_verba_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.regra_cooparticipacao.produto_id -> public.produtos.id
SELECT 'regra_cooparticipacao.produto_id -> produtos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.regra_cooparticipacao s
LEFT JOIN public.produtos t ON t.id = s.produto_id
WHERE s.produto_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.regra_cooparticipacao_itens.regra_cooparticipacao_id -> public.regra_cooparticipacao.id
SELECT 'regra_cooparticipacao_itens.regra_cooparticipacao_id -> regra_cooparticipacao.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.regra_cooparticipacao_itens s
LEFT JOIN public.regra_cooparticipacao t ON t.id = s.regra_cooparticipacao_id
WHERE s.regra_cooparticipacao_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.regra_cooparticipacao_procedimentos.regra_cooparticipacao_id -> public.regra_cooparticipacao.id
SELECT 'regra_cooparticipacao_procedimentos.regra_cooparticipacao_id -> regra_cooparticipacao.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.regra_cooparticipacao_procedimentos s
LEFT JOIN public.regra_cooparticipacao t ON t.id = s.regra_cooparticipacao_id
WHERE s.regra_cooparticipacao_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.regra_cooparticipacao_procedimentos.grupo_procedimento_id -> public.procedimentos_grupos.id
SELECT 'regra_cooparticipacao_procedimentos.grupo_procedimento_id -> procedimentos_grupos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.regra_cooparticipacao_procedimentos s
LEFT JOIN public.procedimentos_grupos t ON t.id = s.grupo_procedimento_id
WHERE s.grupo_procedimento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.regra_cooparticipacao_procedimentos.subgrupo_procedimento_id -> public.procedimento_subgrupos.id
SELECT 'regra_cooparticipacao_procedimentos.subgrupo_procedimento_id -> procedimento_subgrupos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.regra_cooparticipacao_procedimentos s
LEFT JOIN public.procedimento_subgrupos t ON t.id = s.subgrupo_procedimento_id
WHERE s.subgrupo_procedimento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.regra_cooparticipacao_procedimentos.procedimento_id -> public.procedimentos.id
SELECT 'regra_cooparticipacao_procedimentos.procedimento_id -> procedimentos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.regra_cooparticipacao_procedimentos s
LEFT JOIN public.procedimentos t ON t.id = s.procedimento_id
WHERE s.procedimento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.remessa_desconto.empresa_id -> public.empresas.id
SELECT 'remessa_desconto.empresa_id -> empresas.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.remessa_desconto s
LEFT JOIN public.empresas t ON t.id = s.empresa_id
WHERE s.empresa_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.remessa_desconto_item.remessa_desconto_id -> public.remessa_desconto.id
SELECT 'remessa_desconto_item.remessa_desconto_id -> remessa_desconto.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.remessa_desconto_item s
LEFT JOIN public.remessa_desconto t ON t.id = s.remessa_desconto_id
WHERE s.remessa_desconto_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.remessa_desconto_item.adesao_id -> public.adesoes.id
SELECT 'remessa_desconto_item.adesao_id -> adesoes.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.remessa_desconto_item s
LEFT JOIN public.adesoes t ON t.id = s.adesao_id
WHERE s.adesao_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.role_user.user_id -> public.users.id
SELECT 'role_user.user_id -> users.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.role_user s
LEFT JOIN public.users t ON t.id = s.user_id
WHERE s.user_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.role_user.role_id -> public.roles.id
SELECT 'role_user.role_id -> roles.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.role_user s
LEFT JOIN public.roles t ON t.id = s.role_id
WHERE s.role_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.secretarias.empresa_id -> public.empresas.id
SELECT 'secretarias.empresa_id -> empresas.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.secretarias s
LEFT JOIN public.empresas t ON t.id = s.empresa_id
WHERE s.empresa_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.solicitacoes_atualizacao_cadastral.prestador_id -> public.prestadores.id
SELECT 'solicitacoes_atualizacao_cadastral.prestador_id -> prestadores.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.solicitacoes_atualizacao_cadastral s
LEFT JOIN public.prestadores t ON t.id = s.prestador_id
WHERE s.prestador_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.solicitacoes_atualizacao_cadastral.conveniado_id -> public.conveniados.id
SELECT 'solicitacoes_atualizacao_cadastral.conveniado_id -> conveniados.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.solicitacoes_atualizacao_cadastral s
LEFT JOIN public.conveniados t ON t.id = s.conveniado_id
WHERE s.conveniado_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.solicitacoes_atualizacao_cadastral.cidade_id -> public.cidades.id
SELECT 'solicitacoes_atualizacao_cadastral.cidade_id -> cidades.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.solicitacoes_atualizacao_cadastral s
LEFT JOIN public.cidades t ON t.id = s.cidade_id
WHERE s.cidade_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.solicitacoes_credenciamento.edital_credenciamento_id -> public.editais_credenciamento.id
SELECT 'solicitacoes_credenciamento.edital_credenciamento_id -> editais_credenciamento.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.solicitacoes_credenciamento s
LEFT JOIN public.editais_credenciamento t ON t.id = s.edital_credenciamento_id
WHERE s.edital_credenciamento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.solicitacoes_credenciamento_documentos.solicitacoes_credenciamento_id -> public.solicitacoes_credenciamento.id
SELECT 'solicitacoes_credenciamento_documentos.solicitacoes_credenciamento_id -> solicitacoes_credenciamento.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.solicitacoes_credenciamento_documentos s
LEFT JOIN public.solicitacoes_credenciamento t ON t.id = s.solicitacoes_credenciamento_id
WHERE s.solicitacoes_credenciamento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.solicitacoes_credenciamento_documentos.documento_credenciamento_id -> public.documentos_credenciamento.id
SELECT 'solicitacoes_credenciamento_documentos.documento_credenciamento_id -> documentos_credenciamento.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.solicitacoes_credenciamento_documentos s
LEFT JOIN public.documentos_credenciamento t ON t.id = s.documento_credenciamento_id
WHERE s.documento_credenciamento_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.tabela_precos.comunicado_edicao_id -> public.comunicado_edicoes.id
SELECT 'tabela_precos.comunicado_edicao_id -> comunicado_edicoes.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.tabela_precos s
LEFT JOIN public.comunicado_edicoes t ON t.id = s.comunicado_edicao_id
WHERE s.comunicado_edicao_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.tabela_precos.cbhpm_edicao_id -> public.cbhpm_edicoes.id
SELECT 'tabela_precos.cbhpm_edicao_id -> cbhpm_edicoes.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.tabela_precos s
LEFT JOIN public.cbhpm_edicoes t ON t.id = s.cbhpm_edicao_id
WHERE s.cbhpm_edicao_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.tabela_precos.material_edicao_id -> public.material_edicoes.id
SELECT 'tabela_precos.material_edicao_id -> material_edicoes.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.tabela_precos s
LEFT JOIN public.material_edicoes t ON t.id = s.material_edicao_id
WHERE s.material_edicao_id IS NOT NULL AND t.id IS NULL;

-- Validação: public.tabela_precos_itens.tabela_preco_id -> public.tabela_precos.id
SELECT 'tabela_precos_itens.tabela_preco_id -> tabela_precos.id' AS relacao, COUNT(*) AS registros_orfaos
FROM public.tabela_precos_itens s
LEFT JOIN public.tabela_precos t ON t.id = s.tabela_preco_id
WHERE s.tabela_preco_id IS NOT NULL AND t.id IS NULL;

-- ============================================================
-- 2) APLICAÇÃO SEGURA DAS FOREIGN KEYS
-- NOT VALID permite criar a constraint sem travar toda a validação histórica.
-- Depois corrija órfãos e rode VALIDATE CONSTRAINT.
-- ============================================================

ALTER TABLE public.adesao_reducao_margem
  ADD CONSTRAINT fk_adesao_reducao_margem_adesao_id_adesoes
  FOREIGN KEY (adesao_id) REFERENCES public.adesoes(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.adesoes
  ADD CONSTRAINT fk_adesoes_operadora_id_operadoras
  FOREIGN KEY (operadora_id) REFERENCES public.operadoras(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.adesoes
  ADD CONSTRAINT fk_adesoes_empresa_id_empresas
  FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.adesoes
  ADD CONSTRAINT fk_adesoes_secretaria_id_secretarias
  FOREIGN KEY (secretaria_id) REFERENCES public.secretarias(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.adesoes
  ADD CONSTRAINT fk_adesoes_conveniado_id_conveniados
  FOREIGN KEY (conveniado_id) REFERENCES public.conveniados(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.adesoes
  ADD CONSTRAINT fk_adesoes_produto_id_produtos
  FOREIGN KEY (produto_id) REFERENCES public.produtos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.adesoes
  ADD CONSTRAINT fk_adesoes_produto_preco_id_produtos_precos
  FOREIGN KEY (produto_preco_id) REFERENCES public.produtos_precos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.adesoes
  ADD CONSTRAINT fk_adesoes_motivo_encerramento_id_motivo_encerramentos
  FOREIGN KEY (motivo_encerramento_id) REFERENCES public.motivo_encerramentos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.boleto_lancamentos
  ADD CONSTRAINT fk_boleto_lancamentos_boleto_id_boletos
  FOREIGN KEY (boleto_id) REFERENCES public.boletos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.boleto_lancamentos
  ADD CONSTRAINT fk_boleto_lancamentos_lancamento_id_lancamentos
  FOREIGN KEY (lancamento_id) REFERENCES public.lancamentos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.boletos
  ADD CONSTRAINT fk_boletos_operadora_id_operadoras
  FOREIGN KEY (operadora_id) REFERENCES public.operadoras(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.boletos
  ADD CONSTRAINT fk_boletos_pagador_cidade_id_cidades
  FOREIGN KEY (pagador_cidade_id) REFERENCES public.cidades(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.cbhpm
  ADD CONSTRAINT fk_cbhpm_cbhpm_edicao_id_cbhpm_edicoes
  FOREIGN KEY (cbhpm_edicao_id) REFERENCES public.cbhpm_edicoes(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.cbhpm
  ADD CONSTRAINT fk_cbhpm_procedimento_id_procedimentos
  FOREIGN KEY (procedimento_id) REFERENCES public.procedimentos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.cbhpm
  ADD CONSTRAINT fk_cbhpm_porte_anestesico_id_porte_anestesicos
  FOREIGN KEY (porte_anestesico_id) REFERENCES public.porte_anestesicos(porte_anestesico)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.cidades
  ADD CONSTRAINT fk_cidades_estado_id_estados
  FOREIGN KEY (estado_id) REFERENCES public.estados(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.comunicado_portes
  ADD CONSTRAINT fk_comunicado_portes_comunicado_edicao_id_comunicado_edicoes
  FOREIGN KEY (comunicado_edicao_id) REFERENCES public.comunicado_edicoes(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.contrato_profissionais
  ADD CONSTRAINT fk_contrato_profissionais_prestador_id_prestadores
  FOREIGN KEY (prestador_id) REFERENCES public.prestadores(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.conveniado_salarios
  ADD CONSTRAINT fk_conveniado_salarios_conveniado_id_conveniados
  FOREIGN KEY (conveniado_id) REFERENCES public.conveniados(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.conveniados
  ADD CONSTRAINT fk_conveniados_orgao_expedidor_uf_id_estados
  FOREIGN KEY (orgao_expedidor_uf_id) REFERENCES public.estados(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.conveniados
  ADD CONSTRAINT fk_conveniados_naturalidade_cidade_id_cidades
  FOREIGN KEY (naturalidade_cidade_id) REFERENCES public.cidades(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.conveniados
  ADD CONSTRAINT fk_conveniados_usuario_id_users
  FOREIGN KEY (usuario_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.conveniados
  ADD CONSTRAINT fk_conveniados_cargo_id_cargos
  FOREIGN KEY (cargo_id) REFERENCES public.cargos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.dados_bancarios
  ADD CONSTRAINT fk_dados_bancarios_banco_id_bancos
  FOREIGN KEY (banco_id) REFERENCES public.bancos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.deflatores
  ADD CONSTRAINT fk_deflatores_prestadores_contratos_id_prestador_contratos
  FOREIGN KEY (prestadores_contratos_id) REFERENCES public.prestador_contratos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.deflatores
  ADD CONSTRAINT fk_deflatores_procedimento_grupo_id_procedimentos_grupos
  FOREIGN KEY (procedimento_grupo_id) REFERENCES public.procedimentos_grupos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.edital_credenciamento_documentos
  ADD CONSTRAINT fk_edital_credenciamento_documentos_edital_id_editais_credencia
  FOREIGN KEY (edital_id) REFERENCES public.editais_credenciamento(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.edital_credenciamento_documentos
  ADD CONSTRAINT fk_edital_credenciamento_documentos_documento_credenciamento_id
  FOREIGN KEY (documento_credenciamento_id) REFERENCES public.documentos_credenciamento(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.empresa_produto
  ADD CONSTRAINT fk_empresa_produto_empresa_id_empresas
  FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.empresa_produto
  ADD CONSTRAINT fk_empresa_produto_produto_id_produtos
  FOREIGN KEY (produto_id) REFERENCES public.produtos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.empresa_user
  ADD CONSTRAINT fk_empresa_user_user_id_users
  FOREIGN KEY (user_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.empresa_user
  ADD CONSTRAINT fk_empresa_user_empresa_id_empresas
  FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.empresas_verbas
  ADD CONSTRAINT fk_empresas_verbas_empresa_id_empresas
  FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.empresas_verbas
  ADD CONSTRAINT fk_empresas_verbas_grupo_verba_id_grupo_verbas
  FOREIGN KEY (grupo_verba_id) REFERENCES public.grupo_verbas(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.enderecos
  ADD CONSTRAINT fk_enderecos_cidade_id_cidades
  FOREIGN KEY (cidade_id) REFERENCES public.cidades(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.fiscal_contrato_itens
  ADD CONSTRAINT fk_fiscal_contrato_itens_fiscal_contrato_id_fiscal_contratos
  FOREIGN KEY (fiscal_contrato_id) REFERENCES public.fiscal_contratos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.fiscal_contratos
  ADD CONSTRAINT fk_fiscal_contratos_usuario_id_users
  FOREIGN KEY (usuario_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.gestantes
  ADD CONSTRAINT fk_gestantes_conveniado_id_conveniados
  FOREIGN KEY (conveniado_id) REFERENCES public.conveniados(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guia_importacoes
  ADD CONSTRAINT fk_guia_importacoes_prestador_id_prestadores
  FOREIGN KEY (prestador_id) REFERENCES public.prestadores(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guia_importacoes
  ADD CONSTRAINT fk_guia_importacoes_usuario_id_users
  FOREIGN KEY (usuario_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias
  ADD CONSTRAINT fk_guias_usuario_emissor_id_users
  FOREIGN KEY (usuario_emissor_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias
  ADD CONSTRAINT fk_guias_prestador_id_prestadores
  FOREIGN KEY (prestador_id) REFERENCES public.prestadores(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias
  ADD CONSTRAINT fk_guias_profissional_id_prestadores
  FOREIGN KEY (profissional_id) REFERENCES public.prestadores(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias
  ADD CONSTRAINT fk_guias_conveniado_id_conveniados
  FOREIGN KEY (conveniado_id) REFERENCES public.conveniados(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias
  ADD CONSTRAINT fk_guias_solicitante_prestador_id_prestadores
  FOREIGN KEY (solicitante_prestador_id) REFERENCES public.prestadores(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias
  ADD CONSTRAINT fk_guias_lote_pagamento_id_lote_pagamentos
  FOREIGN KEY (lote_pagamento_id) REFERENCES public.lote_pagamentos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias
  ADD CONSTRAINT fk_guias_guia_origem_id_guias
  FOREIGN KEY (guia_origem_id) REFERENCES public.guias(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias
  ADD CONSTRAINT fk_guias_cancelado_por_user_id_users
  FOREIGN KEY (cancelado_por_user_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias
  ADD CONSTRAINT fk_guias_guia_importacao_id_guia_importacoes
  FOREIGN KEY (guia_importacao_id) REFERENCES public.guia_importacoes(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias_anexos
  ADD CONSTRAINT fk_guias_anexos_guia_id_guias
  FOREIGN KEY (guia_id) REFERENCES public.guias(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias_atendimentos
  ADD CONSTRAINT fk_guias_atendimentos_guia_itens_id_guias_itens
  FOREIGN KEY (guia_itens_id) REFERENCES public.guias_itens(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias_atendimentos
  ADD CONSTRAINT fk_guias_atendimentos_usuario_id_users
  FOREIGN KEY (usuario_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias_auditoria
  ADD CONSTRAINT fk_guias_auditoria_guia_itens_id_guias_itens
  FOREIGN KEY (guia_itens_id) REFERENCES public.guias_itens(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias_auditoria
  ADD CONSTRAINT fk_guias_auditoria_analise_usuario_id_users
  FOREIGN KEY (analise_usuario_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias_historico
  ADD CONSTRAINT fk_guias_historico_guia_id_guias
  FOREIGN KEY (guia_id) REFERENCES public.guias(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias_historico
  ADD CONSTRAINT fk_guias_historico_guia_item_id_guias_itens
  FOREIGN KEY (guia_item_id) REFERENCES public.guias_itens(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias_historico
  ADD CONSTRAINT fk_guias_historico_usuario_id_users
  FOREIGN KEY (usuario_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.guias_itens
  ADD CONSTRAINT fk_guias_itens_guia_id_guias
  FOREIGN KEY (guia_id) REFERENCES public.guias(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.historico_credenciamentos
  ADD CONSTRAINT fk_historico_credenciamentos_solicitacao_credencimento_id_solic
  FOREIGN KEY (solicitacao_credencimento_id) REFERENCES public.solicitacoes_credenciamento(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.historico_credenciamentos
  ADD CONSTRAINT fk_historico_credenciamentos_user_id_users
  FOREIGN KEY (user_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.lancamentos
  ADD CONSTRAINT fk_lancamentos_boleto_id_boletos
  FOREIGN KEY (boleto_id) REFERENCES public.boletos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.lancamentos
  ADD CONSTRAINT fk_lancamentos_operadora_id_operadoras
  FOREIGN KEY (operadora_id) REFERENCES public.operadoras(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.lancamentos
  ADD CONSTRAINT fk_lancamentos_prestador_id_prestadores
  FOREIGN KEY (prestador_id) REFERENCES public.prestadores(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.lancamentos
  ADD CONSTRAINT fk_lancamentos_conveniado_id_conveniados
  FOREIGN KEY (conveniado_id) REFERENCES public.conveniados(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.lancamentos
  ADD CONSTRAINT fk_lancamentos_grupo_verba_id_grupo_verbas
  FOREIGN KEY (grupo_verba_id) REFERENCES public.grupo_verbas(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.lancamentos_guias
  ADD CONSTRAINT fk_lancamentos_guias_lancamento_id_lancamentos
  FOREIGN KEY (lancamento_id) REFERENCES public.lancamentos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.lancamentos_guias
  ADD CONSTRAINT fk_lancamentos_guias_guia_id_guias
  FOREIGN KEY (guia_id) REFERENCES public.guias(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.log_acessos
  ADD CONSTRAINT fk_log_acessos_usuario_id_users
  FOREIGN KEY (usuario_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.log_operacoes
  ADD CONSTRAINT fk_log_operacoes_usuario_id_users
  FOREIGN KEY (usuario_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.lote_pagamentos
  ADD CONSTRAINT fk_lote_pagamentos_prestador_id_prestadores
  FOREIGN KEY (prestador_id) REFERENCES public.prestadores(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.lote_pagamentos
  ADD CONSTRAINT fk_lote_pagamentos_usuario_id_users
  FOREIGN KEY (usuario_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.lote_pagamentos
  ADD CONSTRAINT fk_lote_pagamentos_lancamento_id_lancamentos
  FOREIGN KEY (lancamento_id) REFERENCES public.lancamentos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.materiais_itens
  ADD CONSTRAINT fk_materiais_itens_material_edicao_id_material_edicoes
  FOREIGN KEY (material_edicao_id) REFERENCES public.material_edicoes(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.materiais_itens
  ADD CONSTRAINT fk_materiais_itens_material_id_materiais
  FOREIGN KEY (material_id) REFERENCES public.materiais(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.medicamento_brasindice
  ADD CONSTRAINT fk_medicamento_brasindice_medicamento_edicao_id_medicamento_edi
  FOREIGN KEY (medicamento_edicao_id) REFERENCES public.medicamento_edicoes(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.medicamento_brasindice
  ADD CONSTRAINT fk_medicamento_brasindice_medicamento_id_medicamentos
  FOREIGN KEY (medicamento_id) REFERENCES public.medicamentos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.medicamentos
  ADD CONSTRAINT fk_medicamentos_laboratorio_id_laboratorios
  FOREIGN KEY (laboratorio_id) REFERENCES public.laboratorios(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.medicamentos
  ADD CONSTRAINT fk_medicamentos_medicamento_edicao_id_medicamento_edicoes
  FOREIGN KEY (medicamento_edicao_id) REFERENCES public.medicamento_edicoes(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.mensalidades
  ADD CONSTRAINT fk_mensalidades_conveniado_id_conveniados
  FOREIGN KEY (conveniado_id) REFERENCES public.conveniados(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.mensalidades
  ADD CONSTRAINT fk_mensalidades_produto_preco_id_produtos_precos
  FOREIGN KEY (produto_preco_id) REFERENCES public.produtos_precos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.mensalidades
  ADD CONSTRAINT fk_mensalidades_grupo_verba_id_grupo_verbas
  FOREIGN KEY (grupo_verba_id) REFERENCES public.grupo_verbas(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.menus
  ADD CONSTRAINT fk_menus_parent_id_menus
  FOREIGN KEY (parent_id) REFERENCES public.menus(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.operadora_user
  ADD CONSTRAINT fk_operadora_user_operadora_id_operadoras
  FOREIGN KEY (operadora_id) REFERENCES public.operadoras(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.operadora_user
  ADD CONSTRAINT fk_operadora_user_user_id_users
  FOREIGN KEY (user_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.permission_role
  ADD CONSTRAINT fk_permission_role_permission_id_permissions
  FOREIGN KEY (permission_id) REFERENCES public.permissions(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.permission_role
  ADD CONSTRAINT fk_permission_role_role_id_roles
  FOREIGN KEY (role_id) REFERENCES public.roles(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestador_contrato_itens
  ADD CONSTRAINT fk_prestador_contrato_itens_prestadores_contratos_id_prestador_
  FOREIGN KEY (prestadores_contratos_id) REFERENCES public.prestador_contratos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestador_contrato_itens
  ADD CONSTRAINT fk_prestador_contrato_itens_edicao_medicamento_id_medicamento_e
  FOREIGN KEY (edicao_medicamento_id) REFERENCES public.medicamento_edicoes(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestador_contrato_itens
  ADD CONSTRAINT fk_prestador_contrato_itens_tabela_precos_id_tabela_precos
  FOREIGN KEY (tabela_precos_id) REFERENCES public.tabela_precos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestador_contrato_itens
  ADD CONSTRAINT fk_prestador_contrato_itens_motivo_encerramento_id_motivo_encer
  FOREIGN KEY (motivo_encerramento_id) REFERENCES public.motivo_encerramentos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestador_contratos
  ADD CONSTRAINT fk_prestador_contratos_prestador_id_prestadores
  FOREIGN KEY (prestador_id) REFERENCES public.prestadores(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestador_especialidades
  ADD CONSTRAINT fk_prestador_especialidades_prestador_id_prestadores
  FOREIGN KEY (prestador_id) REFERENCES public.prestadores(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestador_especialidades
  ADD CONSTRAINT fk_prestador_especialidades_especialidade_id_especialidades
  FOREIGN KEY (especialidade_id) REFERENCES public.especialidades(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestador_user
  ADD CONSTRAINT fk_prestador_user_prestador_id_prestadores
  FOREIGN KEY (prestador_id) REFERENCES public.prestadores(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestador_user
  ADD CONSTRAINT fk_prestador_user_user_id_users
  FOREIGN KEY (user_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestadores
  ADD CONSTRAINT fk_prestadores_usuario_id_users
  FOREIGN KEY (usuario_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestadores
  ADD CONSTRAINT fk_prestadores_prestadores_classificacao_estabelecimento_id_pre
  FOREIGN KEY (prestadores_classificacao_estabelecimento_id) REFERENCES public.prestadores_classificacao_estabelecimento(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestadores
  ADD CONSTRAINT fk_prestadores_orgao_expedidor_uf_id_estados
  FOREIGN KEY (orgao_expedidor_uf_id) REFERENCES public.estados(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestadores
  ADD CONSTRAINT fk_prestadores_naturalidade_cidade_id_cidades
  FOREIGN KEY (naturalidade_cidade_id) REFERENCES public.cidades(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.prestadores
  ADD CONSTRAINT fk_prestadores_prestador_tipo_id_prestador_tipos
  FOREIGN KEY (prestador_tipo_id) REFERENCES public.prestador_tipos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.procedimento_subgrupos
  ADD CONSTRAINT fk_procedimento_subgrupos_grupo_id_procedimentos_grupos
  FOREIGN KEY (grupo_id) REFERENCES public.procedimentos_grupos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.procedimentos
  ADD CONSTRAINT fk_procedimentos_procedimento_subgrupo_id_procedimento_subgrupo
  FOREIGN KEY (procedimento_subgrupo_id) REFERENCES public.procedimento_subgrupos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.produtos
  ADD CONSTRAINT fk_produtos_operadora_id_operadoras
  FOREIGN KEY (operadora_id) REFERENCES public.operadoras(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.produtos_precos
  ADD CONSTRAINT fk_produtos_precos_produto_id_produtos
  FOREIGN KEY (produto_id) REFERENCES public.produtos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.produtos_precos
  ADD CONSTRAINT fk_produtos_precos_tipo_vinculo_id_tipo_vinculos
  FOREIGN KEY (tipo_vinculo_id) REFERENCES public.tipo_vinculos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.produtos_precos
  ADD CONSTRAINT fk_produtos_precos_grupo_verba_id_grupo_verbas
  FOREIGN KEY (grupo_verba_id) REFERENCES public.grupo_verbas(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.regra_cooparticipacao
  ADD CONSTRAINT fk_regra_cooparticipacao_produto_id_produtos
  FOREIGN KEY (produto_id) REFERENCES public.produtos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.regra_cooparticipacao_itens
  ADD CONSTRAINT fk_regra_cooparticipacao_itens_regra_cooparticipacao_id_regra_c
  FOREIGN KEY (regra_cooparticipacao_id) REFERENCES public.regra_cooparticipacao(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.regra_cooparticipacao_procedimentos
  ADD CONSTRAINT fk_regra_cooparticipacao_procedimentos_regra_cooparticipacao_id
  FOREIGN KEY (regra_cooparticipacao_id) REFERENCES public.regra_cooparticipacao(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.regra_cooparticipacao_procedimentos
  ADD CONSTRAINT fk_regra_cooparticipacao_procedimentos_grupo_procedimento_id_pr
  FOREIGN KEY (grupo_procedimento_id) REFERENCES public.procedimentos_grupos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.regra_cooparticipacao_procedimentos
  ADD CONSTRAINT fk_regra_cooparticipacao_procedimentos_subgrupo_procedimento_id
  FOREIGN KEY (subgrupo_procedimento_id) REFERENCES public.procedimento_subgrupos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.regra_cooparticipacao_procedimentos
  ADD CONSTRAINT fk_regra_cooparticipacao_procedimentos_procedimento_id_procedim
  FOREIGN KEY (procedimento_id) REFERENCES public.procedimentos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.remessa_desconto
  ADD CONSTRAINT fk_remessa_desconto_empresa_id_empresas
  FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.remessa_desconto_item
  ADD CONSTRAINT fk_remessa_desconto_item_remessa_desconto_id_remessa_desconto
  FOREIGN KEY (remessa_desconto_id) REFERENCES public.remessa_desconto(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.remessa_desconto_item
  ADD CONSTRAINT fk_remessa_desconto_item_adesao_id_adesoes
  FOREIGN KEY (adesao_id) REFERENCES public.adesoes(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.role_user
  ADD CONSTRAINT fk_role_user_user_id_users
  FOREIGN KEY (user_id) REFERENCES public.users(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.role_user
  ADD CONSTRAINT fk_role_user_role_id_roles
  FOREIGN KEY (role_id) REFERENCES public.roles(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.secretarias
  ADD CONSTRAINT fk_secretarias_empresa_id_empresas
  FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.solicitacoes_atualizacao_cadastral
  ADD CONSTRAINT fk_solicitacoes_atualizacao_cadastral_prestador_id_prestadores
  FOREIGN KEY (prestador_id) REFERENCES public.prestadores(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.solicitacoes_atualizacao_cadastral
  ADD CONSTRAINT fk_solicitacoes_atualizacao_cadastral_conveniado_id_conveniados
  FOREIGN KEY (conveniado_id) REFERENCES public.conveniados(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.solicitacoes_atualizacao_cadastral
  ADD CONSTRAINT fk_solicitacoes_atualizacao_cadastral_cidade_id_cidades
  FOREIGN KEY (cidade_id) REFERENCES public.cidades(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.solicitacoes_credenciamento
  ADD CONSTRAINT fk_solicitacoes_credenciamento_edital_credenciamento_id_editais
  FOREIGN KEY (edital_credenciamento_id) REFERENCES public.editais_credenciamento(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.solicitacoes_credenciamento_documentos
  ADD CONSTRAINT fk_solicitacoes_credenciamento_documentos_solicitacoes_credenci
  FOREIGN KEY (solicitacoes_credenciamento_id) REFERENCES public.solicitacoes_credenciamento(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.solicitacoes_credenciamento_documentos
  ADD CONSTRAINT fk_solicitacoes_credenciamento_documentos_documento_credenciame
  FOREIGN KEY (documento_credenciamento_id) REFERENCES public.documentos_credenciamento(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.tabela_precos
  ADD CONSTRAINT fk_tabela_precos_comunicado_edicao_id_comunicado_edicoes
  FOREIGN KEY (comunicado_edicao_id) REFERENCES public.comunicado_edicoes(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.tabela_precos
  ADD CONSTRAINT fk_tabela_precos_cbhpm_edicao_id_cbhpm_edicoes
  FOREIGN KEY (cbhpm_edicao_id) REFERENCES public.cbhpm_edicoes(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.tabela_precos
  ADD CONSTRAINT fk_tabela_precos_material_edicao_id_material_edicoes
  FOREIGN KEY (material_edicao_id) REFERENCES public.material_edicoes(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

ALTER TABLE public.tabela_precos_itens
  ADD CONSTRAINT fk_tabela_precos_itens_tabela_preco_id_tabela_precos
  FOREIGN KEY (tabela_preco_id) REFERENCES public.tabela_precos(id)
  ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;

-- ============================================================
-- 3) VALIDAR CONSTRAINTS APÓS CORRIGIR DADOS ÓRFÃOS
-- Rode esta seção somente depois das consultas de validação retornarem 0.
-- ============================================================

ALTER TABLE public.adesao_reducao_margem VALIDATE CONSTRAINT fk_adesao_reducao_margem_adesao_id_adesoes;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_operadora_id_operadoras;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_empresa_id_empresas;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_secretaria_id_secretarias;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_conveniado_id_conveniados;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_produto_id_produtos;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_produto_preco_id_produtos_precos;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_motivo_encerramento_id_motivo_encerramentos;
ALTER TABLE public.boleto_lancamentos VALIDATE CONSTRAINT fk_boleto_lancamentos_boleto_id_boletos;
ALTER TABLE public.boleto_lancamentos VALIDATE CONSTRAINT fk_boleto_lancamentos_lancamento_id_lancamentos;
ALTER TABLE public.boletos VALIDATE CONSTRAINT fk_boletos_operadora_id_operadoras;
ALTER TABLE public.boletos VALIDATE CONSTRAINT fk_boletos_pagador_cidade_id_cidades;
ALTER TABLE public.cbhpm VALIDATE CONSTRAINT fk_cbhpm_cbhpm_edicao_id_cbhpm_edicoes;
ALTER TABLE public.cbhpm VALIDATE CONSTRAINT fk_cbhpm_procedimento_id_procedimentos;
ALTER TABLE public.cbhpm VALIDATE CONSTRAINT fk_cbhpm_porte_anestesico_id_porte_anestesicos;
ALTER TABLE public.cidades VALIDATE CONSTRAINT fk_cidades_estado_id_estados;
ALTER TABLE public.comunicado_portes VALIDATE CONSTRAINT fk_comunicado_portes_comunicado_edicao_id_comunicado_edicoes;
ALTER TABLE public.contrato_profissionais VALIDATE CONSTRAINT fk_contrato_profissionais_prestador_id_prestadores;
ALTER TABLE public.conveniado_salarios VALIDATE CONSTRAINT fk_conveniado_salarios_conveniado_id_conveniados;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT fk_conveniados_orgao_expedidor_uf_id_estados;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT fk_conveniados_naturalidade_cidade_id_cidades;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT fk_conveniados_usuario_id_users;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT fk_conveniados_cargo_id_cargos;
ALTER TABLE public.dados_bancarios VALIDATE CONSTRAINT fk_dados_bancarios_banco_id_bancos;
ALTER TABLE public.deflatores VALIDATE CONSTRAINT fk_deflatores_prestadores_contratos_id_prestador_contratos;
ALTER TABLE public.deflatores VALIDATE CONSTRAINT fk_deflatores_procedimento_grupo_id_procedimentos_grupos;
ALTER TABLE public.edital_credenciamento_documentos VALIDATE CONSTRAINT fk_edital_credenciamento_documentos_edital_id_editais_credencia;
ALTER TABLE public.edital_credenciamento_documentos VALIDATE CONSTRAINT fk_edital_credenciamento_documentos_documento_credenciamento_id;
ALTER TABLE public.empresa_produto VALIDATE CONSTRAINT fk_empresa_produto_empresa_id_empresas;
ALTER TABLE public.empresa_produto VALIDATE CONSTRAINT fk_empresa_produto_produto_id_produtos;
ALTER TABLE public.empresa_user VALIDATE CONSTRAINT fk_empresa_user_user_id_users;
ALTER TABLE public.empresa_user VALIDATE CONSTRAINT fk_empresa_user_empresa_id_empresas;
ALTER TABLE public.empresas_verbas VALIDATE CONSTRAINT fk_empresas_verbas_empresa_id_empresas;
ALTER TABLE public.empresas_verbas VALIDATE CONSTRAINT fk_empresas_verbas_grupo_verba_id_grupo_verbas;
ALTER TABLE public.enderecos VALIDATE CONSTRAINT fk_enderecos_cidade_id_cidades;
ALTER TABLE public.fiscal_contrato_itens VALIDATE CONSTRAINT fk_fiscal_contrato_itens_fiscal_contrato_id_fiscal_contratos;
ALTER TABLE public.fiscal_contratos VALIDATE CONSTRAINT fk_fiscal_contratos_usuario_id_users;
ALTER TABLE public.gestantes VALIDATE CONSTRAINT fk_gestantes_conveniado_id_conveniados;
ALTER TABLE public.guia_importacoes VALIDATE CONSTRAINT fk_guia_importacoes_prestador_id_prestadores;
ALTER TABLE public.guia_importacoes VALIDATE CONSTRAINT fk_guia_importacoes_usuario_id_users;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_usuario_emissor_id_users;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_prestador_id_prestadores;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_profissional_id_prestadores;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_conveniado_id_conveniados;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_solicitante_prestador_id_prestadores;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_lote_pagamento_id_lote_pagamentos;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_guia_origem_id_guias;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_cancelado_por_user_id_users;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_guia_importacao_id_guia_importacoes;
ALTER TABLE public.guias_anexos VALIDATE CONSTRAINT fk_guias_anexos_guia_id_guias;
ALTER TABLE public.guias_atendimentos VALIDATE CONSTRAINT fk_guias_atendimentos_guia_itens_id_guias_itens;
ALTER TABLE public.guias_atendimentos VALIDATE CONSTRAINT fk_guias_atendimentos_usuario_id_users;
ALTER TABLE public.guias_auditoria VALIDATE CONSTRAINT fk_guias_auditoria_guia_itens_id_guias_itens;
ALTER TABLE public.guias_auditoria VALIDATE CONSTRAINT fk_guias_auditoria_analise_usuario_id_users;
ALTER TABLE public.guias_historico VALIDATE CONSTRAINT fk_guias_historico_guia_id_guias;
ALTER TABLE public.guias_historico VALIDATE CONSTRAINT fk_guias_historico_guia_item_id_guias_itens;
ALTER TABLE public.guias_historico VALIDATE CONSTRAINT fk_guias_historico_usuario_id_users;
ALTER TABLE public.guias_itens VALIDATE CONSTRAINT fk_guias_itens_guia_id_guias;
ALTER TABLE public.historico_credenciamentos VALIDATE CONSTRAINT fk_historico_credenciamentos_solicitacao_credencimento_id_solic;
ALTER TABLE public.historico_credenciamentos VALIDATE CONSTRAINT fk_historico_credenciamentos_user_id_users;
ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_boleto_id_boletos;
ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_operadora_id_operadoras;
ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_prestador_id_prestadores;
ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_conveniado_id_conveniados;
ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_grupo_verba_id_grupo_verbas;
ALTER TABLE public.lancamentos_guias VALIDATE CONSTRAINT fk_lancamentos_guias_lancamento_id_lancamentos;
ALTER TABLE public.lancamentos_guias VALIDATE CONSTRAINT fk_lancamentos_guias_guia_id_guias;
ALTER TABLE public.log_acessos VALIDATE CONSTRAINT fk_log_acessos_usuario_id_users;
ALTER TABLE public.log_operacoes VALIDATE CONSTRAINT fk_log_operacoes_usuario_id_users;
ALTER TABLE public.lote_pagamentos VALIDATE CONSTRAINT fk_lote_pagamentos_prestador_id_prestadores;
ALTER TABLE public.lote_pagamentos VALIDATE CONSTRAINT fk_lote_pagamentos_usuario_id_users;
ALTER TABLE public.lote_pagamentos VALIDATE CONSTRAINT fk_lote_pagamentos_lancamento_id_lancamentos;
ALTER TABLE public.materiais_itens VALIDATE CONSTRAINT fk_materiais_itens_material_edicao_id_material_edicoes;
ALTER TABLE public.materiais_itens VALIDATE CONSTRAINT fk_materiais_itens_material_id_materiais;
ALTER TABLE public.medicamento_brasindice VALIDATE CONSTRAINT fk_medicamento_brasindice_medicamento_edicao_id_medicamento_edi;
ALTER TABLE public.medicamento_brasindice VALIDATE CONSTRAINT fk_medicamento_brasindice_medicamento_id_medicamentos;
ALTER TABLE public.medicamentos VALIDATE CONSTRAINT fk_medicamentos_laboratorio_id_laboratorios;
ALTER TABLE public.medicamentos VALIDATE CONSTRAINT fk_medicamentos_medicamento_edicao_id_medicamento_edicoes;
ALTER TABLE public.mensalidades VALIDATE CONSTRAINT fk_mensalidades_conveniado_id_conveniados;
ALTER TABLE public.mensalidades VALIDATE CONSTRAINT fk_mensalidades_produto_preco_id_produtos_precos;
ALTER TABLE public.mensalidades VALIDATE CONSTRAINT fk_mensalidades_grupo_verba_id_grupo_verbas;
ALTER TABLE public.menus VALIDATE CONSTRAINT fk_menus_parent_id_menus;
ALTER TABLE public.operadora_user VALIDATE CONSTRAINT fk_operadora_user_operadora_id_operadoras;
ALTER TABLE public.operadora_user VALIDATE CONSTRAINT fk_operadora_user_user_id_users;
ALTER TABLE public.permission_role VALIDATE CONSTRAINT fk_permission_role_permission_id_permissions;
ALTER TABLE public.permission_role VALIDATE CONSTRAINT fk_permission_role_role_id_roles;
ALTER TABLE public.prestador_contrato_itens VALIDATE CONSTRAINT fk_prestador_contrato_itens_prestadores_contratos_id_prestador_;
ALTER TABLE public.prestador_contrato_itens VALIDATE CONSTRAINT fk_prestador_contrato_itens_edicao_medicamento_id_medicamento_e;
ALTER TABLE public.prestador_contrato_itens VALIDATE CONSTRAINT fk_prestador_contrato_itens_tabela_precos_id_tabela_precos;
ALTER TABLE public.prestador_contrato_itens VALIDATE CONSTRAINT fk_prestador_contrato_itens_motivo_encerramento_id_motivo_encer;
ALTER TABLE public.prestador_contratos VALIDATE CONSTRAINT fk_prestador_contratos_prestador_id_prestadores;
ALTER TABLE public.prestador_especialidades VALIDATE CONSTRAINT fk_prestador_especialidades_prestador_id_prestadores;
ALTER TABLE public.prestador_especialidades VALIDATE CONSTRAINT fk_prestador_especialidades_especialidade_id_especialidades;
ALTER TABLE public.prestador_user VALIDATE CONSTRAINT fk_prestador_user_prestador_id_prestadores;
ALTER TABLE public.prestador_user VALIDATE CONSTRAINT fk_prestador_user_user_id_users;
ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_usuario_id_users;
ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_prestadores_classificacao_estabelecimento_id_pre;
ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_orgao_expedidor_uf_id_estados;
ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_naturalidade_cidade_id_cidades;
ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_prestador_tipo_id_prestador_tipos;
ALTER TABLE public.procedimento_subgrupos VALIDATE CONSTRAINT fk_procedimento_subgrupos_grupo_id_procedimentos_grupos;
ALTER TABLE public.procedimentos VALIDATE CONSTRAINT fk_procedimentos_procedimento_subgrupo_id_procedimento_subgrupo;
ALTER TABLE public.produtos VALIDATE CONSTRAINT fk_produtos_operadora_id_operadoras;
ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT fk_produtos_precos_produto_id_produtos;
ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT fk_produtos_precos_tipo_vinculo_id_tipo_vinculos;
ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT fk_produtos_precos_grupo_verba_id_grupo_verbas;
ALTER TABLE public.regra_cooparticipacao VALIDATE CONSTRAINT fk_regra_cooparticipacao_produto_id_produtos;
ALTER TABLE public.regra_cooparticipacao_itens VALIDATE CONSTRAINT fk_regra_cooparticipacao_itens_regra_cooparticipacao_id_regra_c;
ALTER TABLE public.regra_cooparticipacao_procedimentos VALIDATE CONSTRAINT fk_regra_cooparticipacao_procedimentos_regra_cooparticipacao_id;
ALTER TABLE public.regra_cooparticipacao_procedimentos VALIDATE CONSTRAINT fk_regra_cooparticipacao_procedimentos_grupo_procedimento_id_pr;
ALTER TABLE public.regra_cooparticipacao_procedimentos VALIDATE CONSTRAINT fk_regra_cooparticipacao_procedimentos_subgrupo_procedimento_id;
ALTER TABLE public.regra_cooparticipacao_procedimentos VALIDATE CONSTRAINT fk_regra_cooparticipacao_procedimentos_procedimento_id_procedim;
ALTER TABLE public.remessa_desconto VALIDATE CONSTRAINT fk_remessa_desconto_empresa_id_empresas;
ALTER TABLE public.remessa_desconto_item VALIDATE CONSTRAINT fk_remessa_desconto_item_remessa_desconto_id_remessa_desconto;
ALTER TABLE public.remessa_desconto_item VALIDATE CONSTRAINT fk_remessa_desconto_item_adesao_id_adesoes;
ALTER TABLE public.role_user VALIDATE CONSTRAINT fk_role_user_user_id_users;
ALTER TABLE public.role_user VALIDATE CONSTRAINT fk_role_user_role_id_roles;
ALTER TABLE public.secretarias VALIDATE CONSTRAINT fk_secretarias_empresa_id_empresas;
ALTER TABLE public.solicitacoes_atualizacao_cadastral VALIDATE CONSTRAINT fk_solicitacoes_atualizacao_cadastral_prestador_id_prestadores;
ALTER TABLE public.solicitacoes_atualizacao_cadastral VALIDATE CONSTRAINT fk_solicitacoes_atualizacao_cadastral_conveniado_id_conveniados;
ALTER TABLE public.solicitacoes_atualizacao_cadastral VALIDATE CONSTRAINT fk_solicitacoes_atualizacao_cadastral_cidade_id_cidades;
ALTER TABLE public.solicitacoes_credenciamento VALIDATE CONSTRAINT fk_solicitacoes_credenciamento_edital_credenciamento_id_editais;
ALTER TABLE public.solicitacoes_credenciamento_documentos VALIDATE CONSTRAINT fk_solicitacoes_credenciamento_documentos_solicitacoes_credenci;
ALTER TABLE public.solicitacoes_credenciamento_documentos VALIDATE CONSTRAINT fk_solicitacoes_credenciamento_documentos_documento_credenciame;
ALTER TABLE public.tabela_precos VALIDATE CONSTRAINT fk_tabela_precos_comunicado_edicao_id_comunicado_edicoes;
ALTER TABLE public.tabela_precos VALIDATE CONSTRAINT fk_tabela_precos_cbhpm_edicao_id_cbhpm_edicoes;
ALTER TABLE public.tabela_precos VALIDATE CONSTRAINT fk_tabela_precos_material_edicao_id_material_edicoes;
ALTER TABLE public.tabela_precos_itens VALIDATE CONSTRAINT fk_tabela_precos_itens_tabela_preco_id_tabela_precos;

-- ============================================================
-- 4) VALIDAÇÕES CHECK RECOMENDADAS
-- Aplicar somente após revisar dados legados.
-- ============================================================
ALTER TABLE public.boletos ADD CONSTRAINT ck_boletos_valor_original_nonnegative CHECK (valor_original >= 0) NOT VALID;
ALTER TABLE public.lancamentos ADD CONSTRAINT ck_lancamentos_valor_nonnegative CHECK (valor >= 0) NOT VALID;
ALTER TABLE public.mensalidades ADD CONSTRAINT ck_mensalidades_valor_nonnegative CHECK (valor >= 0) NOT VALID;
ALTER TABLE public.produtos_precos ADD CONSTRAINT ck_produtos_precos_valor_nonnegative CHECK (valor >= 0) NOT VALID;
ALTER TABLE public.conveniado_salarios ADD CONSTRAINT ck_conveniado_salarios_salario_nonnegative CHECK (salario >= 0) NOT VALID;
ALTER TABLE public.adesoes ADD CONSTRAINT ck_adesoes_tipo_cliente CHECK (tipo_cliente IN (1,2,3)) NOT VALID;
ALTER TABLE public.adesoes ADD CONSTRAINT ck_adesoes_status CHECK (status IN (1,2,3)) NOT VALID;
ALTER TABLE public.conveniados ADD CONSTRAINT ck_conveniados_sexo CHECK (sexo IN (1,2)) NOT VALID;
ALTER TABLE public.conveniados ADD CONSTRAINT ck_conveniados_estado_civil CHECK (estado_civil BETWEEN 1 AND 7) NOT VALID;
ALTER TABLE public.conveniados ADD CONSTRAINT ck_conveniados_pcd CHECK (pcd IN (1,2)) NOT VALID;
ALTER TABLE public.boletos ADD CONSTRAINT ck_boletos_status CHECK (status BETWEEN 1 AND 5) NOT VALID;
ALTER TABLE public.boletos ADD CONSTRAINT ck_boletos_pix CHECK (indicador_pix IN ('S','N')) NOT VALID;
ALTER TABLE public.boletos ADD CONSTRAINT ck_boletos_recebimento_parcial CHECK (indicador_permissao_recebimento_parcial IN ('S','N')) NOT VALID;
ALTER TABLE public.users ADD CONSTRAINT ck_users_email_format CHECK (email IS NULL OR email ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$') NOT VALID;
ALTER TABLE public.conveniados ADD CONSTRAINT ck_conveniados_email_format CHECK (email IS NULL OR email ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$') NOT VALID;
ALTER TABLE public.empresas ADD CONSTRAINT ck_empresas_email_format CHECK (email IS NULL OR email ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$') NOT VALID;

-- Depois de revisar os dados, valide:
ALTER TABLE public.boletos VALIDATE CONSTRAINT ck_boletos_valor_original_nonnegative;
ALTER TABLE public.lancamentos VALIDATE CONSTRAINT ck_lancamentos_valor_nonnegative;
ALTER TABLE public.mensalidades VALIDATE CONSTRAINT ck_mensalidades_valor_nonnegative;
ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT ck_produtos_precos_valor_nonnegative;
ALTER TABLE public.conveniado_salarios VALIDATE CONSTRAINT ck_conveniado_salarios_salario_nonnegative;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT ck_adesoes_tipo_cliente;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT ck_adesoes_status;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT ck_conveniados_sexo;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT ck_conveniados_estado_civil;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT ck_conveniados_pcd;
ALTER TABLE public.boletos VALIDATE CONSTRAINT ck_boletos_status;
ALTER TABLE public.boletos VALIDATE CONSTRAINT ck_boletos_pix;
ALTER TABLE public.boletos VALIDATE CONSTRAINT ck_boletos_recebimento_parcial;
ALTER TABLE public.users VALIDATE CONSTRAINT ck_users_email_format;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT ck_conveniados_email_format;
ALTER TABLE public.empresas VALIDATE CONSTRAINT ck_empresas_email_format;

-- ============================================================
-- 5) CONSTRAINTS ÚNICAS RECOMENDADAS
-- Cuidado: execute validação de duplicidade antes.
-- ============================================================
-- Verificar duplicidade antes de criar UNIQUE: public.users.email
SELECT email, COUNT(*) FROM public.users WHERE email IS NOT NULL GROUP BY email HAVING COUNT(*) > 1;
-- Verificar duplicidade antes de criar UNIQUE: public.users.cpf
SELECT cpf, COUNT(*) FROM public.users WHERE cpf IS NOT NULL GROUP BY cpf HAVING COUNT(*) > 1;
-- Verificar duplicidade antes de criar UNIQUE: public.conveniados.cpf
SELECT cpf, COUNT(*) FROM public.conveniados WHERE cpf IS NOT NULL GROUP BY cpf HAVING COUNT(*) > 1;
-- Verificar duplicidade antes de criar UNIQUE: public.empresas.cpf_cnpj
SELECT cpf_cnpj, COUNT(*) FROM public.empresas WHERE cpf_cnpj IS NOT NULL GROUP BY cpf_cnpj HAVING COUNT(*) > 1;
-- Verificar duplicidade antes de criar UNIQUE: public.operadoras.cpf_cnpj
SELECT cpf_cnpj, COUNT(*) FROM public.operadoras WHERE cpf_cnpj IS NOT NULL GROUP BY cpf_cnpj HAVING COUNT(*) > 1;
-- Verificar duplicidade antes de criar UNIQUE: public.prestadores.cpf_cnpj
SELECT cpf_cnpj, COUNT(*) FROM public.prestadores WHERE cpf_cnpj IS NOT NULL GROUP BY cpf_cnpj HAVING COUNT(*) > 1;
-- Verificar duplicidade antes de criar UNIQUE: public.roles.slug
SELECT slug, COUNT(*) FROM public.roles WHERE slug IS NOT NULL GROUP BY slug HAVING COUNT(*) > 1;
-- Verificar duplicidade antes de criar UNIQUE: public.permissions.slug
SELECT slug, COUNT(*) FROM public.permissions WHERE slug IS NOT NULL GROUP BY slug HAVING COUNT(*) > 1;
-- Verificar duplicidade antes de criar UNIQUE: public.bancos.codigo
SELECT codigo, COUNT(*) FROM public.bancos WHERE codigo IS NOT NULL GROUP BY codigo HAVING COUNT(*) > 1;
-- Verificar duplicidade antes de criar UNIQUE: public.cid.codigo
SELECT codigo, COUNT(*) FROM public.cid WHERE codigo IS NOT NULL GROUP BY codigo HAVING COUNT(*) > 1;

CREATE UNIQUE INDEX IF NOT EXISTS ux_users_email ON public.users (email) WHERE email IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_users_cpf ON public.users (cpf) WHERE cpf IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_conveniados_cpf ON public.conveniados (cpf) WHERE cpf IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_empresas_cpf_cnpj ON public.empresas (cpf_cnpj) WHERE cpf_cnpj IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_operadoras_cpf_cnpj ON public.operadoras (cpf_cnpj) WHERE cpf_cnpj IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_prestadores_cpf_cnpj ON public.prestadores (cpf_cnpj) WHERE cpf_cnpj IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_roles_slug ON public.roles (slug) WHERE slug IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_permissions_slug ON public.permissions (slug) WHERE slug IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_bancos_codigo ON public.bancos (codigo) WHERE codigo IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_cid_codigo ON public.cid (codigo) WHERE codigo IS NOT NULL;

-- ============================================================
-- SECAO: SCHEMA COMPLETO + FKs + VALIDACOES
-- Arquivo: servsaude_schema_completo_fks_validacoes.sql
-- ============================================================

-- ============================================================
-- ServSaúde — Schema completo corrigido + validações + FKs
-- Compatível com PostgreSQL / Supabase
-- Execute este arquivo em banco vazio ou controlado.
-- ============================================================

-- ============================================================
-- Schema corrigido — ServSaúde
-- Compatível com PostgreSQL / Supabase
-- Gerado a partir do SQL extraído do dump legado
-- ============================================================

CREATE SCHEMA IF NOT EXISTS public;
CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;

-- ============================================================
-- Tabela: public.adesao_reducao_margem
-- ============================================================
CREATE TABLE IF NOT EXISTS public.adesao_reducao_margem (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    adesao_id bigint NOT NULL,
    tipo_reducao integer NOT NULL,
    valor numeric(8,2) NOT NULL,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.adesoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.adesoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    operadora_id bigint NOT NULL,
    empresa_id bigint,
    secretaria_id bigint,
    conveniado_id bigint NOT NULL,
    grupo_familiar integer,
    produto_id bigint NOT NULL,
    produto_preco_id bigint,
    matricula character varying(255),
    tipo_cliente integer NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    data_inicio date NOT NULL,
    data_fim date,
    data_primeiro_pgto date,
    justificativa_encerramento character varying(255),
    dv character varying(255),
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    salario_atual numeric(13,2),
    motivo_encerramento_id integer
);

-- ============================================================
-- Tabela: public.bancos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.bancos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.boleto_lancamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.boleto_lancamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    boleto_id bigint NOT NULL,
    lancamento_id bigint NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.boletos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.boletos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    operadora_id bigint NOT NULL,
    data_emissao date NOT NULL,
    data_vencimento date NOT NULL,
    valor_original numeric(8,2) NOT NULL,
    nosso_numero integer NOT NULL,
    numero_titulo_cliente character varying(255),
    agencia character varying(255),
    conta character varying(255),
    endereco character varying(255),
    cidade character varying(255),
    uf character varying(255),
    indicador_permissao_recebimento_parcial character varying(255) DEFAULT 'N'::character varying NOT NULL,
    indicador_pix character varying(255) DEFAULT 'S'::character varying NOT NULL,
    pagador_tipo_inscricao character varying(255) NOT NULL,
    pagador_numero_inscricao character varying(255) NOT NULL,
    pagador_nome character varying(255) NOT NULL,
    pagador_endereco character varying(255) NOT NULL,
    pagador_cep character varying(255) NOT NULL,
    pagador_cidade_id bigint NOT NULL,
    pagador_bairro character varying(255) NOT NULL,
    demonstrativo text,
    desconto_tipo integer DEFAULT 0 NOT NULL,
    desconto_data_expiracao date,
    desconto_porcentagem numeric(8,2),
    desconto_valor numeric(8,2),
    multa_tipo integer DEFAULT 0 NOT NULL,
    multa_data date,
    multa_porcentagem numeric(8,2),
    multa_valor numeric(8,2),
    juros_tipo integer DEFAULT 0 NOT NULL,
    juros_porcentagem numeric(8,2),
    juros_valor numeric(8,2),
    pix_qrcode character varying(255),
    instrucoes1 character varying(255),
    instrucoes2 character varying(255),
    instrucoes3 character varying(255),
    instrucoes4 character varying(255),
    status integer DEFAULT 1 NOT NULL,
    codigo_estado_titulo integer DEFAULT 1 NOT NULL,
    error_message text,
    data_baixa date,
    boleto text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.canais_atendimento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.canais_atendimento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    telefone character varying(255),
    email character varying(255),
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.cargos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cargos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.cbhpm
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cbhpm (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    cbhpm_edicao_id bigint NOT NULL,
    procedimento_id bigint NOT NULL,
    codigo_porte character varying(255) NOT NULL,
    fracao_porte numeric(8,2) DEFAULT '1'::numeric,
    qtde_uco numeric(13,3) NOT NULL,
    qtde_filme numeric(13,3) NOT NULL,
    porte_anestesico_id bigint,
    nro_auxiliares integer,
    incidencia integer,
    ur boolean DEFAULT false NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.cbhpm_edicoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cbhpm_edicoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    ano_edicao integer NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.cid
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cid (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    sexo_aplicavel character varying(255) NOT NULL,
    grave boolean DEFAULT false NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.cidades
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cidades (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    estado_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.comunicado_edicoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.comunicado_edicoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    ano_edicao integer NOT NULL,
    uco numeric(8,2) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.comunicado_portes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.comunicado_portes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    comunicado_edicao_id bigint NOT NULL,
    codigo_porte character varying(255) NOT NULL,
    valor numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.contrato_profissionais
-- ============================================================
CREATE TABLE IF NOT EXISTS public.contrato_profissionais (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    contrato_id bigint NOT NULL,
    prestador_id bigint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.conveniado_salarios
-- ============================================================
CREATE TABLE IF NOT EXISTS public.conveniado_salarios (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    conveniado_id bigint NOT NULL,
    salario numeric(8,2) NOT NULL,
    data_competencia date NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.conveniados
-- ============================================================
CREATE TABLE IF NOT EXISTS public.conveniados (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    orgao_expedidor_uf_id bigint,
    naturalidade_cidade_id bigint NOT NULL,
    usuario_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date NOT NULL,
    sexo smallint NOT NULL,
    rg character varying(255),
    orgao_expedidor character varying(255),
    cns character varying(255),
    nome_pai character varying(255),
    nome_mae character varying(255) NOT NULL,
    fone1 character varying(255),
    fone2 character varying(255),
    email character varying(255),
    foto text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    estado_civil integer DEFAULT 1 NOT NULL,
    pcd integer DEFAULT 2 NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    cargo_id integer
);

-- ============================================================
-- Tabela: public.dados_bancarios
-- ============================================================
CREATE TABLE IF NOT EXISTS public.dados_bancarios (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    origem_id bigint NOT NULL,
    tabela character varying(255) NOT NULL,
    banco_id bigint NOT NULL,
    tipo smallint NOT NULL,
    agencia character varying(255),
    agencia_dv character varying(255),
    conta character varying(255),
    conta_dv character varying(255),
    operacao character varying(255),
    pix character varying(255),
    pix_tipo character varying(255),
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.deflatores
-- ============================================================
CREATE TABLE IF NOT EXISTS public.deflatores (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    prestadores_contratos_id bigint NOT NULL,
    procedimento_grupo_id bigint NOT NULL,
    tipo smallint NOT NULL,
    percentual numeric(8,2) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.documentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.documentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo integer NOT NULL,
    tabela text,
    origem_id integer,
    documento text,
    descricao text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.documentos_credenciamento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.documentos_credenciamento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    complemento_descricao character varying(255),
    obrigatorio boolean DEFAULT true NOT NULL,
    active boolean DEFAULT true NOT NULL,
    tipo_pessoa integer DEFAULT 1 NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.editais_credenciamento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.editais_credenciamento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.edital_credenciamento_documentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.edital_credenciamento_documentos (
    edital_id bigint NOT NULL,
    documento_credenciamento_id bigint NOT NULL,
    obrigatorio boolean DEFAULT false NOT NULL,
    updated_at timestamptz DEFAULT '2024-04-22 07:40:35'::timestamp without time zone NOT NULL,
    PRIMARY KEY (edital_id, documento_credenciamento_id)
);

-- ============================================================
-- Tabela: public.empresa_produto
-- ============================================================
CREATE TABLE IF NOT EXISTS public.empresa_produto (
    empresa_id bigint NOT NULL,
    produto_id bigint NOT NULL,
    PRIMARY KEY (empresa_id, produto_id)
);

-- ============================================================
-- Tabela: public.empresa_user
-- ============================================================
CREATE TABLE IF NOT EXISTS public.empresa_user (
    user_id bigint NOT NULL,
    empresa_id bigint NOT NULL,
    PRIMARY KEY (user_id, empresa_id)
);

-- ============================================================
-- Tabela: public.empresas
-- ============================================================
CREATE TABLE IF NOT EXISTS public.empresas (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo smallint NOT NULL,
    cpf_cnpj character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    abreviado text,
    fone character varying(255),
    email character varying(255),
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    contato character varying(255),
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.empresas_verbas
-- ============================================================
CREATE TABLE IF NOT EXISTS public.empresas_verbas (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    empresa_id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    grupo_verba_id bigint
);

-- ============================================================
-- Tabela: public.enderecos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.enderecos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    cidade_id bigint NOT NULL,
    tabela text,
    origem_id integer,
    tipo integer NOT NULL,
    cep text NOT NULL,
    endereco text NOT NULL,
    numero text,
    complemento text,
    bairro text,
    "default" boolean DEFAULT false NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.especialidades
-- ============================================================
CREATE TABLE IF NOT EXISTS public.especialidades (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    cbo character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.estados
-- ============================================================
CREATE TABLE IF NOT EXISTS public.estados (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    uf character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.failed_jobs
-- ============================================================
CREATE TABLE IF NOT EXISTS public.failed_jobs (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- ============================================================
-- Tabela: public.fiscal_contrato_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.fiscal_contrato_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    fiscal_contrato_id bigint NOT NULL,
    contrato_id bigint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.fiscal_contratos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.fiscal_contratos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    usuario_id bigint NOT NULL,
    data_inicio date DEFAULT CURRENT_DATE NOT NULL,
    data_fim date NOT NULL,
    portaria character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.gestantes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.gestantes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    conveniado_id bigint NOT NULL,
    data_inicio_gestacao date DEFAULT CURRENT_DATE NOT NULL,
    data_final_gestacao date,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.grau_parentesco
-- ============================================================
CREATE TABLE IF NOT EXISTS public.grau_parentesco (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.grupo_verbas
-- ============================================================
CREATE TABLE IF NOT EXISTS public.grupo_verbas (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guia_importacoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guia_importacoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    sequencial_transacao integer NOT NULL,
    lote integer NOT NULL,
    data_hora_arquivo timestamptz NOT NULL,
    prestador_id bigint,
    usuario_id bigint,
    versao_layout character varying(255) NOT NULL,
    arquivo character varying(255) NOT NULL,
    disco character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guia_motivo_encerramento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guia_motivo_encerramento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    termo character varying(255) NOT NULL,
    data_inicio_vigencia date,
    data_fim_vigencia date,
    data_fim_implantacao date,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guias
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    usuario_emissor_id bigint,
    prestador_id bigint,
    profissional_id bigint,
    conveniado_id bigint,
    solicitante_prestador_id bigint,
    lote_pagamento_id bigint,
    tipo_lancamento smallint DEFAULT '1'::smallint NOT NULL,
    tipo_autorizacao smallint DEFAULT '1'::smallint NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    carater_atendimento smallint DEFAULT '1'::smallint NOT NULL,
    guia_origem_id bigint,
    indicacao_clinica character varying(255),
    observacoes character varying(255),
    observacoes_internas character varying(255),
    urgente boolean DEFAULT false NOT NULL,
    conferido boolean DEFAULT false NOT NULL,
    status smallint DEFAULT '1'::smallint NOT NULL,
    data_hora_cancalamento timestamptz,
    cancelado_por_user_id bigint,
    motivo_cancelamento character varying(255),
    justifica_para_auditoria character varying(255),
    guia_importacao_id bigint,
    lote_importacao integer,
    numero_guia_prestador integer,
    data_autorizacao date,
    senha integer,
    data_validade_senha date,
    atendimento_rn character varying(255),
    cnes integer,
    tipo_faturamento integer,
    data_inicio_faturamento date,
    data_final_faturamento date,
    tipo_internacao integer,
    regime_internacao integer,
    diagnostico character varying(255),
    indicador_acidente integer,
    motivo_encerramento integer,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    tipo_autenticacao smallint,
    codigo_autenticacao character varying(255),
    autenticada boolean DEFAULT false NOT NULL
);

-- ============================================================
-- Tabela: public.guias_anexos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_anexos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    guia_id bigint,
    nome character varying(255),
    arquivo character varying(255),
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guias_atendimentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_atendimentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    guia_itens_id bigint,
    quantidade numeric(8,2),
    usuario_id bigint,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.guias_auditoria
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_auditoria (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora_analise timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    guia_itens_id bigint NOT NULL,
    quantidade_autorizada numeric(8,2) NOT NULL,
    justificativa character varying(255),
    analise_usuario_id bigint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guias_historico
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_historico (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    guia_id bigint NOT NULL,
    guia_item_id bigint,
    historico character varying(255) NOT NULL,
    usuario_id bigint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guias_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora_emissao timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    data_hora_autorizacao timestamptz,
    data_hora_atendimento timestamptz,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    guia_id bigint,
    referencia_tabela character varying(255) NOT NULL,
    referencia_id integer,
    quantidade_solicitada numeric(8,2),
    quantidade_atendida numeric(8,2),
    quantidade_glosa numeric(8,2),
    valor_unitario numeric(8,2),
    valor_unitario_glosa numeric(8,2),
    percentual_cooparticipacao numeric(8,2),
    valor_unitario_coparticipacao numeric(8,2),
    valor_total_coparticipacao numeric(8,2),
    percentual_item numeric(8,2),
    quantidade_faturada numeric(8,2),
    valor_unitario_faturado numeric(8,2),
    valor_total_faturado numeric(8,2),
    status smallint DEFAULT '1'::smallint NOT NULL,
    data_execucao date,
    hora_inicial time(0) without time zone,
    hora_final time(0) without time zone,
    codigo_tabela integer,
    codigo_despesa integer,
    codigo_procedimento character varying(255),
    quantidade_autorizada numeric(8,2),
    reducao_acrescimo numeric(8,2),
    valor_total numeric(8,2),
    grau_part integer,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.historico_credenciamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.historico_credenciamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    solicitacao_credencimento_id bigint NOT NULL,
    user_id bigint NOT NULL,
    motivo character varying(255) NOT NULL,
    status integer NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.laboratorios
-- ============================================================
CREATE TABLE IF NOT EXISTS public.laboratorios (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.lancamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.lancamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    boleto_id integer,
    operadora_id bigint NOT NULL,
    prestador_id bigint,
    conveniado_id bigint,
    tipo_lancamento smallint DEFAULT '2'::smallint NOT NULL,
    data_hora timestamptz DEFAULT '2024-01-19 13:56:01'::timestamp without time zone NOT NULL,
    data_vencimento timestamptz NOT NULL,
    data_baixa timestamptz,
    tipo_pagamento smallint DEFAULT '1'::smallint NOT NULL,
    competencia_folha character varying(255),
    descricao character varying(255),
    valor numeric(8,2) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    grupo_verba_id bigint
);

-- ============================================================
-- Tabela: public.lancamentos_guias
-- ============================================================
CREATE TABLE IF NOT EXISTS public.lancamentos_guias (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    lancamento_id bigint NOT NULL,
    guia_id bigint NOT NULL,
    valor numeric(8,2) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.log_acessos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.log_acessos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz,
    usuario_id integer,
    usuario_nome text,
    ip text,
    navegador text,
    recurso text,
    registro_id integer,
    url character varying(255),
    action smallint,
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.log_operacoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.log_operacoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz,
    usuario_id integer,
    usuario_nome text,
    ip text,
    navegador text,
    recurso text,
    registro_id integer,
    log text,
    action smallint,
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.lote_pagamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.lote_pagamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    prestador_id bigint NOT NULL,
    usuario_id bigint NOT NULL,
    lancamento_id bigint,
    data_hora timestamptz NOT NULL,
    referencia_pagamento date NOT NULL,
    status smallint DEFAULT '1'::smallint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.materiais
-- ============================================================
CREATE TABLE IF NOT EXISTS public.materiais (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo integer NOT NULL,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.materiais_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.materiais_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    material_edicao_id bigint NOT NULL,
    material_id bigint NOT NULL,
    valor numeric(8,2) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.material_edicoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.material_edicoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    edicao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.medicamento_brasindice
-- ============================================================
CREATE TABLE IF NOT EXISTS public.medicamento_brasindice (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    medicamento_edicao_id bigint NOT NULL,
    medicamento_id bigint NOT NULL,
    pmc numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    pfab numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    fracao_pfab numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    fracao_pmc numeric(15,2) DEFAULT '0'::numeric NOT NULL
);

-- ============================================================
-- Tabela: public.medicamento_edicoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.medicamento_edicoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    edicao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.medicamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.medicamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    laboratorio_id bigint NOT NULL,
    medicamento_edicao_id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    bras character varying(255) NOT NULL,
    in_ character varying(255) NOT NULL,
    dice character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    apresentacao character varying(255) NOT NULL,
    qtde_embalagem integer NOT NULL,
    ultima_versao integer NOT NULL,
    ean character varying(255) NOT NULL,
    ggrem character varying(255) NOT NULL,
    anvisa character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.mensagens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.mensagens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    perfil_id bigint,
    tipo integer NOT NULL,
    titulo character varying(255) NOT NULL,
    corpo text NOT NULL,
    idade_inicial integer,
    idade_final integer,
    data_inicial_exibicao date,
    data_final_exibicao date,
    visivel boolean DEFAULT true NOT NULL,
    fixado boolean DEFAULT false NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.mensalidades
-- ============================================================
CREATE TABLE IF NOT EXISTS public.mensalidades (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    conveniado_id bigint NOT NULL,
    competencia date NOT NULL,
    produto_preco_id bigint NOT NULL,
    grupo_verba_id bigint,
    salario numeric(8,2) NOT NULL,
    percentual numeric(8,2) NOT NULL,
    valor numeric(8,2) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.menus
-- ============================================================
CREATE TABLE IF NOT EXISTS public.menus (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(255) NOT NULL,
    is_divisor boolean DEFAULT false NOT NULL,
    parameter character varying(255),
    link character varying(255),
    permission character varying(255),
    fixed_id integer,
    parent_id integer,
    icon_family character varying(255),
    icon character varying(255),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.migrations
-- ============================================================
CREATE TABLE IF NOT EXISTS public.migrations (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);

-- ============================================================
-- Tabela: public.motivo_encerramentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.motivo_encerramentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    motivo character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    tipo smallint DEFAULT '1'::smallint NOT NULL
);

-- ============================================================
-- Tabela: public.operadora_user
-- ============================================================
CREATE TABLE IF NOT EXISTS public.operadora_user (
    operadora_id bigint NOT NULL,
    user_id bigint NOT NULL,
    PRIMARY KEY (operadora_id, user_id)
);

-- ============================================================
-- Tabela: public.operadoras
-- ============================================================
CREATE TABLE IF NOT EXISTS public.operadoras (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    tipo smallint NOT NULL,
    cpf_cnpj character varying(255) NOT NULL,
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    fone character varying(255),
    email character varying(255),
    certificado character varying(255),
    senha_certificado character varying(255),
    codigo_ans character varying(6),
    tipo_declarante integer NOT NULL,
    cpf_responsavel character varying(255) NOT NULL,
    indicador_situacao_declaracao character varying(255) NOT NULL,
    cnes character varying(7),
    ativo boolean DEFAULT true NOT NULL,
    percentual_max_desconto_coparticipacao numeric(8,2) DEFAULT 24.9 NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    boleto_nr_convenio integer,
    boleto_nr_carteira integer,
    boleto_nr_variacao_carteira integer,
    boleto_nr_controle integer,
    boleto_client_id character varying(255),
    boleto_client_secret text,
    boleto_gw_dev_app_key character varying(255),
    boleto_recebimento_parcial character varying(255) DEFAULT 'N'::character varying NOT NULL,
    boleto_indicador_pix character varying(255) DEFAULT 'S'::character varying NOT NULL,
    boleto_multa_tipo integer DEFAULT 0 NOT NULL,
    boleto_multa_dias_apos_vencimento integer DEFAULT 1,
    boleto_multa_porcentagem numeric(8,2),
    boleto_multa_valor numeric(8,2),
    boleto_juros_tipo integer DEFAULT 0 NOT NULL,
    boleto_juros_porcentagem numeric(8,2),
    boleto_juros_valor numeric(8,2),
    boleto_ambiente integer DEFAULT 1,
    boleto_cancelar_dias_apos_vencimento integer,
    boleto_forma_pagamento_apos_cancelar integer
);

-- ============================================================
-- Tabela: public.parametros
-- ============================================================
CREATE TABLE IF NOT EXISTS public.parametros (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    parameter character varying(255) NOT NULL,
    field_label character varying(255) NOT NULL,
    component text,
    value character varying(255),
    possible_values character varying(255),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.permission_role
-- ============================================================
CREATE TABLE IF NOT EXISTS public.permission_role (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL,
    PRIMARY KEY (permission_id, role_id)
);

-- ============================================================
-- Tabela: public.permissions
-- ============================================================
CREATE TABLE IF NOT EXISTS public.permissions (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    module character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    description character varying(255)
);

-- ============================================================
-- Tabela: public.personal_access_tokens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.personal_access_tokens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.porte_anestesicos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.porte_anestesicos (
    porte_anestesico character varying(255) DEFAULT '0'::character varying NOT NULL,
    porte character varying(255),
    PRIMARY KEY (porte_anestesico)
);

-- ============================================================
-- Tabela: public.prestador_contrato_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_contrato_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    prestadores_contratos_id bigint NOT NULL,
    edicao_medicamento_id bigint NOT NULL,
    acrescimo_medicamentos numeric(8,2),
    tabela_precos_id bigint,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    tipo smallint NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    orcamento_previsto numeric(8,2),
    motivo_encerramento_id bigint,
    data_encerramento timestamptz
);

-- ============================================================
-- Tabela: public.prestador_contratos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_contratos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    prestador_id bigint NOT NULL,
    data date NOT NULL,
    codigo character varying(255) NOT NULL,
    ocorrencia character varying(255),
    objeto character varying(255) NOT NULL,
    observacoes character varying(255),
    reclamacoes character varying(255),
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.prestador_especialidades
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_especialidades (
    prestador_id bigint NOT NULL,
    especialidade_id bigint NOT NULL,
    PRIMARY KEY (prestador_id, especialidade_id)
);

-- ============================================================
-- Tabela: public.prestador_tipos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_tipos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.prestador_user
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_user (
    prestador_id bigint NOT NULL,
    user_id bigint NOT NULL,
    PRIMARY KEY (prestador_id, user_id)
);

-- ============================================================
-- Tabela: public.prestadores
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestadores (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    usuario_id bigint,
    prestadores_classificacao_estabelecimento_id bigint NOT NULL,
    orgao_expedidor_uf_id bigint,
    naturalidade_cidade_id bigint,
    tipo smallint NOT NULL,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    abreviado text,
    cpf_cnpj character varying(255) NOT NULL,
    data_nascimento date,
    rg character varying(255),
    orgao_expedidor character varying(255),
    nome_mae character varying(255),
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    fone character varying(255),
    email character varying(255),
    financeiro_contato_nome character varying(255),
    financeiro_contato_fone character varying(255),
    financeiro_contato_email character varying(255),
    faturamento_contato_nome character varying(255),
    faturamento_contato_fone character varying(255),
    faturamento_contato_email character varying(255),
    tipo_conselho_classe smallint,
    numero_conselho_classe character varying(255),
    procedimentos boolean DEFAULT false NOT NULL,
    material boolean DEFAULT false NOT NULL,
    taxa boolean DEFAULT false NOT NULL,
    medicamentos boolean DEFAULT false NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    prestador_tipo_id integer
);

-- ============================================================
-- Tabela: public.prestadores_classificacao_estabelecimento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestadores_classificacao_estabelecimento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    codigo character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.procedimento_subgrupos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.procedimento_subgrupos (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    grupo_id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    perc_reducao_segundo_procedimento numeric(8,2) NOT NULL,
    perc_reducao_terceiro_procedimento_em_diante numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.procedimentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.procedimentos (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo text NOT NULL,
    procedimento_subgrupo_id integer,
    descricao text,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.procedimentos_grupos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.procedimentos_grupos (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.produtos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.produtos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    operadora_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    abrangencia smallint NOT NULL,
    tipo_contratacao integer NOT NULL,
    tipo_carencia smallint NOT NULL,
    tipo_acomodacao integer NOT NULL,
    data_inicio date NOT NULL,
    data_fim date,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.produtos_precos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.produtos_precos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    produto_id bigint NOT NULL,
    tipo_vinculo_id bigint,
    idade_inicial integer NOT NULL,
    idade_final integer NOT NULL,
    tipo_cobranca integer NOT NULL,
    tipo_cliente integer NOT NULL,
    descricao character varying(255) NOT NULL,
    valor numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    grupo_verba_id bigint
);

-- ============================================================
-- Tabela: public.regra_cooparticipacao
-- ============================================================
CREATE TABLE IF NOT EXISTS public.regra_cooparticipacao (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    produto_id bigint NOT NULL,
    nome text NOT NULL,
    tempo_carencia integer,
    carencia boolean NOT NULL,
    sem_limite_para_gestante boolean DEFAULT false NOT NULL,
    auditoria boolean NOT NULL,
    ativo boolean NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.regra_cooparticipacao_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.regra_cooparticipacao_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    regra_cooparticipacao_id bigint NOT NULL,
    qtde_inicial integer NOT NULL,
    qtde_final integer NOT NULL,
    percentual_cooparticipacao numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.regra_cooparticipacao_procedimentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.regra_cooparticipacao_procedimentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    regra_cooparticipacao_id bigint NOT NULL,
    grupo_procedimento_id integer NOT NULL,
    subgrupo_procedimento_id integer,
    procedimento_id integer,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.remessa_desconto
-- ============================================================
CREATE TABLE IF NOT EXISTS public.remessa_desconto (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    empresa_id bigint NOT NULL,
    competencia date NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.remessa_desconto_item
-- ============================================================
CREATE TABLE IF NOT EXISTS public.remessa_desconto_item (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    remessa_desconto_id bigint NOT NULL,
    adesao_id bigint NOT NULL,
    matricula character varying(255) NOT NULL,
    salario numeric(8,2) NOT NULL,
    desconto_maximo numeric(8,2) NOT NULL,
    valor_divida numeric(8,2) NOT NULL,
    coparticipacao numeric(8,2) NOT NULL,
    codigo_evento character varying(255) NOT NULL,
    valor numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.role_user
-- ============================================================
CREATE TABLE IF NOT EXISTS public.role_user (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL,
    PRIMARY KEY (user_id, role_id)
);

-- ============================================================
-- Tabela: public.roles
-- ============================================================
CREATE TABLE IF NOT EXISTS public.roles (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.secretarias
-- ============================================================
CREATE TABLE IF NOT EXISTS public.secretarias (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    empresa_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    cpf_cnpj character varying(255),
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    fone character varying(255),
    email character varying(255),
    contato character varying(255),
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    abreviado character varying(255)
);

-- ============================================================
-- Tabela: public.solicitacoes_atualizacao_cadastral
-- ============================================================
CREATE TABLE IF NOT EXISTS public.solicitacoes_atualizacao_cadastral (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_solicitacao date DEFAULT CURRENT_DATE NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    prestador_id bigint,
    conveniado_id bigint,
    cidade_id bigint NOT NULL,
    endereco character varying(255),
    endereco_nro character varying(255),
    complemento character varying(255),
    bairro character varying(255),
    cep character varying(255),
    email character varying(255),
    telefone character varying(255),
    celular character varying(255),
    observacoes character varying(255),
    comprovante_endereco character varying(255),
    foto character varying(255),
    disk character varying(255),
    status smallint DEFAULT '1'::smallint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.solicitacoes_credenciamento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.solicitacoes_credenciamento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    edital_credenciamento_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    tipo integer DEFAULT 1 NOT NULL,
    cpf_cnpj character varying(255) NOT NULL,
    responsavel character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.solicitacoes_credenciamento_documentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.solicitacoes_credenciamento_documentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    solicitacoes_credenciamento_id bigint NOT NULL,
    documento_credenciamento_id bigint NOT NULL,
    arquivo text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    nome_arquivo character varying(255)
);

-- ============================================================
-- Tabela: public.tabela_precos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.tabela_precos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    comunicado_edicao_id bigint NOT NULL,
    cbhpm_edicao_id bigint NOT NULL,
    material_edicao_id bigint NOT NULL,
    valor_uco numeric(8,2) NOT NULL,
    valor_filme numeric(8,2) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.tabela_precos_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.tabela_precos_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tabela_preco_id bigint NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    referencia_id integer NOT NULL,
    valor_porte numeric(8,2) NOT NULL,
    fracao_porte numeric(8,2) NOT NULL,
    qtde_uco numeric(8,2) NOT NULL,
    valor_uco numeric(8,2) NOT NULL,
    qtde_filme numeric(8,2) NOT NULL,
    valor_filme numeric(8,2) NOT NULL,
    valor_total numeric(8,2) NOT NULL,
    valor_customizado numeric(8,2),
    valor_final numeric(8,2) NOT NULL,
    preco_customizado boolean DEFAULT false NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.taxas
-- ============================================================
CREATE TABLE IF NOT EXISTS public.taxas (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    descricao character varying(255),
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.tipo_vinculos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.tipo_vinculos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    descricao text NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.users
-- ============================================================
CREATE TABLE IF NOT EXISTS public.users (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(255) NOT NULL,
    email text,
    password character varying(255) NOT NULL,
    fone character varying(255),
    cpf character varying(255),
    forget_token text,
    foto text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    active boolean DEFAULT true NOT NULL,
    colaborador boolean DEFAULT false NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Índices auxiliares recomendados
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_adesao_reducao_margem_adesao_id ON public.adesao_reducao_margem (adesao_id);
CREATE INDEX IF NOT EXISTS idx_adesao_reducao_margem_deleted_at ON public.adesao_reducao_margem (deleted_at);
CREATE INDEX IF NOT EXISTS idx_adesao_reducao_margem_created_at ON public.adesao_reducao_margem (created_at);
CREATE INDEX IF NOT EXISTS idx_adesoes_operadora_id ON public.adesoes (operadora_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_empresa_id ON public.adesoes (empresa_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_secretaria_id ON public.adesoes (secretaria_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_conveniado_id ON public.adesoes (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_produto_id ON public.adesoes (produto_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_produto_preco_id ON public.adesoes (produto_preco_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_status ON public.adesoes (status);
CREATE INDEX IF NOT EXISTS idx_adesoes_deleted_at ON public.adesoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_adesoes_created_at ON public.adesoes (created_at);
CREATE INDEX IF NOT EXISTS idx_adesoes_motivo_encerramento_id ON public.adesoes (motivo_encerramento_id);
CREATE INDEX IF NOT EXISTS idx_bancos_ativo ON public.bancos (ativo);
CREATE INDEX IF NOT EXISTS idx_bancos_created_at ON public.bancos (created_at);
CREATE INDEX IF NOT EXISTS idx_bancos_deleted_at ON public.bancos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_boleto_lancamentos_boleto_id ON public.boleto_lancamentos (boleto_id);
CREATE INDEX IF NOT EXISTS idx_boleto_lancamentos_lancamento_id ON public.boleto_lancamentos (lancamento_id);
CREATE INDEX IF NOT EXISTS idx_boleto_lancamentos_created_at ON public.boleto_lancamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_boletos_operadora_id ON public.boletos (operadora_id);
CREATE INDEX IF NOT EXISTS idx_boletos_pagador_cidade_id ON public.boletos (pagador_cidade_id);
CREATE INDEX IF NOT EXISTS idx_boletos_status ON public.boletos (status);
CREATE INDEX IF NOT EXISTS idx_boletos_deleted_at ON public.boletos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_boletos_created_at ON public.boletos (created_at);
CREATE INDEX IF NOT EXISTS idx_canais_atendimento_email ON public.canais_atendimento (email);
CREATE INDEX IF NOT EXISTS idx_canais_atendimento_deleted_at ON public.canais_atendimento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_canais_atendimento_created_at ON public.canais_atendimento (created_at);
CREATE INDEX IF NOT EXISTS idx_cargos_ativo ON public.cargos (ativo);
CREATE INDEX IF NOT EXISTS idx_cargos_deleted_at ON public.cargos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_cargos_created_at ON public.cargos (created_at);
CREATE INDEX IF NOT EXISTS idx_cbhpm_cbhpm_edicao_id ON public.cbhpm (cbhpm_edicao_id);
CREATE INDEX IF NOT EXISTS idx_cbhpm_procedimento_id ON public.cbhpm (procedimento_id);
CREATE INDEX IF NOT EXISTS idx_cbhpm_porte_anestesico_id ON public.cbhpm (porte_anestesico_id);
CREATE INDEX IF NOT EXISTS idx_cbhpm_deleted_at ON public.cbhpm (deleted_at);
CREATE INDEX IF NOT EXISTS idx_cbhpm_created_at ON public.cbhpm (created_at);
CREATE INDEX IF NOT EXISTS idx_cbhpm_edicoes_ativo ON public.cbhpm_edicoes (ativo);
CREATE INDEX IF NOT EXISTS idx_cbhpm_edicoes_created_at ON public.cbhpm_edicoes (created_at);
CREATE INDEX IF NOT EXISTS idx_cbhpm_edicoes_deleted_at ON public.cbhpm_edicoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_cid_created_at ON public.cid (created_at);
CREATE INDEX IF NOT EXISTS idx_cidades_estado_id ON public.cidades (estado_id);
CREATE INDEX IF NOT EXISTS idx_cidades_created_at ON public.cidades (created_at);
CREATE INDEX IF NOT EXISTS idx_cidades_deleted_at ON public.cidades (deleted_at);
CREATE INDEX IF NOT EXISTS idx_comunicado_edicoes_ativo ON public.comunicado_edicoes (ativo);
CREATE INDEX IF NOT EXISTS idx_comunicado_edicoes_created_at ON public.comunicado_edicoes (created_at);
CREATE INDEX IF NOT EXISTS idx_comunicado_edicoes_deleted_at ON public.comunicado_edicoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_comunicado_portes_comunicado_edicao_id ON public.comunicado_portes (comunicado_edicao_id);
CREATE INDEX IF NOT EXISTS idx_comunicado_portes_created_at ON public.comunicado_portes (created_at);
CREATE INDEX IF NOT EXISTS idx_comunicado_portes_deleted_at ON public.comunicado_portes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_contrato_profissionais_contrato_id ON public.contrato_profissionais (contrato_id);
CREATE INDEX IF NOT EXISTS idx_contrato_profissionais_prestador_id ON public.contrato_profissionais (prestador_id);
CREATE INDEX IF NOT EXISTS idx_contrato_profissionais_deleted_at ON public.contrato_profissionais (deleted_at);
CREATE INDEX IF NOT EXISTS idx_contrato_profissionais_created_at ON public.contrato_profissionais (created_at);
CREATE INDEX IF NOT EXISTS idx_conveniado_salarios_conveniado_id ON public.conveniado_salarios (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_conveniado_salarios_created_at ON public.conveniado_salarios (created_at);
CREATE INDEX IF NOT EXISTS idx_conveniado_salarios_deleted_at ON public.conveniado_salarios (deleted_at);
CREATE INDEX IF NOT EXISTS idx_conveniados_orgao_expedidor_uf_id ON public.conveniados (orgao_expedidor_uf_id);
CREATE INDEX IF NOT EXISTS idx_conveniados_naturalidade_cidade_id ON public.conveniados (naturalidade_cidade_id);
CREATE INDEX IF NOT EXISTS idx_conveniados_usuario_id ON public.conveniados (usuario_id);
CREATE INDEX IF NOT EXISTS idx_conveniados_cpf ON public.conveniados (cpf);
CREATE INDEX IF NOT EXISTS idx_conveniados_email ON public.conveniados (email);
CREATE INDEX IF NOT EXISTS idx_conveniados_ativo ON public.conveniados (ativo);
CREATE INDEX IF NOT EXISTS idx_conveniados_created_at ON public.conveniados (created_at);
CREATE INDEX IF NOT EXISTS idx_conveniados_deleted_at ON public.conveniados (deleted_at);
CREATE INDEX IF NOT EXISTS idx_conveniados_cargo_id ON public.conveniados (cargo_id);
CREATE INDEX IF NOT EXISTS idx_dados_bancarios_origem_id ON public.dados_bancarios (origem_id);
CREATE INDEX IF NOT EXISTS idx_dados_bancarios_banco_id ON public.dados_bancarios (banco_id);
CREATE INDEX IF NOT EXISTS idx_dados_bancarios_created_at ON public.dados_bancarios (created_at);
CREATE INDEX IF NOT EXISTS idx_dados_bancarios_deleted_at ON public.dados_bancarios (deleted_at);
CREATE INDEX IF NOT EXISTS idx_deflatores_prestadores_contratos_id ON public.deflatores (prestadores_contratos_id);
CREATE INDEX IF NOT EXISTS idx_deflatores_procedimento_grupo_id ON public.deflatores (procedimento_grupo_id);
CREATE INDEX IF NOT EXISTS idx_deflatores_deleted_at ON public.deflatores (deleted_at);
CREATE INDEX IF NOT EXISTS idx_deflatores_created_at ON public.deflatores (created_at);
CREATE INDEX IF NOT EXISTS idx_documentos_origem_id ON public.documentos (origem_id);
CREATE INDEX IF NOT EXISTS idx_documentos_deleted_at ON public.documentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_documentos_created_at ON public.documentos (created_at);
CREATE INDEX IF NOT EXISTS idx_documentos_credenciamento_active ON public.documentos_credenciamento (active);
CREATE INDEX IF NOT EXISTS idx_documentos_credenciamento_deleted_at ON public.documentos_credenciamento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_documentos_credenciamento_created_at ON public.documentos_credenciamento (created_at);
CREATE INDEX IF NOT EXISTS idx_editais_credenciamento_ativo ON public.editais_credenciamento (ativo);
CREATE INDEX IF NOT EXISTS idx_editais_credenciamento_deleted_at ON public.editais_credenciamento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_editais_credenciamento_created_at ON public.editais_credenciamento (created_at);
CREATE INDEX IF NOT EXISTS idx_edital_credenciamento_documentos_edital_id ON public.edital_credenciamento_documentos (edital_id);
CREATE INDEX IF NOT EXISTS idx_edital_credenciamento_documentos_documento_credenciamento_id ON public.edital_credenciamento_documentos (documento_credenciamento_id);
CREATE INDEX IF NOT EXISTS idx_empresa_produto_empresa_id ON public.empresa_produto (empresa_id);
CREATE INDEX IF NOT EXISTS idx_empresa_produto_produto_id ON public.empresa_produto (produto_id);
CREATE INDEX IF NOT EXISTS idx_empresa_user_user_id ON public.empresa_user (user_id);
CREATE INDEX IF NOT EXISTS idx_empresa_user_empresa_id ON public.empresa_user (empresa_id);
CREATE INDEX IF NOT EXISTS idx_empresas_cpf_cnpj ON public.empresas (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_empresas_email ON public.empresas (email);
CREATE INDEX IF NOT EXISTS idx_empresas_ativo ON public.empresas (ativo);
CREATE INDEX IF NOT EXISTS idx_empresas_created_at ON public.empresas (created_at);
CREATE INDEX IF NOT EXISTS idx_empresas_deleted_at ON public.empresas (deleted_at);
CREATE INDEX IF NOT EXISTS idx_empresas_verbas_empresa_id ON public.empresas_verbas (empresa_id);
CREATE INDEX IF NOT EXISTS idx_empresas_verbas_created_at ON public.empresas_verbas (created_at);
CREATE INDEX IF NOT EXISTS idx_empresas_verbas_deleted_at ON public.empresas_verbas (deleted_at);
CREATE INDEX IF NOT EXISTS idx_empresas_verbas_grupo_verba_id ON public.empresas_verbas (grupo_verba_id);
CREATE INDEX IF NOT EXISTS idx_enderecos_cidade_id ON public.enderecos (cidade_id);
CREATE INDEX IF NOT EXISTS idx_enderecos_origem_id ON public.enderecos (origem_id);
CREATE INDEX IF NOT EXISTS idx_enderecos_ativo ON public.enderecos (ativo);
CREATE INDEX IF NOT EXISTS idx_enderecos_created_at ON public.enderecos (created_at);
CREATE INDEX IF NOT EXISTS idx_enderecos_deleted_at ON public.enderecos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_especialidades_ativo ON public.especialidades (ativo);
CREATE INDEX IF NOT EXISTS idx_especialidades_created_at ON public.especialidades (created_at);
CREATE INDEX IF NOT EXISTS idx_especialidades_deleted_at ON public.especialidades (deleted_at);
CREATE INDEX IF NOT EXISTS idx_estados_ativo ON public.estados (ativo);
CREATE INDEX IF NOT EXISTS idx_estados_created_at ON public.estados (created_at);
CREATE INDEX IF NOT EXISTS idx_estados_deleted_at ON public.estados (deleted_at);
CREATE INDEX IF NOT EXISTS idx_fiscal_contrato_itens_fiscal_contrato_id ON public.fiscal_contrato_itens (fiscal_contrato_id);
CREATE INDEX IF NOT EXISTS idx_fiscal_contrato_itens_contrato_id ON public.fiscal_contrato_itens (contrato_id);
CREATE INDEX IF NOT EXISTS idx_fiscal_contrato_itens_deleted_at ON public.fiscal_contrato_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_fiscal_contrato_itens_created_at ON public.fiscal_contrato_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_fiscal_contratos_usuario_id ON public.fiscal_contratos (usuario_id);
CREATE INDEX IF NOT EXISTS idx_fiscal_contratos_ativo ON public.fiscal_contratos (ativo);
CREATE INDEX IF NOT EXISTS idx_fiscal_contratos_deleted_at ON public.fiscal_contratos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_fiscal_contratos_created_at ON public.fiscal_contratos (created_at);
CREATE INDEX IF NOT EXISTS idx_gestantes_conveniado_id ON public.gestantes (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_gestantes_created_at ON public.gestantes (created_at);
CREATE INDEX IF NOT EXISTS idx_gestantes_deleted_at ON public.gestantes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_grau_parentesco_ativo ON public.grau_parentesco (ativo);
CREATE INDEX IF NOT EXISTS idx_grau_parentesco_created_at ON public.grau_parentesco (created_at);
CREATE INDEX IF NOT EXISTS idx_grau_parentesco_deleted_at ON public.grau_parentesco (deleted_at);
CREATE INDEX IF NOT EXISTS idx_grupo_verbas_deleted_at ON public.grupo_verbas (deleted_at);
CREATE INDEX IF NOT EXISTS idx_grupo_verbas_created_at ON public.grupo_verbas (created_at);
CREATE INDEX IF NOT EXISTS idx_guia_importacoes_prestador_id ON public.guia_importacoes (prestador_id);
CREATE INDEX IF NOT EXISTS idx_guia_importacoes_usuario_id ON public.guia_importacoes (usuario_id);
CREATE INDEX IF NOT EXISTS idx_guia_importacoes_deleted_at ON public.guia_importacoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guia_importacoes_created_at ON public.guia_importacoes (created_at);
CREATE INDEX IF NOT EXISTS idx_guia_motivo_encerramento_deleted_at ON public.guia_motivo_encerramento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guia_motivo_encerramento_created_at ON public.guia_motivo_encerramento (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_usuario_emissor_id ON public.guias (usuario_emissor_id);
CREATE INDEX IF NOT EXISTS idx_guias_prestador_id ON public.guias (prestador_id);
CREATE INDEX IF NOT EXISTS idx_guias_profissional_id ON public.guias (profissional_id);
CREATE INDEX IF NOT EXISTS idx_guias_conveniado_id ON public.guias (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_guias_solicitante_prestador_id ON public.guias (solicitante_prestador_id);
CREATE INDEX IF NOT EXISTS idx_guias_lote_pagamento_id ON public.guias (lote_pagamento_id);
CREATE INDEX IF NOT EXISTS idx_guias_guia_origem_id ON public.guias (guia_origem_id);
CREATE INDEX IF NOT EXISTS idx_guias_status ON public.guias (status);
CREATE INDEX IF NOT EXISTS idx_guias_cancelado_por_user_id ON public.guias (cancelado_por_user_id);
CREATE INDEX IF NOT EXISTS idx_guias_guia_importacao_id ON public.guias (guia_importacao_id);
CREATE INDEX IF NOT EXISTS idx_guias_deleted_at ON public.guias (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_created_at ON public.guias (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_anexos_guia_id ON public.guias_anexos (guia_id);
CREATE INDEX IF NOT EXISTS idx_guias_anexos_deleted_at ON public.guias_anexos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_anexos_created_at ON public.guias_anexos (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_atendimentos_guia_itens_id ON public.guias_atendimentos (guia_itens_id);
CREATE INDEX IF NOT EXISTS idx_guias_atendimentos_usuario_id ON public.guias_atendimentos (usuario_id);
CREATE INDEX IF NOT EXISTS idx_guias_atendimentos_created_at ON public.guias_atendimentos (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_atendimentos_deleted_at ON public.guias_atendimentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_auditoria_guia_itens_id ON public.guias_auditoria (guia_itens_id);
CREATE INDEX IF NOT EXISTS idx_guias_auditoria_analise_usuario_id ON public.guias_auditoria (analise_usuario_id);
CREATE INDEX IF NOT EXISTS idx_guias_auditoria_deleted_at ON public.guias_auditoria (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_auditoria_created_at ON public.guias_auditoria (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_historico_guia_id ON public.guias_historico (guia_id);
CREATE INDEX IF NOT EXISTS idx_guias_historico_guia_item_id ON public.guias_historico (guia_item_id);
CREATE INDEX IF NOT EXISTS idx_guias_historico_usuario_id ON public.guias_historico (usuario_id);
CREATE INDEX IF NOT EXISTS idx_guias_historico_deleted_at ON public.guias_historico (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_historico_created_at ON public.guias_historico (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_itens_guia_id ON public.guias_itens (guia_id);
CREATE INDEX IF NOT EXISTS idx_guias_itens_referencia_id ON public.guias_itens (referencia_id);
CREATE INDEX IF NOT EXISTS idx_guias_itens_status ON public.guias_itens (status);
CREATE INDEX IF NOT EXISTS idx_guias_itens_deleted_at ON public.guias_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_itens_created_at ON public.guias_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_historico_credenciamentos_solicitacao_credencimento_id ON public.historico_credenciamentos (solicitacao_credencimento_id);
CREATE INDEX IF NOT EXISTS idx_historico_credenciamentos_user_id ON public.historico_credenciamentos (user_id);
CREATE INDEX IF NOT EXISTS idx_historico_credenciamentos_status ON public.historico_credenciamentos (status);
CREATE INDEX IF NOT EXISTS idx_historico_credenciamentos_created_at ON public.historico_credenciamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_laboratorios_created_at ON public.laboratorios (created_at);
CREATE INDEX IF NOT EXISTS idx_laboratorios_deleted_at ON public.laboratorios (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lancamentos_boleto_id ON public.lancamentos (boleto_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_operadora_id ON public.lancamentos (operadora_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_prestador_id ON public.lancamentos (prestador_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_conveniado_id ON public.lancamentos (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_active ON public.lancamentos (active);
CREATE INDEX IF NOT EXISTS idx_lancamentos_deleted_at ON public.lancamentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lancamentos_created_at ON public.lancamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_lancamentos_grupo_verba_id ON public.lancamentos (grupo_verba_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_guias_lancamento_id ON public.lancamentos_guias (lancamento_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_guias_guia_id ON public.lancamentos_guias (guia_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_guias_deleted_at ON public.lancamentos_guias (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lancamentos_guias_created_at ON public.lancamentos_guias (created_at);
CREATE INDEX IF NOT EXISTS idx_log_acessos_usuario_id ON public.log_acessos (usuario_id);
CREATE INDEX IF NOT EXISTS idx_log_acessos_registro_id ON public.log_acessos (registro_id);
CREATE INDEX IF NOT EXISTS idx_log_acessos_deleted_at ON public.log_acessos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_log_operacoes_usuario_id ON public.log_operacoes (usuario_id);
CREATE INDEX IF NOT EXISTS idx_log_operacoes_registro_id ON public.log_operacoes (registro_id);
CREATE INDEX IF NOT EXISTS idx_log_operacoes_deleted_at ON public.log_operacoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_prestador_id ON public.lote_pagamentos (prestador_id);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_usuario_id ON public.lote_pagamentos (usuario_id);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_lancamento_id ON public.lote_pagamentos (lancamento_id);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_status ON public.lote_pagamentos (status);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_deleted_at ON public.lote_pagamentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_created_at ON public.lote_pagamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_materiais_deleted_at ON public.materiais (deleted_at);
CREATE INDEX IF NOT EXISTS idx_materiais_created_at ON public.materiais (created_at);
CREATE INDEX IF NOT EXISTS idx_materiais_itens_material_edicao_id ON public.materiais_itens (material_edicao_id);
CREATE INDEX IF NOT EXISTS idx_materiais_itens_material_id ON public.materiais_itens (material_id);
CREATE INDEX IF NOT EXISTS idx_materiais_itens_deleted_at ON public.materiais_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_materiais_itens_created_at ON public.materiais_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_material_edicoes_ativo ON public.material_edicoes (ativo);
CREATE INDEX IF NOT EXISTS idx_material_edicoes_deleted_at ON public.material_edicoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_material_edicoes_created_at ON public.material_edicoes (created_at);
CREATE INDEX IF NOT EXISTS idx_medicamento_brasindice_medicamento_edicao_id ON public.medicamento_brasindice (medicamento_edicao_id);
CREATE INDEX IF NOT EXISTS idx_medicamento_brasindice_medicamento_id ON public.medicamento_brasindice (medicamento_id);
CREATE INDEX IF NOT EXISTS idx_medicamento_brasindice_ativo ON public.medicamento_brasindice (ativo);
CREATE INDEX IF NOT EXISTS idx_medicamento_brasindice_created_at ON public.medicamento_brasindice (created_at);
CREATE INDEX IF NOT EXISTS idx_medicamento_edicoes_ativo ON public.medicamento_edicoes (ativo);
CREATE INDEX IF NOT EXISTS idx_medicamento_edicoes_deleted_at ON public.medicamento_edicoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_medicamento_edicoes_created_at ON public.medicamento_edicoes (created_at);
CREATE INDEX IF NOT EXISTS idx_medicamentos_laboratorio_id ON public.medicamentos (laboratorio_id);
CREATE INDEX IF NOT EXISTS idx_medicamentos_medicamento_edicao_id ON public.medicamentos (medicamento_edicao_id);
CREATE INDEX IF NOT EXISTS idx_medicamentos_deleted_at ON public.medicamentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_medicamentos_created_at ON public.medicamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_mensagens_perfil_id ON public.mensagens (perfil_id);
CREATE INDEX IF NOT EXISTS idx_mensagens_deleted_at ON public.mensagens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_mensagens_created_at ON public.mensagens (created_at);
CREATE INDEX IF NOT EXISTS idx_mensalidades_conveniado_id ON public.mensalidades (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_mensalidades_produto_preco_id ON public.mensalidades (produto_preco_id);
CREATE INDEX IF NOT EXISTS idx_mensalidades_grupo_verba_id ON public.mensalidades (grupo_verba_id);
CREATE INDEX IF NOT EXISTS idx_mensalidades_deleted_at ON public.mensalidades (deleted_at);
CREATE INDEX IF NOT EXISTS idx_mensalidades_created_at ON public.mensalidades (created_at);
CREATE INDEX IF NOT EXISTS idx_menus_fixed_id ON public.menus (fixed_id);
CREATE INDEX IF NOT EXISTS idx_menus_parent_id ON public.menus (parent_id);
CREATE INDEX IF NOT EXISTS idx_menus_deleted_at ON public.menus (deleted_at);
CREATE INDEX IF NOT EXISTS idx_motivo_encerramentos_ativo ON public.motivo_encerramentos (ativo);
CREATE INDEX IF NOT EXISTS idx_motivo_encerramentos_deleted_at ON public.motivo_encerramentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_motivo_encerramentos_created_at ON public.motivo_encerramentos (created_at);
CREATE INDEX IF NOT EXISTS idx_operadora_user_operadora_id ON public.operadora_user (operadora_id);
CREATE INDEX IF NOT EXISTS idx_operadora_user_user_id ON public.operadora_user (user_id);
CREATE INDEX IF NOT EXISTS idx_operadoras_cpf_cnpj ON public.operadoras (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_operadoras_email ON public.operadoras (email);
CREATE INDEX IF NOT EXISTS idx_operadoras_ativo ON public.operadoras (ativo);
CREATE INDEX IF NOT EXISTS idx_operadoras_created_at ON public.operadoras (created_at);
CREATE INDEX IF NOT EXISTS idx_operadoras_deleted_at ON public.operadoras (deleted_at);
CREATE INDEX IF NOT EXISTS idx_operadoras_boleto_client_id ON public.operadoras (boleto_client_id);
CREATE INDEX IF NOT EXISTS idx_parametros_deleted_at ON public.parametros (deleted_at);
CREATE INDEX IF NOT EXISTS idx_permission_role_permission_id ON public.permission_role (permission_id);
CREATE INDEX IF NOT EXISTS idx_permission_role_role_id ON public.permission_role (role_id);
CREATE INDEX IF NOT EXISTS idx_permissions_active ON public.permissions (active);
CREATE INDEX IF NOT EXISTS idx_permissions_created_at ON public.permissions (created_at);
CREATE INDEX IF NOT EXISTS idx_personal_access_tokens_created_at ON public.personal_access_tokens (created_at);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_prestadores_contratos_id ON public.prestador_contrato_itens (prestadores_contratos_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_edicao_medicamento_id ON public.prestador_contrato_itens (edicao_medicamento_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_tabela_precos_id ON public.prestador_contrato_itens (tabela_precos_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_ativo ON public.prestador_contrato_itens (ativo);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_deleted_at ON public.prestador_contrato_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_created_at ON public.prestador_contrato_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_motivo_encerramento_id ON public.prestador_contrato_itens (motivo_encerramento_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contratos_prestador_id ON public.prestador_contratos (prestador_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contratos_ativo ON public.prestador_contratos (ativo);
CREATE INDEX IF NOT EXISTS idx_prestador_contratos_deleted_at ON public.prestador_contratos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_prestador_contratos_created_at ON public.prestador_contratos (created_at);
CREATE INDEX IF NOT EXISTS idx_prestador_especialidades_prestador_id ON public.prestador_especialidades (prestador_id);
CREATE INDEX IF NOT EXISTS idx_prestador_especialidades_especialidade_id ON public.prestador_especialidades (especialidade_id);
CREATE INDEX IF NOT EXISTS idx_prestador_tipos_active ON public.prestador_tipos (active);
CREATE INDEX IF NOT EXISTS idx_prestador_tipos_deleted_at ON public.prestador_tipos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_prestador_tipos_created_at ON public.prestador_tipos (created_at);
CREATE INDEX IF NOT EXISTS idx_prestador_user_prestador_id ON public.prestador_user (prestador_id);
CREATE INDEX IF NOT EXISTS idx_prestador_user_user_id ON public.prestador_user (user_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_usuario_id ON public.prestadores (usuario_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_prestadores_classificacao_estabelecimento_id ON public.prestadores (prestadores_classificacao_estabelecimento_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_orgao_expedidor_uf_id ON public.prestadores (orgao_expedidor_uf_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_naturalidade_cidade_id ON public.prestadores (naturalidade_cidade_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_cpf_cnpj ON public.prestadores (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_prestadores_email ON public.prestadores (email);
CREATE INDEX IF NOT EXISTS idx_prestadores_ativo ON public.prestadores (ativo);
CREATE INDEX IF NOT EXISTS idx_prestadores_created_at ON public.prestadores (created_at);
CREATE INDEX IF NOT EXISTS idx_prestadores_deleted_at ON public.prestadores (deleted_at);
CREATE INDEX IF NOT EXISTS idx_prestadores_prestador_tipo_id ON public.prestadores (prestador_tipo_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_classificacao_estabelecimento_ativo ON public.prestadores_classificacao_estabelecimento (ativo);
CREATE INDEX IF NOT EXISTS idx_prestadores_classificacao_estabelecimento_created_at ON public.prestadores_classificacao_estabelecimento (created_at);
CREATE INDEX IF NOT EXISTS idx_prestadores_classificacao_estabelecimento_deleted_at ON public.prestadores_classificacao_estabelecimento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_procedimento_subgrupos_grupo_id ON public.procedimento_subgrupos (grupo_id);
CREATE INDEX IF NOT EXISTS idx_procedimento_subgrupos_created_at ON public.procedimento_subgrupos (created_at);
CREATE INDEX IF NOT EXISTS idx_procedimento_subgrupos_deleted_at ON public.procedimento_subgrupos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_procedimentos_procedimento_subgrupo_id ON public.procedimentos (procedimento_subgrupo_id);
CREATE INDEX IF NOT EXISTS idx_procedimentos_created_at ON public.procedimentos (created_at);
CREATE INDEX IF NOT EXISTS idx_procedimentos_deleted_at ON public.procedimentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_procedimentos_grupos_ativo ON public.procedimentos_grupos (ativo);
CREATE INDEX IF NOT EXISTS idx_procedimentos_grupos_created_at ON public.procedimentos_grupos (created_at);
CREATE INDEX IF NOT EXISTS idx_procedimentos_grupos_deleted_at ON public.procedimentos_grupos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_produtos_operadora_id ON public.produtos (operadora_id);
CREATE INDEX IF NOT EXISTS idx_produtos_ativo ON public.produtos (ativo);
CREATE INDEX IF NOT EXISTS idx_produtos_created_at ON public.produtos (created_at);
CREATE INDEX IF NOT EXISTS idx_produtos_deleted_at ON public.produtos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_produto_id ON public.produtos_precos (produto_id);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_tipo_vinculo_id ON public.produtos_precos (tipo_vinculo_id);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_created_at ON public.produtos_precos (created_at);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_deleted_at ON public.produtos_precos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_grupo_verba_id ON public.produtos_precos (grupo_verba_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_produto_id ON public.regra_cooparticipacao (produto_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_ativo ON public.regra_cooparticipacao (ativo);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_created_at ON public.regra_cooparticipacao (created_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_deleted_at ON public.regra_cooparticipacao (deleted_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_itens_regra_cooparticipacao_id ON public.regra_cooparticipacao_itens (regra_cooparticipacao_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_itens_created_at ON public.regra_cooparticipacao_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_itens_deleted_at ON public.regra_cooparticipacao_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_regra_cooparticipacao_id ON public.regra_cooparticipacao_procedimentos (regra_cooparticipacao_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_grupo_procedimento_id ON public.regra_cooparticipacao_procedimentos (grupo_procedimento_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_subgrupo_procedimento_id ON public.regra_cooparticipacao_procedimentos (subgrupo_procedimento_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_procedimento_id ON public.regra_cooparticipacao_procedimentos (procedimento_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_created_at ON public.regra_cooparticipacao_procedimentos (created_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_deleted_at ON public.regra_cooparticipacao_procedimentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_empresa_id ON public.remessa_desconto (empresa_id);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_deleted_at ON public.remessa_desconto (deleted_at);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_created_at ON public.remessa_desconto (created_at);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_item_remessa_desconto_id ON public.remessa_desconto_item (remessa_desconto_id);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_item_adesao_id ON public.remessa_desconto_item (adesao_id);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_item_created_at ON public.remessa_desconto_item (created_at);
CREATE INDEX IF NOT EXISTS idx_role_user_user_id ON public.role_user (user_id);
CREATE INDEX IF NOT EXISTS idx_role_user_role_id ON public.role_user (role_id);
CREATE INDEX IF NOT EXISTS idx_roles_active ON public.roles (active);
CREATE INDEX IF NOT EXISTS idx_roles_created_at ON public.roles (created_at);
CREATE INDEX IF NOT EXISTS idx_secretarias_empresa_id ON public.secretarias (empresa_id);
CREATE INDEX IF NOT EXISTS idx_secretarias_cpf_cnpj ON public.secretarias (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_secretarias_email ON public.secretarias (email);
CREATE INDEX IF NOT EXISTS idx_secretarias_ativo ON public.secretarias (ativo);
CREATE INDEX IF NOT EXISTS idx_secretarias_created_at ON public.secretarias (created_at);
CREATE INDEX IF NOT EXISTS idx_secretarias_deleted_at ON public.secretarias (deleted_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_prestador_id ON public.solicitacoes_atualizacao_cadastral (prestador_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_conveniado_id ON public.solicitacoes_atualizacao_cadastral (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_cidade_id ON public.solicitacoes_atualizacao_cadastral (cidade_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_email ON public.solicitacoes_atualizacao_cadastral (email);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_status ON public.solicitacoes_atualizacao_cadastral (status);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_deleted_at ON public.solicitacoes_atualizacao_cadastral (deleted_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_created_at ON public.solicitacoes_atualizacao_cadastral (created_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_edital_credenciamento_id ON public.solicitacoes_credenciamento (edital_credenciamento_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_cpf_cnpj ON public.solicitacoes_credenciamento (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_email ON public.solicitacoes_credenciamento (email);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_deleted_at ON public.solicitacoes_credenciamento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_created_at ON public.solicitacoes_credenciamento (created_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_documentos_solicitacoes_credenciamento_id ON public.solicitacoes_credenciamento_documentos (solicitacoes_credenciamento_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_documentos_documento_credenciamento_id ON public.solicitacoes_credenciamento_documentos (documento_credenciamento_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_documentos_created_at ON public.solicitacoes_credenciamento_documentos (created_at);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_comunicado_edicao_id ON public.tabela_precos (comunicado_edicao_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_cbhpm_edicao_id ON public.tabela_precos (cbhpm_edicao_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_material_edicao_id ON public.tabela_precos (material_edicao_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_ativo ON public.tabela_precos (ativo);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_deleted_at ON public.tabela_precos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_created_at ON public.tabela_precos (created_at);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_itens_tabela_preco_id ON public.tabela_precos_itens (tabela_preco_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_itens_referencia_id ON public.tabela_precos_itens (referencia_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_itens_created_at ON public.tabela_precos_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_taxas_deleted_at ON public.taxas (deleted_at);
CREATE INDEX IF NOT EXISTS idx_taxas_created_at ON public.taxas (created_at);
CREATE INDEX IF NOT EXISTS idx_tipo_vinculos_ativo ON public.tipo_vinculos (ativo);
CREATE INDEX IF NOT EXISTS idx_tipo_vinculos_deleted_at ON public.tipo_vinculos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_tipo_vinculos_created_at ON public.tipo_vinculos (created_at);
CREATE INDEX IF NOT EXISTS idx_users_email ON public.users (email);
CREATE INDEX IF NOT EXISTS idx_users_cpf ON public.users (cpf);
CREATE INDEX IF NOT EXISTS idx_users_active ON public.users (active);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON public.users (created_at);
CREATE INDEX IF NOT EXISTS idx_users_deleted_at ON public.users (deleted_at);

-- ============================================================
-- Observações importantes
-- ============================================================
-- 1. Este script corrige estrutura básica, chaves primárias e compatibilidade.
-- 2. As FOREIGN KEYS não foram adicionadas automaticamente para evitar erros por tabelas ausentes ou relações ambíguas.
-- 3. Recomenda-se validar as relações antes de aplicar constraints definitivas.
-- 4. Para Supabase, habilite RLS manualmente por módulo após definir perfis e permissões.

-- ============================================================
-- Funções auxiliares de validação e aplicação segura
-- ============================================================
CREATE TABLE IF NOT EXISTS public._migration_validation_issues (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    issue_type text NOT NULL,
    table_name text NOT NULL,
    column_name text,
    referenced_table text,
    referenced_column text,
    issue_count bigint NOT NULL DEFAULT 0,
    details jsonb,
    created_at timestamptz DEFAULT now()
);

CREATE OR REPLACE FUNCTION public._table_exists(p_table text)
RETURNS boolean
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'public'
          AND table_name = p_table
    );
END;
$$;

CREATE OR REPLACE FUNCTION public._column_exists(p_table text, p_column text)
RETURNS boolean
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = p_table
          AND column_name = p_column
    );
END;
$$;

CREATE OR REPLACE FUNCTION public._constraint_exists(p_table text, p_constraint text)
RETURNS boolean
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = 'public'
          AND table_name = p_table
          AND constraint_name = p_constraint
    );
END;
$$;

CREATE OR REPLACE FUNCTION public._validate_fk_orphans(
    p_source_table text,
    p_source_column text,
    p_target_table text,
    p_target_column text
)
RETURNS bigint
LANGUAGE plpgsql
AS $$
DECLARE
    v_count bigint;
    v_sql text;
BEGIN
    IF NOT public._table_exists(p_source_table)
       OR NOT public._table_exists(p_target_table)
       OR NOT public._column_exists(p_source_table, p_source_column)
       OR NOT public._column_exists(p_target_table, p_target_column)
    THEN
        INSERT INTO public._migration_validation_issues (
            issue_type, table_name, column_name, referenced_table, referenced_column, issue_count, details
        )
        VALUES (
            'MISSING_TABLE_OR_COLUMN',
            p_source_table,
            p_source_column,
            p_target_table,
            p_target_column,
            1,
            jsonb_build_object(
                'source_table_exists', public._table_exists(p_source_table),
                'target_table_exists', public._table_exists(p_target_table),
                'source_column_exists', public._column_exists(p_source_table, p_source_column),
                'target_column_exists', public._column_exists(p_target_table, p_target_column)
            )
        );

        RETURN 1;
    END IF;

    v_sql := format(
        'SELECT count(*) FROM public.%I s
         WHERE s.%I IS NOT NULL
           AND NOT EXISTS (
               SELECT 1
               FROM public.%I t
               WHERE t.%I = s.%I
           )',
        p_source_table,
        p_source_column,
        p_target_table,
        p_target_column,
        p_source_column
    );

    EXECUTE v_sql INTO v_count;

    IF v_count > 0 THEN
        INSERT INTO public._migration_validation_issues (
            issue_type, table_name, column_name, referenced_table, referenced_column, issue_count, details
        )
        VALUES (
            'FK_ORPHAN_RECORDS',
            p_source_table,
            p_source_column,
            p_target_table,
            p_target_column,
            v_count,
            jsonb_build_object('message', 'Existem registros órfãos antes da criação da foreign key.')
        );
    END IF;

    RETURN v_count;
END;
$$;

CREATE OR REPLACE FUNCTION public._add_fk_if_valid(
    p_source_table text,
    p_source_column text,
    p_target_table text,
    p_target_column text,
    p_constraint text
)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    v_orphans bigint;
    v_sql text;
BEGIN
    v_orphans := public._validate_fk_orphans(
        p_source_table,
        p_source_column,
        p_target_table,
        p_target_column
    );

    IF v_orphans > 0 THEN
        RAISE NOTICE 'FK ignorada: %.% -> %.% possui % problema(s).',
            p_source_table, p_source_column, p_target_table, p_target_column, v_orphans;
        RETURN;
    END IF;

    IF public._constraint_exists(p_source_table, p_constraint) THEN
        RAISE NOTICE 'Constraint já existe: %', p_constraint;
        RETURN;
    END IF;

    v_sql := format(
        'ALTER TABLE public.%I
         ADD CONSTRAINT %I
         FOREIGN KEY (%I)
         REFERENCES public.%I(%I)
         ON UPDATE CASCADE
         ON DELETE RESTRICT
         NOT VALID',
        p_source_table,
        p_constraint,
        p_source_column,
        p_target_table,
        p_target_column
    );

    EXECUTE v_sql;

    RAISE NOTICE 'FK criada como NOT VALID: %', p_constraint;
END;
$$;

-- ============================================================
-- Validações e criação segura de Foreign Keys
-- As FKs são criadas como NOT VALID para evitar travar importações grandes.
-- Depois de resolver pendências, execute os VALIDATE CONSTRAINTS no final.
-- ============================================================

TRUNCATE TABLE public._migration_validation_issues;

SELECT public._add_fk_if_valid('adesao_reducao_margem', 'adesao_id', 'adesoes', 'id', 'fk_adesao_reducao_margem_adesao_id_adesoes');
SELECT public._add_fk_if_valid('adesoes', 'operadora_id', 'operadoras', 'id', 'fk_adesoes_operadora_id_operadoras');
SELECT public._add_fk_if_valid('adesoes', 'empresa_id', 'empresas', 'id', 'fk_adesoes_empresa_id_empresas');
SELECT public._add_fk_if_valid('adesoes', 'secretaria_id', 'secretarias', 'id', 'fk_adesoes_secretaria_id_secretarias');
SELECT public._add_fk_if_valid('adesoes', 'conveniado_id', 'conveniados', 'id', 'fk_adesoes_conveniado_id_conveniados');
SELECT public._add_fk_if_valid('adesoes', 'produto_id', 'produtos', 'id', 'fk_adesoes_produto_id_produtos');
SELECT public._add_fk_if_valid('adesoes', 'produto_preco_id', 'produtos_precos', 'id', 'fk_adesoes_produto_preco_id_produtos_precos');
SELECT public._add_fk_if_valid('boleto_lancamentos', 'boleto_id', 'boletos', 'id', 'fk_boleto_lancamentos_boleto_id_boletos');
SELECT public._add_fk_if_valid('boleto_lancamentos', 'lancamento_id', 'lancamentos', 'id', 'fk_boleto_lancamentos_lancamento_id_lancamentos');
SELECT public._add_fk_if_valid('boletos', 'operadora_id', 'operadoras', 'id', 'fk_boletos_operadora_id_operadoras');
SELECT public._add_fk_if_valid('boletos', 'pagador_cidade_id', 'cidades', 'id', 'fk_boletos_pagador_cidade_id_cidades');
SELECT public._add_fk_if_valid('cbhpm', 'cbhpm_edicao_id', 'cbhpm_edicoes', 'id', 'fk_cbhpm_cbhpm_edicao_id_cbhpm_edicoes');
SELECT public._add_fk_if_valid('cbhpm', 'procedimento_id', 'procedimentos', 'id', 'fk_cbhpm_procedimento_id_procedimentos');
SELECT public._add_fk_if_valid('cidades', 'estado_id', 'estados', 'id', 'fk_cidades_estado_id_estados');
SELECT public._add_fk_if_valid('comunicado_portes', 'comunicado_edicao_id', 'comunicado_edicoes', 'id', 'fk_comunicado_portes_comunicado_edicao_id_comunicado_edicoes');
SELECT public._add_fk_if_valid('contrato_profissionais', 'contrato_id', 'prestador_contratos', 'id', 'fk_contrato_profissionais_contrato_id_prestador_contratos');
SELECT public._add_fk_if_valid('contrato_profissionais', 'prestador_id', 'prestadores', 'id', 'fk_contrato_profissionais_prestador_id_prestadores');
SELECT public._add_fk_if_valid('conveniado_salarios', 'conveniado_id', 'conveniados', 'id', 'fk_conveniado_salarios_conveniado_id_conveniados');
SELECT public._add_fk_if_valid('conveniados', 'naturalidade_cidade_id', 'cidades', 'id', 'fk_conveniados_naturalidade_cidade_id_cidades');
SELECT public._add_fk_if_valid('conveniados', 'orgao_expedidor_uf_id', 'estados', 'id', 'fk_conveniados_orgao_expedidor_uf_id_estados');
SELECT public._add_fk_if_valid('conveniados', 'usuario_id', 'users', 'id', 'fk_conveniados_usuario_id_users');
SELECT public._add_fk_if_valid('conveniados', 'cargo_id', 'cargos', 'id', 'fk_conveniados_cargo_id_cargos');
SELECT public._add_fk_if_valid('dados_bancarios', 'banco_id', 'bancos', 'id', 'fk_dados_bancarios_banco_id_bancos');
SELECT public._add_fk_if_valid('deflatores', 'procedimento_grupo_id', 'procedimentos_grupos', 'id', 'fk_deflatores_procedimento_grupo_id_procedimentos_grupos');
SELECT public._add_fk_if_valid('documentos_credenciamento', 'id', 'documentos_credenciamento', 'id', 'fk_documentos_credenciamento_id_documentos_credenciamento');
SELECT public._add_fk_if_valid('edital_credenciamento_documentos', 'edital_id', 'editais_credenciamento', 'id', 'fk_edital_credenciamento_documentos_edital_id_editais_creden');
SELECT public._add_fk_if_valid('edital_credenciamento_documentos', 'documento_credenciamento_id', 'documentos_credenciamento', 'id', 'fk_edital_credenciamento_documentos_documento_credenciamento');
SELECT public._add_fk_if_valid('empresa_produto', 'empresa_id', 'empresas', 'id', 'fk_empresa_produto_empresa_id_empresas');
SELECT public._add_fk_if_valid('empresa_produto', 'produto_id', 'produtos', 'id', 'fk_empresa_produto_produto_id_produtos');
SELECT public._add_fk_if_valid('empresa_user', 'empresa_id', 'empresas', 'id', 'fk_empresa_user_empresa_id_empresas');
SELECT public._add_fk_if_valid('empresa_user', 'user_id', 'users', 'id', 'fk_empresa_user_user_id_users');
SELECT public._add_fk_if_valid('empresas_verbas', 'empresa_id', 'empresas', 'id', 'fk_empresas_verbas_empresa_id_empresas');
SELECT public._add_fk_if_valid('empresas_verbas', 'grupo_verba_id', 'grupo_verbas', 'id', 'fk_empresas_verbas_grupo_verba_id_grupo_verbas');
SELECT public._add_fk_if_valid('enderecos', 'cidade_id', 'cidades', 'id', 'fk_enderecos_cidade_id_cidades');
SELECT public._add_fk_if_valid('fiscal_contrato_itens', 'fiscal_contrato_id', 'fiscal_contratos', 'id', 'fk_fiscal_contrato_itens_fiscal_contrato_id_fiscal_contratos');
SELECT public._add_fk_if_valid('fiscal_contrato_itens', 'contrato_id', 'prestador_contratos', 'id', 'fk_fiscal_contrato_itens_contrato_id_prestador_contratos');
SELECT public._add_fk_if_valid('fiscal_contratos', 'usuario_id', 'users', 'id', 'fk_fiscal_contratos_usuario_id_users');
SELECT public._add_fk_if_valid('gestantes', 'conveniado_id', 'conveniados', 'id', 'fk_gestantes_conveniado_id_conveniados');
SELECT public._add_fk_if_valid('guia_importacoes', 'prestador_id', 'prestadores', 'id', 'fk_guia_importacoes_prestador_id_prestadores');
SELECT public._add_fk_if_valid('guia_importacoes', 'usuario_id', 'users', 'id', 'fk_guia_importacoes_usuario_id_users');
SELECT public._add_fk_if_valid('guias', 'usuario_emissor_id', 'users', 'id', 'fk_guias_usuario_emissor_id_users');
SELECT public._add_fk_if_valid('guias', 'prestador_id', 'prestadores', 'id', 'fk_guias_prestador_id_prestadores');
SELECT public._add_fk_if_valid('guias', 'profissional_id', 'prestadores', 'id', 'fk_guias_profissional_id_prestadores');
SELECT public._add_fk_if_valid('guias', 'conveniado_id', 'conveniados', 'id', 'fk_guias_conveniado_id_conveniados');
SELECT public._add_fk_if_valid('guias', 'solicitante_prestador_id', 'prestadores', 'id', 'fk_guias_solicitante_prestador_id_prestadores');
SELECT public._add_fk_if_valid('guias', 'lote_pagamento_id', 'lote_pagamentos', 'id', 'fk_guias_lote_pagamento_id_lote_pagamentos');
SELECT public._add_fk_if_valid('guias', 'guia_origem_id', 'guias', 'id', 'fk_guias_guia_origem_id_guias');
SELECT public._add_fk_if_valid('guias', 'cancelado_por_user_id', 'users', 'id', 'fk_guias_cancelado_por_user_id_users');
SELECT public._add_fk_if_valid('guias', 'guia_importacao_id', 'guia_importacoes', 'id', 'fk_guias_guia_importacao_id_guia_importacoes');
SELECT public._add_fk_if_valid('guias_anexos', 'guia_id', 'guias', 'id', 'fk_guias_anexos_guia_id_guias');
SELECT public._add_fk_if_valid('guias_atendimentos', 'guia_itens_id', 'guias_itens', 'id', 'fk_guias_atendimentos_guia_itens_id_guias_itens');
SELECT public._add_fk_if_valid('guias_atendimentos', 'usuario_id', 'users', 'id', 'fk_guias_atendimentos_usuario_id_users');
SELECT public._add_fk_if_valid('guias_auditoria', 'guia_itens_id', 'guias_itens', 'id', 'fk_guias_auditoria_guia_itens_id_guias_itens');
SELECT public._add_fk_if_valid('guias_auditoria', 'analise_usuario_id', 'users', 'id', 'fk_guias_auditoria_analise_usuario_id_users');
SELECT public._add_fk_if_valid('guias_historico', 'guia_id', 'guias', 'id', 'fk_guias_historico_guia_id_guias');
SELECT public._add_fk_if_valid('guias_historico', 'guia_item_id', 'guias_itens', 'id', 'fk_guias_historico_guia_item_id_guias_itens');
SELECT public._add_fk_if_valid('guias_historico', 'usuario_id', 'users', 'id', 'fk_guias_historico_usuario_id_users');
SELECT public._add_fk_if_valid('guias_itens', 'guia_id', 'guias', 'id', 'fk_guias_itens_guia_id_guias');
SELECT public._add_fk_if_valid('historico_credenciamentos', 'user_id', 'users', 'id', 'fk_historico_credenciamentos_user_id_users');
SELECT public._add_fk_if_valid('lancamentos', 'boleto_id', 'boletos', 'id', 'fk_lancamentos_boleto_id_boletos');
SELECT public._add_fk_if_valid('lancamentos', 'operadora_id', 'operadoras', 'id', 'fk_lancamentos_operadora_id_operadoras');
SELECT public._add_fk_if_valid('lancamentos', 'prestador_id', 'prestadores', 'id', 'fk_lancamentos_prestador_id_prestadores');
SELECT public._add_fk_if_valid('lancamentos', 'conveniado_id', 'conveniados', 'id', 'fk_lancamentos_conveniado_id_conveniados');
SELECT public._add_fk_if_valid('lancamentos', 'grupo_verba_id', 'grupo_verbas', 'id', 'fk_lancamentos_grupo_verba_id_grupo_verbas');
SELECT public._add_fk_if_valid('lancamentos_guias', 'lancamento_id', 'lancamentos', 'id', 'fk_lancamentos_guias_lancamento_id_lancamentos');
SELECT public._add_fk_if_valid('lancamentos_guias', 'guia_id', 'guias', 'id', 'fk_lancamentos_guias_guia_id_guias');
SELECT public._add_fk_if_valid('lote_pagamentos', 'prestador_id', 'prestadores', 'id', 'fk_lote_pagamentos_prestador_id_prestadores');
SELECT public._add_fk_if_valid('lote_pagamentos', 'usuario_id', 'users', 'id', 'fk_lote_pagamentos_usuario_id_users');
SELECT public._add_fk_if_valid('lote_pagamentos', 'lancamento_id', 'lancamentos', 'id', 'fk_lote_pagamentos_lancamento_id_lancamentos');
SELECT public._add_fk_if_valid('materiais_itens', 'material_edicao_id', 'material_edicoes', 'id', 'fk_materiais_itens_material_edicao_id_material_edicoes');
SELECT public._add_fk_if_valid('materiais_itens', 'material_id', 'materiais', 'id', 'fk_materiais_itens_material_id_materiais');
SELECT public._add_fk_if_valid('medicamento_brasindice', 'medicamento_edicao_id', 'medicamento_edicoes', 'id', 'fk_medicamento_brasindice_medicamento_edicao_id_medicamento_');
SELECT public._add_fk_if_valid('medicamento_brasindice', 'medicamento_id', 'medicamentos', 'id', 'fk_medicamento_brasindice_medicamento_id_medicamentos');
SELECT public._add_fk_if_valid('medicamentos', 'laboratorio_id', 'laboratorios', 'id', 'fk_medicamentos_laboratorio_id_laboratorios');
SELECT public._add_fk_if_valid('medicamentos', 'medicamento_edicao_id', 'medicamento_edicoes', 'id', 'fk_medicamentos_medicamento_edicao_id_medicamento_edicoes');
SELECT public._add_fk_if_valid('mensalidades', 'conveniado_id', 'conveniados', 'id', 'fk_mensalidades_conveniado_id_conveniados');
SELECT public._add_fk_if_valid('mensalidades', 'produto_preco_id', 'produtos_precos', 'id', 'fk_mensalidades_produto_preco_id_produtos_precos');
SELECT public._add_fk_if_valid('mensalidades', 'grupo_verba_id', 'grupo_verbas', 'id', 'fk_mensalidades_grupo_verba_id_grupo_verbas');
SELECT public._add_fk_if_valid('motivo_encerramentos', 'id', 'motivo_encerramentos', 'id', 'fk_motivo_encerramentos_id_motivo_encerramentos');
SELECT public._add_fk_if_valid('operadora_user', 'operadora_id', 'operadoras', 'id', 'fk_operadora_user_operadora_id_operadoras');
SELECT public._add_fk_if_valid('operadora_user', 'user_id', 'users', 'id', 'fk_operadora_user_user_id_users');
SELECT public._add_fk_if_valid('permission_role', 'permission_id', 'permissions', 'id', 'fk_permission_role_permission_id_permissions');
SELECT public._add_fk_if_valid('permission_role', 'role_id', 'roles', 'id', 'fk_permission_role_role_id_roles');
SELECT public._add_fk_if_valid('prestador_contrato_itens', 'prestadores_contratos_id', 'prestador_contratos', 'id', 'fk_prestador_contrato_itens_prestadores_contratos_id_prestad');
SELECT public._add_fk_if_valid('prestador_contrato_itens', 'edicao_medicamento_id', 'medicamento_edicoes', 'id', 'fk_prestador_contrato_itens_edicao_medicamento_id_medicament');
SELECT public._add_fk_if_valid('prestador_contrato_itens', 'tabela_precos_id', 'tabela_precos', 'id', 'fk_prestador_contrato_itens_tabela_precos_id_tabela_precos');
SELECT public._add_fk_if_valid('prestador_contrato_itens', 'motivo_encerramento_id', 'motivo_encerramentos', 'id', 'fk_prestador_contrato_itens_motivo_encerramento_id_motivo_en');
SELECT public._add_fk_if_valid('prestador_contratos', 'prestador_id', 'prestadores', 'id', 'fk_prestador_contratos_prestador_id_prestadores');
SELECT public._add_fk_if_valid('prestador_especialidades', 'prestador_id', 'prestadores', 'id', 'fk_prestador_especialidades_prestador_id_prestadores');
SELECT public._add_fk_if_valid('prestador_especialidades', 'especialidade_id', 'especialidades', 'id', 'fk_prestador_especialidades_especialidade_id_especialidades');
SELECT public._add_fk_if_valid('prestador_user', 'prestador_id', 'prestadores', 'id', 'fk_prestador_user_prestador_id_prestadores');
SELECT public._add_fk_if_valid('prestador_user', 'user_id', 'users', 'id', 'fk_prestador_user_user_id_users');
SELECT public._add_fk_if_valid('prestadores', 'usuario_id', 'users', 'id', 'fk_prestadores_usuario_id_users');
SELECT public._add_fk_if_valid('prestadores', 'prestadores_classificacao_estabelecimento_id', 'prestadores_classificacao_estabelecimento', 'id', 'fk_prestadores_prestadores_classificacao_estabelecimento_id_');
SELECT public._add_fk_if_valid('prestadores', 'orgao_expedidor_uf_id', 'estados', 'id', 'fk_prestadores_orgao_expedidor_uf_id_estados');
SELECT public._add_fk_if_valid('prestadores', 'naturalidade_cidade_id', 'cidades', 'id', 'fk_prestadores_naturalidade_cidade_id_cidades');
SELECT public._add_fk_if_valid('prestadores', 'prestador_tipo_id', 'prestador_tipos', 'id', 'fk_prestadores_prestador_tipo_id_prestador_tipos');
SELECT public._add_fk_if_valid('procedimento_subgrupos', 'grupo_id', 'procedimentos_grupos', 'id', 'fk_procedimento_subgrupos_grupo_id_procedimentos_grupos');
SELECT public._add_fk_if_valid('procedimentos', 'procedimento_subgrupo_id', 'procedimento_subgrupos', 'id', 'fk_procedimentos_procedimento_subgrupo_id_procedimento_subgr');
SELECT public._add_fk_if_valid('produtos', 'operadora_id', 'operadoras', 'id', 'fk_produtos_operadora_id_operadoras');
SELECT public._add_fk_if_valid('produtos_precos', 'produto_id', 'produtos', 'id', 'fk_produtos_precos_produto_id_produtos');
SELECT public._add_fk_if_valid('produtos_precos', 'tipo_vinculo_id', 'tipo_vinculos', 'id', 'fk_produtos_precos_tipo_vinculo_id_tipo_vinculos');
SELECT public._add_fk_if_valid('produtos_precos', 'grupo_verba_id', 'grupo_verbas', 'id', 'fk_produtos_precos_grupo_verba_id_grupo_verbas');
SELECT public._add_fk_if_valid('regra_cooparticipacao', 'produto_id', 'produtos', 'id', 'fk_regra_cooparticipacao_produto_id_produtos');
SELECT public._add_fk_if_valid('regra_cooparticipacao_itens', 'regra_cooparticipacao_id', 'regra_cooparticipacao', 'id', 'fk_regra_cooparticipacao_itens_regra_cooparticipacao_id_regr');
SELECT public._add_fk_if_valid('regra_cooparticipacao_procedimentos', 'regra_cooparticipacao_id', 'regra_cooparticipacao', 'id', 'fk_regra_cooparticipacao_procedimentos_regra_cooparticipacao');
SELECT public._add_fk_if_valid('regra_cooparticipacao_procedimentos', 'grupo_procedimento_id', 'procedimentos_grupos', 'id', 'fk_regra_cooparticipacao_procedimentos_grupo_procedimento_id');
SELECT public._add_fk_if_valid('regra_cooparticipacao_procedimentos', 'subgrupo_procedimento_id', 'procedimento_subgrupos', 'id', 'fk_regra_cooparticipacao_procedimentos_subgrupo_procedimento');
SELECT public._add_fk_if_valid('regra_cooparticipacao_procedimentos', 'procedimento_id', 'procedimentos', 'id', 'fk_regra_cooparticipacao_procedimentos_procedimento_id_proce');
SELECT public._add_fk_if_valid('remessa_desconto', 'empresa_id', 'empresas', 'id', 'fk_remessa_desconto_empresa_id_empresas');
SELECT public._add_fk_if_valid('remessa_desconto_item', 'remessa_desconto_id', 'remessa_desconto', 'id', 'fk_remessa_desconto_item_remessa_desconto_id_remessa_descont');
SELECT public._add_fk_if_valid('remessa_desconto_item', 'adesao_id', 'adesoes', 'id', 'fk_remessa_desconto_item_adesao_id_adesoes');
SELECT public._add_fk_if_valid('role_user', 'user_id', 'users', 'id', 'fk_role_user_user_id_users');
SELECT public._add_fk_if_valid('role_user', 'role_id', 'roles', 'id', 'fk_role_user_role_id_roles');
SELECT public._add_fk_if_valid('secretarias', 'empresa_id', 'empresas', 'id', 'fk_secretarias_empresa_id_empresas');
SELECT public._add_fk_if_valid('solicitacoes_atualizacao_cadastral', 'prestador_id', 'prestadores', 'id', 'fk_solicitacoes_atualizacao_cadastral_prestador_id_prestador');
SELECT public._add_fk_if_valid('solicitacoes_atualizacao_cadastral', 'conveniado_id', 'conveniados', 'id', 'fk_solicitacoes_atualizacao_cadastral_conveniado_id_convenia');
SELECT public._add_fk_if_valid('solicitacoes_atualizacao_cadastral', 'cidade_id', 'cidades', 'id', 'fk_solicitacoes_atualizacao_cadastral_cidade_id_cidades');
SELECT public._add_fk_if_valid('solicitacoes_credenciamento', 'edital_credenciamento_id', 'editais_credenciamento', 'id', 'fk_solicitacoes_credenciamento_edital_credenciamento_id_edit');
SELECT public._add_fk_if_valid('solicitacoes_credenciamento_documentos', 'solicitacoes_credenciamento_id', 'solicitacoes_credenciamento', 'id', 'fk_solicitacoes_credenciamento_documentos_solicitacoes_crede');
SELECT public._add_fk_if_valid('solicitacoes_credenciamento_documentos', 'documento_credenciamento_id', 'documentos_credenciamento', 'id', 'fk_solicitacoes_credenciamento_documentos_documento_credenci');
SELECT public._add_fk_if_valid('tabela_precos', 'comunicado_edicao_id', 'comunicado_edicoes', 'id', 'fk_tabela_precos_comunicado_edicao_id_comunicado_edicoes');
SELECT public._add_fk_if_valid('tabela_precos', 'cbhpm_edicao_id', 'cbhpm_edicoes', 'id', 'fk_tabela_precos_cbhpm_edicao_id_cbhpm_edicoes');
SELECT public._add_fk_if_valid('tabela_precos', 'material_edicao_id', 'material_edicoes', 'id', 'fk_tabela_precos_material_edicao_id_material_edicoes');
SELECT public._add_fk_if_valid('tabela_precos_itens', 'tabela_preco_id', 'tabela_precos', 'id', 'fk_tabela_precos_itens_tabela_preco_id_tabela_precos');

-- ============================================================
-- Validações CHECK recomendadas
-- ============================================================
CREATE OR REPLACE FUNCTION public._add_check_if_possible(
    p_table text,
    p_constraint text,
    p_expression text
)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    v_sql text;
BEGIN
    IF NOT public._table_exists(p_table) THEN
        INSERT INTO public._migration_validation_issues(issue_type, table_name, issue_count, details)
        VALUES ('MISSING_TABLE_FOR_CHECK', p_table, 1, jsonb_build_object('constraint', p_constraint));
        RETURN;
    END IF;

    IF public._constraint_exists(p_table, p_constraint) THEN
        RETURN;
    END IF;

    v_sql := format(
        'ALTER TABLE public.%I ADD CONSTRAINT %I CHECK (%s) NOT VALID',
        p_table,
        p_constraint,
        p_expression
    );

    EXECUTE v_sql;
END;
$$;
SELECT public._add_check_if_possible('conveniados', 'chk_conveniados_sexo', 'sexo IN (1,2)');
SELECT public._add_check_if_possible('conveniados', 'chk_conveniados_estado_civil', 'estado_civil BETWEEN 1 AND 7');
SELECT public._add_check_if_possible('conveniados', 'chk_conveniados_pcd', 'pcd IN (1,2)');
SELECT public._add_check_if_possible('adesoes', 'chk_adesoes_tipo_cliente', 'tipo_cliente IN (1,2,3)');
SELECT public._add_check_if_possible('adesoes', 'chk_adesoes_status', 'status IN (1,2,3)');
SELECT public._add_check_if_possible('boletos', 'chk_boletos_valor_original', 'valor_original >= 0');
SELECT public._add_check_if_possible('boletos', 'chk_boletos_status', 'status BETWEEN 1 AND 5');
SELECT public._add_check_if_possible('lancamentos', 'chk_lancamentos_valor', 'valor >= 0');
SELECT public._add_check_if_possible('produtos_precos', 'chk_produtos_precos_idade', 'idade_inicial <= idade_final');
SELECT public._add_check_if_possible('produtos_precos', 'chk_produtos_precos_valor', 'valor >= 0');
SELECT public._add_check_if_possible('guias_itens', 'chk_guias_itens_quantidades', 'COALESCE(quantidade_solicitada,0) >= 0 AND COALESCE(quantidade_atendida,0) >= 0');
SELECT public._add_check_if_possible('users', 'chk_users_email_format', 'email IS NULL OR email ~* ''^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$''');

-- ============================================================
-- Índices únicos recomendados com validação prévia
-- ============================================================
CREATE OR REPLACE FUNCTION public._create_unique_index_if_no_duplicates(
    p_table text,
    p_column text,
    p_index text
)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    v_duplicates bigint;
    v_sql text;
BEGIN
    IF NOT public._table_exists(p_table) OR NOT public._column_exists(p_table, p_column) THEN
        INSERT INTO public._migration_validation_issues(issue_type, table_name, column_name, issue_count, details)
        VALUES ('MISSING_TABLE_OR_COLUMN_FOR_UNIQUE', p_table, p_column, 1, jsonb_build_object('index', p_index));
        RETURN;
    END IF;

    v_sql := format(
        'SELECT count(*) FROM (
            SELECT %I
            FROM public.%I
            WHERE %I IS NOT NULL
            GROUP BY %I
            HAVING count(*) > 1
        ) d',
        p_column, p_table, p_column, p_column
    );

    EXECUTE v_sql INTO v_duplicates;

    IF v_duplicates > 0 THEN
        INSERT INTO public._migration_validation_issues(issue_type, table_name, column_name, issue_count, details)
        VALUES ('DUPLICATES_FOUND_FOR_UNIQUE', p_table, p_column, v_duplicates, jsonb_build_object('index', p_index));
        RAISE NOTICE 'Índice único ignorado: %.% possui duplicidades.', p_table, p_column;
        RETURN;
    END IF;

    v_sql := format(
        'CREATE UNIQUE INDEX IF NOT EXISTS %I ON public.%I (%I) WHERE %I IS NOT NULL',
        p_index, p_table, p_column, p_column
    );

    EXECUTE v_sql;
END;
$$;
SELECT public._create_unique_index_if_no_duplicates('users', 'email', 'ux_users_email');
SELECT public._create_unique_index_if_no_duplicates('users', 'cpf', 'ux_users_cpf');
SELECT public._create_unique_index_if_no_duplicates('conveniados', 'cpf', 'ux_conveniados_cpf');
SELECT public._create_unique_index_if_no_duplicates('empresas', 'cpf_cnpj', 'ux_empresas_cpf_cnpj');
SELECT public._create_unique_index_if_no_duplicates('operadoras', 'cpf_cnpj', 'ux_operadoras_cpf_cnpj');
SELECT public._create_unique_index_if_no_duplicates('prestadores', 'cpf_cnpj', 'ux_prestadores_cpf_cnpj');
SELECT public._create_unique_index_if_no_duplicates('roles', 'slug', 'ux_roles_slug');
SELECT public._create_unique_index_if_no_duplicates('permissions', 'slug', 'ux_permissions_slug');
SELECT public._create_unique_index_if_no_duplicates('bancos', 'codigo', 'ux_bancos_codigo');
SELECT public._create_unique_index_if_no_duplicates('cid', 'codigo', 'ux_cid_codigo');

-- ============================================================
-- Relatório final de validação
-- ============================================================
SELECT *
FROM public._migration_validation_issues
ORDER BY created_at, table_name, column_name;

-- ============================================================
-- VALIDATE CONSTRAINTS
-- Execute estes comandos apenas depois que o relatório acima não retornar problemas críticos.
-- ============================================================

-- ALTER TABLE public.adesao_reducao_margem VALIDATE CONSTRAINT fk_adesao_reducao_margem_adesao_id_adesoes;
-- ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_operadora_id_operadoras;
-- ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_empresa_id_empresas;
-- ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_secretaria_id_secretarias;
-- ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_conveniado_id_conveniados;
-- ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_produto_id_produtos;
-- ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_produto_preco_id_produtos_precos;
-- ALTER TABLE public.boleto_lancamentos VALIDATE CONSTRAINT fk_boleto_lancamentos_boleto_id_boletos;
-- ALTER TABLE public.boleto_lancamentos VALIDATE CONSTRAINT fk_boleto_lancamentos_lancamento_id_lancamentos;
-- ALTER TABLE public.boletos VALIDATE CONSTRAINT fk_boletos_operadora_id_operadoras;
-- ALTER TABLE public.boletos VALIDATE CONSTRAINT fk_boletos_pagador_cidade_id_cidades;
-- ALTER TABLE public.cbhpm VALIDATE CONSTRAINT fk_cbhpm_cbhpm_edicao_id_cbhpm_edicoes;
-- ALTER TABLE public.cbhpm VALIDATE CONSTRAINT fk_cbhpm_procedimento_id_procedimentos;
-- ALTER TABLE public.cidades VALIDATE CONSTRAINT fk_cidades_estado_id_estados;
-- ALTER TABLE public.comunicado_portes VALIDATE CONSTRAINT fk_comunicado_portes_comunicado_edicao_id_comunicado_edicoes;
-- ALTER TABLE public.contrato_profissionais VALIDATE CONSTRAINT fk_contrato_profissionais_contrato_id_prestador_contratos;
-- ALTER TABLE public.contrato_profissionais VALIDATE CONSTRAINT fk_contrato_profissionais_prestador_id_prestadores;
-- ALTER TABLE public.conveniado_salarios VALIDATE CONSTRAINT fk_conveniado_salarios_conveniado_id_conveniados;
-- ALTER TABLE public.conveniados VALIDATE CONSTRAINT fk_conveniados_naturalidade_cidade_id_cidades;
-- ALTER TABLE public.conveniados VALIDATE CONSTRAINT fk_conveniados_orgao_expedidor_uf_id_estados;
-- ALTER TABLE public.conveniados VALIDATE CONSTRAINT fk_conveniados_usuario_id_users;
-- ALTER TABLE public.conveniados VALIDATE CONSTRAINT fk_conveniados_cargo_id_cargos;
-- ALTER TABLE public.dados_bancarios VALIDATE CONSTRAINT fk_dados_bancarios_banco_id_bancos;
-- ALTER TABLE public.deflatores VALIDATE CONSTRAINT fk_deflatores_procedimento_grupo_id_procedimentos_grupos;
-- ALTER TABLE public.documentos_credenciamento VALIDATE CONSTRAINT fk_documentos_credenciamento_id_documentos_credenciamento;
-- ALTER TABLE public.edital_credenciamento_documentos VALIDATE CONSTRAINT fk_edital_credenciamento_documentos_edital_id_editais_creden;
-- ALTER TABLE public.edital_credenciamento_documentos VALIDATE CONSTRAINT fk_edital_credenciamento_documentos_documento_credenciamento;
-- ALTER TABLE public.empresa_produto VALIDATE CONSTRAINT fk_empresa_produto_empresa_id_empresas;
-- ALTER TABLE public.empresa_produto VALIDATE CONSTRAINT fk_empresa_produto_produto_id_produtos;
-- ALTER TABLE public.empresa_user VALIDATE CONSTRAINT fk_empresa_user_empresa_id_empresas;
-- ALTER TABLE public.empresa_user VALIDATE CONSTRAINT fk_empresa_user_user_id_users;
-- ALTER TABLE public.empresas_verbas VALIDATE CONSTRAINT fk_empresas_verbas_empresa_id_empresas;
-- ALTER TABLE public.empresas_verbas VALIDATE CONSTRAINT fk_empresas_verbas_grupo_verba_id_grupo_verbas;
-- ALTER TABLE public.enderecos VALIDATE CONSTRAINT fk_enderecos_cidade_id_cidades;
-- ALTER TABLE public.fiscal_contrato_itens VALIDATE CONSTRAINT fk_fiscal_contrato_itens_fiscal_contrato_id_fiscal_contratos;
-- ALTER TABLE public.fiscal_contrato_itens VALIDATE CONSTRAINT fk_fiscal_contrato_itens_contrato_id_prestador_contratos;
-- ALTER TABLE public.fiscal_contratos VALIDATE CONSTRAINT fk_fiscal_contratos_usuario_id_users;
-- ALTER TABLE public.gestantes VALIDATE CONSTRAINT fk_gestantes_conveniado_id_conveniados;
-- ALTER TABLE public.guia_importacoes VALIDATE CONSTRAINT fk_guia_importacoes_prestador_id_prestadores;
-- ALTER TABLE public.guia_importacoes VALIDATE CONSTRAINT fk_guia_importacoes_usuario_id_users;
-- ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_usuario_emissor_id_users;
-- ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_prestador_id_prestadores;
-- ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_profissional_id_prestadores;
-- ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_conveniado_id_conveniados;
-- ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_solicitante_prestador_id_prestadores;
-- ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_lote_pagamento_id_lote_pagamentos;
-- ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_guia_origem_id_guias;
-- ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_cancelado_por_user_id_users;
-- ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_guia_importacao_id_guia_importacoes;
-- ALTER TABLE public.guias_anexos VALIDATE CONSTRAINT fk_guias_anexos_guia_id_guias;
-- ALTER TABLE public.guias_atendimentos VALIDATE CONSTRAINT fk_guias_atendimentos_guia_itens_id_guias_itens;
-- ALTER TABLE public.guias_atendimentos VALIDATE CONSTRAINT fk_guias_atendimentos_usuario_id_users;
-- ALTER TABLE public.guias_auditoria VALIDATE CONSTRAINT fk_guias_auditoria_guia_itens_id_guias_itens;
-- ALTER TABLE public.guias_auditoria VALIDATE CONSTRAINT fk_guias_auditoria_analise_usuario_id_users;
-- ALTER TABLE public.guias_historico VALIDATE CONSTRAINT fk_guias_historico_guia_id_guias;
-- ALTER TABLE public.guias_historico VALIDATE CONSTRAINT fk_guias_historico_guia_item_id_guias_itens;
-- ALTER TABLE public.guias_historico VALIDATE CONSTRAINT fk_guias_historico_usuario_id_users;
-- ALTER TABLE public.guias_itens VALIDATE CONSTRAINT fk_guias_itens_guia_id_guias;
-- ALTER TABLE public.historico_credenciamentos VALIDATE CONSTRAINT fk_historico_credenciamentos_user_id_users;
-- ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_boleto_id_boletos;
-- ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_operadora_id_operadoras;
-- ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_prestador_id_prestadores;
-- ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_conveniado_id_conveniados;
-- ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_grupo_verba_id_grupo_verbas;
-- ALTER TABLE public.lancamentos_guias VALIDATE CONSTRAINT fk_lancamentos_guias_lancamento_id_lancamentos;
-- ALTER TABLE public.lancamentos_guias VALIDATE CONSTRAINT fk_lancamentos_guias_guia_id_guias;
-- ALTER TABLE public.lote_pagamentos VALIDATE CONSTRAINT fk_lote_pagamentos_prestador_id_prestadores;
-- ALTER TABLE public.lote_pagamentos VALIDATE CONSTRAINT fk_lote_pagamentos_usuario_id_users;
-- ALTER TABLE public.lote_pagamentos VALIDATE CONSTRAINT fk_lote_pagamentos_lancamento_id_lancamentos;
-- ALTER TABLE public.materiais_itens VALIDATE CONSTRAINT fk_materiais_itens_material_edicao_id_material_edicoes;
-- ALTER TABLE public.materiais_itens VALIDATE CONSTRAINT fk_materiais_itens_material_id_materiais;
-- ALTER TABLE public.medicamento_brasindice VALIDATE CONSTRAINT fk_medicamento_brasindice_medicamento_edicao_id_medicamento_;
-- ALTER TABLE public.medicamento_brasindice VALIDATE CONSTRAINT fk_medicamento_brasindice_medicamento_id_medicamentos;
-- ALTER TABLE public.medicamentos VALIDATE CONSTRAINT fk_medicamentos_laboratorio_id_laboratorios;
-- ALTER TABLE public.medicamentos VALIDATE CONSTRAINT fk_medicamentos_medicamento_edicao_id_medicamento_edicoes;
-- ALTER TABLE public.mensalidades VALIDATE CONSTRAINT fk_mensalidades_conveniado_id_conveniados;
-- ALTER TABLE public.mensalidades VALIDATE CONSTRAINT fk_mensalidades_produto_preco_id_produtos_precos;
-- ALTER TABLE public.mensalidades VALIDATE CONSTRAINT fk_mensalidades_grupo_verba_id_grupo_verbas;
-- ALTER TABLE public.motivo_encerramentos VALIDATE CONSTRAINT fk_motivo_encerramentos_id_motivo_encerramentos;
-- ALTER TABLE public.operadora_user VALIDATE CONSTRAINT fk_operadora_user_operadora_id_operadoras;
-- ALTER TABLE public.operadora_user VALIDATE CONSTRAINT fk_operadora_user_user_id_users;
-- ALTER TABLE public.permission_role VALIDATE CONSTRAINT fk_permission_role_permission_id_permissions;
-- ALTER TABLE public.permission_role VALIDATE CONSTRAINT fk_permission_role_role_id_roles;
-- ALTER TABLE public.prestador_contrato_itens VALIDATE CONSTRAINT fk_prestador_contrato_itens_prestadores_contratos_id_prestad;
-- ALTER TABLE public.prestador_contrato_itens VALIDATE CONSTRAINT fk_prestador_contrato_itens_edicao_medicamento_id_medicament;
-- ALTER TABLE public.prestador_contrato_itens VALIDATE CONSTRAINT fk_prestador_contrato_itens_tabela_precos_id_tabela_precos;
-- ALTER TABLE public.prestador_contrato_itens VALIDATE CONSTRAINT fk_prestador_contrato_itens_motivo_encerramento_id_motivo_en;
-- ALTER TABLE public.prestador_contratos VALIDATE CONSTRAINT fk_prestador_contratos_prestador_id_prestadores;
-- ALTER TABLE public.prestador_especialidades VALIDATE CONSTRAINT fk_prestador_especialidades_prestador_id_prestadores;
-- ALTER TABLE public.prestador_especialidades VALIDATE CONSTRAINT fk_prestador_especialidades_especialidade_id_especialidades;
-- ALTER TABLE public.prestador_user VALIDATE CONSTRAINT fk_prestador_user_prestador_id_prestadores;
-- ALTER TABLE public.prestador_user VALIDATE CONSTRAINT fk_prestador_user_user_id_users;
-- ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_usuario_id_users;
-- ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_prestadores_classificacao_estabelecimento_id_;
-- ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_orgao_expedidor_uf_id_estados;
-- ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_naturalidade_cidade_id_cidades;
-- ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_prestador_tipo_id_prestador_tipos;
-- ALTER TABLE public.procedimento_subgrupos VALIDATE CONSTRAINT fk_procedimento_subgrupos_grupo_id_procedimentos_grupos;
-- ALTER TABLE public.procedimentos VALIDATE CONSTRAINT fk_procedimentos_procedimento_subgrupo_id_procedimento_subgr;
-- ALTER TABLE public.produtos VALIDATE CONSTRAINT fk_produtos_operadora_id_operadoras;
-- ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT fk_produtos_precos_produto_id_produtos;
-- ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT fk_produtos_precos_tipo_vinculo_id_tipo_vinculos;
-- ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT fk_produtos_precos_grupo_verba_id_grupo_verbas;
-- ALTER TABLE public.regra_cooparticipacao VALIDATE CONSTRAINT fk_regra_cooparticipacao_produto_id_produtos;
-- ALTER TABLE public.regra_cooparticipacao_itens VALIDATE CONSTRAINT fk_regra_cooparticipacao_itens_regra_cooparticipacao_id_regr;
-- ALTER TABLE public.regra_cooparticipacao_procedimentos VALIDATE CONSTRAINT fk_regra_cooparticipacao_procedimentos_regra_cooparticipacao;
-- ALTER TABLE public.regra_cooparticipacao_procedimentos VALIDATE CONSTRAINT fk_regra_cooparticipacao_procedimentos_grupo_procedimento_id;
-- ALTER TABLE public.regra_cooparticipacao_procedimentos VALIDATE CONSTRAINT fk_regra_cooparticipacao_procedimentos_subgrupo_procedimento;
-- ALTER TABLE public.regra_cooparticipacao_procedimentos VALIDATE CONSTRAINT fk_regra_cooparticipacao_procedimentos_procedimento_id_proce;
-- ALTER TABLE public.remessa_desconto VALIDATE CONSTRAINT fk_remessa_desconto_empresa_id_empresas;
-- ALTER TABLE public.remessa_desconto_item VALIDATE CONSTRAINT fk_remessa_desconto_item_remessa_desconto_id_remessa_descont;
-- ALTER TABLE public.remessa_desconto_item VALIDATE CONSTRAINT fk_remessa_desconto_item_adesao_id_adesoes;
-- ALTER TABLE public.role_user VALIDATE CONSTRAINT fk_role_user_user_id_users;
-- ALTER TABLE public.role_user VALIDATE CONSTRAINT fk_role_user_role_id_roles;
-- ALTER TABLE public.secretarias VALIDATE CONSTRAINT fk_secretarias_empresa_id_empresas;
-- ALTER TABLE public.solicitacoes_atualizacao_cadastral VALIDATE CONSTRAINT fk_solicitacoes_atualizacao_cadastral_prestador_id_prestador;
-- ALTER TABLE public.solicitacoes_atualizacao_cadastral VALIDATE CONSTRAINT fk_solicitacoes_atualizacao_cadastral_conveniado_id_convenia;
-- ALTER TABLE public.solicitacoes_atualizacao_cadastral VALIDATE CONSTRAINT fk_solicitacoes_atualizacao_cadastral_cidade_id_cidades;
-- ALTER TABLE public.solicitacoes_credenciamento VALIDATE CONSTRAINT fk_solicitacoes_credenciamento_edital_credenciamento_id_edit;
-- ALTER TABLE public.solicitacoes_credenciamento_documentos VALIDATE CONSTRAINT fk_solicitacoes_credenciamento_documentos_solicitacoes_crede;
-- ALTER TABLE public.solicitacoes_credenciamento_documentos VALIDATE CONSTRAINT fk_solicitacoes_credenciamento_documentos_documento_credenci;
-- ALTER TABLE public.tabela_precos VALIDATE CONSTRAINT fk_tabela_precos_comunicado_edicao_id_comunicado_edicoes;
-- ALTER TABLE public.tabela_precos VALIDATE CONSTRAINT fk_tabela_precos_cbhpm_edicao_id_cbhpm_edicoes;
-- ALTER TABLE public.tabela_precos VALIDATE CONSTRAINT fk_tabela_precos_material_edicao_id_material_edicoes;
-- ALTER TABLE public.tabela_precos_itens VALIDATE CONSTRAINT fk_tabela_precos_itens_tabela_preco_id_tabela_precos;
-- ALTER TABLE public.conveniados VALIDATE CONSTRAINT chk_conveniados_sexo;
-- ALTER TABLE public.conveniados VALIDATE CONSTRAINT chk_conveniados_estado_civil;
-- ALTER TABLE public.conveniados VALIDATE CONSTRAINT chk_conveniados_pcd;
-- ALTER TABLE public.adesoes VALIDATE CONSTRAINT chk_adesoes_tipo_cliente;
-- ALTER TABLE public.adesoes VALIDATE CONSTRAINT chk_adesoes_status;
-- ALTER TABLE public.boletos VALIDATE CONSTRAINT chk_boletos_valor_original;
-- ALTER TABLE public.boletos VALIDATE CONSTRAINT chk_boletos_status;
-- ALTER TABLE public.lancamentos VALIDATE CONSTRAINT chk_lancamentos_valor;
-- ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT chk_produtos_precos_idade;
-- ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT chk_produtos_precos_valor;
-- ALTER TABLE public.guias_itens VALIDATE CONSTRAINT chk_guias_itens_quantidades;
-- ALTER TABLE public.users VALIDATE CONSTRAINT chk_users_email_format;

-- ============================================================
-- Relações ignoradas automaticamente por ausência de tabela/coluna
-- ============================================================

-- ============================================================
-- SECAO: 00 - EXTENSOES (opcional)
-- Arquivo: sql_execucao_servsaude/00_extensoes_opcional.sql
-- ============================================================

-- ============================================================
-- ServSaude - 00 - extensoes opcionais
-- Execute apenas se o projeto realmente precisar dessas extensoes.
-- No Supabase, prefira instalar extensoes pelo painel quando possivel.
-- ============================================================

CREATE SCHEMA IF NOT EXISTS extensions;

-- Use o schema extensions para evitar conflito com funcoes no public.
CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA extensions;


-- ============================================================
-- SECAO: 01 - SCHEMA BASE
-- Arquivo: sql_execucao_servsaude/01_schema_base.sql
-- ============================================================

﻿-- ============================================================
-- ServSaude - 01 - schema base, tabelas, PKs e extensao
-- Origem: servsaude_schema_completo_fks_validacoes.sql
-- Execute conforme a numeracao do arquivo.
-- ============================================================

-- ============================================================
-- ServSaÃºde â€” Schema completo corrigido + validaÃ§Ãµes + FKs
-- CompatÃ­vel com PostgreSQL / Supabase
-- Execute este arquivo em banco vazio ou controlado.
-- ============================================================

-- ============================================================
-- Schema corrigido â€” ServSaÃºde
-- CompatÃ­vel com PostgreSQL / Supabase
-- Gerado a partir do SQL extraÃ­do do dump legado
-- ============================================================

CREATE SCHEMA IF NOT EXISTS public;
-- Extensao unaccent removida do schema base para evitar conflito em bancos
-- onde a extensao/funcoes ja existem com assinaturas diferentes.
-- Execute 00_extensoes_opcional.sql somente se precisar usar unaccent.

-- ============================================================
-- Tabela: public.adesao_reducao_margem
-- ============================================================
CREATE TABLE IF NOT EXISTS public.adesao_reducao_margem (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    adesao_id bigint NOT NULL,
    tipo_reducao integer NOT NULL,
    valor numeric(8,2) NOT NULL,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.adesoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.adesoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    operadora_id bigint NOT NULL,
    empresa_id bigint,
    secretaria_id bigint,
    conveniado_id bigint NOT NULL,
    grupo_familiar integer,
    produto_id bigint NOT NULL,
    produto_preco_id bigint,
    matricula character varying(255),
    tipo_cliente integer NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    data_inicio date NOT NULL,
    data_fim date,
    data_primeiro_pgto date,
    justificativa_encerramento character varying(255),
    dv character varying(255),
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    salario_atual numeric(13,2),
    motivo_encerramento_id integer
);

-- ============================================================
-- Tabela: public.bancos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.bancos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.boleto_lancamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.boleto_lancamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    boleto_id bigint NOT NULL,
    lancamento_id bigint NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.boletos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.boletos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    operadora_id bigint NOT NULL,
    data_emissao date NOT NULL,
    data_vencimento date NOT NULL,
    valor_original numeric(8,2) NOT NULL,
    nosso_numero integer NOT NULL,
    numero_titulo_cliente character varying(255),
    agencia character varying(255),
    conta character varying(255),
    endereco character varying(255),
    cidade character varying(255),
    uf character varying(255),
    indicador_permissao_recebimento_parcial character varying(255) DEFAULT 'N'::character varying NOT NULL,
    indicador_pix character varying(255) DEFAULT 'S'::character varying NOT NULL,
    pagador_tipo_inscricao character varying(255) NOT NULL,
    pagador_numero_inscricao character varying(255) NOT NULL,
    pagador_nome character varying(255) NOT NULL,
    pagador_endereco character varying(255) NOT NULL,
    pagador_cep character varying(255) NOT NULL,
    pagador_cidade_id bigint NOT NULL,
    pagador_bairro character varying(255) NOT NULL,
    demonstrativo text,
    desconto_tipo integer DEFAULT 0 NOT NULL,
    desconto_data_expiracao date,
    desconto_porcentagem numeric(8,2),
    desconto_valor numeric(8,2),
    multa_tipo integer DEFAULT 0 NOT NULL,
    multa_data date,
    multa_porcentagem numeric(8,2),
    multa_valor numeric(8,2),
    juros_tipo integer DEFAULT 0 NOT NULL,
    juros_porcentagem numeric(8,2),
    juros_valor numeric(8,2),
    pix_qrcode character varying(255),
    instrucoes1 character varying(255),
    instrucoes2 character varying(255),
    instrucoes3 character varying(255),
    instrucoes4 character varying(255),
    status integer DEFAULT 1 NOT NULL,
    codigo_estado_titulo integer DEFAULT 1 NOT NULL,
    error_message text,
    data_baixa date,
    boleto text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.canais_atendimento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.canais_atendimento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    telefone character varying(255),
    email character varying(255),
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.cargos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cargos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.cbhpm
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cbhpm (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    cbhpm_edicao_id bigint NOT NULL,
    procedimento_id bigint NOT NULL,
    codigo_porte character varying(255) NOT NULL,
    fracao_porte numeric(8,2) DEFAULT '1'::numeric,
    qtde_uco numeric(13,3) NOT NULL,
    qtde_filme numeric(13,3) NOT NULL,
    porte_anestesico_id bigint,
    nro_auxiliares integer,
    incidencia integer,
    ur boolean DEFAULT false NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.cbhpm_edicoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cbhpm_edicoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    ano_edicao integer NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.cid
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cid (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    sexo_aplicavel character varying(255) NOT NULL,
    grave boolean DEFAULT false NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.cidades
-- ============================================================
CREATE TABLE IF NOT EXISTS public.cidades (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    estado_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.comunicado_edicoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.comunicado_edicoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    ano_edicao integer NOT NULL,
    uco numeric(8,2) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.comunicado_portes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.comunicado_portes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    comunicado_edicao_id bigint NOT NULL,
    codigo_porte character varying(255) NOT NULL,
    valor numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.contrato_profissionais
-- ============================================================
CREATE TABLE IF NOT EXISTS public.contrato_profissionais (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    contrato_id bigint NOT NULL,
    prestador_id bigint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.conveniado_salarios
-- ============================================================
CREATE TABLE IF NOT EXISTS public.conveniado_salarios (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    conveniado_id bigint NOT NULL,
    salario numeric(8,2) NOT NULL,
    data_competencia date NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.conveniados
-- ============================================================
CREATE TABLE IF NOT EXISTS public.conveniados (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    orgao_expedidor_uf_id bigint,
    naturalidade_cidade_id bigint NOT NULL,
    usuario_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date NOT NULL,
    sexo smallint NOT NULL,
    rg character varying(255),
    orgao_expedidor character varying(255),
    cns character varying(255),
    nome_pai character varying(255),
    nome_mae character varying(255) NOT NULL,
    fone1 character varying(255),
    fone2 character varying(255),
    email character varying(255),
    foto text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    estado_civil integer DEFAULT 1 NOT NULL,
    pcd integer DEFAULT 2 NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    cargo_id integer
);

-- ============================================================
-- Tabela: public.dados_bancarios
-- ============================================================
CREATE TABLE IF NOT EXISTS public.dados_bancarios (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    origem_id bigint NOT NULL,
    tabela character varying(255) NOT NULL,
    banco_id bigint NOT NULL,
    tipo smallint NOT NULL,
    agencia character varying(255),
    agencia_dv character varying(255),
    conta character varying(255),
    conta_dv character varying(255),
    operacao character varying(255),
    pix character varying(255),
    pix_tipo character varying(255),
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.deflatores
-- ============================================================
CREATE TABLE IF NOT EXISTS public.deflatores (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    prestadores_contratos_id bigint NOT NULL,
    procedimento_grupo_id bigint NOT NULL,
    tipo smallint NOT NULL,
    percentual numeric(8,2) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.documentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.documentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo integer NOT NULL,
    tabela text,
    origem_id integer,
    documento text,
    descricao text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.documentos_credenciamento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.documentos_credenciamento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    complemento_descricao character varying(255),
    obrigatorio boolean DEFAULT true NOT NULL,
    active boolean DEFAULT true NOT NULL,
    tipo_pessoa integer DEFAULT 1 NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.editais_credenciamento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.editais_credenciamento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.edital_credenciamento_documentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.edital_credenciamento_documentos (
    edital_id bigint NOT NULL,
    documento_credenciamento_id bigint NOT NULL,
    obrigatorio boolean DEFAULT false NOT NULL,
    updated_at timestamptz DEFAULT '2024-04-22 07:40:35'::timestamp without time zone NOT NULL,
    PRIMARY KEY (edital_id, documento_credenciamento_id)
);

-- ============================================================
-- Tabela: public.empresa_produto
-- ============================================================
CREATE TABLE IF NOT EXISTS public.empresa_produto (
    empresa_id bigint NOT NULL,
    produto_id bigint NOT NULL,
    PRIMARY KEY (empresa_id, produto_id)
);

-- ============================================================
-- Tabela: public.empresa_user
-- ============================================================
CREATE TABLE IF NOT EXISTS public.empresa_user (
    user_id bigint NOT NULL,
    empresa_id bigint NOT NULL,
    PRIMARY KEY (user_id, empresa_id)
);

-- ============================================================
-- Tabela: public.empresas
-- ============================================================
CREATE TABLE IF NOT EXISTS public.empresas (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo smallint NOT NULL,
    cpf_cnpj character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    abreviado text,
    fone character varying(255),
    email character varying(255),
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    contato character varying(255),
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.empresas_verbas
-- ============================================================
CREATE TABLE IF NOT EXISTS public.empresas_verbas (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    empresa_id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    grupo_verba_id bigint
);

-- ============================================================
-- Tabela: public.enderecos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.enderecos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    cidade_id bigint NOT NULL,
    tabela text,
    origem_id integer,
    tipo integer NOT NULL,
    cep text NOT NULL,
    endereco text NOT NULL,
    numero text,
    complemento text,
    bairro text,
    "default" boolean DEFAULT false NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.especialidades
-- ============================================================
CREATE TABLE IF NOT EXISTS public.especialidades (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    cbo character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.estados
-- ============================================================
CREATE TABLE IF NOT EXISTS public.estados (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    uf character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.failed_jobs
-- ============================================================
CREATE TABLE IF NOT EXISTS public.failed_jobs (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- ============================================================
-- Tabela: public.fiscal_contrato_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.fiscal_contrato_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    fiscal_contrato_id bigint NOT NULL,
    contrato_id bigint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.fiscal_contratos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.fiscal_contratos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    usuario_id bigint NOT NULL,
    data_inicio date DEFAULT CURRENT_DATE NOT NULL,
    data_fim date NOT NULL,
    portaria character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.gestantes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.gestantes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    conveniado_id bigint NOT NULL,
    data_inicio_gestacao date DEFAULT CURRENT_DATE NOT NULL,
    data_final_gestacao date,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.grau_parentesco
-- ============================================================
CREATE TABLE IF NOT EXISTS public.grau_parentesco (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.grupo_verbas
-- ============================================================
CREATE TABLE IF NOT EXISTS public.grupo_verbas (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guia_importacoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guia_importacoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    sequencial_transacao integer NOT NULL,
    lote integer NOT NULL,
    data_hora_arquivo timestamptz NOT NULL,
    prestador_id bigint,
    usuario_id bigint,
    versao_layout character varying(255) NOT NULL,
    arquivo character varying(255) NOT NULL,
    disco character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guia_motivo_encerramento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guia_motivo_encerramento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    termo character varying(255) NOT NULL,
    data_inicio_vigencia date,
    data_fim_vigencia date,
    data_fim_implantacao date,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guias
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    usuario_emissor_id bigint,
    prestador_id bigint,
    profissional_id bigint,
    conveniado_id bigint,
    solicitante_prestador_id bigint,
    lote_pagamento_id bigint,
    tipo_lancamento smallint DEFAULT '1'::smallint NOT NULL,
    tipo_autorizacao smallint DEFAULT '1'::smallint NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    carater_atendimento smallint DEFAULT '1'::smallint NOT NULL,
    guia_origem_id bigint,
    indicacao_clinica character varying(255),
    observacoes character varying(255),
    observacoes_internas character varying(255),
    urgente boolean DEFAULT false NOT NULL,
    conferido boolean DEFAULT false NOT NULL,
    status smallint DEFAULT '1'::smallint NOT NULL,
    data_hora_cancalamento timestamptz,
    cancelado_por_user_id bigint,
    motivo_cancelamento character varying(255),
    justifica_para_auditoria character varying(255),
    guia_importacao_id bigint,
    lote_importacao integer,
    numero_guia_prestador integer,
    data_autorizacao date,
    senha integer,
    data_validade_senha date,
    atendimento_rn character varying(255),
    cnes integer,
    tipo_faturamento integer,
    data_inicio_faturamento date,
    data_final_faturamento date,
    tipo_internacao integer,
    regime_internacao integer,
    diagnostico character varying(255),
    indicador_acidente integer,
    motivo_encerramento integer,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    tipo_autenticacao smallint,
    codigo_autenticacao character varying(255),
    autenticada boolean DEFAULT false NOT NULL
);

-- ============================================================
-- Tabela: public.guias_anexos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_anexos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    guia_id bigint,
    nome character varying(255),
    arquivo character varying(255),
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guias_atendimentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_atendimentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    guia_itens_id bigint,
    quantidade numeric(8,2),
    usuario_id bigint,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.guias_auditoria
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_auditoria (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora_analise timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    guia_itens_id bigint NOT NULL,
    quantidade_autorizada numeric(8,2) NOT NULL,
    justificativa character varying(255),
    analise_usuario_id bigint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guias_historico
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_historico (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    guia_id bigint NOT NULL,
    guia_item_id bigint,
    historico character varying(255) NOT NULL,
    usuario_id bigint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.guias_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.guias_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora_emissao timestamptz DEFAULT '2024-03-06 09:46:05'::timestamp without time zone NOT NULL,
    data_hora_autorizacao timestamptz,
    data_hora_atendimento timestamptz,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    guia_id bigint,
    referencia_tabela character varying(255) NOT NULL,
    referencia_id integer,
    quantidade_solicitada numeric(8,2),
    quantidade_atendida numeric(8,2),
    quantidade_glosa numeric(8,2),
    valor_unitario numeric(8,2),
    valor_unitario_glosa numeric(8,2),
    percentual_cooparticipacao numeric(8,2),
    valor_unitario_coparticipacao numeric(8,2),
    valor_total_coparticipacao numeric(8,2),
    percentual_item numeric(8,2),
    quantidade_faturada numeric(8,2),
    valor_unitario_faturado numeric(8,2),
    valor_total_faturado numeric(8,2),
    status smallint DEFAULT '1'::smallint NOT NULL,
    data_execucao date,
    hora_inicial time(0) without time zone,
    hora_final time(0) without time zone,
    codigo_tabela integer,
    codigo_despesa integer,
    codigo_procedimento character varying(255),
    quantidade_autorizada numeric(8,2),
    reducao_acrescimo numeric(8,2),
    valor_total numeric(8,2),
    grau_part integer,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.historico_credenciamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.historico_credenciamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    solicitacao_credencimento_id bigint NOT NULL,
    user_id bigint NOT NULL,
    motivo character varying(255) NOT NULL,
    status integer NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.laboratorios
-- ============================================================
CREATE TABLE IF NOT EXISTS public.laboratorios (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.lancamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.lancamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    boleto_id integer,
    operadora_id bigint NOT NULL,
    prestador_id bigint,
    conveniado_id bigint,
    tipo_lancamento smallint DEFAULT '2'::smallint NOT NULL,
    data_hora timestamptz DEFAULT '2024-01-19 13:56:01'::timestamp without time zone NOT NULL,
    data_vencimento timestamptz NOT NULL,
    data_baixa timestamptz,
    tipo_pagamento smallint DEFAULT '1'::smallint NOT NULL,
    competencia_folha character varying(255),
    descricao character varying(255),
    valor numeric(8,2) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    grupo_verba_id bigint
);

-- ============================================================
-- Tabela: public.lancamentos_guias
-- ============================================================
CREATE TABLE IF NOT EXISTS public.lancamentos_guias (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    lancamento_id bigint NOT NULL,
    guia_id bigint NOT NULL,
    valor numeric(8,2) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.log_acessos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.log_acessos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz,
    usuario_id integer,
    usuario_nome text,
    ip text,
    navegador text,
    recurso text,
    registro_id integer,
    url character varying(255),
    action smallint,
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.log_operacoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.log_operacoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_hora timestamptz,
    usuario_id integer,
    usuario_nome text,
    ip text,
    navegador text,
    recurso text,
    registro_id integer,
    log text,
    action smallint,
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.lote_pagamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.lote_pagamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    prestador_id bigint NOT NULL,
    usuario_id bigint NOT NULL,
    lancamento_id bigint,
    data_hora timestamptz NOT NULL,
    referencia_pagamento date NOT NULL,
    status smallint DEFAULT '1'::smallint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.materiais
-- ============================================================
CREATE TABLE IF NOT EXISTS public.materiais (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo integer NOT NULL,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.materiais_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.materiais_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    material_edicao_id bigint NOT NULL,
    material_id bigint NOT NULL,
    valor numeric(8,2) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.material_edicoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.material_edicoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    edicao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.medicamento_brasindice
-- ============================================================
CREATE TABLE IF NOT EXISTS public.medicamento_brasindice (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    medicamento_edicao_id bigint NOT NULL,
    medicamento_id bigint NOT NULL,
    pmc numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    pfab numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    fracao_pfab numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    fracao_pmc numeric(15,2) DEFAULT '0'::numeric NOT NULL
);

-- ============================================================
-- Tabela: public.medicamento_edicoes
-- ============================================================
CREATE TABLE IF NOT EXISTS public.medicamento_edicoes (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    edicao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.medicamentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.medicamentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    laboratorio_id bigint NOT NULL,
    medicamento_edicao_id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    bras character varying(255) NOT NULL,
    in_ character varying(255) NOT NULL,
    dice character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    apresentacao character varying(255) NOT NULL,
    qtde_embalagem integer NOT NULL,
    ultima_versao integer NOT NULL,
    ean character varying(255) NOT NULL,
    ggrem character varying(255) NOT NULL,
    anvisa character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.mensagens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.mensagens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    perfil_id bigint,
    tipo integer NOT NULL,
    titulo character varying(255) NOT NULL,
    corpo text NOT NULL,
    idade_inicial integer,
    idade_final integer,
    data_inicial_exibicao date,
    data_final_exibicao date,
    visivel boolean DEFAULT true NOT NULL,
    fixado boolean DEFAULT false NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.mensalidades
-- ============================================================
CREATE TABLE IF NOT EXISTS public.mensalidades (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    conveniado_id bigint NOT NULL,
    competencia date NOT NULL,
    produto_preco_id bigint NOT NULL,
    grupo_verba_id bigint,
    salario numeric(8,2) NOT NULL,
    percentual numeric(8,2) NOT NULL,
    valor numeric(8,2) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.menus
-- ============================================================
CREATE TABLE IF NOT EXISTS public.menus (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(255) NOT NULL,
    is_divisor boolean DEFAULT false NOT NULL,
    parameter character varying(255),
    link character varying(255),
    permission character varying(255),
    fixed_id integer,
    parent_id integer,
    icon_family character varying(255),
    icon character varying(255),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.migrations
-- ============================================================
CREATE TABLE IF NOT EXISTS public.migrations (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);

-- ============================================================
-- Tabela: public.motivo_encerramentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.motivo_encerramentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    motivo character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    tipo smallint DEFAULT '1'::smallint NOT NULL
);

-- ============================================================
-- Tabela: public.operadora_user
-- ============================================================
CREATE TABLE IF NOT EXISTS public.operadora_user (
    operadora_id bigint NOT NULL,
    user_id bigint NOT NULL,
    PRIMARY KEY (operadora_id, user_id)
);

-- ============================================================
-- Tabela: public.operadoras
-- ============================================================
CREATE TABLE IF NOT EXISTS public.operadoras (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    tipo smallint NOT NULL,
    cpf_cnpj character varying(255) NOT NULL,
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    fone character varying(255),
    email character varying(255),
    certificado character varying(255),
    senha_certificado character varying(255),
    codigo_ans character varying(6),
    tipo_declarante integer NOT NULL,
    cpf_responsavel character varying(255) NOT NULL,
    indicador_situacao_declaracao character varying(255) NOT NULL,
    cnes character varying(7),
    ativo boolean DEFAULT true NOT NULL,
    percentual_max_desconto_coparticipacao numeric(8,2) DEFAULT 24.9 NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    boleto_nr_convenio integer,
    boleto_nr_carteira integer,
    boleto_nr_variacao_carteira integer,
    boleto_nr_controle integer,
    boleto_client_id character varying(255),
    boleto_client_secret text,
    boleto_gw_dev_app_key character varying(255),
    boleto_recebimento_parcial character varying(255) DEFAULT 'N'::character varying NOT NULL,
    boleto_indicador_pix character varying(255) DEFAULT 'S'::character varying NOT NULL,
    boleto_multa_tipo integer DEFAULT 0 NOT NULL,
    boleto_multa_dias_apos_vencimento integer DEFAULT 1,
    boleto_multa_porcentagem numeric(8,2),
    boleto_multa_valor numeric(8,2),
    boleto_juros_tipo integer DEFAULT 0 NOT NULL,
    boleto_juros_porcentagem numeric(8,2),
    boleto_juros_valor numeric(8,2),
    boleto_ambiente integer DEFAULT 1,
    boleto_cancelar_dias_apos_vencimento integer,
    boleto_forma_pagamento_apos_cancelar integer
);

-- ============================================================
-- Tabela: public.parametros
-- ============================================================
CREATE TABLE IF NOT EXISTS public.parametros (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    parameter character varying(255) NOT NULL,
    field_label character varying(255) NOT NULL,
    component text,
    value character varying(255),
    possible_values character varying(255),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.permission_role
-- ============================================================
CREATE TABLE IF NOT EXISTS public.permission_role (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL,
    PRIMARY KEY (permission_id, role_id)
);

-- ============================================================
-- Tabela: public.permissions
-- ============================================================
CREATE TABLE IF NOT EXISTS public.permissions (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    module character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    description character varying(255)
);

-- ============================================================
-- Tabela: public.personal_access_tokens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.personal_access_tokens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.porte_anestesicos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.porte_anestesicos (
    porte_anestesico character varying(255) DEFAULT '0'::character varying NOT NULL,
    porte character varying(255),
    PRIMARY KEY (porte_anestesico)
);

-- ============================================================
-- Tabela: public.prestador_contrato_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_contrato_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    prestadores_contratos_id bigint NOT NULL,
    edicao_medicamento_id bigint NOT NULL,
    acrescimo_medicamentos numeric(8,2),
    tabela_precos_id bigint,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    tipo smallint NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    orcamento_previsto numeric(8,2),
    motivo_encerramento_id bigint,
    data_encerramento timestamptz
);

-- ============================================================
-- Tabela: public.prestador_contratos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_contratos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    prestador_id bigint NOT NULL,
    data date NOT NULL,
    codigo character varying(255) NOT NULL,
    ocorrencia character varying(255),
    objeto character varying(255) NOT NULL,
    observacoes character varying(255),
    reclamacoes character varying(255),
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.prestador_especialidades
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_especialidades (
    prestador_id bigint NOT NULL,
    especialidade_id bigint NOT NULL,
    PRIMARY KEY (prestador_id, especialidade_id)
);

-- ============================================================
-- Tabela: public.prestador_tipos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_tipos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.prestador_user
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestador_user (
    prestador_id bigint NOT NULL,
    user_id bigint NOT NULL,
    PRIMARY KEY (prestador_id, user_id)
);

-- ============================================================
-- Tabela: public.prestadores
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestadores (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    usuario_id bigint,
    prestadores_classificacao_estabelecimento_id bigint NOT NULL,
    orgao_expedidor_uf_id bigint,
    naturalidade_cidade_id bigint,
    tipo smallint NOT NULL,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    abreviado text,
    cpf_cnpj character varying(255) NOT NULL,
    data_nascimento date,
    rg character varying(255),
    orgao_expedidor character varying(255),
    nome_mae character varying(255),
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    fone character varying(255),
    email character varying(255),
    financeiro_contato_nome character varying(255),
    financeiro_contato_fone character varying(255),
    financeiro_contato_email character varying(255),
    faturamento_contato_nome character varying(255),
    faturamento_contato_fone character varying(255),
    faturamento_contato_email character varying(255),
    tipo_conselho_classe smallint,
    numero_conselho_classe character varying(255),
    procedimentos boolean DEFAULT false NOT NULL,
    material boolean DEFAULT false NOT NULL,
    taxa boolean DEFAULT false NOT NULL,
    medicamentos boolean DEFAULT false NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    prestador_tipo_id integer
);

-- ============================================================
-- Tabela: public.prestadores_classificacao_estabelecimento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.prestadores_classificacao_estabelecimento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    codigo character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.procedimento_subgrupos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.procedimento_subgrupos (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    grupo_id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    perc_reducao_segundo_procedimento numeric(8,2) NOT NULL,
    perc_reducao_terceiro_procedimento_em_diante numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.procedimentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.procedimentos (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo text NOT NULL,
    procedimento_subgrupo_id integer,
    descricao text,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.procedimentos_grupos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.procedimentos_grupos (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.produtos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.produtos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    operadora_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    abrangencia smallint NOT NULL,
    tipo_contratacao integer NOT NULL,
    tipo_carencia smallint NOT NULL,
    tipo_acomodacao integer NOT NULL,
    data_inicio date NOT NULL,
    data_fim date,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.produtos_precos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.produtos_precos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    produto_id bigint NOT NULL,
    tipo_vinculo_id bigint,
    idade_inicial integer NOT NULL,
    idade_final integer NOT NULL,
    tipo_cobranca integer NOT NULL,
    tipo_cliente integer NOT NULL,
    descricao character varying(255) NOT NULL,
    valor numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    grupo_verba_id bigint
);

-- ============================================================
-- Tabela: public.regra_cooparticipacao
-- ============================================================
CREATE TABLE IF NOT EXISTS public.regra_cooparticipacao (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    produto_id bigint NOT NULL,
    nome text NOT NULL,
    tempo_carencia integer,
    carencia boolean NOT NULL,
    sem_limite_para_gestante boolean DEFAULT false NOT NULL,
    auditoria boolean NOT NULL,
    ativo boolean NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.regra_cooparticipacao_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.regra_cooparticipacao_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    regra_cooparticipacao_id bigint NOT NULL,
    qtde_inicial integer NOT NULL,
    qtde_final integer NOT NULL,
    percentual_cooparticipacao numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.regra_cooparticipacao_procedimentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.regra_cooparticipacao_procedimentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    regra_cooparticipacao_id bigint NOT NULL,
    grupo_procedimento_id integer NOT NULL,
    subgrupo_procedimento_id integer,
    procedimento_id integer,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Tabela: public.remessa_desconto
-- ============================================================
CREATE TABLE IF NOT EXISTS public.remessa_desconto (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    empresa_id bigint NOT NULL,
    competencia date NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.remessa_desconto_item
-- ============================================================
CREATE TABLE IF NOT EXISTS public.remessa_desconto_item (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    remessa_desconto_id bigint NOT NULL,
    adesao_id bigint NOT NULL,
    matricula character varying(255) NOT NULL,
    salario numeric(8,2) NOT NULL,
    desconto_maximo numeric(8,2) NOT NULL,
    valor_divida numeric(8,2) NOT NULL,
    coparticipacao numeric(8,2) NOT NULL,
    codigo_evento character varying(255) NOT NULL,
    valor numeric(8,2) NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.role_user
-- ============================================================
CREATE TABLE IF NOT EXISTS public.role_user (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL,
    PRIMARY KEY (user_id, role_id)
);

-- ============================================================
-- Tabela: public.roles
-- ============================================================
CREATE TABLE IF NOT EXISTS public.roles (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.secretarias
-- ============================================================
CREATE TABLE IF NOT EXISTS public.secretarias (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    empresa_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    cpf_cnpj character varying(255),
    inscricao_municipal character varying(255),
    inscricao_estadual character varying(255),
    fone character varying(255),
    email character varying(255),
    contato character varying(255),
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz,
    abreviado character varying(255)
);

-- ============================================================
-- Tabela: public.solicitacoes_atualizacao_cadastral
-- ============================================================
CREATE TABLE IF NOT EXISTS public.solicitacoes_atualizacao_cadastral (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_solicitacao date DEFAULT CURRENT_DATE NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    prestador_id bigint,
    conveniado_id bigint,
    cidade_id bigint NOT NULL,
    endereco character varying(255),
    endereco_nro character varying(255),
    complemento character varying(255),
    bairro character varying(255),
    cep character varying(255),
    email character varying(255),
    telefone character varying(255),
    celular character varying(255),
    observacoes character varying(255),
    comprovante_endereco character varying(255),
    foto character varying(255),
    disk character varying(255),
    status smallint DEFAULT '1'::smallint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.solicitacoes_credenciamento
-- ============================================================
CREATE TABLE IF NOT EXISTS public.solicitacoes_credenciamento (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    edital_credenciamento_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    tipo integer DEFAULT 1 NOT NULL,
    cpf_cnpj character varying(255) NOT NULL,
    responsavel character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.solicitacoes_credenciamento_documentos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.solicitacoes_credenciamento_documentos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    solicitacoes_credenciamento_id bigint NOT NULL,
    documento_credenciamento_id bigint NOT NULL,
    arquivo text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    nome_arquivo character varying(255)
);

-- ============================================================
-- Tabela: public.tabela_precos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.tabela_precos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome character varying(255) NOT NULL,
    comunicado_edicao_id bigint NOT NULL,
    cbhpm_edicao_id bigint NOT NULL,
    material_edicao_id bigint NOT NULL,
    valor_uco numeric(8,2) NOT NULL,
    valor_filme numeric(8,2) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.tabela_precos_itens
-- ============================================================
CREATE TABLE IF NOT EXISTS public.tabela_precos_itens (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tabela_preco_id bigint NOT NULL,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    referencia_id integer NOT NULL,
    valor_porte numeric(8,2) NOT NULL,
    fracao_porte numeric(8,2) NOT NULL,
    qtde_uco numeric(8,2) NOT NULL,
    valor_uco numeric(8,2) NOT NULL,
    qtde_filme numeric(8,2) NOT NULL,
    valor_filme numeric(8,2) NOT NULL,
    valor_total numeric(8,2) NOT NULL,
    valor_customizado numeric(8,2),
    valor_final numeric(8,2) NOT NULL,
    preco_customizado boolean DEFAULT false NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.taxas
-- ============================================================
CREATE TABLE IF NOT EXISTS public.taxas (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo character varying(255) NOT NULL,
    descricao character varying(255),
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.tipo_vinculos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.tipo_vinculos (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo smallint DEFAULT '1'::smallint NOT NULL,
    descricao text NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    deleted_at timestamptz,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ============================================================
-- Tabela: public.users
-- ============================================================
CREATE TABLE IF NOT EXISTS public.users (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(255) NOT NULL,
    email text,
    password character varying(255) NOT NULL,
    fone character varying(255),
    cpf character varying(255),
    forget_token text,
    foto text,
    disk character varying(255) DEFAULT 'public'::character varying NOT NULL,
    active boolean DEFAULT true NOT NULL,
    colaborador boolean DEFAULT false NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    deleted_at timestamptz
);

-- ============================================================
-- Ãndices auxiliares recomendados
-- ============================================================



-- ============================================================
-- SECAO: 02 - INDICES AUXILIARES
-- Arquivo: sql_execucao_servsaude/02_indices_auxiliares.sql
-- ============================================================

﻿-- ============================================================
-- ServSaude - 02 - indices auxiliares recomendados
-- Origem: servsaude_schema_completo_fks_validacoes.sql
-- Execute conforme a numeracao do arquivo.
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_adesao_reducao_margem_adesao_id ON public.adesao_reducao_margem (adesao_id);
CREATE INDEX IF NOT EXISTS idx_adesao_reducao_margem_deleted_at ON public.adesao_reducao_margem (deleted_at);
CREATE INDEX IF NOT EXISTS idx_adesao_reducao_margem_created_at ON public.adesao_reducao_margem (created_at);
CREATE INDEX IF NOT EXISTS idx_adesoes_operadora_id ON public.adesoes (operadora_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_empresa_id ON public.adesoes (empresa_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_secretaria_id ON public.adesoes (secretaria_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_conveniado_id ON public.adesoes (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_produto_id ON public.adesoes (produto_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_produto_preco_id ON public.adesoes (produto_preco_id);
CREATE INDEX IF NOT EXISTS idx_adesoes_status ON public.adesoes (status);
CREATE INDEX IF NOT EXISTS idx_adesoes_deleted_at ON public.adesoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_adesoes_created_at ON public.adesoes (created_at);
CREATE INDEX IF NOT EXISTS idx_adesoes_motivo_encerramento_id ON public.adesoes (motivo_encerramento_id);
CREATE INDEX IF NOT EXISTS idx_bancos_ativo ON public.bancos (ativo);
CREATE INDEX IF NOT EXISTS idx_bancos_created_at ON public.bancos (created_at);
CREATE INDEX IF NOT EXISTS idx_bancos_deleted_at ON public.bancos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_boleto_lancamentos_boleto_id ON public.boleto_lancamentos (boleto_id);
CREATE INDEX IF NOT EXISTS idx_boleto_lancamentos_lancamento_id ON public.boleto_lancamentos (lancamento_id);
CREATE INDEX IF NOT EXISTS idx_boleto_lancamentos_created_at ON public.boleto_lancamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_boletos_operadora_id ON public.boletos (operadora_id);
CREATE INDEX IF NOT EXISTS idx_boletos_pagador_cidade_id ON public.boletos (pagador_cidade_id);
CREATE INDEX IF NOT EXISTS idx_boletos_status ON public.boletos (status);
CREATE INDEX IF NOT EXISTS idx_boletos_deleted_at ON public.boletos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_boletos_created_at ON public.boletos (created_at);
CREATE INDEX IF NOT EXISTS idx_canais_atendimento_email ON public.canais_atendimento (email);
CREATE INDEX IF NOT EXISTS idx_canais_atendimento_deleted_at ON public.canais_atendimento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_canais_atendimento_created_at ON public.canais_atendimento (created_at);
CREATE INDEX IF NOT EXISTS idx_cargos_ativo ON public.cargos (ativo);
CREATE INDEX IF NOT EXISTS idx_cargos_deleted_at ON public.cargos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_cargos_created_at ON public.cargos (created_at);
CREATE INDEX IF NOT EXISTS idx_cbhpm_cbhpm_edicao_id ON public.cbhpm (cbhpm_edicao_id);
CREATE INDEX IF NOT EXISTS idx_cbhpm_procedimento_id ON public.cbhpm (procedimento_id);
CREATE INDEX IF NOT EXISTS idx_cbhpm_porte_anestesico_id ON public.cbhpm (porte_anestesico_id);
CREATE INDEX IF NOT EXISTS idx_cbhpm_deleted_at ON public.cbhpm (deleted_at);
CREATE INDEX IF NOT EXISTS idx_cbhpm_created_at ON public.cbhpm (created_at);
CREATE INDEX IF NOT EXISTS idx_cbhpm_edicoes_ativo ON public.cbhpm_edicoes (ativo);
CREATE INDEX IF NOT EXISTS idx_cbhpm_edicoes_created_at ON public.cbhpm_edicoes (created_at);
CREATE INDEX IF NOT EXISTS idx_cbhpm_edicoes_deleted_at ON public.cbhpm_edicoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_cid_created_at ON public.cid (created_at);
CREATE INDEX IF NOT EXISTS idx_cidades_estado_id ON public.cidades (estado_id);
CREATE INDEX IF NOT EXISTS idx_cidades_created_at ON public.cidades (created_at);
CREATE INDEX IF NOT EXISTS idx_cidades_deleted_at ON public.cidades (deleted_at);
CREATE INDEX IF NOT EXISTS idx_comunicado_edicoes_ativo ON public.comunicado_edicoes (ativo);
CREATE INDEX IF NOT EXISTS idx_comunicado_edicoes_created_at ON public.comunicado_edicoes (created_at);
CREATE INDEX IF NOT EXISTS idx_comunicado_edicoes_deleted_at ON public.comunicado_edicoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_comunicado_portes_comunicado_edicao_id ON public.comunicado_portes (comunicado_edicao_id);
CREATE INDEX IF NOT EXISTS idx_comunicado_portes_created_at ON public.comunicado_portes (created_at);
CREATE INDEX IF NOT EXISTS idx_comunicado_portes_deleted_at ON public.comunicado_portes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_contrato_profissionais_contrato_id ON public.contrato_profissionais (contrato_id);
CREATE INDEX IF NOT EXISTS idx_contrato_profissionais_prestador_id ON public.contrato_profissionais (prestador_id);
CREATE INDEX IF NOT EXISTS idx_contrato_profissionais_deleted_at ON public.contrato_profissionais (deleted_at);
CREATE INDEX IF NOT EXISTS idx_contrato_profissionais_created_at ON public.contrato_profissionais (created_at);
CREATE INDEX IF NOT EXISTS idx_conveniado_salarios_conveniado_id ON public.conveniado_salarios (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_conveniado_salarios_created_at ON public.conveniado_salarios (created_at);
CREATE INDEX IF NOT EXISTS idx_conveniado_salarios_deleted_at ON public.conveniado_salarios (deleted_at);
CREATE INDEX IF NOT EXISTS idx_conveniados_orgao_expedidor_uf_id ON public.conveniados (orgao_expedidor_uf_id);
CREATE INDEX IF NOT EXISTS idx_conveniados_naturalidade_cidade_id ON public.conveniados (naturalidade_cidade_id);
CREATE INDEX IF NOT EXISTS idx_conveniados_usuario_id ON public.conveniados (usuario_id);
CREATE INDEX IF NOT EXISTS idx_conveniados_cpf ON public.conveniados (cpf);
CREATE INDEX IF NOT EXISTS idx_conveniados_email ON public.conveniados (email);
CREATE INDEX IF NOT EXISTS idx_conveniados_ativo ON public.conveniados (ativo);
CREATE INDEX IF NOT EXISTS idx_conveniados_created_at ON public.conveniados (created_at);
CREATE INDEX IF NOT EXISTS idx_conveniados_deleted_at ON public.conveniados (deleted_at);
CREATE INDEX IF NOT EXISTS idx_conveniados_cargo_id ON public.conveniados (cargo_id);
CREATE INDEX IF NOT EXISTS idx_dados_bancarios_origem_id ON public.dados_bancarios (origem_id);
CREATE INDEX IF NOT EXISTS idx_dados_bancarios_banco_id ON public.dados_bancarios (banco_id);
CREATE INDEX IF NOT EXISTS idx_dados_bancarios_created_at ON public.dados_bancarios (created_at);
CREATE INDEX IF NOT EXISTS idx_dados_bancarios_deleted_at ON public.dados_bancarios (deleted_at);
CREATE INDEX IF NOT EXISTS idx_deflatores_prestadores_contratos_id ON public.deflatores (prestadores_contratos_id);
CREATE INDEX IF NOT EXISTS idx_deflatores_procedimento_grupo_id ON public.deflatores (procedimento_grupo_id);
CREATE INDEX IF NOT EXISTS idx_deflatores_deleted_at ON public.deflatores (deleted_at);
CREATE INDEX IF NOT EXISTS idx_deflatores_created_at ON public.deflatores (created_at);
CREATE INDEX IF NOT EXISTS idx_documentos_origem_id ON public.documentos (origem_id);
CREATE INDEX IF NOT EXISTS idx_documentos_deleted_at ON public.documentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_documentos_created_at ON public.documentos (created_at);
CREATE INDEX IF NOT EXISTS idx_documentos_credenciamento_active ON public.documentos_credenciamento (active);
CREATE INDEX IF NOT EXISTS idx_documentos_credenciamento_deleted_at ON public.documentos_credenciamento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_documentos_credenciamento_created_at ON public.documentos_credenciamento (created_at);
CREATE INDEX IF NOT EXISTS idx_editais_credenciamento_ativo ON public.editais_credenciamento (ativo);
CREATE INDEX IF NOT EXISTS idx_editais_credenciamento_deleted_at ON public.editais_credenciamento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_editais_credenciamento_created_at ON public.editais_credenciamento (created_at);
CREATE INDEX IF NOT EXISTS idx_edital_credenciamento_documentos_edital_id ON public.edital_credenciamento_documentos (edital_id);
CREATE INDEX IF NOT EXISTS idx_edital_credenciamento_documentos_documento_credenciamento_id ON public.edital_credenciamento_documentos (documento_credenciamento_id);
CREATE INDEX IF NOT EXISTS idx_empresa_produto_empresa_id ON public.empresa_produto (empresa_id);
CREATE INDEX IF NOT EXISTS idx_empresa_produto_produto_id ON public.empresa_produto (produto_id);
CREATE INDEX IF NOT EXISTS idx_empresa_user_user_id ON public.empresa_user (user_id);
CREATE INDEX IF NOT EXISTS idx_empresa_user_empresa_id ON public.empresa_user (empresa_id);
CREATE INDEX IF NOT EXISTS idx_empresas_cpf_cnpj ON public.empresas (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_empresas_email ON public.empresas (email);
CREATE INDEX IF NOT EXISTS idx_empresas_ativo ON public.empresas (ativo);
CREATE INDEX IF NOT EXISTS idx_empresas_created_at ON public.empresas (created_at);
CREATE INDEX IF NOT EXISTS idx_empresas_deleted_at ON public.empresas (deleted_at);
CREATE INDEX IF NOT EXISTS idx_empresas_verbas_empresa_id ON public.empresas_verbas (empresa_id);
CREATE INDEX IF NOT EXISTS idx_empresas_verbas_created_at ON public.empresas_verbas (created_at);
CREATE INDEX IF NOT EXISTS idx_empresas_verbas_deleted_at ON public.empresas_verbas (deleted_at);
CREATE INDEX IF NOT EXISTS idx_empresas_verbas_grupo_verba_id ON public.empresas_verbas (grupo_verba_id);
CREATE INDEX IF NOT EXISTS idx_enderecos_cidade_id ON public.enderecos (cidade_id);
CREATE INDEX IF NOT EXISTS idx_enderecos_origem_id ON public.enderecos (origem_id);
CREATE INDEX IF NOT EXISTS idx_enderecos_ativo ON public.enderecos (ativo);
CREATE INDEX IF NOT EXISTS idx_enderecos_created_at ON public.enderecos (created_at);
CREATE INDEX IF NOT EXISTS idx_enderecos_deleted_at ON public.enderecos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_especialidades_ativo ON public.especialidades (ativo);
CREATE INDEX IF NOT EXISTS idx_especialidades_created_at ON public.especialidades (created_at);
CREATE INDEX IF NOT EXISTS idx_especialidades_deleted_at ON public.especialidades (deleted_at);
CREATE INDEX IF NOT EXISTS idx_estados_ativo ON public.estados (ativo);
CREATE INDEX IF NOT EXISTS idx_estados_created_at ON public.estados (created_at);
CREATE INDEX IF NOT EXISTS idx_estados_deleted_at ON public.estados (deleted_at);
CREATE INDEX IF NOT EXISTS idx_fiscal_contrato_itens_fiscal_contrato_id ON public.fiscal_contrato_itens (fiscal_contrato_id);
CREATE INDEX IF NOT EXISTS idx_fiscal_contrato_itens_contrato_id ON public.fiscal_contrato_itens (contrato_id);
CREATE INDEX IF NOT EXISTS idx_fiscal_contrato_itens_deleted_at ON public.fiscal_contrato_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_fiscal_contrato_itens_created_at ON public.fiscal_contrato_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_fiscal_contratos_usuario_id ON public.fiscal_contratos (usuario_id);
CREATE INDEX IF NOT EXISTS idx_fiscal_contratos_ativo ON public.fiscal_contratos (ativo);
CREATE INDEX IF NOT EXISTS idx_fiscal_contratos_deleted_at ON public.fiscal_contratos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_fiscal_contratos_created_at ON public.fiscal_contratos (created_at);
CREATE INDEX IF NOT EXISTS idx_gestantes_conveniado_id ON public.gestantes (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_gestantes_created_at ON public.gestantes (created_at);
CREATE INDEX IF NOT EXISTS idx_gestantes_deleted_at ON public.gestantes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_grau_parentesco_ativo ON public.grau_parentesco (ativo);
CREATE INDEX IF NOT EXISTS idx_grau_parentesco_created_at ON public.grau_parentesco (created_at);
CREATE INDEX IF NOT EXISTS idx_grau_parentesco_deleted_at ON public.grau_parentesco (deleted_at);
CREATE INDEX IF NOT EXISTS idx_grupo_verbas_deleted_at ON public.grupo_verbas (deleted_at);
CREATE INDEX IF NOT EXISTS idx_grupo_verbas_created_at ON public.grupo_verbas (created_at);
CREATE INDEX IF NOT EXISTS idx_guia_importacoes_prestador_id ON public.guia_importacoes (prestador_id);
CREATE INDEX IF NOT EXISTS idx_guia_importacoes_usuario_id ON public.guia_importacoes (usuario_id);
CREATE INDEX IF NOT EXISTS idx_guia_importacoes_deleted_at ON public.guia_importacoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guia_importacoes_created_at ON public.guia_importacoes (created_at);
CREATE INDEX IF NOT EXISTS idx_guia_motivo_encerramento_deleted_at ON public.guia_motivo_encerramento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guia_motivo_encerramento_created_at ON public.guia_motivo_encerramento (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_usuario_emissor_id ON public.guias (usuario_emissor_id);
CREATE INDEX IF NOT EXISTS idx_guias_prestador_id ON public.guias (prestador_id);
CREATE INDEX IF NOT EXISTS idx_guias_profissional_id ON public.guias (profissional_id);
CREATE INDEX IF NOT EXISTS idx_guias_conveniado_id ON public.guias (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_guias_solicitante_prestador_id ON public.guias (solicitante_prestador_id);
CREATE INDEX IF NOT EXISTS idx_guias_lote_pagamento_id ON public.guias (lote_pagamento_id);
CREATE INDEX IF NOT EXISTS idx_guias_guia_origem_id ON public.guias (guia_origem_id);
CREATE INDEX IF NOT EXISTS idx_guias_status ON public.guias (status);
CREATE INDEX IF NOT EXISTS idx_guias_cancelado_por_user_id ON public.guias (cancelado_por_user_id);
CREATE INDEX IF NOT EXISTS idx_guias_guia_importacao_id ON public.guias (guia_importacao_id);
CREATE INDEX IF NOT EXISTS idx_guias_deleted_at ON public.guias (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_created_at ON public.guias (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_anexos_guia_id ON public.guias_anexos (guia_id);
CREATE INDEX IF NOT EXISTS idx_guias_anexos_deleted_at ON public.guias_anexos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_anexos_created_at ON public.guias_anexos (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_atendimentos_guia_itens_id ON public.guias_atendimentos (guia_itens_id);
CREATE INDEX IF NOT EXISTS idx_guias_atendimentos_usuario_id ON public.guias_atendimentos (usuario_id);
CREATE INDEX IF NOT EXISTS idx_guias_atendimentos_created_at ON public.guias_atendimentos (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_atendimentos_deleted_at ON public.guias_atendimentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_auditoria_guia_itens_id ON public.guias_auditoria (guia_itens_id);
CREATE INDEX IF NOT EXISTS idx_guias_auditoria_analise_usuario_id ON public.guias_auditoria (analise_usuario_id);
CREATE INDEX IF NOT EXISTS idx_guias_auditoria_deleted_at ON public.guias_auditoria (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_auditoria_created_at ON public.guias_auditoria (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_historico_guia_id ON public.guias_historico (guia_id);
CREATE INDEX IF NOT EXISTS idx_guias_historico_guia_item_id ON public.guias_historico (guia_item_id);
CREATE INDEX IF NOT EXISTS idx_guias_historico_usuario_id ON public.guias_historico (usuario_id);
CREATE INDEX IF NOT EXISTS idx_guias_historico_deleted_at ON public.guias_historico (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_historico_created_at ON public.guias_historico (created_at);
CREATE INDEX IF NOT EXISTS idx_guias_itens_guia_id ON public.guias_itens (guia_id);
CREATE INDEX IF NOT EXISTS idx_guias_itens_referencia_id ON public.guias_itens (referencia_id);
CREATE INDEX IF NOT EXISTS idx_guias_itens_status ON public.guias_itens (status);
CREATE INDEX IF NOT EXISTS idx_guias_itens_deleted_at ON public.guias_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_guias_itens_created_at ON public.guias_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_historico_credenciamentos_solicitacao_credencimento_id ON public.historico_credenciamentos (solicitacao_credencimento_id);
CREATE INDEX IF NOT EXISTS idx_historico_credenciamentos_user_id ON public.historico_credenciamentos (user_id);
CREATE INDEX IF NOT EXISTS idx_historico_credenciamentos_status ON public.historico_credenciamentos (status);
CREATE INDEX IF NOT EXISTS idx_historico_credenciamentos_created_at ON public.historico_credenciamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_laboratorios_created_at ON public.laboratorios (created_at);
CREATE INDEX IF NOT EXISTS idx_laboratorios_deleted_at ON public.laboratorios (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lancamentos_boleto_id ON public.lancamentos (boleto_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_operadora_id ON public.lancamentos (operadora_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_prestador_id ON public.lancamentos (prestador_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_conveniado_id ON public.lancamentos (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_active ON public.lancamentos (active);
CREATE INDEX IF NOT EXISTS idx_lancamentos_deleted_at ON public.lancamentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lancamentos_created_at ON public.lancamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_lancamentos_grupo_verba_id ON public.lancamentos (grupo_verba_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_guias_lancamento_id ON public.lancamentos_guias (lancamento_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_guias_guia_id ON public.lancamentos_guias (guia_id);
CREATE INDEX IF NOT EXISTS idx_lancamentos_guias_deleted_at ON public.lancamentos_guias (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lancamentos_guias_created_at ON public.lancamentos_guias (created_at);
CREATE INDEX IF NOT EXISTS idx_log_acessos_usuario_id ON public.log_acessos (usuario_id);
CREATE INDEX IF NOT EXISTS idx_log_acessos_registro_id ON public.log_acessos (registro_id);
CREATE INDEX IF NOT EXISTS idx_log_acessos_deleted_at ON public.log_acessos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_log_operacoes_usuario_id ON public.log_operacoes (usuario_id);
CREATE INDEX IF NOT EXISTS idx_log_operacoes_registro_id ON public.log_operacoes (registro_id);
CREATE INDEX IF NOT EXISTS idx_log_operacoes_deleted_at ON public.log_operacoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_prestador_id ON public.lote_pagamentos (prestador_id);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_usuario_id ON public.lote_pagamentos (usuario_id);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_lancamento_id ON public.lote_pagamentos (lancamento_id);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_status ON public.lote_pagamentos (status);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_deleted_at ON public.lote_pagamentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_lote_pagamentos_created_at ON public.lote_pagamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_materiais_deleted_at ON public.materiais (deleted_at);
CREATE INDEX IF NOT EXISTS idx_materiais_created_at ON public.materiais (created_at);
CREATE INDEX IF NOT EXISTS idx_materiais_itens_material_edicao_id ON public.materiais_itens (material_edicao_id);
CREATE INDEX IF NOT EXISTS idx_materiais_itens_material_id ON public.materiais_itens (material_id);
CREATE INDEX IF NOT EXISTS idx_materiais_itens_deleted_at ON public.materiais_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_materiais_itens_created_at ON public.materiais_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_material_edicoes_ativo ON public.material_edicoes (ativo);
CREATE INDEX IF NOT EXISTS idx_material_edicoes_deleted_at ON public.material_edicoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_material_edicoes_created_at ON public.material_edicoes (created_at);
CREATE INDEX IF NOT EXISTS idx_medicamento_brasindice_medicamento_edicao_id ON public.medicamento_brasindice (medicamento_edicao_id);
CREATE INDEX IF NOT EXISTS idx_medicamento_brasindice_medicamento_id ON public.medicamento_brasindice (medicamento_id);
CREATE INDEX IF NOT EXISTS idx_medicamento_brasindice_ativo ON public.medicamento_brasindice (ativo);
CREATE INDEX IF NOT EXISTS idx_medicamento_brasindice_created_at ON public.medicamento_brasindice (created_at);
CREATE INDEX IF NOT EXISTS idx_medicamento_edicoes_ativo ON public.medicamento_edicoes (ativo);
CREATE INDEX IF NOT EXISTS idx_medicamento_edicoes_deleted_at ON public.medicamento_edicoes (deleted_at);
CREATE INDEX IF NOT EXISTS idx_medicamento_edicoes_created_at ON public.medicamento_edicoes (created_at);
CREATE INDEX IF NOT EXISTS idx_medicamentos_laboratorio_id ON public.medicamentos (laboratorio_id);
CREATE INDEX IF NOT EXISTS idx_medicamentos_medicamento_edicao_id ON public.medicamentos (medicamento_edicao_id);
CREATE INDEX IF NOT EXISTS idx_medicamentos_deleted_at ON public.medicamentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_medicamentos_created_at ON public.medicamentos (created_at);
CREATE INDEX IF NOT EXISTS idx_mensagens_perfil_id ON public.mensagens (perfil_id);
CREATE INDEX IF NOT EXISTS idx_mensagens_deleted_at ON public.mensagens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_mensagens_created_at ON public.mensagens (created_at);
CREATE INDEX IF NOT EXISTS idx_mensalidades_conveniado_id ON public.mensalidades (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_mensalidades_produto_preco_id ON public.mensalidades (produto_preco_id);
CREATE INDEX IF NOT EXISTS idx_mensalidades_grupo_verba_id ON public.mensalidades (grupo_verba_id);
CREATE INDEX IF NOT EXISTS idx_mensalidades_deleted_at ON public.mensalidades (deleted_at);
CREATE INDEX IF NOT EXISTS idx_mensalidades_created_at ON public.mensalidades (created_at);
CREATE INDEX IF NOT EXISTS idx_menus_fixed_id ON public.menus (fixed_id);
CREATE INDEX IF NOT EXISTS idx_menus_parent_id ON public.menus (parent_id);
CREATE INDEX IF NOT EXISTS idx_menus_deleted_at ON public.menus (deleted_at);
CREATE INDEX IF NOT EXISTS idx_motivo_encerramentos_ativo ON public.motivo_encerramentos (ativo);
CREATE INDEX IF NOT EXISTS idx_motivo_encerramentos_deleted_at ON public.motivo_encerramentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_motivo_encerramentos_created_at ON public.motivo_encerramentos (created_at);
CREATE INDEX IF NOT EXISTS idx_operadora_user_operadora_id ON public.operadora_user (operadora_id);
CREATE INDEX IF NOT EXISTS idx_operadora_user_user_id ON public.operadora_user (user_id);
CREATE INDEX IF NOT EXISTS idx_operadoras_cpf_cnpj ON public.operadoras (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_operadoras_email ON public.operadoras (email);
CREATE INDEX IF NOT EXISTS idx_operadoras_ativo ON public.operadoras (ativo);
CREATE INDEX IF NOT EXISTS idx_operadoras_created_at ON public.operadoras (created_at);
CREATE INDEX IF NOT EXISTS idx_operadoras_deleted_at ON public.operadoras (deleted_at);
CREATE INDEX IF NOT EXISTS idx_operadoras_boleto_client_id ON public.operadoras (boleto_client_id);
CREATE INDEX IF NOT EXISTS idx_parametros_deleted_at ON public.parametros (deleted_at);
CREATE INDEX IF NOT EXISTS idx_permission_role_permission_id ON public.permission_role (permission_id);
CREATE INDEX IF NOT EXISTS idx_permission_role_role_id ON public.permission_role (role_id);
CREATE INDEX IF NOT EXISTS idx_permissions_active ON public.permissions (active);
CREATE INDEX IF NOT EXISTS idx_permissions_created_at ON public.permissions (created_at);
CREATE INDEX IF NOT EXISTS idx_personal_access_tokens_created_at ON public.personal_access_tokens (created_at);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_prestadores_contratos_id ON public.prestador_contrato_itens (prestadores_contratos_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_edicao_medicamento_id ON public.prestador_contrato_itens (edicao_medicamento_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_tabela_precos_id ON public.prestador_contrato_itens (tabela_precos_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_ativo ON public.prestador_contrato_itens (ativo);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_deleted_at ON public.prestador_contrato_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_created_at ON public.prestador_contrato_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_prestador_contrato_itens_motivo_encerramento_id ON public.prestador_contrato_itens (motivo_encerramento_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contratos_prestador_id ON public.prestador_contratos (prestador_id);
CREATE INDEX IF NOT EXISTS idx_prestador_contratos_ativo ON public.prestador_contratos (ativo);
CREATE INDEX IF NOT EXISTS idx_prestador_contratos_deleted_at ON public.prestador_contratos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_prestador_contratos_created_at ON public.prestador_contratos (created_at);
CREATE INDEX IF NOT EXISTS idx_prestador_especialidades_prestador_id ON public.prestador_especialidades (prestador_id);
CREATE INDEX IF NOT EXISTS idx_prestador_especialidades_especialidade_id ON public.prestador_especialidades (especialidade_id);
CREATE INDEX IF NOT EXISTS idx_prestador_tipos_active ON public.prestador_tipos (active);
CREATE INDEX IF NOT EXISTS idx_prestador_tipos_deleted_at ON public.prestador_tipos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_prestador_tipos_created_at ON public.prestador_tipos (created_at);
CREATE INDEX IF NOT EXISTS idx_prestador_user_prestador_id ON public.prestador_user (prestador_id);
CREATE INDEX IF NOT EXISTS idx_prestador_user_user_id ON public.prestador_user (user_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_usuario_id ON public.prestadores (usuario_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_prestadores_classificacao_estabelecimento_id ON public.prestadores (prestadores_classificacao_estabelecimento_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_orgao_expedidor_uf_id ON public.prestadores (orgao_expedidor_uf_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_naturalidade_cidade_id ON public.prestadores (naturalidade_cidade_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_cpf_cnpj ON public.prestadores (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_prestadores_email ON public.prestadores (email);
CREATE INDEX IF NOT EXISTS idx_prestadores_ativo ON public.prestadores (ativo);
CREATE INDEX IF NOT EXISTS idx_prestadores_created_at ON public.prestadores (created_at);
CREATE INDEX IF NOT EXISTS idx_prestadores_deleted_at ON public.prestadores (deleted_at);
CREATE INDEX IF NOT EXISTS idx_prestadores_prestador_tipo_id ON public.prestadores (prestador_tipo_id);
CREATE INDEX IF NOT EXISTS idx_prestadores_classificacao_estabelecimento_ativo ON public.prestadores_classificacao_estabelecimento (ativo);
CREATE INDEX IF NOT EXISTS idx_prestadores_classificacao_estabelecimento_created_at ON public.prestadores_classificacao_estabelecimento (created_at);
CREATE INDEX IF NOT EXISTS idx_prestadores_classificacao_estabelecimento_deleted_at ON public.prestadores_classificacao_estabelecimento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_procedimento_subgrupos_grupo_id ON public.procedimento_subgrupos (grupo_id);
CREATE INDEX IF NOT EXISTS idx_procedimento_subgrupos_created_at ON public.procedimento_subgrupos (created_at);
CREATE INDEX IF NOT EXISTS idx_procedimento_subgrupos_deleted_at ON public.procedimento_subgrupos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_procedimentos_procedimento_subgrupo_id ON public.procedimentos (procedimento_subgrupo_id);
CREATE INDEX IF NOT EXISTS idx_procedimentos_created_at ON public.procedimentos (created_at);
CREATE INDEX IF NOT EXISTS idx_procedimentos_deleted_at ON public.procedimentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_procedimentos_grupos_ativo ON public.procedimentos_grupos (ativo);
CREATE INDEX IF NOT EXISTS idx_procedimentos_grupos_created_at ON public.procedimentos_grupos (created_at);
CREATE INDEX IF NOT EXISTS idx_procedimentos_grupos_deleted_at ON public.procedimentos_grupos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_produtos_operadora_id ON public.produtos (operadora_id);
CREATE INDEX IF NOT EXISTS idx_produtos_ativo ON public.produtos (ativo);
CREATE INDEX IF NOT EXISTS idx_produtos_created_at ON public.produtos (created_at);
CREATE INDEX IF NOT EXISTS idx_produtos_deleted_at ON public.produtos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_produto_id ON public.produtos_precos (produto_id);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_tipo_vinculo_id ON public.produtos_precos (tipo_vinculo_id);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_created_at ON public.produtos_precos (created_at);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_deleted_at ON public.produtos_precos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_produtos_precos_grupo_verba_id ON public.produtos_precos (grupo_verba_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_produto_id ON public.regra_cooparticipacao (produto_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_ativo ON public.regra_cooparticipacao (ativo);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_created_at ON public.regra_cooparticipacao (created_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_deleted_at ON public.regra_cooparticipacao (deleted_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_itens_regra_cooparticipacao_id ON public.regra_cooparticipacao_itens (regra_cooparticipacao_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_itens_created_at ON public.regra_cooparticipacao_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_itens_deleted_at ON public.regra_cooparticipacao_itens (deleted_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_regra_cooparticipacao_id ON public.regra_cooparticipacao_procedimentos (regra_cooparticipacao_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_grupo_procedimento_id ON public.regra_cooparticipacao_procedimentos (grupo_procedimento_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_subgrupo_procedimento_id ON public.regra_cooparticipacao_procedimentos (subgrupo_procedimento_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_procedimento_id ON public.regra_cooparticipacao_procedimentos (procedimento_id);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_created_at ON public.regra_cooparticipacao_procedimentos (created_at);
CREATE INDEX IF NOT EXISTS idx_regra_cooparticipacao_procedimentos_deleted_at ON public.regra_cooparticipacao_procedimentos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_empresa_id ON public.remessa_desconto (empresa_id);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_deleted_at ON public.remessa_desconto (deleted_at);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_created_at ON public.remessa_desconto (created_at);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_item_remessa_desconto_id ON public.remessa_desconto_item (remessa_desconto_id);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_item_adesao_id ON public.remessa_desconto_item (adesao_id);
CREATE INDEX IF NOT EXISTS idx_remessa_desconto_item_created_at ON public.remessa_desconto_item (created_at);
CREATE INDEX IF NOT EXISTS idx_role_user_user_id ON public.role_user (user_id);
CREATE INDEX IF NOT EXISTS idx_role_user_role_id ON public.role_user (role_id);
CREATE INDEX IF NOT EXISTS idx_roles_active ON public.roles (active);
CREATE INDEX IF NOT EXISTS idx_roles_created_at ON public.roles (created_at);
CREATE INDEX IF NOT EXISTS idx_secretarias_empresa_id ON public.secretarias (empresa_id);
CREATE INDEX IF NOT EXISTS idx_secretarias_cpf_cnpj ON public.secretarias (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_secretarias_email ON public.secretarias (email);
CREATE INDEX IF NOT EXISTS idx_secretarias_ativo ON public.secretarias (ativo);
CREATE INDEX IF NOT EXISTS idx_secretarias_created_at ON public.secretarias (created_at);
CREATE INDEX IF NOT EXISTS idx_secretarias_deleted_at ON public.secretarias (deleted_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_prestador_id ON public.solicitacoes_atualizacao_cadastral (prestador_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_conveniado_id ON public.solicitacoes_atualizacao_cadastral (conveniado_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_cidade_id ON public.solicitacoes_atualizacao_cadastral (cidade_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_email ON public.solicitacoes_atualizacao_cadastral (email);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_status ON public.solicitacoes_atualizacao_cadastral (status);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_deleted_at ON public.solicitacoes_atualizacao_cadastral (deleted_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_atualizacao_cadastral_created_at ON public.solicitacoes_atualizacao_cadastral (created_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_edital_credenciamento_id ON public.solicitacoes_credenciamento (edital_credenciamento_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_cpf_cnpj ON public.solicitacoes_credenciamento (cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_email ON public.solicitacoes_credenciamento (email);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_deleted_at ON public.solicitacoes_credenciamento (deleted_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_created_at ON public.solicitacoes_credenciamento (created_at);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_documentos_solicitacoes_credenciamento_id ON public.solicitacoes_credenciamento_documentos (solicitacoes_credenciamento_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_documentos_documento_credenciamento_id ON public.solicitacoes_credenciamento_documentos (documento_credenciamento_id);
CREATE INDEX IF NOT EXISTS idx_solicitacoes_credenciamento_documentos_created_at ON public.solicitacoes_credenciamento_documentos (created_at);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_comunicado_edicao_id ON public.tabela_precos (comunicado_edicao_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_cbhpm_edicao_id ON public.tabela_precos (cbhpm_edicao_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_material_edicao_id ON public.tabela_precos (material_edicao_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_ativo ON public.tabela_precos (ativo);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_deleted_at ON public.tabela_precos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_created_at ON public.tabela_precos (created_at);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_itens_tabela_preco_id ON public.tabela_precos_itens (tabela_preco_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_itens_referencia_id ON public.tabela_precos_itens (referencia_id);
CREATE INDEX IF NOT EXISTS idx_tabela_precos_itens_created_at ON public.tabela_precos_itens (created_at);
CREATE INDEX IF NOT EXISTS idx_taxas_deleted_at ON public.taxas (deleted_at);
CREATE INDEX IF NOT EXISTS idx_taxas_created_at ON public.taxas (created_at);
CREATE INDEX IF NOT EXISTS idx_tipo_vinculos_ativo ON public.tipo_vinculos (ativo);
CREATE INDEX IF NOT EXISTS idx_tipo_vinculos_deleted_at ON public.tipo_vinculos (deleted_at);
CREATE INDEX IF NOT EXISTS idx_tipo_vinculos_created_at ON public.tipo_vinculos (created_at);
CREATE INDEX IF NOT EXISTS idx_users_email ON public.users (email);
CREATE INDEX IF NOT EXISTS idx_users_cpf ON public.users (cpf);
CREATE INDEX IF NOT EXISTS idx_users_active ON public.users (active);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON public.users (created_at);
CREATE INDEX IF NOT EXISTS idx_users_deleted_at ON public.users (deleted_at);

-- ============================================================
-- ObservaÃ§Ãµes importantes
-- ============================================================
-- 1. Este script corrige estrutura bÃ¡sica, chaves primÃ¡rias e compatibilidade.
-- 2. As FOREIGN KEYS nÃ£o foram adicionadas automaticamente para evitar erros por tabelas ausentes ou relaÃ§Ãµes ambÃ­guas.
-- 3. Recomenda-se validar as relaÃ§Ãµes antes de aplicar constraints definitivas.
-- 4. Para Supabase, habilite RLS manualmente por mÃ³dulo apÃ³s definir perfis e permissÃµes.

-- ============================================================
-- FunÃ§Ãµes auxiliares de validaÃ§Ã£o e aplicaÃ§Ã£o segura
-- ============================================================



-- ============================================================
-- SECAO: 03 - FUNCOES DE VALIDACAO
-- Arquivo: sql_execucao_servsaude/03_funcoes_validacao.sql
-- ============================================================

﻿-- ============================================================
-- ServSaude - 03 - tabela e funcoes auxiliares de validacao
-- Origem: servsaude_schema_completo_fks_validacoes.sql
-- Execute conforme a numeracao do arquivo.
-- ============================================================

CREATE TABLE IF NOT EXISTS public._migration_validation_issues (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    issue_type text NOT NULL,
    table_name text NOT NULL,
    column_name text,
    referenced_table text,
    referenced_column text,
    issue_count bigint NOT NULL DEFAULT 0,
    details jsonb,
    created_at timestamptz DEFAULT now()
);

CREATE OR REPLACE FUNCTION public._table_exists(p_table text)
RETURNS boolean
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'public'
          AND table_name = p_table
    );
END;
$$;

CREATE OR REPLACE FUNCTION public._column_exists(p_table text, p_column text)
RETURNS boolean
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = p_table
          AND column_name = p_column
    );
END;
$$;

CREATE OR REPLACE FUNCTION public._constraint_exists(p_table text, p_constraint text)
RETURNS boolean
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = 'public'
          AND table_name = p_table
          AND constraint_name = p_constraint
    );
END;
$$;

CREATE OR REPLACE FUNCTION public._validate_fk_orphans(
    p_source_table text,
    p_source_column text,
    p_target_table text,
    p_target_column text
)
RETURNS bigint
LANGUAGE plpgsql
AS $$
DECLARE
    v_count bigint;
    v_sql text;
BEGIN
    IF NOT public._table_exists(p_source_table)
       OR NOT public._table_exists(p_target_table)
       OR NOT public._column_exists(p_source_table, p_source_column)
       OR NOT public._column_exists(p_target_table, p_target_column)
    THEN
        INSERT INTO public._migration_validation_issues (
            issue_type, table_name, column_name, referenced_table, referenced_column, issue_count, details
        )
        VALUES (
            'MISSING_TABLE_OR_COLUMN',
            p_source_table,
            p_source_column,
            p_target_table,
            p_target_column,
            1,
            jsonb_build_object(
                'source_table_exists', public._table_exists(p_source_table),
                'target_table_exists', public._table_exists(p_target_table),
                'source_column_exists', public._column_exists(p_source_table, p_source_column),
                'target_column_exists', public._column_exists(p_target_table, p_target_column)
            )
        );

        RETURN 1;
    END IF;

    v_sql := format(
        'SELECT count(*) FROM public.%I s
         WHERE s.%I IS NOT NULL
           AND NOT EXISTS (
               SELECT 1
               FROM public.%I t
               WHERE t.%I = s.%I
           )',
        p_source_table,
        p_source_column,
        p_target_table,
        p_target_column,
        p_source_column
    );

    EXECUTE v_sql INTO v_count;

    IF v_count > 0 THEN
        INSERT INTO public._migration_validation_issues (
            issue_type, table_name, column_name, referenced_table, referenced_column, issue_count, details
        )
        VALUES (
            'FK_ORPHAN_RECORDS',
            p_source_table,
            p_source_column,
            p_target_table,
            p_target_column,
            v_count,
            jsonb_build_object('message', 'Existem registros Ã³rfÃ£os antes da criaÃ§Ã£o da foreign key.')
        );
    END IF;

    RETURN v_count;
END;
$$;

CREATE OR REPLACE FUNCTION public._add_fk_if_valid(
    p_source_table text,
    p_source_column text,
    p_target_table text,
    p_target_column text,
    p_constraint text
)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    v_orphans bigint;
    v_sql text;
BEGIN
    v_orphans := public._validate_fk_orphans(
        p_source_table,
        p_source_column,
        p_target_table,
        p_target_column
    );

    IF v_orphans > 0 THEN
        RAISE NOTICE 'FK ignorada: %.% -> %.% possui % problema(s).',
            p_source_table, p_source_column, p_target_table, p_target_column, v_orphans;
        RETURN;
    END IF;

    IF public._constraint_exists(p_source_table, p_constraint) THEN
        RAISE NOTICE 'Constraint jÃ¡ existe: %', p_constraint;
        RETURN;
    END IF;

    v_sql := format(
        'ALTER TABLE public.%I
         ADD CONSTRAINT %I
         FOREIGN KEY (%I)
         REFERENCES public.%I(%I)
         ON UPDATE CASCADE
         ON DELETE RESTRICT
         NOT VALID',
        p_source_table,
        p_constraint,
        p_source_column,
        p_target_table,
        p_target_column
    );

    EXECUTE v_sql;

    RAISE NOTICE 'FK criada como NOT VALID: %', p_constraint;
END;
$$;

-- ============================================================
-- ValidaÃ§Ãµes e criaÃ§Ã£o segura de Foreign Keys
-- As FKs sÃ£o criadas como NOT VALID para evitar travar importaÃ§Ãµes grandes.
-- Depois de resolver pendÃªncias, execute os VALIDATE CONSTRAINTS no final.
-- ============================================================



-- ============================================================
-- SECAO: 04 - FOREIGN KEYS NOT VALID
-- Arquivo: sql_execucao_servsaude/04_aplicar_foreign_keys_not_valid.sql
-- ============================================================

﻿-- ============================================================
-- ServSaude - 04 - validacao de orfaos e criacao de FKs NOT VALID
-- Origem: servsaude_schema_completo_fks_validacoes.sql
-- Execute conforme a numeracao do arquivo.
-- ============================================================

TRUNCATE TABLE public._migration_validation_issues;

SELECT public._add_fk_if_valid('adesao_reducao_margem', 'adesao_id', 'adesoes', 'id', 'fk_adesao_reducao_margem_adesao_id_adesoes');
SELECT public._add_fk_if_valid('adesoes', 'operadora_id', 'operadoras', 'id', 'fk_adesoes_operadora_id_operadoras');
SELECT public._add_fk_if_valid('adesoes', 'empresa_id', 'empresas', 'id', 'fk_adesoes_empresa_id_empresas');
SELECT public._add_fk_if_valid('adesoes', 'secretaria_id', 'secretarias', 'id', 'fk_adesoes_secretaria_id_secretarias');
SELECT public._add_fk_if_valid('adesoes', 'conveniado_id', 'conveniados', 'id', 'fk_adesoes_conveniado_id_conveniados');
SELECT public._add_fk_if_valid('adesoes', 'produto_id', 'produtos', 'id', 'fk_adesoes_produto_id_produtos');
SELECT public._add_fk_if_valid('adesoes', 'produto_preco_id', 'produtos_precos', 'id', 'fk_adesoes_produto_preco_id_produtos_precos');
SELECT public._add_fk_if_valid('boleto_lancamentos', 'boleto_id', 'boletos', 'id', 'fk_boleto_lancamentos_boleto_id_boletos');
SELECT public._add_fk_if_valid('boleto_lancamentos', 'lancamento_id', 'lancamentos', 'id', 'fk_boleto_lancamentos_lancamento_id_lancamentos');
SELECT public._add_fk_if_valid('boletos', 'operadora_id', 'operadoras', 'id', 'fk_boletos_operadora_id_operadoras');
SELECT public._add_fk_if_valid('boletos', 'pagador_cidade_id', 'cidades', 'id', 'fk_boletos_pagador_cidade_id_cidades');
SELECT public._add_fk_if_valid('cbhpm', 'cbhpm_edicao_id', 'cbhpm_edicoes', 'id', 'fk_cbhpm_cbhpm_edicao_id_cbhpm_edicoes');
SELECT public._add_fk_if_valid('cbhpm', 'procedimento_id', 'procedimentos', 'id', 'fk_cbhpm_procedimento_id_procedimentos');
SELECT public._add_fk_if_valid('cidades', 'estado_id', 'estados', 'id', 'fk_cidades_estado_id_estados');
SELECT public._add_fk_if_valid('comunicado_portes', 'comunicado_edicao_id', 'comunicado_edicoes', 'id', 'fk_comunicado_portes_comunicado_edicao_id_comunicado_edicoes');
SELECT public._add_fk_if_valid('contrato_profissionais', 'contrato_id', 'prestador_contratos', 'id', 'fk_contrato_profissionais_contrato_id_prestador_contratos');
SELECT public._add_fk_if_valid('contrato_profissionais', 'prestador_id', 'prestadores', 'id', 'fk_contrato_profissionais_prestador_id_prestadores');
SELECT public._add_fk_if_valid('conveniado_salarios', 'conveniado_id', 'conveniados', 'id', 'fk_conveniado_salarios_conveniado_id_conveniados');
SELECT public._add_fk_if_valid('conveniados', 'naturalidade_cidade_id', 'cidades', 'id', 'fk_conveniados_naturalidade_cidade_id_cidades');
SELECT public._add_fk_if_valid('conveniados', 'orgao_expedidor_uf_id', 'estados', 'id', 'fk_conveniados_orgao_expedidor_uf_id_estados');
SELECT public._add_fk_if_valid('conveniados', 'usuario_id', 'users', 'id', 'fk_conveniados_usuario_id_users');
SELECT public._add_fk_if_valid('conveniados', 'cargo_id', 'cargos', 'id', 'fk_conveniados_cargo_id_cargos');
SELECT public._add_fk_if_valid('dados_bancarios', 'banco_id', 'bancos', 'id', 'fk_dados_bancarios_banco_id_bancos');
SELECT public._add_fk_if_valid('deflatores', 'procedimento_grupo_id', 'procedimentos_grupos', 'id', 'fk_deflatores_procedimento_grupo_id_procedimentos_grupos');
SELECT public._add_fk_if_valid('documentos_credenciamento', 'id', 'documentos_credenciamento', 'id', 'fk_documentos_credenciamento_id_documentos_credenciamento');
SELECT public._add_fk_if_valid('edital_credenciamento_documentos', 'edital_id', 'editais_credenciamento', 'id', 'fk_edital_credenciamento_documentos_edital_id_editais_creden');
SELECT public._add_fk_if_valid('edital_credenciamento_documentos', 'documento_credenciamento_id', 'documentos_credenciamento', 'id', 'fk_edital_credenciamento_documentos_documento_credenciamento');
SELECT public._add_fk_if_valid('empresa_produto', 'empresa_id', 'empresas', 'id', 'fk_empresa_produto_empresa_id_empresas');
SELECT public._add_fk_if_valid('empresa_produto', 'produto_id', 'produtos', 'id', 'fk_empresa_produto_produto_id_produtos');
SELECT public._add_fk_if_valid('empresa_user', 'empresa_id', 'empresas', 'id', 'fk_empresa_user_empresa_id_empresas');
SELECT public._add_fk_if_valid('empresa_user', 'user_id', 'users', 'id', 'fk_empresa_user_user_id_users');
SELECT public._add_fk_if_valid('empresas_verbas', 'empresa_id', 'empresas', 'id', 'fk_empresas_verbas_empresa_id_empresas');
SELECT public._add_fk_if_valid('empresas_verbas', 'grupo_verba_id', 'grupo_verbas', 'id', 'fk_empresas_verbas_grupo_verba_id_grupo_verbas');
SELECT public._add_fk_if_valid('enderecos', 'cidade_id', 'cidades', 'id', 'fk_enderecos_cidade_id_cidades');
SELECT public._add_fk_if_valid('fiscal_contrato_itens', 'fiscal_contrato_id', 'fiscal_contratos', 'id', 'fk_fiscal_contrato_itens_fiscal_contrato_id_fiscal_contratos');
SELECT public._add_fk_if_valid('fiscal_contrato_itens', 'contrato_id', 'prestador_contratos', 'id', 'fk_fiscal_contrato_itens_contrato_id_prestador_contratos');
SELECT public._add_fk_if_valid('fiscal_contratos', 'usuario_id', 'users', 'id', 'fk_fiscal_contratos_usuario_id_users');
SELECT public._add_fk_if_valid('gestantes', 'conveniado_id', 'conveniados', 'id', 'fk_gestantes_conveniado_id_conveniados');
SELECT public._add_fk_if_valid('guia_importacoes', 'prestador_id', 'prestadores', 'id', 'fk_guia_importacoes_prestador_id_prestadores');
SELECT public._add_fk_if_valid('guia_importacoes', 'usuario_id', 'users', 'id', 'fk_guia_importacoes_usuario_id_users');
SELECT public._add_fk_if_valid('guias', 'usuario_emissor_id', 'users', 'id', 'fk_guias_usuario_emissor_id_users');
SELECT public._add_fk_if_valid('guias', 'prestador_id', 'prestadores', 'id', 'fk_guias_prestador_id_prestadores');
SELECT public._add_fk_if_valid('guias', 'profissional_id', 'prestadores', 'id', 'fk_guias_profissional_id_prestadores');
SELECT public._add_fk_if_valid('guias', 'conveniado_id', 'conveniados', 'id', 'fk_guias_conveniado_id_conveniados');
SELECT public._add_fk_if_valid('guias', 'solicitante_prestador_id', 'prestadores', 'id', 'fk_guias_solicitante_prestador_id_prestadores');
SELECT public._add_fk_if_valid('guias', 'lote_pagamento_id', 'lote_pagamentos', 'id', 'fk_guias_lote_pagamento_id_lote_pagamentos');
SELECT public._add_fk_if_valid('guias', 'guia_origem_id', 'guias', 'id', 'fk_guias_guia_origem_id_guias');
SELECT public._add_fk_if_valid('guias', 'cancelado_por_user_id', 'users', 'id', 'fk_guias_cancelado_por_user_id_users');
SELECT public._add_fk_if_valid('guias', 'guia_importacao_id', 'guia_importacoes', 'id', 'fk_guias_guia_importacao_id_guia_importacoes');
SELECT public._add_fk_if_valid('guias_anexos', 'guia_id', 'guias', 'id', 'fk_guias_anexos_guia_id_guias');
SELECT public._add_fk_if_valid('guias_atendimentos', 'guia_itens_id', 'guias_itens', 'id', 'fk_guias_atendimentos_guia_itens_id_guias_itens');
SELECT public._add_fk_if_valid('guias_atendimentos', 'usuario_id', 'users', 'id', 'fk_guias_atendimentos_usuario_id_users');
SELECT public._add_fk_if_valid('guias_auditoria', 'guia_itens_id', 'guias_itens', 'id', 'fk_guias_auditoria_guia_itens_id_guias_itens');
SELECT public._add_fk_if_valid('guias_auditoria', 'analise_usuario_id', 'users', 'id', 'fk_guias_auditoria_analise_usuario_id_users');
SELECT public._add_fk_if_valid('guias_historico', 'guia_id', 'guias', 'id', 'fk_guias_historico_guia_id_guias');
SELECT public._add_fk_if_valid('guias_historico', 'guia_item_id', 'guias_itens', 'id', 'fk_guias_historico_guia_item_id_guias_itens');
SELECT public._add_fk_if_valid('guias_historico', 'usuario_id', 'users', 'id', 'fk_guias_historico_usuario_id_users');
SELECT public._add_fk_if_valid('guias_itens', 'guia_id', 'guias', 'id', 'fk_guias_itens_guia_id_guias');
SELECT public._add_fk_if_valid('historico_credenciamentos', 'user_id', 'users', 'id', 'fk_historico_credenciamentos_user_id_users');
SELECT public._add_fk_if_valid('lancamentos', 'boleto_id', 'boletos', 'id', 'fk_lancamentos_boleto_id_boletos');
SELECT public._add_fk_if_valid('lancamentos', 'operadora_id', 'operadoras', 'id', 'fk_lancamentos_operadora_id_operadoras');
SELECT public._add_fk_if_valid('lancamentos', 'prestador_id', 'prestadores', 'id', 'fk_lancamentos_prestador_id_prestadores');
SELECT public._add_fk_if_valid('lancamentos', 'conveniado_id', 'conveniados', 'id', 'fk_lancamentos_conveniado_id_conveniados');
SELECT public._add_fk_if_valid('lancamentos', 'grupo_verba_id', 'grupo_verbas', 'id', 'fk_lancamentos_grupo_verba_id_grupo_verbas');
SELECT public._add_fk_if_valid('lancamentos_guias', 'lancamento_id', 'lancamentos', 'id', 'fk_lancamentos_guias_lancamento_id_lancamentos');
SELECT public._add_fk_if_valid('lancamentos_guias', 'guia_id', 'guias', 'id', 'fk_lancamentos_guias_guia_id_guias');
SELECT public._add_fk_if_valid('lote_pagamentos', 'prestador_id', 'prestadores', 'id', 'fk_lote_pagamentos_prestador_id_prestadores');
SELECT public._add_fk_if_valid('lote_pagamentos', 'usuario_id', 'users', 'id', 'fk_lote_pagamentos_usuario_id_users');
SELECT public._add_fk_if_valid('lote_pagamentos', 'lancamento_id', 'lancamentos', 'id', 'fk_lote_pagamentos_lancamento_id_lancamentos');
SELECT public._add_fk_if_valid('materiais_itens', 'material_edicao_id', 'material_edicoes', 'id', 'fk_materiais_itens_material_edicao_id_material_edicoes');
SELECT public._add_fk_if_valid('materiais_itens', 'material_id', 'materiais', 'id', 'fk_materiais_itens_material_id_materiais');
SELECT public._add_fk_if_valid('medicamento_brasindice', 'medicamento_edicao_id', 'medicamento_edicoes', 'id', 'fk_medicamento_brasindice_medicamento_edicao_id_medicamento_');
SELECT public._add_fk_if_valid('medicamento_brasindice', 'medicamento_id', 'medicamentos', 'id', 'fk_medicamento_brasindice_medicamento_id_medicamentos');
SELECT public._add_fk_if_valid('medicamentos', 'laboratorio_id', 'laboratorios', 'id', 'fk_medicamentos_laboratorio_id_laboratorios');
SELECT public._add_fk_if_valid('medicamentos', 'medicamento_edicao_id', 'medicamento_edicoes', 'id', 'fk_medicamentos_medicamento_edicao_id_medicamento_edicoes');
SELECT public._add_fk_if_valid('mensalidades', 'conveniado_id', 'conveniados', 'id', 'fk_mensalidades_conveniado_id_conveniados');
SELECT public._add_fk_if_valid('mensalidades', 'produto_preco_id', 'produtos_precos', 'id', 'fk_mensalidades_produto_preco_id_produtos_precos');
SELECT public._add_fk_if_valid('mensalidades', 'grupo_verba_id', 'grupo_verbas', 'id', 'fk_mensalidades_grupo_verba_id_grupo_verbas');
SELECT public._add_fk_if_valid('motivo_encerramentos', 'id', 'motivo_encerramentos', 'id', 'fk_motivo_encerramentos_id_motivo_encerramentos');
SELECT public._add_fk_if_valid('operadora_user', 'operadora_id', 'operadoras', 'id', 'fk_operadora_user_operadora_id_operadoras');
SELECT public._add_fk_if_valid('operadora_user', 'user_id', 'users', 'id', 'fk_operadora_user_user_id_users');
SELECT public._add_fk_if_valid('permission_role', 'permission_id', 'permissions', 'id', 'fk_permission_role_permission_id_permissions');
SELECT public._add_fk_if_valid('permission_role', 'role_id', 'roles', 'id', 'fk_permission_role_role_id_roles');
SELECT public._add_fk_if_valid('prestador_contrato_itens', 'prestadores_contratos_id', 'prestador_contratos', 'id', 'fk_prestador_contrato_itens_prestadores_contratos_id_prestad');
SELECT public._add_fk_if_valid('prestador_contrato_itens', 'edicao_medicamento_id', 'medicamento_edicoes', 'id', 'fk_prestador_contrato_itens_edicao_medicamento_id_medicament');
SELECT public._add_fk_if_valid('prestador_contrato_itens', 'tabela_precos_id', 'tabela_precos', 'id', 'fk_prestador_contrato_itens_tabela_precos_id_tabela_precos');
SELECT public._add_fk_if_valid('prestador_contrato_itens', 'motivo_encerramento_id', 'motivo_encerramentos', 'id', 'fk_prestador_contrato_itens_motivo_encerramento_id_motivo_en');
SELECT public._add_fk_if_valid('prestador_contratos', 'prestador_id', 'prestadores', 'id', 'fk_prestador_contratos_prestador_id_prestadores');
SELECT public._add_fk_if_valid('prestador_especialidades', 'prestador_id', 'prestadores', 'id', 'fk_prestador_especialidades_prestador_id_prestadores');
SELECT public._add_fk_if_valid('prestador_especialidades', 'especialidade_id', 'especialidades', 'id', 'fk_prestador_especialidades_especialidade_id_especialidades');
SELECT public._add_fk_if_valid('prestador_user', 'prestador_id', 'prestadores', 'id', 'fk_prestador_user_prestador_id_prestadores');
SELECT public._add_fk_if_valid('prestador_user', 'user_id', 'users', 'id', 'fk_prestador_user_user_id_users');
SELECT public._add_fk_if_valid('prestadores', 'usuario_id', 'users', 'id', 'fk_prestadores_usuario_id_users');
SELECT public._add_fk_if_valid('prestadores', 'prestadores_classificacao_estabelecimento_id', 'prestadores_classificacao_estabelecimento', 'id', 'fk_prestadores_prestadores_classificacao_estabelecimento_id_');
SELECT public._add_fk_if_valid('prestadores', 'orgao_expedidor_uf_id', 'estados', 'id', 'fk_prestadores_orgao_expedidor_uf_id_estados');
SELECT public._add_fk_if_valid('prestadores', 'naturalidade_cidade_id', 'cidades', 'id', 'fk_prestadores_naturalidade_cidade_id_cidades');
SELECT public._add_fk_if_valid('prestadores', 'prestador_tipo_id', 'prestador_tipos', 'id', 'fk_prestadores_prestador_tipo_id_prestador_tipos');
SELECT public._add_fk_if_valid('procedimento_subgrupos', 'grupo_id', 'procedimentos_grupos', 'id', 'fk_procedimento_subgrupos_grupo_id_procedimentos_grupos');
SELECT public._add_fk_if_valid('procedimentos', 'procedimento_subgrupo_id', 'procedimento_subgrupos', 'id', 'fk_procedimentos_procedimento_subgrupo_id_procedimento_subgr');
SELECT public._add_fk_if_valid('produtos', 'operadora_id', 'operadoras', 'id', 'fk_produtos_operadora_id_operadoras');
SELECT public._add_fk_if_valid('produtos_precos', 'produto_id', 'produtos', 'id', 'fk_produtos_precos_produto_id_produtos');
SELECT public._add_fk_if_valid('produtos_precos', 'tipo_vinculo_id', 'tipo_vinculos', 'id', 'fk_produtos_precos_tipo_vinculo_id_tipo_vinculos');
SELECT public._add_fk_if_valid('produtos_precos', 'grupo_verba_id', 'grupo_verbas', 'id', 'fk_produtos_precos_grupo_verba_id_grupo_verbas');
SELECT public._add_fk_if_valid('regra_cooparticipacao', 'produto_id', 'produtos', 'id', 'fk_regra_cooparticipacao_produto_id_produtos');
SELECT public._add_fk_if_valid('regra_cooparticipacao_itens', 'regra_cooparticipacao_id', 'regra_cooparticipacao', 'id', 'fk_regra_cooparticipacao_itens_regra_cooparticipacao_id_regr');
SELECT public._add_fk_if_valid('regra_cooparticipacao_procedimentos', 'regra_cooparticipacao_id', 'regra_cooparticipacao', 'id', 'fk_regra_cooparticipacao_procedimentos_regra_cooparticipacao');
SELECT public._add_fk_if_valid('regra_cooparticipacao_procedimentos', 'grupo_procedimento_id', 'procedimentos_grupos', 'id', 'fk_regra_cooparticipacao_procedimentos_grupo_procedimento_id');
SELECT public._add_fk_if_valid('regra_cooparticipacao_procedimentos', 'subgrupo_procedimento_id', 'procedimento_subgrupos', 'id', 'fk_regra_cooparticipacao_procedimentos_subgrupo_procedimento');
SELECT public._add_fk_if_valid('regra_cooparticipacao_procedimentos', 'procedimento_id', 'procedimentos', 'id', 'fk_regra_cooparticipacao_procedimentos_procedimento_id_proce');
SELECT public._add_fk_if_valid('remessa_desconto', 'empresa_id', 'empresas', 'id', 'fk_remessa_desconto_empresa_id_empresas');
SELECT public._add_fk_if_valid('remessa_desconto_item', 'remessa_desconto_id', 'remessa_desconto', 'id', 'fk_remessa_desconto_item_remessa_desconto_id_remessa_descont');
SELECT public._add_fk_if_valid('remessa_desconto_item', 'adesao_id', 'adesoes', 'id', 'fk_remessa_desconto_item_adesao_id_adesoes');
SELECT public._add_fk_if_valid('role_user', 'user_id', 'users', 'id', 'fk_role_user_user_id_users');
SELECT public._add_fk_if_valid('role_user', 'role_id', 'roles', 'id', 'fk_role_user_role_id_roles');
SELECT public._add_fk_if_valid('secretarias', 'empresa_id', 'empresas', 'id', 'fk_secretarias_empresa_id_empresas');
SELECT public._add_fk_if_valid('solicitacoes_atualizacao_cadastral', 'prestador_id', 'prestadores', 'id', 'fk_solicitacoes_atualizacao_cadastral_prestador_id_prestador');
SELECT public._add_fk_if_valid('solicitacoes_atualizacao_cadastral', 'conveniado_id', 'conveniados', 'id', 'fk_solicitacoes_atualizacao_cadastral_conveniado_id_convenia');
SELECT public._add_fk_if_valid('solicitacoes_atualizacao_cadastral', 'cidade_id', 'cidades', 'id', 'fk_solicitacoes_atualizacao_cadastral_cidade_id_cidades');
SELECT public._add_fk_if_valid('solicitacoes_credenciamento', 'edital_credenciamento_id', 'editais_credenciamento', 'id', 'fk_solicitacoes_credenciamento_edital_credenciamento_id_edit');
SELECT public._add_fk_if_valid('solicitacoes_credenciamento_documentos', 'solicitacoes_credenciamento_id', 'solicitacoes_credenciamento', 'id', 'fk_solicitacoes_credenciamento_documentos_solicitacoes_crede');
SELECT public._add_fk_if_valid('solicitacoes_credenciamento_documentos', 'documento_credenciamento_id', 'documentos_credenciamento', 'id', 'fk_solicitacoes_credenciamento_documentos_documento_credenci');
SELECT public._add_fk_if_valid('tabela_precos', 'comunicado_edicao_id', 'comunicado_edicoes', 'id', 'fk_tabela_precos_comunicado_edicao_id_comunicado_edicoes');
SELECT public._add_fk_if_valid('tabela_precos', 'cbhpm_edicao_id', 'cbhpm_edicoes', 'id', 'fk_tabela_precos_cbhpm_edicao_id_cbhpm_edicoes');
SELECT public._add_fk_if_valid('tabela_precos', 'material_edicao_id', 'material_edicoes', 'id', 'fk_tabela_precos_material_edicao_id_material_edicoes');
SELECT public._add_fk_if_valid('tabela_precos_itens', 'tabela_preco_id', 'tabela_precos', 'id', 'fk_tabela_precos_itens_tabela_preco_id_tabela_precos');

-- ============================================================
-- ValidaÃ§Ãµes CHECK recomendadas
-- ============================================================



-- ============================================================
-- SECAO: 05 - CHECKS NOT VALID
-- Arquivo: sql_execucao_servsaude/05_checks_not_valid.sql
-- ============================================================

﻿-- ============================================================
-- ServSaude - 05 - checks NOT VALID
-- Origem: servsaude_schema_completo_fks_validacoes.sql
-- Execute conforme a numeracao do arquivo.
-- ============================================================

CREATE OR REPLACE FUNCTION public._add_check_if_possible(
    p_table text,
    p_constraint text,
    p_expression text
)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    v_sql text;
BEGIN
    IF NOT public._table_exists(p_table) THEN
        INSERT INTO public._migration_validation_issues(issue_type, table_name, issue_count, details)
        VALUES ('MISSING_TABLE_FOR_CHECK', p_table, 1, jsonb_build_object('constraint', p_constraint));
        RETURN;
    END IF;

    IF public._constraint_exists(p_table, p_constraint) THEN
        RETURN;
    END IF;

    v_sql := format(
        'ALTER TABLE public.%I ADD CONSTRAINT %I CHECK (%s) NOT VALID',
        p_table,
        p_constraint,
        p_expression
    );

    EXECUTE v_sql;
END;
$$;
SELECT public._add_check_if_possible('conveniados', 'chk_conveniados_sexo', 'sexo IN (1,2)');
SELECT public._add_check_if_possible('conveniados', 'chk_conveniados_estado_civil', 'estado_civil BETWEEN 1 AND 7');
SELECT public._add_check_if_possible('conveniados', 'chk_conveniados_pcd', 'pcd IN (1,2)');
SELECT public._add_check_if_possible('adesoes', 'chk_adesoes_tipo_cliente', 'tipo_cliente IN (1,2,3)');
SELECT public._add_check_if_possible('adesoes', 'chk_adesoes_status', 'status IN (1,2,3)');
SELECT public._add_check_if_possible('boletos', 'chk_boletos_valor_original', 'valor_original >= 0');
SELECT public._add_check_if_possible('boletos', 'chk_boletos_status', 'status BETWEEN 1 AND 5');
SELECT public._add_check_if_possible('lancamentos', 'chk_lancamentos_valor', 'valor >= 0');
SELECT public._add_check_if_possible('produtos_precos', 'chk_produtos_precos_idade', 'idade_inicial <= idade_final');
SELECT public._add_check_if_possible('produtos_precos', 'chk_produtos_precos_valor', 'valor >= 0');
SELECT public._add_check_if_possible('guias_itens', 'chk_guias_itens_quantidades', 'COALESCE(quantidade_solicitada,0) >= 0 AND COALESCE(quantidade_atendida,0) >= 0');
SELECT public._add_check_if_possible('users', 'chk_users_email_format', 'email IS NULL OR email ~* ''^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$''');

-- ============================================================
-- Ãndices Ãºnicos recomendados com validaÃ§Ã£o prÃ©via
-- ============================================================



-- ============================================================
-- SECAO: 06 - INDICES UNICOS
-- Arquivo: sql_execucao_servsaude/06_indices_unicos_validados.sql
-- ============================================================

﻿-- ============================================================
-- ServSaude - 06 - indices unicos apos checagem de duplicidade
-- Origem: servsaude_schema_completo_fks_validacoes.sql
-- Execute conforme a numeracao do arquivo.
-- ============================================================

CREATE OR REPLACE FUNCTION public._create_unique_index_if_no_duplicates(
    p_table text,
    p_column text,
    p_index text
)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    v_duplicates bigint;
    v_sql text;
BEGIN
    IF NOT public._table_exists(p_table) OR NOT public._column_exists(p_table, p_column) THEN
        INSERT INTO public._migration_validation_issues(issue_type, table_name, column_name, issue_count, details)
        VALUES ('MISSING_TABLE_OR_COLUMN_FOR_UNIQUE', p_table, p_column, 1, jsonb_build_object('index', p_index));
        RETURN;
    END IF;

    v_sql := format(
        'SELECT count(*) FROM (
            SELECT %I
            FROM public.%I
            WHERE %I IS NOT NULL
            GROUP BY %I
            HAVING count(*) > 1
        ) d',
        p_column, p_table, p_column, p_column
    );

    EXECUTE v_sql INTO v_duplicates;

    IF v_duplicates > 0 THEN
        INSERT INTO public._migration_validation_issues(issue_type, table_name, column_name, issue_count, details)
        VALUES ('DUPLICATES_FOUND_FOR_UNIQUE', p_table, p_column, v_duplicates, jsonb_build_object('index', p_index));
        RAISE NOTICE 'Ãndice Ãºnico ignorado: %.% possui duplicidades.', p_table, p_column;
        RETURN;
    END IF;

    v_sql := format(
        'CREATE UNIQUE INDEX IF NOT EXISTS %I ON public.%I (%I) WHERE %I IS NOT NULL',
        p_index, p_table, p_column, p_column
    );

    EXECUTE v_sql;
END;
$$;
SELECT public._create_unique_index_if_no_duplicates('users', 'email', 'ux_users_email');
SELECT public._create_unique_index_if_no_duplicates('users', 'cpf', 'ux_users_cpf');
SELECT public._create_unique_index_if_no_duplicates('conveniados', 'cpf', 'ux_conveniados_cpf');
SELECT public._create_unique_index_if_no_duplicates('empresas', 'cpf_cnpj', 'ux_empresas_cpf_cnpj');
SELECT public._create_unique_index_if_no_duplicates('operadoras', 'cpf_cnpj', 'ux_operadoras_cpf_cnpj');
SELECT public._create_unique_index_if_no_duplicates('prestadores', 'cpf_cnpj', 'ux_prestadores_cpf_cnpj');
SELECT public._create_unique_index_if_no_duplicates('roles', 'slug', 'ux_roles_slug');
SELECT public._create_unique_index_if_no_duplicates('permissions', 'slug', 'ux_permissions_slug');
SELECT public._create_unique_index_if_no_duplicates('bancos', 'codigo', 'ux_bancos_codigo');
SELECT public._create_unique_index_if_no_duplicates('cid', 'codigo', 'ux_cid_codigo');

-- ============================================================
-- RelatÃ³rio final de validaÃ§Ã£o
-- ============================================================



-- ============================================================
-- SECAO: 07 - RELATORIO DE VALIDACAO
-- Arquivo: sql_execucao_servsaude/07_relatorio_validacao.sql
-- ============================================================

﻿-- ============================================================
-- ServSaude - 07 - relatorio de problemas encontrados
-- Origem: servsaude_schema_completo_fks_validacoes.sql
-- Execute conforme a numeracao do arquivo.
-- ============================================================

SELECT *
FROM public._migration_validation_issues
ORDER BY created_at, table_name, column_name;

-- ============================================================



-- ============================================================
-- SECAO: 08 - VALIDATE CONSTRAINTS
-- Arquivo: sql_execucao_servsaude/08_validate_constraints.sql
-- ============================================================

﻿-- ============================================================
-- ServSaude - 08 - VALIDATE CONSTRAINTS, executar somente apos saneamento
-- Origem: servsaude_schema_completo_fks_validacoes.sql
-- Execute conforme a numeracao do arquivo.
-- ============================================================

ALTER TABLE public.adesao_reducao_margem VALIDATE CONSTRAINT fk_adesao_reducao_margem_adesao_id_adesoes;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_operadora_id_operadoras;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_empresa_id_empresas;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_secretaria_id_secretarias;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_conveniado_id_conveniados;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_produto_id_produtos;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT fk_adesoes_produto_preco_id_produtos_precos;
ALTER TABLE public.boleto_lancamentos VALIDATE CONSTRAINT fk_boleto_lancamentos_boleto_id_boletos;
ALTER TABLE public.boleto_lancamentos VALIDATE CONSTRAINT fk_boleto_lancamentos_lancamento_id_lancamentos;
ALTER TABLE public.boletos VALIDATE CONSTRAINT fk_boletos_operadora_id_operadoras;
ALTER TABLE public.boletos VALIDATE CONSTRAINT fk_boletos_pagador_cidade_id_cidades;
ALTER TABLE public.cbhpm VALIDATE CONSTRAINT fk_cbhpm_cbhpm_edicao_id_cbhpm_edicoes;
ALTER TABLE public.cbhpm VALIDATE CONSTRAINT fk_cbhpm_procedimento_id_procedimentos;
ALTER TABLE public.cidades VALIDATE CONSTRAINT fk_cidades_estado_id_estados;
ALTER TABLE public.comunicado_portes VALIDATE CONSTRAINT fk_comunicado_portes_comunicado_edicao_id_comunicado_edicoes;
ALTER TABLE public.contrato_profissionais VALIDATE CONSTRAINT fk_contrato_profissionais_contrato_id_prestador_contratos;
ALTER TABLE public.contrato_profissionais VALIDATE CONSTRAINT fk_contrato_profissionais_prestador_id_prestadores;
ALTER TABLE public.conveniado_salarios VALIDATE CONSTRAINT fk_conveniado_salarios_conveniado_id_conveniados;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT fk_conveniados_naturalidade_cidade_id_cidades;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT fk_conveniados_orgao_expedidor_uf_id_estados;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT fk_conveniados_usuario_id_users;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT fk_conveniados_cargo_id_cargos;
ALTER TABLE public.dados_bancarios VALIDATE CONSTRAINT fk_dados_bancarios_banco_id_bancos;
ALTER TABLE public.deflatores VALIDATE CONSTRAINT fk_deflatores_procedimento_grupo_id_procedimentos_grupos;
ALTER TABLE public.documentos_credenciamento VALIDATE CONSTRAINT fk_documentos_credenciamento_id_documentos_credenciamento;
ALTER TABLE public.edital_credenciamento_documentos VALIDATE CONSTRAINT fk_edital_credenciamento_documentos_edital_id_editais_creden;
ALTER TABLE public.edital_credenciamento_documentos VALIDATE CONSTRAINT fk_edital_credenciamento_documentos_documento_credenciamento;
ALTER TABLE public.empresa_produto VALIDATE CONSTRAINT fk_empresa_produto_empresa_id_empresas;
ALTER TABLE public.empresa_produto VALIDATE CONSTRAINT fk_empresa_produto_produto_id_produtos;
ALTER TABLE public.empresa_user VALIDATE CONSTRAINT fk_empresa_user_empresa_id_empresas;
ALTER TABLE public.empresa_user VALIDATE CONSTRAINT fk_empresa_user_user_id_users;
ALTER TABLE public.empresas_verbas VALIDATE CONSTRAINT fk_empresas_verbas_empresa_id_empresas;
ALTER TABLE public.empresas_verbas VALIDATE CONSTRAINT fk_empresas_verbas_grupo_verba_id_grupo_verbas;
ALTER TABLE public.enderecos VALIDATE CONSTRAINT fk_enderecos_cidade_id_cidades;
ALTER TABLE public.fiscal_contrato_itens VALIDATE CONSTRAINT fk_fiscal_contrato_itens_fiscal_contrato_id_fiscal_contratos;
ALTER TABLE public.fiscal_contrato_itens VALIDATE CONSTRAINT fk_fiscal_contrato_itens_contrato_id_prestador_contratos;
ALTER TABLE public.fiscal_contratos VALIDATE CONSTRAINT fk_fiscal_contratos_usuario_id_users;
ALTER TABLE public.gestantes VALIDATE CONSTRAINT fk_gestantes_conveniado_id_conveniados;
ALTER TABLE public.guia_importacoes VALIDATE CONSTRAINT fk_guia_importacoes_prestador_id_prestadores;
ALTER TABLE public.guia_importacoes VALIDATE CONSTRAINT fk_guia_importacoes_usuario_id_users;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_usuario_emissor_id_users;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_prestador_id_prestadores;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_profissional_id_prestadores;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_conveniado_id_conveniados;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_solicitante_prestador_id_prestadores;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_lote_pagamento_id_lote_pagamentos;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_guia_origem_id_guias;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_cancelado_por_user_id_users;
ALTER TABLE public.guias VALIDATE CONSTRAINT fk_guias_guia_importacao_id_guia_importacoes;
ALTER TABLE public.guias_anexos VALIDATE CONSTRAINT fk_guias_anexos_guia_id_guias;
ALTER TABLE public.guias_atendimentos VALIDATE CONSTRAINT fk_guias_atendimentos_guia_itens_id_guias_itens;
ALTER TABLE public.guias_atendimentos VALIDATE CONSTRAINT fk_guias_atendimentos_usuario_id_users;
ALTER TABLE public.guias_auditoria VALIDATE CONSTRAINT fk_guias_auditoria_guia_itens_id_guias_itens;
ALTER TABLE public.guias_auditoria VALIDATE CONSTRAINT fk_guias_auditoria_analise_usuario_id_users;
ALTER TABLE public.guias_historico VALIDATE CONSTRAINT fk_guias_historico_guia_id_guias;
ALTER TABLE public.guias_historico VALIDATE CONSTRAINT fk_guias_historico_guia_item_id_guias_itens;
ALTER TABLE public.guias_historico VALIDATE CONSTRAINT fk_guias_historico_usuario_id_users;
ALTER TABLE public.guias_itens VALIDATE CONSTRAINT fk_guias_itens_guia_id_guias;
ALTER TABLE public.historico_credenciamentos VALIDATE CONSTRAINT fk_historico_credenciamentos_user_id_users;
ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_boleto_id_boletos;
ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_operadora_id_operadoras;
ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_prestador_id_prestadores;
ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_conveniado_id_conveniados;
ALTER TABLE public.lancamentos VALIDATE CONSTRAINT fk_lancamentos_grupo_verba_id_grupo_verbas;
ALTER TABLE public.lancamentos_guias VALIDATE CONSTRAINT fk_lancamentos_guias_lancamento_id_lancamentos;
ALTER TABLE public.lancamentos_guias VALIDATE CONSTRAINT fk_lancamentos_guias_guia_id_guias;
ALTER TABLE public.lote_pagamentos VALIDATE CONSTRAINT fk_lote_pagamentos_prestador_id_prestadores;
ALTER TABLE public.lote_pagamentos VALIDATE CONSTRAINT fk_lote_pagamentos_usuario_id_users;
ALTER TABLE public.lote_pagamentos VALIDATE CONSTRAINT fk_lote_pagamentos_lancamento_id_lancamentos;
ALTER TABLE public.materiais_itens VALIDATE CONSTRAINT fk_materiais_itens_material_edicao_id_material_edicoes;
ALTER TABLE public.materiais_itens VALIDATE CONSTRAINT fk_materiais_itens_material_id_materiais;
ALTER TABLE public.medicamento_brasindice VALIDATE CONSTRAINT fk_medicamento_brasindice_medicamento_edicao_id_medicamento_;
ALTER TABLE public.medicamento_brasindice VALIDATE CONSTRAINT fk_medicamento_brasindice_medicamento_id_medicamentos;
ALTER TABLE public.medicamentos VALIDATE CONSTRAINT fk_medicamentos_laboratorio_id_laboratorios;
ALTER TABLE public.medicamentos VALIDATE CONSTRAINT fk_medicamentos_medicamento_edicao_id_medicamento_edicoes;
ALTER TABLE public.mensalidades VALIDATE CONSTRAINT fk_mensalidades_conveniado_id_conveniados;
ALTER TABLE public.mensalidades VALIDATE CONSTRAINT fk_mensalidades_produto_preco_id_produtos_precos;
ALTER TABLE public.mensalidades VALIDATE CONSTRAINT fk_mensalidades_grupo_verba_id_grupo_verbas;
ALTER TABLE public.motivo_encerramentos VALIDATE CONSTRAINT fk_motivo_encerramentos_id_motivo_encerramentos;
ALTER TABLE public.operadora_user VALIDATE CONSTRAINT fk_operadora_user_operadora_id_operadoras;
ALTER TABLE public.operadora_user VALIDATE CONSTRAINT fk_operadora_user_user_id_users;
ALTER TABLE public.permission_role VALIDATE CONSTRAINT fk_permission_role_permission_id_permissions;
ALTER TABLE public.permission_role VALIDATE CONSTRAINT fk_permission_role_role_id_roles;
ALTER TABLE public.prestador_contrato_itens VALIDATE CONSTRAINT fk_prestador_contrato_itens_prestadores_contratos_id_prestad;
ALTER TABLE public.prestador_contrato_itens VALIDATE CONSTRAINT fk_prestador_contrato_itens_edicao_medicamento_id_medicament;
ALTER TABLE public.prestador_contrato_itens VALIDATE CONSTRAINT fk_prestador_contrato_itens_tabela_precos_id_tabela_precos;
ALTER TABLE public.prestador_contrato_itens VALIDATE CONSTRAINT fk_prestador_contrato_itens_motivo_encerramento_id_motivo_en;
ALTER TABLE public.prestador_contratos VALIDATE CONSTRAINT fk_prestador_contratos_prestador_id_prestadores;
ALTER TABLE public.prestador_especialidades VALIDATE CONSTRAINT fk_prestador_especialidades_prestador_id_prestadores;
ALTER TABLE public.prestador_especialidades VALIDATE CONSTRAINT fk_prestador_especialidades_especialidade_id_especialidades;
ALTER TABLE public.prestador_user VALIDATE CONSTRAINT fk_prestador_user_prestador_id_prestadores;
ALTER TABLE public.prestador_user VALIDATE CONSTRAINT fk_prestador_user_user_id_users;
ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_usuario_id_users;
ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_prestadores_classificacao_estabelecimento_id_;
ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_orgao_expedidor_uf_id_estados;
ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_naturalidade_cidade_id_cidades;
ALTER TABLE public.prestadores VALIDATE CONSTRAINT fk_prestadores_prestador_tipo_id_prestador_tipos;
ALTER TABLE public.procedimento_subgrupos VALIDATE CONSTRAINT fk_procedimento_subgrupos_grupo_id_procedimentos_grupos;
ALTER TABLE public.procedimentos VALIDATE CONSTRAINT fk_procedimentos_procedimento_subgrupo_id_procedimento_subgr;
ALTER TABLE public.produtos VALIDATE CONSTRAINT fk_produtos_operadora_id_operadoras;
ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT fk_produtos_precos_produto_id_produtos;
ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT fk_produtos_precos_tipo_vinculo_id_tipo_vinculos;
ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT fk_produtos_precos_grupo_verba_id_grupo_verbas;
ALTER TABLE public.regra_cooparticipacao VALIDATE CONSTRAINT fk_regra_cooparticipacao_produto_id_produtos;
ALTER TABLE public.regra_cooparticipacao_itens VALIDATE CONSTRAINT fk_regra_cooparticipacao_itens_regra_cooparticipacao_id_regr;
ALTER TABLE public.regra_cooparticipacao_procedimentos VALIDATE CONSTRAINT fk_regra_cooparticipacao_procedimentos_regra_cooparticipacao;
ALTER TABLE public.regra_cooparticipacao_procedimentos VALIDATE CONSTRAINT fk_regra_cooparticipacao_procedimentos_grupo_procedimento_id;
ALTER TABLE public.regra_cooparticipacao_procedimentos VALIDATE CONSTRAINT fk_regra_cooparticipacao_procedimentos_subgrupo_procedimento;
ALTER TABLE public.regra_cooparticipacao_procedimentos VALIDATE CONSTRAINT fk_regra_cooparticipacao_procedimentos_procedimento_id_proce;
ALTER TABLE public.remessa_desconto VALIDATE CONSTRAINT fk_remessa_desconto_empresa_id_empresas;
ALTER TABLE public.remessa_desconto_item VALIDATE CONSTRAINT fk_remessa_desconto_item_remessa_desconto_id_remessa_descont;
ALTER TABLE public.remessa_desconto_item VALIDATE CONSTRAINT fk_remessa_desconto_item_adesao_id_adesoes;
ALTER TABLE public.role_user VALIDATE CONSTRAINT fk_role_user_user_id_users;
ALTER TABLE public.role_user VALIDATE CONSTRAINT fk_role_user_role_id_roles;
ALTER TABLE public.secretarias VALIDATE CONSTRAINT fk_secretarias_empresa_id_empresas;
ALTER TABLE public.solicitacoes_atualizacao_cadastral VALIDATE CONSTRAINT fk_solicitacoes_atualizacao_cadastral_prestador_id_prestador;
ALTER TABLE public.solicitacoes_atualizacao_cadastral VALIDATE CONSTRAINT fk_solicitacoes_atualizacao_cadastral_conveniado_id_convenia;
ALTER TABLE public.solicitacoes_atualizacao_cadastral VALIDATE CONSTRAINT fk_solicitacoes_atualizacao_cadastral_cidade_id_cidades;
ALTER TABLE public.solicitacoes_credenciamento VALIDATE CONSTRAINT fk_solicitacoes_credenciamento_edital_credenciamento_id_edit;
ALTER TABLE public.solicitacoes_credenciamento_documentos VALIDATE CONSTRAINT fk_solicitacoes_credenciamento_documentos_solicitacoes_crede;
ALTER TABLE public.solicitacoes_credenciamento_documentos VALIDATE CONSTRAINT fk_solicitacoes_credenciamento_documentos_documento_credenci;
ALTER TABLE public.tabela_precos VALIDATE CONSTRAINT fk_tabela_precos_comunicado_edicao_id_comunicado_edicoes;
ALTER TABLE public.tabela_precos VALIDATE CONSTRAINT fk_tabela_precos_cbhpm_edicao_id_cbhpm_edicoes;
ALTER TABLE public.tabela_precos VALIDATE CONSTRAINT fk_tabela_precos_material_edicao_id_material_edicoes;
ALTER TABLE public.tabela_precos_itens VALIDATE CONSTRAINT fk_tabela_precos_itens_tabela_preco_id_tabela_precos;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT chk_conveniados_sexo;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT chk_conveniados_estado_civil;
ALTER TABLE public.conveniados VALIDATE CONSTRAINT chk_conveniados_pcd;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT chk_adesoes_tipo_cliente;
ALTER TABLE public.adesoes VALIDATE CONSTRAINT chk_adesoes_status;
ALTER TABLE public.boletos VALIDATE CONSTRAINT chk_boletos_valor_original;
ALTER TABLE public.boletos VALIDATE CONSTRAINT chk_boletos_status;
ALTER TABLE public.lancamentos VALIDATE CONSTRAINT chk_lancamentos_valor;
ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT chk_produtos_precos_idade;
ALTER TABLE public.produtos_precos VALIDATE CONSTRAINT chk_produtos_precos_valor;
ALTER TABLE public.guias_itens VALIDATE CONSTRAINT chk_guias_itens_quantidades;
ALTER TABLE public.users VALIDATE CONSTRAINT chk_users_email_format;

-- ============================================================



-- ============================================================
-- SECAO: 99 - LIMPAR PUBLIC (ATENCAO: apaga tudo)
-- Arquivo: sql_execucao_servsaude/99_limpar_public_seguro.sql
-- ============================================================

-- ============================================================
-- ServSaude - 99 - limpar objetos do schema public com seguranca
-- ATENCAO: este script apaga tabelas e dados do schema public.
-- Use apenas em banco de desenvolvimento, homologacao ou banco vazio/controlado.
-- ============================================================

-- ============================================================
-- 1. Remover todas as tabelas do schema public
-- ============================================================
DO $$
DECLARE
    r record;
BEGIN
    FOR r IN (
        SELECT tablename
        FROM pg_tables
        WHERE schemaname = 'public'
    ) LOOP
        EXECUTE format('DROP TABLE IF EXISTS public.%I CASCADE', r.tablename);
    END LOOP;
END $$;

-- ============================================================
-- 2. Remover sequences soltas do schema public
-- Observacao: sequences ligadas a tabelas normalmente ja caem no CASCADE.
-- ============================================================
DO $$
DECLARE
    r record;
BEGIN
    FOR r IN (
        SELECT sequence_name
        FROM information_schema.sequences
        WHERE sequence_schema = 'public'
    ) LOOP
        EXECUTE format('DROP SEQUENCE IF EXISTS public.%I CASCADE', r.sequence_name);
    END LOOP;
END $$;

-- ============================================================
-- 3. Remover functions criadas no public sem tocar em funcoes de extensoes
-- Diferenca importante:
-- - Usa oid::regprocedure, entao inclui a assinatura da funcao.
-- - Evita erro "function name is not unique".
-- - Ignora funcoes pertencentes a extensoes, como unaccent.
-- ============================================================
DO $$
DECLARE
    r record;
BEGIN
    FOR r IN (
        SELECT p.oid::regprocedure AS function_signature
        FROM pg_proc p
        JOIN pg_namespace n ON n.oid = p.pronamespace
        LEFT JOIN pg_depend d
            ON d.objid = p.oid
           AND d.deptype = 'e'
        WHERE n.nspname = 'public'
          AND d.objid IS NULL
    ) LOOP
        EXECUTE format('DROP FUNCTION IF EXISTS %s CASCADE', r.function_signature);
    END LOOP;
END $$;

-- ============================================================
-- 4. Remover types customizados do schema public
-- Enum = typtype 'e'; Composite/domains podem ser tratados depois se necessario.
-- ============================================================
DO $$
DECLARE
    r record;
BEGIN
    FOR r IN (
        SELECT t.typname
        FROM pg_type t
        JOIN pg_namespace n ON n.oid = t.typnamespace
        WHERE n.nspname = 'public'
          AND t.typtype = 'e'
    ) LOOP
        EXECUTE format('DROP TYPE IF EXISTS public.%I CASCADE', r.typname);
    END LOOP;
END $$;

-- ============================================================
-- 5. Verificacao final
-- ============================================================
SELECT tablename
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;

