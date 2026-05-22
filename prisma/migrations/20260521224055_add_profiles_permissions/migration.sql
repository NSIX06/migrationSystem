-- CreateEnum
CREATE TYPE "UserTypeEnum" AS ENUM ('ADMIN', 'GESTOR', 'ATENDIMENTO', 'FINANCEIRO', 'AUDITORIA', 'CREDENCIAMENTO', 'BENEFICIARIO', 'PRESTADOR', 'VISUALIZADOR');

-- CreateEnum
CREATE TYPE "UserStatusEnum" AS ENUM ('ATIVO', 'INATIVO', 'BLOQUEADO', 'PENDENTE');

-- AlterTable
ALTER TABLE "roles" ADD COLUMN     "descricao" VARCHAR(255);

-- CreateTable
CREATE TABLE "profiles" (
    "user_id" UUID NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "cpf" VARCHAR(14),
    "fone" VARCHAR(20),
    "user_type" "UserTypeEnum" NOT NULL,
    "status" "UserStatusEnum" NOT NULL DEFAULT 'ATIVO',
    "conveniado_id" BIGINT,
    "prestador_id" BIGINT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "profiles_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "permissao_usuarios" (
    "user_id" UUID NOT NULL,
    "permissao_id" BIGINT NOT NULL,
    "concedido" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "permissao_usuarios_pkey" PRIMARY KEY ("user_id","permissao_id")
);

-- CreateIndex
CREATE INDEX "profiles_email_idx" ON "profiles"("email");

-- CreateIndex
CREATE INDEX "profiles_user_type_idx" ON "profiles"("user_type");

-- CreateIndex
CREATE INDEX "profiles_status_idx" ON "profiles"("status");

-- AddForeignKey
ALTER TABLE "profiles" ADD CONSTRAINT "profiles_conveniado_id_fkey" FOREIGN KEY ("conveniado_id") REFERENCES "conveniados"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "profiles" ADD CONSTRAINT "profiles_prestador_id_fkey" FOREIGN KEY ("prestador_id") REFERENCES "prestadores"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "permissao_usuarios" ADD CONSTRAINT "permissao_usuarios_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "profiles"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "permissao_usuarios" ADD CONSTRAINT "permissao_usuarios_permissao_id_fkey" FOREIGN KEY ("permissao_id") REFERENCES "permissoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "usuario_roles" ADD CONSTRAINT "usuario_roles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "profiles"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;
