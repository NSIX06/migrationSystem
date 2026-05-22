# 01 — Diagnóstico do Sistema Legado ServSaúde

## 1. Identificação do Sistema

| Campo | Valor |
|---|---|
| **Nome** | ServSaúde |
| **Tipo** | Sistema de Gestão de Operadora de Plano de Saúde |
| **Área** | Saúde Suplementar — regulada pela ANS |
| **Modelo** | Operadora municipal/pública com beneficiários vinculados a empresas e secretarias de governo |
| **Stack legada** | PHP (Laravel) + MySQL + Sanctum (API Tokens) |
| **Versão provável** | Laravel 9–10 (identificado por `personal_access_tokens`, `failed_jobs`, `migrations`) |

---

## 2. Objetivo do Sistema

Gerenciar todo o ciclo operacional de uma operadora de plano de saúde: cadastro de beneficiários e prestadores, emissão de autorizações médicas (guias), controle financeiro (boletos, mensalidades, pagamento a prestadores) e relatórios regulatórios ANS.

O sistema atende operadoras que oferecem planos coletivos para servidores públicos e funcionários de empresas conveniadas, com desconto em folha de pagamento e coparticipação nos atendimentos.

---

## 3. Área de Atuação

- **Saúde Suplementar**: planos coletivos empresariais e por adesão
- **Público-alvo**: servidores municipais, funcionários de empresas conveniadas e dependentes
- **Regulação**: ANS — RN 465/2021, padrão TISS, CBHPM, Brasindice

**Dependências externas identificadas no banco:**

| Dependência | Tabelas relacionadas | Descrição |
|---|---|---|
| **CBHPM** | `cbhpm`, `cbhpm_edicoes`, `comunicado_edicoes`, `comunicado_portes` | Tabela de procedimentos médicos com portes e UCO |
| **Brasindice** | `medicamentos`, `medicamento_brasindice`, `medicamento_edicoes` | Tabela de preços de medicamentos (PMC/Pfab) |
| **TISS (ANS)** | `guia_importacoes`, `guias` | Importação de guias em XML padrão ANS |
| **Boleto bancário** | `boletos`, `operadoras.boleto_client_id` | API de geração de boletos (Itaú/BB) |
| **CID-10** | `cid` | Classificação Internacional de Doenças |

---

## 4. Módulos Identificados no Banco

Foram identificados **8 módulos reais** com base nas 44+ tabelas analisadas:

### Módulo 1 — Beneficiários (Conveniados)
Cadastro completo de beneficiários: dados pessoais, histórico salarial, adesão ao plano e gestantes.

**Tabelas**: `conveniados`, `conveniado_salarios`, `adesoes`, `adesao_reducao_margem`, `gestantes`, `grau_parentesco`, `cargos`

### Módulo 2 — Prestadores de Saúde
Clínicas, hospitais, laboratórios e profissionais. Inclui contratos, especialidades e profissionais vinculados.

**Tabelas**: `prestadores`, `prestador_tipos`, `prestadores_classificacao_estabelecimento`, `prestador_contratos`, `prestador_contrato_itens`, `contrato_profissionais`, `prestador_especialidades`, `deflatores`

### Módulo 3 — Produtos e Planos
Planos de saúde, faixas de preço por idade/vínculo e regras de coparticipação por procedimento.

**Tabelas**: `produtos`, `produtos_precos`, `tipo_vinculos`, `regra_cooparticipacao`, `regra_cooparticipacao_itens`, `regra_cooparticipacao_procedimentos`, `empresa_produto`

### Módulo 4 — Autorizações Médicas (Guias)
Núcleo do sistema. Emissão, autorização, auditoria e faturamento de guias. Suporta importação TISS.

**Tabelas**: `guias`, `guias_itens`, `guias_historico`, `guias_auditoria`, `guias_atendimentos`, `guias_anexos`, `guia_importacoes`, `guia_motivo_encerramento`

### Módulo 5 — Financeiro
Mensalidades, boletos bancários, lançamentos, lotes de pagamento a prestadores e remessa de desconto em folha.

**Tabelas**: `lancamentos`, `lancamentos_guias`, `lote_pagamentos`, `boletos`, `boleto_lancamentos`, `mensalidades`, `remessa_desconto`, `remessa_desconto_item`, `grupo_verbas`, `empresas_verbas`, `bancos`, `dados_bancarios`

### Módulo 6 — Tabelas Médicas (CBHPM / Brasindice)
Tabelas regulatórias de procedimentos, medicamentos, materiais e tabelas de preço customizadas por contrato.

**Tabelas**: `tabela_precos`, `tabela_precos_itens`, `cbhpm`, `cbhpm_edicoes`, `comunicado_edicoes`, `comunicado_portes`, `procedimentos`, `procedimentos_grupos`, `procedimento_subgrupos`, `medicamentos`, `medicamento_brasindice`, `medicamento_edicoes`, `laboratorios`, `materiais`, `materiais_itens`, `material_edicoes`, `taxas`, `cid`

### Módulo 7 — Credenciamento de Prestadores
Portal para solicitação de credenciamento: editais, documentos obrigatórios, análise e histórico de decisões.

**Tabelas**: `editais_credenciamento`, `documentos_credenciamento`, `edital_credenciamento_documentos`, `solicitacoes_credenciamento`, `solicitacoes_credenciamento_documentos`, `historico_credenciamentos`

### Módulo 8 — Administração e Segurança
Usuários, papéis, permissões, configurações do sistema, mensagens e logs de auditoria.

**Tabelas**: `users`, `roles`, `permissions`, `role_user`, `permission_role`, `operadora_user`, `empresa_user`, `prestador_user`, `menus`, `parametros`, `mensagens`, `canais_atendimento`, `log_acessos`, `log_operacoes`

---

## 5. Setores Atendidos pelo Sistema

| Setor | Módulos Utilizados |
|---|---|
| **Recepção / Autorizações** | Autorizações, Beneficiários |
| **Financeiro** | Financeiro, Beneficiários, Prestadores |
| **Cadastro** | Beneficiários, Prestadores, Empresas |
| **Auditoria Médica** | Autorizações (auditoria de guias), Tabelas Médicas |
| **Comercial / RH Empresa** | Produtos, Empresas, Credenciamento |
| **TI / Administração** | Administração, logs, parâmetros |
| **Beneficiário (self-service)** | Consulta guias, dados pessoais, boletos |
| **Prestador (portal)** | Emissão guias, consulta pagamentos |

---

## 6. Funções Reais do Sistema (identificadas diretamente no banco)

1. **Cadastrar e gerenciar beneficiários** — dados pessoais, CPF, RG, CNS, foto, cargo, PCD
2. **Gerenciar adesões ao plano** — vincular beneficiário a produto/empresa/secretaria; controlar vigência
3. **Emitir e autorizar guias médicas** — consultas, exames, SADT, internações; workflow por status
4. **Auditar guias** — revisar itens, glosar procedimentos, registrar justificativas
5. **Importar guias via TISS** — processar XML padrão ANS enviado pelos prestadores
6. **Calcular coparticipação** — aplicar regras por grupo de procedimento, faixa e produto
7. **Gerar boletos bancários** — integração com API bancária, PIX, multa, juros, nosso número
8. **Controlar mensalidades** — cálculo por faixa salarial e percentual por competência
9. **Pagar prestadores em lote** — agrupar guias em lotes, gerar lançamento de pagamento
10. **Gerar remessa de desconto em folha** — exportar descontos por matrícula para RH/Folha
11. **Credenciar prestadores** — publicar editais, receber documentação, analisar e decidir
12. **Manter tabelas CBHPM e Brasindice** — importar e versionar tabelas regulatórias por edição
13. **Controlar tabelas de preço customizadas** — tabelas específicas por contrato de prestador
14. **Gerenciar atualizações cadastrais** — beneficiários/prestadores solicitam atualização via portal
15. **Controlar acesso por perfil (RBAC)** — roles e permissions granulares por módulo

---

## 7. Perfis de Usuário

| Perfil | Acesso |
|---|---|
| `super_admin` | Total |
| `operadora_admin` | Todos os módulos da operadora |
| `operadora_financeiro` | Lançamentos, boletos, lotes de pagamento |
| `operadora_autorizacoes` | Emissão e autorização de guias |
| `operadora_auditoria` | Auditoria de guias médicas |
| `empresa` | Consulta beneficiários, remessa de desconto |
| `prestador` | Emissão de guias, consulta de pagamentos |
| `beneficiario` | Dados pessoais, guias próprias, boletos |

---

## 8. Volume Estimado de Dados

| Tabela | Estimativa | Criticidade |
|---|---|---|
| `conveniados` | 1.000 – 50.000 | Crítica |
| `adesoes` | 1.000 – 60.000 | Crítica |
| `guias` | 10.000 – 500.000 | Crítica |
| `guias_itens` | 50.000 – 2.000.000 | Crítica |
| `lancamentos` | 10.000 – 200.000 | Crítica |
| `boletos` | 5.000 – 100.000 | Crítica |
| `procedimentos` | ~5.000 (CBHPM) | Alta |
| `medicamentos` | ~30.000 (Brasindice) | Alta |
| `cid` | ~16.000 (CID-10) | Média |
| `log_acessos` | Crescimento contínuo | Média |

---

## 9. Dados Críticos para Migração

| Categoria | Tabelas | Tratamento |
|---|---|---|
| **Críticos** | `conveniados`, `adesoes`, `guias`, `guias_itens`, `lancamentos`, `boletos` | Migrar 100%, validar com queries comparativas |
| **Históricos** | `guias_historico`, `log_acessos`, `log_operacoes` | Migrar últimos 12 meses; arquivar o restante |
| **Sensíveis (LGPD)** | CPF, RG, dados bancários, fotos, senha certificado, `boleto_client_secret` | Criptografar em trânsito; mascarar em logs |
| **Descartáveis** | `failed_jobs`, `migrations`, `menus`, `personal_access_tokens`, `_migration_validation_issues` | Não migrar |
| **Regulatórios** | `cbhpm`, `medicamentos`, `procedimentos`, `cid` | Migrar completo; atualizar pelas fontes oficiais |

---

## 10. Conclusão

O ServSaúde é um sistema de **missão crítica** no segmento de saúde suplementar. Seus dados são simultaneamente regulatórios (exigidos pela ANS), financeiros e de saúde — portanto protegidos pela **LGPD**.

A base de domínio de negócio é sólida e bem modelada conceitualmente. Os problemas são predominantemente técnicos: stack legada (PHP/Laravel monolítico), estrutura de banco acoplada ao framework, e ausência de práticas modernas de segurança e escalabilidade.

A migração é viável e representa uma oportunidade de modernizar sem perder as regras de negócio já consolidadas.
