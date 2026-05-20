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
