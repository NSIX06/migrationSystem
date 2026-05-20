-- ============================================================
-- ServSaude - 00 - extensoes opcionais
-- Execute apenas se o projeto realmente precisar dessas extensoes.
-- No Supabase, prefira instalar extensoes pelo painel quando possivel.
-- ============================================================

CREATE SCHEMA IF NOT EXISTS extensions;

-- Use o schema extensions para evitar conflito com funcoes no public.
CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA extensions;
