-- ============================================================
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

