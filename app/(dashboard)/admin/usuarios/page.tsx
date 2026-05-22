import { prisma } from '@/lib/prisma'
import { getCurrentUser, can } from '@/lib/auth'
import { redirect } from 'next/navigation'
import Link from 'next/link'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { formatDate } from '@/lib/utils'
import { Users, Plus, Search } from 'lucide-react'
import { InativarButton } from '@/components/servsaude/usuario-buttons'

export const metadata = { title: 'Usuários — ServSaúde' }

const userTypeLabel: Record<string, string> = {
  ADMIN: 'Administrador', GESTOR: 'Gestor', ATENDIMENTO: 'Atendimento',
  FINANCEIRO: 'Financeiro', AUDITORIA: 'Auditoria', CREDENCIAMENTO: 'Credenciamento',
  BENEFICIARIO: 'Beneficiário', PRESTADOR: 'Prestador', VISUALIZADOR: 'Visualizador',
}

const statusVariant: Record<string, 'success' | 'warning' | 'destructive' | 'secondary'> = {
  ATIVO: 'success', PENDENTE: 'warning', BLOQUEADO: 'destructive', INATIVO: 'secondary',
}

export default async function UsuariosPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string; tipo?: string; status?: string }>
}) {
  const actor = await getCurrentUser()
  if (!can(actor, 'users.view')) redirect('/acesso-negado')

  const { q = '', tipo = '', status = '' } = await searchParams

  const usuarios = await prisma.profile.findMany({
    where: {
      deletedAt: null,
      ...(q ? {
        OR: [
          { nome: { contains: q, mode: 'insensitive' } },
          { email: { contains: q, mode: 'insensitive' } },
          { cpf: { contains: q } },
        ],
      } : {}),
      ...(tipo ? { userType: tipo as any } : {}),
      ...(status ? { status: status as any } : {}),
    },
    include: {
      roles: { include: { role: true } },
    },
    orderBy: { nome: 'asc' },
    take: 100,
  })

  const canCreate = can(actor, 'users.create')
  const canDisable = can(actor, 'users.disable')

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Usuários</h1>
          <p className="text-sm text-slate-500">Gerenciamento de usuários do sistema</p>
        </div>
        {canCreate && (
          <Button asChild>
            <Link href="/admin/usuarios/novo">
              <Plus className="h-4 w-4 mr-2" />
              Novo Usuário
            </Link>
          </Button>
        )}
      </div>

      {/* Filtros */}
      <form method="GET" className="flex gap-2 flex-wrap">
        <div className="relative flex-1 min-w-48">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
          <input
            name="q"
            defaultValue={q}
            placeholder="Buscar por nome, e-mail ou CPF…"
            className="w-full pl-9 pr-3 py-2 text-sm border rounded-md focus:outline-none focus:ring-1 focus:ring-ring bg-background"
          />
        </div>
        <select
          name="tipo"
          defaultValue={tipo}
          className="px-3 py-2 text-sm border rounded-md bg-background focus:outline-none focus:ring-1 focus:ring-ring"
        >
          <option value="">Todos os tipos</option>
          {Object.entries(userTypeLabel).map(([k, v]) => (
            <option key={k} value={k}>{v}</option>
          ))}
        </select>
        <select
          name="status"
          defaultValue={status}
          className="px-3 py-2 text-sm border rounded-md bg-background focus:outline-none focus:ring-1 focus:ring-ring"
        >
          <option value="">Todos os status</option>
          <option value="ATIVO">Ativo</option>
          <option value="INATIVO">Inativo</option>
          <option value="BLOQUEADO">Bloqueado</option>
          <option value="PENDENTE">Pendente</option>
        </select>
        <Button type="submit" variant="secondary" size="sm">Filtrar</Button>
        {(q || tipo || status) && (
          <Button asChild variant="ghost" size="sm">
            <Link href="/admin/usuarios">Limpar</Link>
          </Button>
        )}
      </form>

      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Users className="h-4 w-4" />
            {usuarios.length} usuário(s) encontrado(s)
          </CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          {usuarios.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-10">
              Nenhum usuário encontrado.
            </p>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b bg-slate-50">
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Nome</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">E-mail</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Tipo</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Perfil</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Status</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Criado em</th>
                    <th className="text-right px-4 py-3 font-medium text-slate-600">Ações</th>
                  </tr>
                </thead>
                <tbody className="divide-y">
                  {usuarios.map((u) => {
                    const role = u.roles[0]?.role
                    const isSelf = u.userId === actor?.userId
                    return (
                      <tr key={u.userId} className="hover:bg-slate-50 transition-colors">
                        <td className="px-4 py-3 font-medium">{u.nome}</td>
                        <td className="px-4 py-3 text-slate-600">{u.email}</td>
                        <td className="px-4 py-3 text-slate-600">{userTypeLabel[u.userType] ?? u.userType}</td>
                        <td className="px-4 py-3">
                          {role ? (
                            <Badge variant="secondary">{role.nome}</Badge>
                          ) : (
                            <span className="text-slate-400">—</span>
                          )}
                        </td>
                        <td className="px-4 py-3">
                          <Badge variant={statusVariant[u.status] ?? 'secondary'}>
                            {u.status}
                          </Badge>
                        </td>
                        <td className="px-4 py-3 text-slate-500">{formatDate(u.createdAt)}</td>
                        <td className="px-4 py-3 text-right">
                          <div className="flex items-center justify-end gap-2">
                            <Button asChild variant="ghost" size="sm">
                              <Link href={`/admin/usuarios/${u.userId}`}>Editar</Link>
                            </Button>
                            {canDisable && !isSelf && (
                              <InativarButton
                                userId={u.userId}
                                status={u.status}
                              />
                            )}
                          </div>
                        </td>
                      </tr>
                    )
                  })}
                </tbody>
              </table>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  )
}
