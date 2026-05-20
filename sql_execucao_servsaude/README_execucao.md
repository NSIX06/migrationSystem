# Execucao do schema ServSaude em partes
Ordem recomendada:
0. 00_extensoes_opcional.sql somente se precisar da extensao unaccent.
1. 01_schema_base.sql
2. 02_indices_auxiliares.sql
3. 03_funcoes_validacao.sql
4. 04_aplicar_foreign_keys_not_valid.sql
5. 05_checks_not_valid.sql
6. 06_indices_unicos_validados.sql
7. 07_relatorio_validacao.sql
8. 08_validate_constraints.sql somente depois que o relatorio nao mostrar problemas criticos.
Observacoes:
- As FKs e CHECKs sao criadas como NOT VALID para reduzir risco durante carga/migracao.
- O arquivo 04 limpa a tabela _migration_validation_issues antes de testar as FKs.
- O arquivo 08 foi gerado com os ALTER TABLE VALIDATE CONSTRAINT descomentados.
- Se algum comando do arquivo 08 falhar, resolva os dados apontados no relatorio e execute novamente o comando especifico.
- Em Supabase, CREATE EXTENSION pode exigir permissao do ambiente/projeto.
- O arquivo 01 nao instala unaccent para evitar conflito com funcoes ja existentes no public.
