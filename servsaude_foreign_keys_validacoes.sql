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