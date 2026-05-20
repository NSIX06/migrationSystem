-- ============================================================
-- ServSaude - 07 - relatorio de problemas encontrados
-- Origem: servsaude_schema_completo_fks_validacoes.sql
-- Execute conforme a numeracao do arquivo.
-- ============================================================

SELECT *
FROM public._migration_validation_issues
ORDER BY created_at, table_name, column_name;

-- ============================================================

