// Mapa de rotas → permissão necessária
export const ROUTE_PERMISSIONS: Record<string, string> = {
  '/dashboard':   'dashboard.view',
  '/conveniados': 'beneficiarios.view',
  '/prestadores': 'prestadores.view',
  '/guias':       'guias.view',
  '/financeiro':  'financeiro.view',
  '/relatorios':  'relatorios.view',
  '/admin':       'settings.view',
}

// Permissões por módulo para o seed
export const ALL_PERMISSIONS = [
  // Dashboard
  { modulo: 'Dashboard',      slug: 'dashboard.view',        nome: 'Visualizar dashboard' },

  // Usuários
  { modulo: 'Usuários',       slug: 'users.view',            nome: 'Visualizar usuários' },
  { modulo: 'Usuários',       slug: 'users.create',          nome: 'Criar usuários' },
  { modulo: 'Usuários',       slug: 'users.update',          nome: 'Editar usuários' },
  { modulo: 'Usuários',       slug: 'users.delete',          nome: 'Excluir usuários' },
  { modulo: 'Usuários',       slug: 'users.disable',         nome: 'Inativar usuários' },

  // Perfis
  { modulo: 'Perfis',         slug: 'roles.view',            nome: 'Visualizar perfis' },
  { modulo: 'Perfis',         slug: 'roles.create',          nome: 'Criar perfis' },
  { modulo: 'Perfis',         slug: 'roles.update',          nome: 'Editar perfis' },
  { modulo: 'Perfis',         slug: 'roles.delete',          nome: 'Excluir perfis' },

  // Beneficiários
  { modulo: 'Beneficiários',  slug: 'beneficiarios.view',    nome: 'Visualizar beneficiários' },
  { modulo: 'Beneficiários',  slug: 'beneficiarios.create',  nome: 'Criar beneficiários' },
  { modulo: 'Beneficiários',  slug: 'beneficiarios.update',  nome: 'Editar beneficiários' },
  { modulo: 'Beneficiários',  slug: 'beneficiarios.delete',  nome: 'Excluir beneficiários' },

  // Prestadores
  { modulo: 'Prestadores',    slug: 'prestadores.view',      nome: 'Visualizar prestadores' },
  { modulo: 'Prestadores',    slug: 'prestadores.create',    nome: 'Criar prestadores' },
  { modulo: 'Prestadores',    slug: 'prestadores.update',    nome: 'Editar prestadores' },

  // Guias
  { modulo: 'Guias',          slug: 'guias.view',            nome: 'Visualizar guias' },
  { modulo: 'Guias',          slug: 'guias.create',          nome: 'Criar guias' },
  { modulo: 'Guias',          slug: 'guias.update',          nome: 'Editar guias' },
  { modulo: 'Guias',          slug: 'guias.approve',         nome: 'Autorizar/negar guias' },
  { modulo: 'Guias',          slug: 'guias.audit',           nome: 'Auditar guias' },

  // Financeiro
  { modulo: 'Financeiro',     slug: 'financeiro.view',       nome: 'Visualizar financeiro' },
  { modulo: 'Financeiro',     slug: 'financeiro.manage',     nome: 'Gerenciar financeiro' },
  { modulo: 'Financeiro',     slug: 'boletos.view',          nome: 'Visualizar boletos' },
  { modulo: 'Financeiro',     slug: 'boletos.create',        nome: 'Emitir boletos' },
  { modulo: 'Financeiro',     slug: 'boletos.cancel',        nome: 'Cancelar boletos' },

  // Relatórios
  { modulo: 'Relatórios',     slug: 'relatorios.view',       nome: 'Visualizar relatórios' },
  { modulo: 'Relatórios',     slug: 'relatorios.export',     nome: 'Exportar relatórios' },

  // Documentos
  { modulo: 'Documentos',     slug: 'documentos.view',       nome: 'Visualizar documentos' },
  { modulo: 'Documentos',     slug: 'documentos.upload',     nome: 'Enviar documentos' },
  { modulo: 'Documentos',     slug: 'documentos.delete',     nome: 'Excluir documentos' },

  // Logs
  { modulo: 'Logs',           slug: 'logs.view',             nome: 'Visualizar logs' },

  // Configurações
  { modulo: 'Configurações',  slug: 'settings.view',         nome: 'Acessar administração' },
  { modulo: 'Configurações',  slug: 'settings.manage',       nome: 'Gerenciar configurações' },
] as const

// Permissões por perfil padrão
export const ROLE_PERMISSIONS: Record<string, string[]> = {
  administrador: ALL_PERMISSIONS.map(p => p.slug),
  gestor: [
    'dashboard.view', 'users.view', 'roles.view',
    'beneficiarios.view', 'beneficiarios.create', 'beneficiarios.update',
    'prestadores.view', 'prestadores.create', 'prestadores.update',
    'guias.view', 'guias.approve',
    'financeiro.view', 'financeiro.manage', 'boletos.view', 'boletos.create',
    'relatorios.view', 'relatorios.export',
    'documentos.view', 'settings.view',
  ],
  atendimento: [
    'dashboard.view',
    'beneficiarios.view', 'beneficiarios.create', 'beneficiarios.update',
    'prestadores.view',
    'guias.view', 'guias.create',
    'financeiro.view', 'boletos.view',
    'documentos.view', 'documentos.upload',
  ],
  financeiro: [
    'dashboard.view',
    'beneficiarios.view',
    'financeiro.view', 'financeiro.manage',
    'boletos.view', 'boletos.create', 'boletos.cancel',
    'relatorios.view', 'relatorios.export',
  ],
  auditoria: [
    'dashboard.view',
    'beneficiarios.view',
    'prestadores.view',
    'guias.view', 'guias.audit',
    'relatorios.view',
    'logs.view',
  ],
  credenciamento: [
    'dashboard.view',
    'prestadores.view', 'prestadores.create', 'prestadores.update',
    'documentos.view', 'documentos.upload',
  ],
  beneficiario: [
    'dashboard.view',
    'guias.view',
    'boletos.view',
    'documentos.view',
  ],
  prestador: [
    'dashboard.view',
    'guias.view',
    'documentos.view',
  ],
  visualizador: [
    'dashboard.view',
    'beneficiarios.view',
    'prestadores.view',
    'guias.view',
    'financeiro.view',
    'relatorios.view',
  ],
}
