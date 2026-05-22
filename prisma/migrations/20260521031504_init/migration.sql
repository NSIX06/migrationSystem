-- CreateEnum
CREATE TYPE "SexoEnum" AS ENUM ('MASCULINO', 'FEMININO');

-- CreateEnum
CREATE TYPE "EstadoCivilEnum" AS ENUM ('SOLTEIRO', 'CASADO', 'SEPARADO', 'DIVORCIADO', 'VIUVO', 'UNIAO_ESTAVEL', 'OUTRO');

-- CreateEnum
CREATE TYPE "PcdEnum" AS ENUM ('SIM', 'NAO');

-- CreateEnum
CREATE TYPE "StatusAdesaoEnum" AS ENUM ('ATIVO', 'SUSPENSO', 'ENCERRADO');

-- CreateEnum
CREATE TYPE "TipoClienteEnum" AS ENUM ('TITULAR', 'DEPENDENTE', 'AGREGADO');

-- CreateEnum
CREATE TYPE "TipoPrestadorEnum" AS ENUM ('PESSOA_FISICA', 'PESSOA_JURIDICA');

-- CreateEnum
CREATE TYPE "StatusGuiaEnum" AS ENUM ('SOLICITADA', 'AUTORIZADA', 'NEGADA', 'EM_AUDITORIA', 'CANCELADA', 'FATURADA');

-- CreateEnum
CREATE TYPE "TipoGuiaEnum" AS ENUM ('CONSULTA', 'SADT', 'INTERNACAO', 'HONORARIO', 'OUTROS');

-- CreateEnum
CREATE TYPE "CaraterAtendimentoEnum" AS ENUM ('ELETIVO', 'URGENCIA_EMERGENCIA');

-- CreateEnum
CREATE TYPE "StatusLancamentoEnum" AS ENUM ('ABERTO', 'PAGO', 'CANCELADO', 'VENCIDO');

-- CreateEnum
CREATE TYPE "TipoLancamentoEnum" AS ENUM ('MENSALIDADE', 'COPARTICIPACAO', 'PAGAMENTO_PRESTADOR', 'ESTORNO', 'OUTROS');

-- CreateEnum
CREATE TYPE "StatusBoletoEnum" AS ENUM ('EMITIDO', 'PAGO', 'CANCELADO', 'VENCIDO', 'BAIXADO_MANUALMENTE');

-- CreateEnum
CREATE TYPE "StatusLoteEnum" AS ENUM ('ABERTO', 'PROCESSADO', 'PAGO');

-- CreateEnum
CREATE TYPE "TipoGuiaItemEnum" AS ENUM ('PROCEDIMENTO', 'MEDICAMENTO', 'MATERIAL', 'TAXA', 'HONORARIO');

-- CreateEnum
CREATE TYPE "TipoAbrangenciaEnum" AS ENUM ('MUNICIPAL', 'ESTADUAL', 'NACIONAL');

-- CreateEnum
CREATE TYPE "TipoAcomodacaoEnum" AS ENUM ('ENFERMARIA', 'APARTAMENTO', 'UTI');

-- CreateEnum
CREATE TYPE "TipoContratacaoEnum" AS ENUM ('COLETIVO_EMPRESARIAL', 'COLETIVO_POR_ADESAO', 'INDIVIDUAL');

-- CreateEnum
CREATE TYPE "TipoCarenciaEnum" AS ENUM ('SEM_CARENCIA', 'CARENCIA_PADRAO', 'CARENCIA_REDUZIDA');

-- CreateEnum
CREATE TYPE "StatusCredenciamentoEnum" AS ENUM ('SOLICITADO', 'EM_ANALISE', 'APROVADO', 'REPROVADO', 'CANCELADO');

-- CreateTable
CREATE TABLE "estados" (
    "id" BIGSERIAL NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "uf" VARCHAR(2) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "estados_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cidades" (
    "id" BIGSERIAL NOT NULL,
    "estado_id" BIGINT NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "cidades_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "enderecos" (
    "id" BIGSERIAL NOT NULL,
    "cidade_id" BIGINT NOT NULL,
    "entidade_tipo" VARCHAR(50) NOT NULL,
    "entidade_id" BIGINT NOT NULL,
    "tipo" INTEGER NOT NULL,
    "cep" TEXT NOT NULL,
    "logradouro" TEXT NOT NULL,
    "numero" TEXT,
    "complemento" TEXT,
    "bairro" TEXT,
    "principal" BOOLEAN NOT NULL DEFAULT false,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "enderecos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "operadoras" (
    "id" BIGSERIAL NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "razao_social" VARCHAR(255) NOT NULL,
    "tipo" SMALLINT NOT NULL,
    "cpf_cnpj" VARCHAR(255) NOT NULL,
    "inscricao_municipal" VARCHAR(255),
    "inscricao_estadual" VARCHAR(255),
    "fone" VARCHAR(255),
    "email" VARCHAR(255),
    "codigo_ans" VARCHAR(6),
    "tipo_declarante" INTEGER NOT NULL,
    "cpf_responsavel" VARCHAR(255) NOT NULL,
    "indicador_situacao_declaracao" VARCHAR(255) NOT NULL,
    "cnes" VARCHAR(7),
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "percentual_max_desconto_coparticipacao" DECIMAL(8,2) NOT NULL DEFAULT 24.9,
    "boleto_nr_convenio" INTEGER,
    "boleto_nr_carteira" INTEGER,
    "boleto_ambiente" INTEGER DEFAULT 1,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "operadoras_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" BIGSERIAL NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "slug" VARCHAR(255) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permissoes" (
    "id" BIGSERIAL NOT NULL,
    "modulo" VARCHAR(255) NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "slug" VARCHAR(255) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "descricao" VARCHAR(255),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "permissoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role_permissoes" (
    "role_id" BIGINT NOT NULL,
    "permissao_id" BIGINT NOT NULL,

    CONSTRAINT "role_permissoes_pkey" PRIMARY KEY ("role_id","permissao_id")
);

-- CreateTable
CREATE TABLE "usuario_roles" (
    "user_id" UUID NOT NULL,
    "role_id" BIGINT NOT NULL,

    CONSTRAINT "usuario_roles_pkey" PRIMARY KEY ("user_id","role_id")
);

-- CreateTable
CREATE TABLE "operadora_usuarios" (
    "operadora_id" BIGINT NOT NULL,
    "user_id" UUID NOT NULL,

    CONSTRAINT "operadora_usuarios_pkey" PRIMARY KEY ("operadora_id","user_id")
);

-- CreateTable
CREATE TABLE "empresas" (
    "id" BIGSERIAL NOT NULL,
    "tipo" SMALLINT NOT NULL,
    "cpf_cnpj" VARCHAR(255) NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "razao_social" VARCHAR(255) NOT NULL,
    "abreviado" TEXT,
    "fone" VARCHAR(255),
    "email" VARCHAR(255),
    "contato" VARCHAR(255),
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "empresas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "empresa_usuarios" (
    "empresa_id" BIGINT NOT NULL,
    "user_id" UUID NOT NULL,

    CONSTRAINT "empresa_usuarios_pkey" PRIMARY KEY ("empresa_id","user_id")
);

-- CreateTable
CREATE TABLE "secretarias" (
    "id" BIGSERIAL NOT NULL,
    "empresa_id" BIGINT NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "razao_social" VARCHAR(255) NOT NULL,
    "cpf_cnpj" VARCHAR(255),
    "abreviado" VARCHAR(255),
    "fone" VARCHAR(255),
    "email" VARCHAR(255),
    "contato" VARCHAR(255),
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "secretarias_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cargos" (
    "id" BIGSERIAL NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "cargos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conveniados" (
    "id" BIGSERIAL NOT NULL,
    "orgao_expedidor_uf_id" BIGINT,
    "naturalidade_cidade_id" BIGINT NOT NULL,
    "user_id" UUID NOT NULL,
    "cargo_id" BIGINT,
    "nome" VARCHAR(255) NOT NULL,
    "cpf" VARCHAR(14) NOT NULL,
    "data_nascimento" DATE NOT NULL,
    "sexo" "SexoEnum" NOT NULL,
    "rg" VARCHAR(255),
    "orgao_expedidor" VARCHAR(255),
    "cns" VARCHAR(255),
    "nome_pai" VARCHAR(255),
    "nome_mae" VARCHAR(255) NOT NULL,
    "fone1" VARCHAR(255),
    "fone2" VARCHAR(255),
    "email" VARCHAR(255),
    "foto_url" TEXT,
    "estado_civil" "EstadoCivilEnum" NOT NULL DEFAULT 'SOLTEIRO',
    "pcd" "PcdEnum" NOT NULL DEFAULT 'NAO',
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "conveniados_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conveniado_salarios" (
    "id" BIGSERIAL NOT NULL,
    "conveniado_id" BIGINT NOT NULL,
    "salario" DECIMAL(8,2) NOT NULL,
    "data_competencia" DATE NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "conveniado_salarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gestantes" (
    "id" BIGSERIAL NOT NULL,
    "conveniado_id" BIGINT NOT NULL,
    "data_inicio_gestacao" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_final_gestacao" DATE,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "gestantes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "grau_parentesco" (
    "id" BIGSERIAL NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "grau_parentesco_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tipo_vinculos" (
    "id" BIGSERIAL NOT NULL,
    "tipo" SMALLINT NOT NULL,
    "descricao" TEXT NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "tipo_vinculos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "produtos" (
    "id" BIGSERIAL NOT NULL,
    "operadora_id" BIGINT NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "abrangencia" "TipoAbrangenciaEnum" NOT NULL,
    "tipo_contratacao" "TipoContratacaoEnum" NOT NULL,
    "tipo_carencia" "TipoCarenciaEnum" NOT NULL,
    "tipo_acomodacao" "TipoAcomodacaoEnum" NOT NULL,
    "data_inicio" DATE NOT NULL,
    "data_fim" DATE,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "produtos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "produtos_precos" (
    "id" BIGSERIAL NOT NULL,
    "produto_id" BIGINT NOT NULL,
    "tipo_vinculo_id" BIGINT,
    "grupo_verba_id" BIGINT,
    "idade_inicial" INTEGER NOT NULL,
    "idade_final" INTEGER NOT NULL,
    "tipo_cobranca" INTEGER NOT NULL,
    "tipo_cliente" "TipoClienteEnum" NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "valor" DECIMAL(8,2) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "produtos_precos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "empresa_produtos" (
    "empresa_id" BIGINT NOT NULL,
    "produto_id" BIGINT NOT NULL,

    CONSTRAINT "empresa_produtos_pkey" PRIMARY KEY ("empresa_id","produto_id")
);

-- CreateTable
CREATE TABLE "regras_coparticipacao" (
    "id" BIGSERIAL NOT NULL,
    "produto_id" BIGINT NOT NULL,
    "nome" TEXT NOT NULL,
    "tempo_carencia" INTEGER,
    "carencia" BOOLEAN NOT NULL,
    "sem_limite_para_gestante" BOOLEAN NOT NULL DEFAULT false,
    "auditoria" BOOLEAN NOT NULL,
    "ativo" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "regras_coparticipacao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "regras_coparticipacao_itens" (
    "id" BIGSERIAL NOT NULL,
    "regra_coparticipacao_id" BIGINT NOT NULL,
    "qtde_inicial" INTEGER NOT NULL,
    "qtde_final" INTEGER NOT NULL,
    "percentual_coparticipacao" DECIMAL(8,2) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "regras_coparticipacao_itens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "regras_coparticipacao_procedimentos" (
    "id" BIGSERIAL NOT NULL,
    "tipo" SMALLINT NOT NULL DEFAULT 1,
    "regra_coparticipacao_id" BIGINT NOT NULL,
    "grupo_procedimento_id" INTEGER NOT NULL,
    "subgrupo_procedimento_id" INTEGER,
    "procedimento_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "regras_coparticipacao_procedimentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "motivo_encerramentos" (
    "id" BIGSERIAL NOT NULL,
    "motivo" VARCHAR(255) NOT NULL,
    "tipo" SMALLINT NOT NULL DEFAULT 1,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "motivo_encerramentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adesoes" (
    "id" BIGSERIAL NOT NULL,
    "operadora_id" BIGINT NOT NULL,
    "empresa_id" BIGINT,
    "secretaria_id" BIGINT,
    "conveniado_id" BIGINT NOT NULL,
    "produto_id" BIGINT NOT NULL,
    "produto_preco_id" BIGINT,
    "motivo_encerramento_id" BIGINT,
    "grupo_familiar" INTEGER,
    "matricula" VARCHAR(255),
    "tipo_cliente" "TipoClienteEnum" NOT NULL,
    "status" "StatusAdesaoEnum" NOT NULL DEFAULT 'ATIVO',
    "data_inicio" DATE NOT NULL,
    "data_fim" DATE,
    "data_primeiro_pgto" DATE,
    "justificativa_encerramento" VARCHAR(255),
    "dv" VARCHAR(255),
    "salario_atual" DECIMAL(13,2),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "adesoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adesao_reducao_margem" (
    "id" BIGSERIAL NOT NULL,
    "adesao_id" BIGINT NOT NULL,
    "tipo_reducao" INTEGER NOT NULL,
    "valor" DECIMAL(8,2) NOT NULL,
    "data_inicio" DATE NOT NULL,
    "data_fim" DATE NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "adesao_reducao_margem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prestador_tipos" (
    "id" BIGSERIAL NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "prestador_tipos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prestadores_classificacao_estabelecimento" (
    "id" BIGSERIAL NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "codigo" VARCHAR(255) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "prestadores_classificacao_estabelecimento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "especialidades" (
    "id" BIGSERIAL NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "cbo" VARCHAR(255) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "especialidades_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prestadores" (
    "id" BIGSERIAL NOT NULL,
    "prestadores_classificacao_estabelecimento_id" BIGINT NOT NULL,
    "prestador_tipo_id" BIGINT,
    "orgao_expedidor_uf_id" BIGINT,
    "naturalidade_estado_id" BIGINT,
    "naturalidade_cidade_id" BIGINT,
    "user_id" UUID,
    "tipo" "TipoPrestadorEnum" NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "razao_social" VARCHAR(255) NOT NULL,
    "abreviado" TEXT,
    "cpf_cnpj" VARCHAR(255) NOT NULL,
    "data_nascimento" DATE,
    "rg" VARCHAR(255),
    "orgao_expedidor" VARCHAR(255),
    "nome_mae" VARCHAR(255),
    "fone" VARCHAR(255),
    "email" VARCHAR(255),
    "financeiro_contato_nome" VARCHAR(255),
    "financeiro_contato_fone" VARCHAR(255),
    "financeiro_contato_email" VARCHAR(255),
    "tipo_conselho_classe" SMALLINT,
    "numero_conselho_classe" VARCHAR(255),
    "procedimentos" BOOLEAN NOT NULL DEFAULT false,
    "material" BOOLEAN NOT NULL DEFAULT false,
    "taxa" BOOLEAN NOT NULL DEFAULT false,
    "medicamentos" BOOLEAN NOT NULL DEFAULT false,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "prestadores_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prestador_usuarios" (
    "prestador_id" BIGINT NOT NULL,
    "user_id" UUID NOT NULL,

    CONSTRAINT "prestador_usuarios_pkey" PRIMARY KEY ("prestador_id","user_id")
);

-- CreateTable
CREATE TABLE "prestador_especialidades" (
    "prestador_id" BIGINT NOT NULL,
    "especialidade_id" BIGINT NOT NULL,

    CONSTRAINT "prestador_especialidades_pkey" PRIMARY KEY ("prestador_id","especialidade_id")
);

-- CreateTable
CREATE TABLE "prestador_contratos" (
    "id" BIGSERIAL NOT NULL,
    "prestador_id" BIGINT NOT NULL,
    "data" DATE NOT NULL,
    "codigo" VARCHAR(255) NOT NULL,
    "ocorrencia" VARCHAR(255),
    "objeto" VARCHAR(255) NOT NULL,
    "observacoes" VARCHAR(255),
    "reclamacoes" VARCHAR(255),
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "prestador_contratos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prestador_contrato_itens" (
    "id" BIGSERIAL NOT NULL,
    "prestadores_contratos_id" BIGINT NOT NULL,
    "edicao_medicamento_id" BIGINT NOT NULL,
    "acrescimo_medicamentos" DECIMAL(8,2),
    "tabela_precos_id" BIGINT,
    "motivo_encerramento_id" BIGINT,
    "data_inicio" DATE NOT NULL,
    "data_fim" DATE NOT NULL,
    "tipo" SMALLINT NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "orcamento_previsto" DECIMAL(8,2),
    "data_encerramento" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "prestador_contrato_itens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "deflatores" (
    "id" BIGSERIAL NOT NULL,
    "prestadores_contratos_id" BIGINT NOT NULL,
    "procedimento_grupo_id" INTEGER NOT NULL,
    "tipo" SMALLINT NOT NULL,
    "percentual" DECIMAL(8,2) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "deflatores_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contrato_profissionais" (
    "id" BIGSERIAL NOT NULL,
    "contrato_id" BIGINT NOT NULL,
    "prestador_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "contrato_profissionais_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "procedimentos_grupos" (
    "id" SERIAL NOT NULL,
    "codigo" VARCHAR(255) NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "procedimentos_grupos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "procedimento_subgrupos" (
    "id" SERIAL NOT NULL,
    "grupo_id" INTEGER NOT NULL,
    "codigo" VARCHAR(255) NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "perc_reducao_segundo_procedimento" DECIMAL(8,2) NOT NULL,
    "perc_reducao_terceiro_procedimento_em_diante" DECIMAL(8,2) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "procedimento_subgrupos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "procedimentos" (
    "id" SERIAL NOT NULL,
    "procedimento_subgrupo_id" INTEGER,
    "codigo" TEXT NOT NULL,
    "descricao" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "procedimentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cbhpm_edicoes" (
    "id" BIGSERIAL NOT NULL,
    "ano_edicao" INTEGER NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "cbhpm_edicoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "porte_anestesicos" (
    "porte_anestesico" VARCHAR(255) NOT NULL,
    "porte" VARCHAR(255),

    CONSTRAINT "porte_anestesicos_pkey" PRIMARY KEY ("porte_anestesico")
);

-- CreateTable
CREATE TABLE "cbhpm" (
    "id" BIGSERIAL NOT NULL,
    "cbhpm_edicao_id" BIGINT NOT NULL,
    "procedimento_id" INTEGER NOT NULL,
    "codigo_porte" VARCHAR(255) NOT NULL,
    "fracao_porte" DECIMAL(8,2) NOT NULL DEFAULT 1,
    "qtde_uco" DECIMAL(13,3) NOT NULL,
    "qtde_filme" DECIMAL(13,3) NOT NULL,
    "porte_anestesico_id" TEXT,
    "nro_auxiliares" INTEGER,
    "incidencia" INTEGER,
    "ur" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "cbhpm_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "comunicado_edicoes" (
    "id" BIGSERIAL NOT NULL,
    "ano_edicao" INTEGER NOT NULL,
    "uco" DECIMAL(8,2) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "comunicado_edicoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "comunicado_portes" (
    "id" BIGSERIAL NOT NULL,
    "comunicado_edicao_id" BIGINT NOT NULL,
    "codigo_porte" VARCHAR(255) NOT NULL,
    "valor" DECIMAL(8,2) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "comunicado_portes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "material_edicoes" (
    "id" BIGSERIAL NOT NULL,
    "edicao" VARCHAR(255) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "material_edicoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "materiais" (
    "id" BIGSERIAL NOT NULL,
    "tipo" INTEGER NOT NULL,
    "codigo" VARCHAR(255) NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "materiais_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "materiais_itens" (
    "id" BIGSERIAL NOT NULL,
    "material_edicao_id" BIGINT NOT NULL,
    "material_id" BIGINT NOT NULL,
    "valor" DECIMAL(8,2) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "materiais_itens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "laboratorios" (
    "id" BIGSERIAL NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "laboratorios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "medicamento_edicoes" (
    "id" BIGSERIAL NOT NULL,
    "edicao" VARCHAR(255) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "medicamento_edicoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "medicamentos" (
    "id" BIGSERIAL NOT NULL,
    "laboratorio_id" BIGINT NOT NULL,
    "medicamento_edicao_id" BIGINT NOT NULL,
    "codigo" VARCHAR(255) NOT NULL,
    "bras" VARCHAR(255) NOT NULL,
    "in_" VARCHAR(255) NOT NULL,
    "dice" VARCHAR(255) NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "apresentacao" VARCHAR(255) NOT NULL,
    "qtde_embalagem" INTEGER NOT NULL,
    "ultima_versao" INTEGER NOT NULL,
    "ean" VARCHAR(255) NOT NULL,
    "ggrem" VARCHAR(255) NOT NULL,
    "anvisa" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "medicamentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "medicamento_brasindice" (
    "id" BIGSERIAL NOT NULL,
    "medicamento_edicao_id" BIGINT NOT NULL,
    "medicamento_id" BIGINT NOT NULL,
    "pmc" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "pfab" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "fracao_pfab" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "fracao_pmc" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "medicamento_brasindice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tabela_precos" (
    "id" BIGSERIAL NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "comunicado_edicao_id" BIGINT NOT NULL,
    "cbhpm_edicao_id" BIGINT NOT NULL,
    "material_edicao_id" BIGINT NOT NULL,
    "valor_uco" DECIMAL(8,2) NOT NULL,
    "valor_filme" DECIMAL(8,2) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "tabela_precos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tabela_precos_itens" (
    "id" BIGSERIAL NOT NULL,
    "tabela_preco_id" BIGINT NOT NULL,
    "tipo" SMALLINT NOT NULL DEFAULT 1,
    "referencia_id" INTEGER NOT NULL,
    "valor_porte" DECIMAL(8,2) NOT NULL,
    "fracao_porte" DECIMAL(8,2) NOT NULL,
    "qtde_uco" DECIMAL(8,2) NOT NULL,
    "valor_uco" DECIMAL(8,2) NOT NULL,
    "qtde_filme" DECIMAL(8,2) NOT NULL,
    "valor_filme" DECIMAL(8,2) NOT NULL,
    "valor_total" DECIMAL(8,2) NOT NULL,
    "valor_customizado" DECIMAL(8,2),
    "valor_final" DECIMAL(8,2) NOT NULL,
    "preco_customizado" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tabela_precos_itens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "taxas" (
    "id" BIGSERIAL NOT NULL,
    "codigo" VARCHAR(255) NOT NULL,
    "descricao" VARCHAR(255),
    "tipo" SMALLINT NOT NULL DEFAULT 1,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "taxas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cid" (
    "id" BIGSERIAL NOT NULL,
    "codigo" VARCHAR(255) NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "sexo_aplicavel" VARCHAR(255) NOT NULL,
    "grave" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "cid_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "guia_importacoes" (
    "id" BIGSERIAL NOT NULL,
    "sequencial_transacao" INTEGER NOT NULL,
    "lote" INTEGER NOT NULL,
    "data_hora_arquivo" TIMESTAMP(3) NOT NULL,
    "prestador_id" BIGINT,
    "user_id" UUID,
    "versao_layout" VARCHAR(255) NOT NULL,
    "arquivo" VARCHAR(255) NOT NULL,
    "disco" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "guia_importacoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "guia_motivo_encerramento" (
    "id" BIGSERIAL NOT NULL,
    "codigo" VARCHAR(255) NOT NULL,
    "termo" VARCHAR(255) NOT NULL,
    "data_inicio_vigencia" DATE,
    "data_fim_vigencia" DATE,
    "data_fim_implantacao" DATE,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "guia_motivo_encerramento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "guias" (
    "id" BIGSERIAL NOT NULL,
    "operadora_id" BIGINT NOT NULL,
    "prestador_id" BIGINT,
    "profissional_id" BIGINT,
    "conveniado_id" BIGINT,
    "solicitante_prestador_id" BIGINT,
    "lote_pagamento_id" BIGINT,
    "guia_importacao_id" BIGINT,
    "guia_origem_id" BIGINT,
    "cancelado_por_user_id" UUID,
    "usuario_emissor_id" UUID,
    "data_hora" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tipo_lancamento" SMALLINT NOT NULL DEFAULT 1,
    "tipo_autorizacao" SMALLINT NOT NULL DEFAULT 1,
    "tipo" "TipoGuiaEnum" NOT NULL DEFAULT 'CONSULTA',
    "carater_atendimento" "CaraterAtendimentoEnum" NOT NULL DEFAULT 'ELETIVO',
    "indicacao_clinica" VARCHAR(255),
    "observacoes" VARCHAR(255),
    "observacoes_internas" VARCHAR(255),
    "urgente" BOOLEAN NOT NULL DEFAULT false,
    "conferido" BOOLEAN NOT NULL DEFAULT false,
    "status" "StatusGuiaEnum" NOT NULL DEFAULT 'SOLICITADA',
    "data_hora_cancalamento" TIMESTAMP(3),
    "motivo_cancelamento" VARCHAR(255),
    "justifica_para_auditoria" VARCHAR(255),
    "lote_importacao" INTEGER,
    "numero_guia_prestador" INTEGER,
    "data_autorizacao" DATE,
    "senha" INTEGER,
    "data_validade_senha" DATE,
    "tipo_autenticacao" SMALLINT,
    "codigo_autenticacao" VARCHAR(255),
    "autenticada" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "guias_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "guias_itens" (
    "id" BIGSERIAL NOT NULL,
    "guia_id" BIGINT,
    "tipo" "TipoGuiaItemEnum" NOT NULL DEFAULT 'PROCEDIMENTO',
    "referencia_tabela" VARCHAR(255) NOT NULL,
    "referencia_id" INTEGER,
    "data_hora_emissao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_hora_autorizacao" TIMESTAMP(3),
    "data_hora_atendimento" TIMESTAMP(3),
    "data_execucao" DATE,
    "quantidade_solicitada" DECIMAL(8,2),
    "quantidade_atendida" DECIMAL(8,2),
    "quantidade_glosa" DECIMAL(8,2),
    "quantidade_autorizada" DECIMAL(8,2),
    "valor_unitario" DECIMAL(8,2),
    "valor_unitario_glosa" DECIMAL(8,2),
    "percentual_cooparticipacao" DECIMAL(8,2),
    "valor_unitario_coparticipacao" DECIMAL(8,2),
    "valor_total_coparticipacao" DECIMAL(8,2),
    "percentual_item" DECIMAL(8,2),
    "quantidade_faturada" DECIMAL(8,2),
    "valor_unitario_faturado" DECIMAL(8,2),
    "valor_total_faturado" DECIMAL(8,2),
    "valor_total" DECIMAL(8,2),
    "reducao_acrescimo" DECIMAL(8,2),
    "grau_part" INTEGER,
    "status" "StatusGuiaEnum" NOT NULL DEFAULT 'SOLICITADA',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "guias_itens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "guias_historico" (
    "id" BIGSERIAL NOT NULL,
    "guia_id" BIGINT NOT NULL,
    "guia_item_id" BIGINT,
    "usuario_id" UUID NOT NULL,
    "data_hora" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "historico" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "guias_historico_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "guias_auditoria" (
    "id" BIGSERIAL NOT NULL,
    "guia_itens_id" BIGINT NOT NULL,
    "analise_usuario_id" UUID NOT NULL,
    "data_hora_analise" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "quantidade_autorizada" DECIMAL(8,2) NOT NULL,
    "justificativa" VARCHAR(255),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "guias_auditoria_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "guias_atendimentos" (
    "id" BIGSERIAL NOT NULL,
    "guia_itens_id" BIGINT,
    "usuario_id" UUID,
    "data_hora" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "quantidade" DECIMAL(8,2),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "guias_atendimentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "guias_anexos" (
    "id" BIGSERIAL NOT NULL,
    "guia_id" BIGINT,
    "nome" VARCHAR(255),
    "arquivo_url" VARCHAR(255),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "guias_anexos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bancos" (
    "id" BIGSERIAL NOT NULL,
    "codigo" VARCHAR(255) NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "bancos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dados_bancarios" (
    "id" BIGSERIAL NOT NULL,
    "banco_id" BIGINT NOT NULL,
    "tipo" SMALLINT NOT NULL,
    "agencia" VARCHAR(255),
    "agencia_dv" VARCHAR(255),
    "conta" VARCHAR(255),
    "conta_dv" VARCHAR(255),
    "operacao" VARCHAR(255),
    "pix" VARCHAR(255),
    "pix_tipo" VARCHAR(255),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "dados_bancarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "grupo_verbas" (
    "id" BIGSERIAL NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "grupo_verbas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "empresas_verbas" (
    "id" BIGSERIAL NOT NULL,
    "empresa_id" BIGINT NOT NULL,
    "grupo_verba_id" BIGINT,
    "codigo" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "empresas_verbas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "lote_pagamentos" (
    "id" BIGSERIAL NOT NULL,
    "prestador_id" BIGINT NOT NULL,
    "usuario_id" UUID NOT NULL,
    "lancamento_id" BIGINT,
    "data_hora" TIMESTAMP(3) NOT NULL,
    "referencia_pagamento" DATE NOT NULL,
    "status" "StatusLoteEnum" NOT NULL DEFAULT 'ABERTO',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "lote_pagamentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "lancamentos" (
    "id" BIGSERIAL NOT NULL,
    "operadora_id" BIGINT NOT NULL,
    "prestador_id" BIGINT,
    "conveniado_id" BIGINT,
    "grupo_verba_id" BIGINT,
    "tipo" SMALLINT NOT NULL DEFAULT 1,
    "tipo_lancamento" "TipoLancamentoEnum" NOT NULL DEFAULT 'MENSALIDADE',
    "data_hora" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_vencimento" TIMESTAMP(3) NOT NULL,
    "data_baixa" TIMESTAMP(3),
    "tipo_pagamento" SMALLINT NOT NULL DEFAULT 1,
    "competencia_folha" VARCHAR(255),
    "descricao" VARCHAR(255),
    "valor" DECIMAL(8,2) NOT NULL,
    "status" "StatusLancamentoEnum" NOT NULL DEFAULT 'ABERTO',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "lancamentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "lancamentos_guias" (
    "id" BIGSERIAL NOT NULL,
    "lancamento_id" BIGINT NOT NULL,
    "guia_id" BIGINT NOT NULL,
    "valor" DECIMAL(8,2) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "lancamentos_guias_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "boletos" (
    "id" BIGSERIAL NOT NULL,
    "operadora_id" BIGINT NOT NULL,
    "pagador_cidade_id" BIGINT NOT NULL,
    "data_emissao" DATE NOT NULL,
    "data_vencimento" DATE NOT NULL,
    "valor_original" DECIMAL(8,2) NOT NULL,
    "nosso_numero" INTEGER NOT NULL,
    "pagador_tipo_inscricao" VARCHAR(255) NOT NULL,
    "pagador_numero_inscricao" VARCHAR(255) NOT NULL,
    "pagador_nome" VARCHAR(255) NOT NULL,
    "pagador_endereco" VARCHAR(255) NOT NULL,
    "pagador_cep" VARCHAR(255) NOT NULL,
    "pagador_bairro" VARCHAR(255) NOT NULL,
    "demonstrativo" TEXT,
    "indicador_permissao_recebimento_parcial" VARCHAR(255) NOT NULL DEFAULT 'N',
    "indicador_pix" VARCHAR(255) NOT NULL DEFAULT 'S',
    "pix_qrcode" VARCHAR(255),
    "status" "StatusBoletoEnum" NOT NULL DEFAULT 'EMITIDO',
    "data_baixa" DATE,
    "boleto_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "boletos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "boleto_lancamentos" (
    "id" BIGSERIAL NOT NULL,
    "boleto_id" BIGINT NOT NULL,
    "lancamento_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "boleto_lancamentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mensalidades" (
    "id" BIGSERIAL NOT NULL,
    "conveniado_id" BIGINT NOT NULL,
    "produto_preco_id" BIGINT NOT NULL,
    "grupo_verba_id" BIGINT,
    "competencia" DATE NOT NULL,
    "salario" DECIMAL(8,2) NOT NULL,
    "percentual" DECIMAL(8,2) NOT NULL,
    "valor" DECIMAL(8,2) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "mensalidades_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "remessa_desconto" (
    "id" BIGSERIAL NOT NULL,
    "empresa_id" BIGINT NOT NULL,
    "competencia" DATE NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "remessa_desconto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "remessa_desconto_item" (
    "id" BIGSERIAL NOT NULL,
    "remessa_desconto_id" BIGINT NOT NULL,
    "adesao_id" BIGINT NOT NULL,
    "matricula" VARCHAR(255) NOT NULL,
    "salario" DECIMAL(8,2) NOT NULL,
    "desconto_maximo" DECIMAL(8,2) NOT NULL,
    "valor_divida" DECIMAL(8,2) NOT NULL,
    "coparticipacao" DECIMAL(8,2) NOT NULL,
    "codigo_evento" VARCHAR(255) NOT NULL,
    "valor" DECIMAL(8,2) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "remessa_desconto_item_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "editais_credenciamento" (
    "id" BIGSERIAL NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "data_inicio" DATE NOT NULL,
    "data_fim" DATE NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "editais_credenciamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "documentos_credenciamento" (
    "id" BIGSERIAL NOT NULL,
    "descricao" VARCHAR(255) NOT NULL,
    "complemento_descricao" VARCHAR(255),
    "obrigatorio" BOOLEAN NOT NULL DEFAULT true,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "tipo_pessoa" INTEGER NOT NULL DEFAULT 1,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "documentos_credenciamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "edital_credenciamento_documentos" (
    "edital_id" BIGINT NOT NULL,
    "documento_credenciamento_id" BIGINT NOT NULL,
    "obrigatorio" BOOLEAN NOT NULL DEFAULT false,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "edital_credenciamento_documentos_pkey" PRIMARY KEY ("edital_id","documento_credenciamento_id")
);

-- CreateTable
CREATE TABLE "solicitacoes_credenciamento" (
    "id" BIGSERIAL NOT NULL,
    "edital_credenciamento_id" BIGINT NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "tipo" INTEGER NOT NULL DEFAULT 1,
    "cpf_cnpj" VARCHAR(255) NOT NULL,
    "responsavel" VARCHAR(255) NOT NULL,
    "telefone" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "solicitacoes_credenciamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "solicitacoes_credenciamento_documentos" (
    "id" BIGSERIAL NOT NULL,
    "solicitacoes_credenciamento_id" BIGINT NOT NULL,
    "documento_credenciamento_id" BIGINT NOT NULL,
    "arquivo_url" TEXT,
    "nome_arquivo" VARCHAR(255),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "solicitacoes_credenciamento_documentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "historico_credenciamentos" (
    "id" BIGSERIAL NOT NULL,
    "solicitacao_credencimento_id" BIGINT NOT NULL,
    "user_id" UUID NOT NULL,
    "motivo" VARCHAR(255) NOT NULL,
    "status" "StatusCredenciamentoEnum" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "historico_credenciamentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_log" (
    "id" BIGSERIAL NOT NULL,
    "data_hora" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "usuario_id" UUID,
    "usuario_nome" TEXT,
    "ip" TEXT,
    "navegador" TEXT,
    "recurso" TEXT,
    "registro_id" INTEGER,
    "action" SMALLINT,
    "log" TEXT,
    "url" VARCHAR(255),

    CONSTRAINT "audit_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "solicitacoes_atualizacao_cadastral" (
    "id" BIGSERIAL NOT NULL,
    "prestador_id" BIGINT,
    "conveniado_id" BIGINT,
    "cidade_id" BIGINT NOT NULL,
    "tipo" SMALLINT NOT NULL DEFAULT 1,
    "data_solicitacao" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "endereco" VARCHAR(255),
    "endereco_nro" VARCHAR(255),
    "complemento" VARCHAR(255),
    "bairro" VARCHAR(255),
    "cep" VARCHAR(255),
    "email" VARCHAR(255),
    "telefone" VARCHAR(255),
    "celular" VARCHAR(255),
    "observacoes" VARCHAR(255),
    "comprovante_endereco_url" VARCHAR(255),
    "foto_url" VARCHAR(255),
    "status" SMALLINT NOT NULL DEFAULT 1,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "solicitacoes_atualizacao_cadastral_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fiscal_contratos" (
    "id" BIGSERIAL NOT NULL,
    "usuario_id" UUID NOT NULL,
    "data_inicio" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_fim" DATE NOT NULL,
    "portaria" VARCHAR(255) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "fiscal_contratos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fiscal_contrato_itens" (
    "id" BIGSERIAL NOT NULL,
    "fiscal_contrato_id" BIGINT NOT NULL,
    "contrato_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "fiscal_contrato_itens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "canais_atendimento" (
    "id" BIGSERIAL NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "telefone" VARCHAR(255),
    "email" VARCHAR(255),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "canais_atendimento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mensagens" (
    "id" BIGSERIAL NOT NULL,
    "perfil_id" BIGINT,
    "tipo" INTEGER NOT NULL,
    "titulo" VARCHAR(255) NOT NULL,
    "corpo" TEXT NOT NULL,
    "idade_inicial" INTEGER,
    "idade_final" INTEGER,
    "data_inicial_exibicao" DATE,
    "data_final_exibicao" DATE,
    "visivel" BOOLEAN NOT NULL DEFAULT true,
    "fixado" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "mensagens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "parametros" (
    "id" BIGSERIAL NOT NULL,
    "parameter" VARCHAR(255) NOT NULL,
    "field_label" VARCHAR(255) NOT NULL,
    "component" TEXT,
    "value" VARCHAR(255),
    "possible_values" VARCHAR(255),
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "parametros_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "estados_uf_idx" ON "estados"("uf");

-- CreateIndex
CREATE INDEX "cidades_estado_id_idx" ON "cidades"("estado_id");

-- CreateIndex
CREATE INDEX "cidades_nome_idx" ON "cidades"("nome");

-- CreateIndex
CREATE INDEX "enderecos_cidade_id_idx" ON "enderecos"("cidade_id");

-- CreateIndex
CREATE INDEX "enderecos_entidade_tipo_entidade_id_idx" ON "enderecos"("entidade_tipo", "entidade_id");

-- CreateIndex
CREATE INDEX "operadoras_ativo_idx" ON "operadoras"("ativo");

-- CreateIndex
CREATE UNIQUE INDEX "operadoras_cpf_cnpj_key" ON "operadoras"("cpf_cnpj");

-- CreateIndex
CREATE UNIQUE INDEX "roles_slug_key" ON "roles"("slug");

-- CreateIndex
CREATE INDEX "permissoes_modulo_idx" ON "permissoes"("modulo");

-- CreateIndex
CREATE UNIQUE INDEX "permissoes_slug_key" ON "permissoes"("slug");

-- CreateIndex
CREATE INDEX "empresas_ativo_idx" ON "empresas"("ativo");

-- CreateIndex
CREATE UNIQUE INDEX "empresas_cpf_cnpj_key" ON "empresas"("cpf_cnpj");

-- CreateIndex
CREATE INDEX "secretarias_empresa_id_idx" ON "secretarias"("empresa_id");

-- CreateIndex
CREATE INDEX "conveniados_ativo_idx" ON "conveniados"("ativo");

-- CreateIndex
CREATE INDEX "conveniados_user_id_idx" ON "conveniados"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "conveniados_cpf_key" ON "conveniados"("cpf");

-- CreateIndex
CREATE INDEX "conveniado_salarios_conveniado_id_idx" ON "conveniado_salarios"("conveniado_id");

-- CreateIndex
CREATE UNIQUE INDEX "gestantes_conveniado_id_key" ON "gestantes"("conveniado_id");

-- CreateIndex
CREATE INDEX "produtos_operadora_id_idx" ON "produtos"("operadora_id");

-- CreateIndex
CREATE INDEX "produtos_ativo_idx" ON "produtos"("ativo");

-- CreateIndex
CREATE INDEX "produtos_precos_produto_id_idx" ON "produtos_precos"("produto_id");

-- CreateIndex
CREATE INDEX "regras_coparticipacao_produto_id_idx" ON "regras_coparticipacao"("produto_id");

-- CreateIndex
CREATE INDEX "adesoes_conveniado_id_idx" ON "adesoes"("conveniado_id");

-- CreateIndex
CREATE INDEX "adesoes_status_idx" ON "adesoes"("status");

-- CreateIndex
CREATE INDEX "adesoes_operadora_id_idx" ON "adesoes"("operadora_id");

-- CreateIndex
CREATE INDEX "adesao_reducao_margem_adesao_id_idx" ON "adesao_reducao_margem"("adesao_id");

-- CreateIndex
CREATE INDEX "prestadores_ativo_idx" ON "prestadores"("ativo");

-- CreateIndex
CREATE UNIQUE INDEX "prestadores_cpf_cnpj_key" ON "prestadores"("cpf_cnpj");

-- CreateIndex
CREATE INDEX "prestador_contratos_prestador_id_idx" ON "prestador_contratos"("prestador_id");

-- CreateIndex
CREATE INDEX "procedimentos_codigo_idx" ON "procedimentos"("codigo");

-- CreateIndex
CREATE INDEX "cbhpm_cbhpm_edicao_id_idx" ON "cbhpm"("cbhpm_edicao_id");

-- CreateIndex
CREATE INDEX "medicamentos_codigo_idx" ON "medicamentos"("codigo");

-- CreateIndex
CREATE INDEX "medicamento_brasindice_medicamento_id_idx" ON "medicamento_brasindice"("medicamento_id");

-- CreateIndex
CREATE INDEX "tabela_precos_itens_tabela_preco_id_idx" ON "tabela_precos_itens"("tabela_preco_id");

-- CreateIndex
CREATE UNIQUE INDEX "cid_codigo_key" ON "cid"("codigo");

-- CreateIndex
CREATE INDEX "guias_status_idx" ON "guias"("status");

-- CreateIndex
CREATE INDEX "guias_conveniado_id_idx" ON "guias"("conveniado_id");

-- CreateIndex
CREATE INDEX "guias_prestador_id_idx" ON "guias"("prestador_id");

-- CreateIndex
CREATE INDEX "guias_operadora_id_idx" ON "guias"("operadora_id");

-- CreateIndex
CREATE INDEX "guias_itens_guia_id_idx" ON "guias_itens"("guia_id");

-- CreateIndex
CREATE INDEX "guias_itens_status_idx" ON "guias_itens"("status");

-- CreateIndex
CREATE INDEX "guias_historico_guia_id_idx" ON "guias_historico"("guia_id");

-- CreateIndex
CREATE INDEX "guias_auditoria_guia_itens_id_idx" ON "guias_auditoria"("guia_itens_id");

-- CreateIndex
CREATE UNIQUE INDEX "bancos_codigo_key" ON "bancos"("codigo");

-- CreateIndex
CREATE INDEX "lote_pagamentos_prestador_id_idx" ON "lote_pagamentos"("prestador_id");

-- CreateIndex
CREATE INDEX "lote_pagamentos_status_idx" ON "lote_pagamentos"("status");

-- CreateIndex
CREATE INDEX "lancamentos_operadora_id_idx" ON "lancamentos"("operadora_id");

-- CreateIndex
CREATE INDEX "lancamentos_status_idx" ON "lancamentos"("status");

-- CreateIndex
CREATE INDEX "boletos_operadora_id_idx" ON "boletos"("operadora_id");

-- CreateIndex
CREATE INDEX "boletos_status_idx" ON "boletos"("status");

-- CreateIndex
CREATE INDEX "mensalidades_conveniado_id_idx" ON "mensalidades"("conveniado_id");

-- CreateIndex
CREATE INDEX "mensalidades_competencia_idx" ON "mensalidades"("competencia");

-- CreateIndex
CREATE INDEX "remessa_desconto_empresa_id_idx" ON "remessa_desconto"("empresa_id");

-- CreateIndex
CREATE INDEX "historico_credenciamentos_solicitacao_credencimento_id_idx" ON "historico_credenciamentos"("solicitacao_credencimento_id");

-- CreateIndex
CREATE INDEX "audit_log_usuario_id_idx" ON "audit_log"("usuario_id");

-- CreateIndex
CREATE INDEX "audit_log_data_hora_idx" ON "audit_log"("data_hora");

-- AddForeignKey
ALTER TABLE "cidades" ADD CONSTRAINT "cidades_estado_id_fkey" FOREIGN KEY ("estado_id") REFERENCES "estados"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "enderecos" ADD CONSTRAINT "enderecos_cidade_id_fkey" FOREIGN KEY ("cidade_id") REFERENCES "cidades"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_permissoes" ADD CONSTRAINT "role_permissoes_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_permissoes" ADD CONSTRAINT "role_permissoes_permissao_id_fkey" FOREIGN KEY ("permissao_id") REFERENCES "permissoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "usuario_roles" ADD CONSTRAINT "usuario_roles_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "operadora_usuarios" ADD CONSTRAINT "operadora_usuarios_operadora_id_fkey" FOREIGN KEY ("operadora_id") REFERENCES "operadoras"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "empresa_usuarios" ADD CONSTRAINT "empresa_usuarios_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "secretarias" ADD CONSTRAINT "secretarias_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conveniados" ADD CONSTRAINT "conveniados_orgao_expedidor_uf_id_fkey" FOREIGN KEY ("orgao_expedidor_uf_id") REFERENCES "estados"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conveniados" ADD CONSTRAINT "conveniados_naturalidade_cidade_id_fkey" FOREIGN KEY ("naturalidade_cidade_id") REFERENCES "cidades"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conveniados" ADD CONSTRAINT "conveniados_cargo_id_fkey" FOREIGN KEY ("cargo_id") REFERENCES "cargos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conveniado_salarios" ADD CONSTRAINT "conveniado_salarios_conveniado_id_fkey" FOREIGN KEY ("conveniado_id") REFERENCES "conveniados"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "gestantes" ADD CONSTRAINT "gestantes_conveniado_id_fkey" FOREIGN KEY ("conveniado_id") REFERENCES "conveniados"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produtos" ADD CONSTRAINT "produtos_operadora_id_fkey" FOREIGN KEY ("operadora_id") REFERENCES "operadoras"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produtos_precos" ADD CONSTRAINT "produtos_precos_produto_id_fkey" FOREIGN KEY ("produto_id") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produtos_precos" ADD CONSTRAINT "produtos_precos_tipo_vinculo_id_fkey" FOREIGN KEY ("tipo_vinculo_id") REFERENCES "tipo_vinculos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produtos_precos" ADD CONSTRAINT "produtos_precos_grupo_verba_id_fkey" FOREIGN KEY ("grupo_verba_id") REFERENCES "grupo_verbas"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "empresa_produtos" ADD CONSTRAINT "empresa_produtos_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "empresa_produtos" ADD CONSTRAINT "empresa_produtos_produto_id_fkey" FOREIGN KEY ("produto_id") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "regras_coparticipacao" ADD CONSTRAINT "regras_coparticipacao_produto_id_fkey" FOREIGN KEY ("produto_id") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "regras_coparticipacao_itens" ADD CONSTRAINT "regras_coparticipacao_itens_regra_coparticipacao_id_fkey" FOREIGN KEY ("regra_coparticipacao_id") REFERENCES "regras_coparticipacao"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "regras_coparticipacao_procedimentos" ADD CONSTRAINT "regras_coparticipacao_procedimentos_regra_coparticipacao_i_fkey" FOREIGN KEY ("regra_coparticipacao_id") REFERENCES "regras_coparticipacao"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "regras_coparticipacao_procedimentos" ADD CONSTRAINT "regras_coparticipacao_procedimentos_grupo_procedimento_id_fkey" FOREIGN KEY ("grupo_procedimento_id") REFERENCES "procedimentos_grupos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "regras_coparticipacao_procedimentos" ADD CONSTRAINT "regras_coparticipacao_procedimentos_subgrupo_procedimento__fkey" FOREIGN KEY ("subgrupo_procedimento_id") REFERENCES "procedimento_subgrupos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "regras_coparticipacao_procedimentos" ADD CONSTRAINT "regras_coparticipacao_procedimentos_procedimento_id_fkey" FOREIGN KEY ("procedimento_id") REFERENCES "procedimentos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adesoes" ADD CONSTRAINT "adesoes_operadora_id_fkey" FOREIGN KEY ("operadora_id") REFERENCES "operadoras"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adesoes" ADD CONSTRAINT "adesoes_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresas"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adesoes" ADD CONSTRAINT "adesoes_secretaria_id_fkey" FOREIGN KEY ("secretaria_id") REFERENCES "secretarias"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adesoes" ADD CONSTRAINT "adesoes_conveniado_id_fkey" FOREIGN KEY ("conveniado_id") REFERENCES "conveniados"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adesoes" ADD CONSTRAINT "adesoes_produto_id_fkey" FOREIGN KEY ("produto_id") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adesoes" ADD CONSTRAINT "adesoes_produto_preco_id_fkey" FOREIGN KEY ("produto_preco_id") REFERENCES "produtos_precos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adesoes" ADD CONSTRAINT "adesoes_motivo_encerramento_id_fkey" FOREIGN KEY ("motivo_encerramento_id") REFERENCES "motivo_encerramentos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adesao_reducao_margem" ADD CONSTRAINT "adesao_reducao_margem_adesao_id_fkey" FOREIGN KEY ("adesao_id") REFERENCES "adesoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prestadores" ADD CONSTRAINT "prestadores_prestadores_classificacao_estabelecimento_id_fkey" FOREIGN KEY ("prestadores_classificacao_estabelecimento_id") REFERENCES "prestadores_classificacao_estabelecimento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prestadores" ADD CONSTRAINT "prestadores_prestador_tipo_id_fkey" FOREIGN KEY ("prestador_tipo_id") REFERENCES "prestador_tipos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prestadores" ADD CONSTRAINT "prestadores_orgao_expedidor_uf_id_fkey" FOREIGN KEY ("orgao_expedidor_uf_id") REFERENCES "estados"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prestadores" ADD CONSTRAINT "prestadores_naturalidade_estado_id_fkey" FOREIGN KEY ("naturalidade_estado_id") REFERENCES "estados"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prestadores" ADD CONSTRAINT "prestadores_naturalidade_cidade_id_fkey" FOREIGN KEY ("naturalidade_cidade_id") REFERENCES "cidades"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prestador_usuarios" ADD CONSTRAINT "prestador_usuarios_prestador_id_fkey" FOREIGN KEY ("prestador_id") REFERENCES "prestadores"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prestador_especialidades" ADD CONSTRAINT "prestador_especialidades_prestador_id_fkey" FOREIGN KEY ("prestador_id") REFERENCES "prestadores"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prestador_especialidades" ADD CONSTRAINT "prestador_especialidades_especialidade_id_fkey" FOREIGN KEY ("especialidade_id") REFERENCES "especialidades"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prestador_contratos" ADD CONSTRAINT "prestador_contratos_prestador_id_fkey" FOREIGN KEY ("prestador_id") REFERENCES "prestadores"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prestador_contrato_itens" ADD CONSTRAINT "prestador_contrato_itens_prestadores_contratos_id_fkey" FOREIGN KEY ("prestadores_contratos_id") REFERENCES "prestador_contratos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prestador_contrato_itens" ADD CONSTRAINT "prestador_contrato_itens_edicao_medicamento_id_fkey" FOREIGN KEY ("edicao_medicamento_id") REFERENCES "medicamento_edicoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prestador_contrato_itens" ADD CONSTRAINT "prestador_contrato_itens_tabela_precos_id_fkey" FOREIGN KEY ("tabela_precos_id") REFERENCES "tabela_precos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prestador_contrato_itens" ADD CONSTRAINT "prestador_contrato_itens_motivo_encerramento_id_fkey" FOREIGN KEY ("motivo_encerramento_id") REFERENCES "motivo_encerramentos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deflatores" ADD CONSTRAINT "deflatores_prestadores_contratos_id_fkey" FOREIGN KEY ("prestadores_contratos_id") REFERENCES "prestador_contrato_itens"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deflatores" ADD CONSTRAINT "deflatores_procedimento_grupo_id_fkey" FOREIGN KEY ("procedimento_grupo_id") REFERENCES "procedimentos_grupos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contrato_profissionais" ADD CONSTRAINT "contrato_profissionais_contrato_id_fkey" FOREIGN KEY ("contrato_id") REFERENCES "prestador_contratos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contrato_profissionais" ADD CONSTRAINT "contrato_profissionais_prestador_id_fkey" FOREIGN KEY ("prestador_id") REFERENCES "prestadores"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedimento_subgrupos" ADD CONSTRAINT "procedimento_subgrupos_grupo_id_fkey" FOREIGN KEY ("grupo_id") REFERENCES "procedimentos_grupos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "procedimentos" ADD CONSTRAINT "procedimentos_procedimento_subgrupo_id_fkey" FOREIGN KEY ("procedimento_subgrupo_id") REFERENCES "procedimento_subgrupos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cbhpm" ADD CONSTRAINT "cbhpm_cbhpm_edicao_id_fkey" FOREIGN KEY ("cbhpm_edicao_id") REFERENCES "cbhpm_edicoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cbhpm" ADD CONSTRAINT "cbhpm_procedimento_id_fkey" FOREIGN KEY ("procedimento_id") REFERENCES "procedimentos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cbhpm" ADD CONSTRAINT "cbhpm_porte_anestesico_id_fkey" FOREIGN KEY ("porte_anestesico_id") REFERENCES "porte_anestesicos"("porte_anestesico") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comunicado_portes" ADD CONSTRAINT "comunicado_portes_comunicado_edicao_id_fkey" FOREIGN KEY ("comunicado_edicao_id") REFERENCES "comunicado_edicoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "materiais_itens" ADD CONSTRAINT "materiais_itens_material_edicao_id_fkey" FOREIGN KEY ("material_edicao_id") REFERENCES "material_edicoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "materiais_itens" ADD CONSTRAINT "materiais_itens_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materiais"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medicamentos" ADD CONSTRAINT "medicamentos_laboratorio_id_fkey" FOREIGN KEY ("laboratorio_id") REFERENCES "laboratorios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medicamentos" ADD CONSTRAINT "medicamentos_medicamento_edicao_id_fkey" FOREIGN KEY ("medicamento_edicao_id") REFERENCES "medicamento_edicoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medicamento_brasindice" ADD CONSTRAINT "medicamento_brasindice_medicamento_edicao_id_fkey" FOREIGN KEY ("medicamento_edicao_id") REFERENCES "medicamento_edicoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medicamento_brasindice" ADD CONSTRAINT "medicamento_brasindice_medicamento_id_fkey" FOREIGN KEY ("medicamento_id") REFERENCES "medicamentos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tabela_precos" ADD CONSTRAINT "tabela_precos_comunicado_edicao_id_fkey" FOREIGN KEY ("comunicado_edicao_id") REFERENCES "comunicado_edicoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tabela_precos" ADD CONSTRAINT "tabela_precos_cbhpm_edicao_id_fkey" FOREIGN KEY ("cbhpm_edicao_id") REFERENCES "cbhpm_edicoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tabela_precos" ADD CONSTRAINT "tabela_precos_material_edicao_id_fkey" FOREIGN KEY ("material_edicao_id") REFERENCES "material_edicoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tabela_precos_itens" ADD CONSTRAINT "tabela_precos_itens_tabela_preco_id_fkey" FOREIGN KEY ("tabela_preco_id") REFERENCES "tabela_precos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guia_importacoes" ADD CONSTRAINT "guia_importacoes_prestador_id_fkey" FOREIGN KEY ("prestador_id") REFERENCES "prestadores"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias" ADD CONSTRAINT "guias_operadora_id_fkey" FOREIGN KEY ("operadora_id") REFERENCES "operadoras"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias" ADD CONSTRAINT "guias_prestador_id_fkey" FOREIGN KEY ("prestador_id") REFERENCES "prestadores"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias" ADD CONSTRAINT "guias_profissional_id_fkey" FOREIGN KEY ("profissional_id") REFERENCES "prestadores"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias" ADD CONSTRAINT "guias_solicitante_prestador_id_fkey" FOREIGN KEY ("solicitante_prestador_id") REFERENCES "prestadores"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias" ADD CONSTRAINT "guias_conveniado_id_fkey" FOREIGN KEY ("conveniado_id") REFERENCES "conveniados"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias" ADD CONSTRAINT "guias_lote_pagamento_id_fkey" FOREIGN KEY ("lote_pagamento_id") REFERENCES "lote_pagamentos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias" ADD CONSTRAINT "guias_guia_importacao_id_fkey" FOREIGN KEY ("guia_importacao_id") REFERENCES "guia_importacoes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias" ADD CONSTRAINT "guias_guia_origem_id_fkey" FOREIGN KEY ("guia_origem_id") REFERENCES "guias"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias_itens" ADD CONSTRAINT "guias_itens_guia_id_fkey" FOREIGN KEY ("guia_id") REFERENCES "guias"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias_historico" ADD CONSTRAINT "guias_historico_guia_id_fkey" FOREIGN KEY ("guia_id") REFERENCES "guias"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias_historico" ADD CONSTRAINT "guias_historico_guia_item_id_fkey" FOREIGN KEY ("guia_item_id") REFERENCES "guias_itens"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias_auditoria" ADD CONSTRAINT "guias_auditoria_guia_itens_id_fkey" FOREIGN KEY ("guia_itens_id") REFERENCES "guias_itens"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias_atendimentos" ADD CONSTRAINT "guias_atendimentos_guia_itens_id_fkey" FOREIGN KEY ("guia_itens_id") REFERENCES "guias_itens"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "guias_anexos" ADD CONSTRAINT "guias_anexos_guia_id_fkey" FOREIGN KEY ("guia_id") REFERENCES "guias"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dados_bancarios" ADD CONSTRAINT "dados_bancarios_banco_id_fkey" FOREIGN KEY ("banco_id") REFERENCES "bancos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "empresas_verbas" ADD CONSTRAINT "empresas_verbas_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "empresas_verbas" ADD CONSTRAINT "empresas_verbas_grupo_verba_id_fkey" FOREIGN KEY ("grupo_verba_id") REFERENCES "grupo_verbas"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lote_pagamentos" ADD CONSTRAINT "lote_pagamentos_prestador_id_fkey" FOREIGN KEY ("prestador_id") REFERENCES "prestadores"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lote_pagamentos" ADD CONSTRAINT "lote_pagamentos_lancamento_id_fkey" FOREIGN KEY ("lancamento_id") REFERENCES "lancamentos"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lancamentos" ADD CONSTRAINT "lancamentos_operadora_id_fkey" FOREIGN KEY ("operadora_id") REFERENCES "operadoras"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lancamentos" ADD CONSTRAINT "lancamentos_prestador_id_fkey" FOREIGN KEY ("prestador_id") REFERENCES "prestadores"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lancamentos" ADD CONSTRAINT "lancamentos_conveniado_id_fkey" FOREIGN KEY ("conveniado_id") REFERENCES "conveniados"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lancamentos" ADD CONSTRAINT "lancamentos_grupo_verba_id_fkey" FOREIGN KEY ("grupo_verba_id") REFERENCES "grupo_verbas"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lancamentos_guias" ADD CONSTRAINT "lancamentos_guias_lancamento_id_fkey" FOREIGN KEY ("lancamento_id") REFERENCES "lancamentos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lancamentos_guias" ADD CONSTRAINT "lancamentos_guias_guia_id_fkey" FOREIGN KEY ("guia_id") REFERENCES "guias"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "boletos" ADD CONSTRAINT "boletos_operadora_id_fkey" FOREIGN KEY ("operadora_id") REFERENCES "operadoras"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "boletos" ADD CONSTRAINT "boletos_pagador_cidade_id_fkey" FOREIGN KEY ("pagador_cidade_id") REFERENCES "cidades"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "boleto_lancamentos" ADD CONSTRAINT "boleto_lancamentos_boleto_id_fkey" FOREIGN KEY ("boleto_id") REFERENCES "boletos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "boleto_lancamentos" ADD CONSTRAINT "boleto_lancamentos_lancamento_id_fkey" FOREIGN KEY ("lancamento_id") REFERENCES "lancamentos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mensalidades" ADD CONSTRAINT "mensalidades_conveniado_id_fkey" FOREIGN KEY ("conveniado_id") REFERENCES "conveniados"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mensalidades" ADD CONSTRAINT "mensalidades_produto_preco_id_fkey" FOREIGN KEY ("produto_preco_id") REFERENCES "produtos_precos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mensalidades" ADD CONSTRAINT "mensalidades_grupo_verba_id_fkey" FOREIGN KEY ("grupo_verba_id") REFERENCES "grupo_verbas"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remessa_desconto" ADD CONSTRAINT "remessa_desconto_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remessa_desconto_item" ADD CONSTRAINT "remessa_desconto_item_remessa_desconto_id_fkey" FOREIGN KEY ("remessa_desconto_id") REFERENCES "remessa_desconto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remessa_desconto_item" ADD CONSTRAINT "remessa_desconto_item_adesao_id_fkey" FOREIGN KEY ("adesao_id") REFERENCES "adesoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "edital_credenciamento_documentos" ADD CONSTRAINT "edital_credenciamento_documentos_edital_id_fkey" FOREIGN KEY ("edital_id") REFERENCES "editais_credenciamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "edital_credenciamento_documentos" ADD CONSTRAINT "edital_credenciamento_documentos_documento_credenciamento__fkey" FOREIGN KEY ("documento_credenciamento_id") REFERENCES "documentos_credenciamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "solicitacoes_credenciamento" ADD CONSTRAINT "solicitacoes_credenciamento_edital_credenciamento_id_fkey" FOREIGN KEY ("edital_credenciamento_id") REFERENCES "editais_credenciamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "solicitacoes_credenciamento_documentos" ADD CONSTRAINT "solicitacoes_credenciamento_documentos_solicitacoes_creden_fkey" FOREIGN KEY ("solicitacoes_credenciamento_id") REFERENCES "solicitacoes_credenciamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "solicitacoes_credenciamento_documentos" ADD CONSTRAINT "solicitacoes_credenciamento_documentos_documento_credencia_fkey" FOREIGN KEY ("documento_credenciamento_id") REFERENCES "documentos_credenciamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "historico_credenciamentos" ADD CONSTRAINT "historico_credenciamentos_solicitacao_credencimento_id_fkey" FOREIGN KEY ("solicitacao_credencimento_id") REFERENCES "solicitacoes_credenciamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "solicitacoes_atualizacao_cadastral" ADD CONSTRAINT "solicitacoes_atualizacao_cadastral_prestador_id_fkey" FOREIGN KEY ("prestador_id") REFERENCES "prestadores"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "solicitacoes_atualizacao_cadastral" ADD CONSTRAINT "solicitacoes_atualizacao_cadastral_conveniado_id_fkey" FOREIGN KEY ("conveniado_id") REFERENCES "conveniados"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "solicitacoes_atualizacao_cadastral" ADD CONSTRAINT "solicitacoes_atualizacao_cadastral_cidade_id_fkey" FOREIGN KEY ("cidade_id") REFERENCES "cidades"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fiscal_contrato_itens" ADD CONSTRAINT "fiscal_contrato_itens_fiscal_contrato_id_fkey" FOREIGN KEY ("fiscal_contrato_id") REFERENCES "fiscal_contratos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fiscal_contrato_itens" ADD CONSTRAINT "fiscal_contrato_itens_contrato_id_fkey" FOREIGN KEY ("contrato_id") REFERENCES "prestador_contratos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
