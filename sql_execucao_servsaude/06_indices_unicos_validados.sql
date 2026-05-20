-- ============================================================
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

