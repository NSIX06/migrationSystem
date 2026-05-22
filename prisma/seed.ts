import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
  console.log('🌱 Iniciando seed...')

  // Estado
  const sp = await prisma.estado.upsert({
    where: { id: BigInt(1) },
    create: { id: BigInt(1), nome: 'São Paulo', uf: 'SP', ativo: true },
    update: {},
  })

  // Cidade
  const cidadeSP = await prisma.cidade.upsert({
    where: { id: BigInt(1) },
    create: { id: BigInt(1), estadoId: sp.id, nome: 'São Paulo' },
    update: {},
  })

  // Operadora
  const operadora = await prisma.operadora.upsert({
    where: { id: BigInt(1) },
    create: {
      id: BigInt(1),
      nome: 'ServSaúde',
      razaoSocial: 'ServSaúde Operadora de Planos de Saúde Ltda',
      tipo: 1,
      cpfCnpj: '12.345.678/0001-90',
      codigoAns: '123456',
      tipoDeclarante: 1,
      cpfResponsavel: '123.456.789-00',
      indicadorSituacaoDeclaracao: 'A',
      email: 'contato@servsaude.com.br',
      fone: '(11) 3000-0000',
      ativo: true,
    },
    update: {},
  })

  // Cargo
  const cargo = await prisma.cargo.upsert({
    where: { id: BigInt(1) },
    create: { id: BigInt(1), descricao: 'Funcionário Municipal', ativo: true },
    update: {},
  })

  // Produto
  const produto = await prisma.produto.upsert({
    where: { id: BigInt(1) },
    create: {
      id: BigInt(1),
      operadoraId: operadora.id,
      descricao: 'Plano Básico Municipal',
      abrangencia: 'MUNICIPAL',
      tipoContratacao: 'COLETIVO_EMPRESARIAL',
      tipoCarencia: 'CARENCIA_PADRAO',
      tipoAcomodacao: 'ENFERMARIA',
      dataInicio: new Date('2024-01-01'),
      ativo: true,
    },
    update: {},
  })

  // Classificação de estabelecimento (obrigatório para Prestador)
  const classif = await prisma.prestadorClassificacaoEstabelecimento.upsert({
    where: { id: BigInt(1) },
    create: { id: BigInt(1), nome: 'Clínica Médica', codigo: '001', ativo: true },
    update: {},
  })

  const classif2 = await prisma.prestadorClassificacaoEstabelecimento.upsert({
    where: { id: BigInt(2) },
    create: { id: BigInt(2), nome: 'Hospital', codigo: '002', ativo: true },
    update: {},
  })

  // Tipo de prestador
  const tipoPrestador = await prisma.prestadorTipo.upsert({
    where: { id: BigInt(1) },
    create: { id: BigInt(1), descricao: 'Médico', ativo: true },
    update: {},
  })

  const tipoPrestador2 = await prisma.prestadorTipo.upsert({
    where: { id: BigInt(2) },
    create: { id: BigInt(2), descricao: 'Laboratório', ativo: true },
    update: {},
  })

  // Conveniados (beneficiários)
  const beneficiarios = [
    {
      id: BigInt(1),
      nome: 'João da Silva',
      cpf: '12345678901',
      dataNascimento: new Date('1985-03-15'),
      sexo: 'MASCULINO' as const,
      nomeMae: 'Maria da Silva',
      email: 'joao.silva@email.com',
      fone1: '(11) 98765-4321',
      estadoCivil: 'CASADO' as const,
    },
    {
      id: BigInt(2),
      nome: 'Ana Oliveira',
      cpf: '98765432100',
      dataNascimento: new Date('1992-07-22'),
      sexo: 'FEMININO' as const,
      nomeMae: 'Cláudia Oliveira',
      email: 'ana.oliveira@email.com',
      fone1: '(11) 91234-5678',
      estadoCivil: 'SOLTEIRO' as const,
    },
    {
      id: BigInt(3),
      nome: 'Carlos Pereira',
      cpf: '45678912345',
      dataNascimento: new Date('1978-11-08'),
      sexo: 'MASCULINO' as const,
      nomeMae: 'Tereza Pereira',
      email: 'carlos.pereira@email.com',
      fone1: '(11) 97654-3210',
      estadoCivil: 'DIVORCIADO' as const,
    },
    {
      id: BigInt(4),
      nome: 'Fernanda Costa',
      cpf: '32165498700',
      dataNascimento: new Date('2001-05-30'),
      sexo: 'FEMININO' as const,
      nomeMae: 'Sandra Costa',
      email: 'fernanda.costa@email.com',
      fone1: '(11) 93456-7890',
      estadoCivil: 'SOLTEIRO' as const,
    },
  ]

  for (const b of beneficiarios) {
    await prisma.conveniado.upsert({
      where: { id: b.id },
      create: {
        ...b,
        naturalidadeCidadeId: cidadeSP.id,
        cargoId: cargo.id,
        userId: `00000000-0000-0000-0000-00000000000${b.id}`,
        ativo: true,
        pcd: 'NAO',
      },
      update: {},
    })
  }

  // Adesões
  const adesoes = [
    { id: BigInt(1), conveniadoId: BigInt(1), status: 'ATIVO' as const, matricula: '001/2024', dataInicio: new Date('2024-01-01') },
    { id: BigInt(2), conveniadoId: BigInt(2), status: 'ATIVO' as const, matricula: '002/2024', dataInicio: new Date('2024-02-01') },
    { id: BigInt(3), conveniadoId: BigInt(3), status: 'SUSPENSO' as const, matricula: '003/2024', dataInicio: new Date('2024-01-15') },
    { id: BigInt(4), conveniadoId: BigInt(4), status: 'ATIVO' as const, matricula: '004/2024', dataInicio: new Date('2024-03-01') },
  ]

  for (const a of adesoes) {
    await prisma.adesao.upsert({
      where: { id: a.id },
      create: {
        ...a,
        operadoraId: operadora.id,
        produtoId: produto.id,
        tipoCliente: 'TITULAR',
      },
      update: {},
    })
  }

  // Prestadores
  const prestadores = [
    {
      id: BigInt(1),
      nome: 'Dr. Ricardo Santos',
      razaoSocial: 'Ricardo Santos CRM 12345',
      cpfCnpj: '111.222.333-44',
      tipo: 'PESSOA_FISICA' as const,
      prestadoresClassificacaoEstabelecimentoId: classif.id,
      prestadorTipoId: tipoPrestador.id,
      email: 'dr.ricardo@clinica.com',
      fone: '(11) 3200-0001',
      ativo: true,
    },
    {
      id: BigInt(2),
      nome: 'Hospital São Lucas',
      razaoSocial: 'Hospital São Lucas S/A',
      cpfCnpj: '12.345.678/0001-11',
      tipo: 'PESSOA_JURIDICA' as const,
      prestadoresClassificacaoEstabelecimentoId: classif2.id,
      prestadorTipoId: tipoPrestador2.id,
      email: 'contato@hospitalsaolucas.com',
      fone: '(11) 3200-0002',
      ativo: true,
    },
    {
      id: BigInt(3),
      nome: 'Dra. Patricia Lima',
      razaoSocial: 'Patricia Lima CRM 54321',
      cpfCnpj: '444.555.666-77',
      tipo: 'PESSOA_FISICA' as const,
      prestadoresClassificacaoEstabelecimentoId: classif.id,
      prestadorTipoId: tipoPrestador.id,
      email: 'dra.patricia@clinica.com',
      fone: '(11) 3200-0003',
      ativo: true,
    },
  ]

  for (const p of prestadores) {
    await prisma.prestador.upsert({
      where: { id: p.id },
      create: { ...p, procedimentos: true, material: false, taxa: false, medicamentos: false },
      update: {},
    })
  }

  // Guias
  const guias = [
    {
      id: BigInt(1),
      conveniadoId: BigInt(1),
      prestadorId: BigInt(1),
      tipo: 'CONSULTA' as const,
      status: 'SOLICITADA' as const,
      caraterAtendimento: 'ELETIVO' as const,
      indicacaoClinica: 'Dor abdominal recorrente',
      urgente: false,
    },
    {
      id: BigInt(2),
      conveniadoId: BigInt(2),
      prestadorId: BigInt(2),
      tipo: 'SADT' as const,
      status: 'SOLICITADA' as const,
      caraterAtendimento: 'ELETIVO' as const,
      indicacaoClinica: 'Exames de rotina anuais',
      urgente: false,
    },
    {
      id: BigInt(3),
      conveniadoId: BigInt(4),
      prestadorId: BigInt(1),
      tipo: 'CONSULTA' as const,
      status: 'SOLICITADA' as const,
      caraterAtendimento: 'URGENCIA_EMERGENCIA' as const,
      indicacaoClinica: 'Febre alta persistente',
      urgente: true,
    },
    {
      id: BigInt(4),
      conveniadoId: BigInt(1),
      prestadorId: BigInt(2),
      tipo: 'INTERNACAO' as const,
      status: 'AUTORIZADA' as const,
      caraterAtendimento: 'ELETIVO' as const,
      indicacaoClinica: 'Cirurgia eletiva programada',
      urgente: false,
      dataAutorizacao: new Date('2025-05-10'),
      senha: 987654,
      dataValidadeSenha: new Date('2025-06-10'),
      autenticada: true,
    },
  ]

  for (const g of guias) {
    await prisma.guia.upsert({
      where: { id: g.id },
      create: { ...g, operadoraId: operadora.id },
      update: {},
    })
  }

  // Lançamentos
  const hoje = new Date()
  const lancamentos = [
    {
      id: BigInt(1), conveniadoId: BigInt(1),
      tipoLancamento: 'MENSALIDADE' as const,
      descricao: 'Mensalidade Maio/2025',
      valor: 189.90, status: 'ABERTO' as const,
      dataVencimento: new Date(hoje.getFullYear(), hoje.getMonth(), 10),
    },
    {
      id: BigInt(2), conveniadoId: BigInt(2),
      tipoLancamento: 'MENSALIDADE' as const,
      descricao: 'Mensalidade Maio/2025',
      valor: 189.90, status: 'PAGO' as const,
      dataVencimento: new Date(hoje.getFullYear(), hoje.getMonth(), 10),
      dataBaixa: new Date(hoje.getFullYear(), hoje.getMonth(), 8),
    },
    {
      id: BigInt(3), conveniadoId: BigInt(3),
      tipoLancamento: 'MENSALIDADE' as const,
      descricao: 'Mensalidade Abril/2025',
      valor: 189.90, status: 'VENCIDO' as const,
      dataVencimento: new Date(hoje.getFullYear(), hoje.getMonth() - 1, 10),
    },
    {
      id: BigInt(4), conveniadoId: BigInt(4),
      tipoLancamento: 'COPARTICIPACAO' as const,
      descricao: 'Coparticipação Consulta #3',
      valor: 30.00, status: 'ABERTO' as const,
      dataVencimento: new Date(hoje.getFullYear(), hoje.getMonth(), 20),
    },
    {
      id: BigInt(5), prestadorId: BigInt(2),
      tipoLancamento: 'PAGAMENTO_PRESTADOR' as const,
      descricao: 'Pagamento Hospital São Lucas - Abril',
      valor: 4500.00, status: 'PAGO' as const,
      dataVencimento: new Date(hoje.getFullYear(), hoje.getMonth() - 1, 30),
      dataBaixa: new Date(hoje.getFullYear(), hoje.getMonth(), 2),
    },
  ]

  for (const l of lancamentos) {
    await prisma.lancamento.upsert({
      where: { id: l.id },
      create: { ...l, operadoraId: operadora.id },
      update: {},
    })
  }

  // ── Permissões ──────────────────────────────────────────────
  const permissoesData = [
    { modulo: 'Dashboard',     slug: 'dashboard.view',       nome: 'Visualizar dashboard' },
    { modulo: 'Usuários',      slug: 'users.view',           nome: 'Visualizar usuários' },
    { modulo: 'Usuários',      slug: 'users.create',         nome: 'Criar usuários' },
    { modulo: 'Usuários',      slug: 'users.update',         nome: 'Editar usuários' },
    { modulo: 'Usuários',      slug: 'users.delete',         nome: 'Excluir usuários' },
    { modulo: 'Usuários',      slug: 'users.disable',        nome: 'Inativar usuários' },
    { modulo: 'Perfis',        slug: 'roles.view',           nome: 'Visualizar perfis' },
    { modulo: 'Perfis',        slug: 'roles.create',         nome: 'Criar perfis' },
    { modulo: 'Perfis',        slug: 'roles.update',         nome: 'Editar perfis' },
    { modulo: 'Perfis',        slug: 'roles.delete',         nome: 'Excluir perfis' },
    { modulo: 'Beneficiários', slug: 'beneficiarios.view',   nome: 'Visualizar beneficiários' },
    { modulo: 'Beneficiários', slug: 'beneficiarios.create', nome: 'Criar beneficiários' },
    { modulo: 'Beneficiários', slug: 'beneficiarios.update', nome: 'Editar beneficiários' },
    { modulo: 'Beneficiários', slug: 'beneficiarios.delete', nome: 'Excluir beneficiários' },
    { modulo: 'Prestadores',   slug: 'prestadores.view',     nome: 'Visualizar prestadores' },
    { modulo: 'Prestadores',   slug: 'prestadores.create',   nome: 'Criar prestadores' },
    { modulo: 'Prestadores',   slug: 'prestadores.update',   nome: 'Editar prestadores' },
    { modulo: 'Guias',         slug: 'guias.view',           nome: 'Visualizar guias' },
    { modulo: 'Guias',         slug: 'guias.create',         nome: 'Criar guias' },
    { modulo: 'Guias',         slug: 'guias.update',         nome: 'Editar guias' },
    { modulo: 'Guias',         slug: 'guias.approve',        nome: 'Autorizar/negar guias' },
    { modulo: 'Guias',         slug: 'guias.audit',          nome: 'Auditar guias' },
    { modulo: 'Financeiro',    slug: 'financeiro.view',      nome: 'Visualizar financeiro' },
    { modulo: 'Financeiro',    slug: 'financeiro.manage',    nome: 'Gerenciar financeiro' },
    { modulo: 'Financeiro',    slug: 'boletos.view',         nome: 'Visualizar boletos' },
    { modulo: 'Financeiro',    slug: 'boletos.create',       nome: 'Emitir boletos' },
    { modulo: 'Financeiro',    slug: 'boletos.cancel',       nome: 'Cancelar boletos' },
    { modulo: 'Relatórios',    slug: 'relatorios.view',      nome: 'Visualizar relatórios' },
    { modulo: 'Relatórios',    slug: 'relatorios.export',    nome: 'Exportar relatórios' },
    { modulo: 'Documentos',    slug: 'documentos.view',      nome: 'Visualizar documentos' },
    { modulo: 'Documentos',    slug: 'documentos.upload',    nome: 'Enviar documentos' },
    { modulo: 'Documentos',    slug: 'documentos.delete',    nome: 'Excluir documentos' },
    { modulo: 'Logs',          slug: 'logs.view',            nome: 'Visualizar logs' },
    { modulo: 'Configurações', slug: 'settings.view',        nome: 'Acessar administração' },
    { modulo: 'Configurações', slug: 'settings.manage',      nome: 'Gerenciar configurações' },
  ]

  const permissoes: Record<string, bigint> = {}
  for (const p of permissoesData) {
    const created = await prisma.permissao.upsert({
      where: { slug: p.slug },
      create: { ...p, ativo: true },
      update: {},
    })
    permissoes[p.slug] = created.id
  }

  // ── Perfis (Roles) ───────────────────────────────────────────
  const rolesData = [
    { slug: 'administrador',  nome: 'Administrador',  descricao: 'Acesso total ao sistema' },
    { slug: 'gestor',         nome: 'Gestor',         descricao: 'Gestão geral da operadora' },
    { slug: 'atendimento',    nome: 'Atendimento',    descricao: 'Atendimento ao beneficiário' },
    { slug: 'financeiro',     nome: 'Financeiro',     descricao: 'Módulo financeiro e boletos' },
    { slug: 'auditoria',      nome: 'Auditoria',      descricao: 'Auditoria de guias' },
    { slug: 'credenciamento', nome: 'Credenciamento', descricao: 'Credenciamento de prestadores' },
    { slug: 'beneficiario',   nome: 'Beneficiário',   descricao: 'Acesso do beneficiário' },
    { slug: 'prestador',      nome: 'Prestador',      descricao: 'Acesso do prestador' },
    { slug: 'visualizador',   nome: 'Visualizador',   descricao: 'Somente leitura' },
  ]

  const rolePermissoesMap: Record<string, string[]> = {
    administrador:  Object.keys(permissoes),
    gestor: ['dashboard.view','users.view','roles.view','beneficiarios.view','beneficiarios.create','beneficiarios.update','prestadores.view','prestadores.create','prestadores.update','guias.view','guias.approve','financeiro.view','financeiro.manage','boletos.view','boletos.create','relatorios.view','relatorios.export','documentos.view','settings.view'],
    atendimento: ['dashboard.view','beneficiarios.view','beneficiarios.create','beneficiarios.update','prestadores.view','guias.view','guias.create','financeiro.view','boletos.view','documentos.view','documentos.upload'],
    financeiro: ['dashboard.view','beneficiarios.view','financeiro.view','financeiro.manage','boletos.view','boletos.create','boletos.cancel','relatorios.view','relatorios.export'],
    auditoria: ['dashboard.view','beneficiarios.view','prestadores.view','guias.view','guias.audit','relatorios.view','logs.view'],
    credenciamento: ['dashboard.view','prestadores.view','prestadores.create','prestadores.update','documentos.view','documentos.upload'],
    beneficiario: ['dashboard.view','guias.view','boletos.view','documentos.view'],
    prestador: ['dashboard.view','guias.view','documentos.view'],
    visualizador: ['dashboard.view','beneficiarios.view','prestadores.view','guias.view','financeiro.view','relatorios.view'],
  }

  const roles: Record<string, bigint> = {}
  for (const r of rolesData) {
    const created = await prisma.role.upsert({
      where: { slug: r.slug },
      create: { nome: r.nome, slug: r.slug, descricao: r.descricao, ativo: true },
      update: {},
    })
    roles[r.slug] = created.id

    // Vincula permissões
    const slugs = rolePermissoesMap[r.slug] ?? []
    for (const slug of slugs) {
      const permId = permissoes[slug]
      if (!permId) continue
      await prisma.rolePermissao.upsert({
        where: { roleId_permissaoId: { roleId: created.id, permissaoId: permId } },
        create: { roleId: created.id, permissaoId: permId },
        update: {},
      })
    }
  }

  console.log('✅ Seed concluído!')
  console.log(`   Operadora: ${operadora.nome}`)
  console.log(`   Beneficiários: ${beneficiarios.length}`)
  console.log(`   Prestadores: ${prestadores.length}`)
  console.log(`   Guias: ${guias.length}`)
  console.log(`   Lançamentos: ${lancamentos.length}`)
  console.log(`   Perfis: ${rolesData.length}`)
  console.log(`   Permissões: ${permissoesData.length}`)
}

main()
  .catch((e) => { console.error(e); process.exit(1) })
  .finally(() => prisma.$disconnect())
