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
