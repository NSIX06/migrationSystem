import { prisma } from '@/lib/prisma'
import { getCurrentUser, can } from '@/lib/auth'
import { redirect, notFound } from 'next/navigation'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { ArrowLeft, User } from 'lucide-react'
import { EditarUsuarioForm } from '@/components/servsaude/editar-usuario-form'
import { ExcluirButton } from '@/components/servsaude/usuario-buttons'
import { formatDate, formatDateTime } from '@/lib/utils'

export const metadata = { title: 'Editar Usuário — ServSaúde' }

export default async function EditarUsuarioPage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const actor = await getCurrentUser()
  if (!can(actor, 'users.update')) redirect('/acesso-negado')

  const { id: userId } = await params

  const [profile, roles, logs] = await Promise.all([
    prisma.profile.findFirst({
      where: { userId, deletedAt: null },
      include: {
        roles: { include: { role: true } },
      },
    }),
    prisma.role.findMany({
      where: { ativo: true },
      orderBy: { nome: 'asc' },
      select: { id: true, nome: true },
    }),
    prisma.auditLog.findMany({
      where: { userId },
      orderBy: { dataHora: 'desc' },
      take: 10,
    }),
  ])

  if (!profile) notFound()

  const currentRoleId = profile.roles[0]?.roleId

  return (
    <div className="space-y-6 max-w-3xl">
      <div className="flex items-center gap-4">
        <Button asChild variant="ghost" size="sm">
          <Link href="/admin/usuarios">
            <ArrowLeft className="h-4 w-4 mr-1" />
            Voltar
          </Link>
        </Button>
        <div className="flex-1">
          <h1 className="text-2xl font-bold text-slate-900 flex items-center gap-2">
            <User className="h-5 w-5" />
            {profile.nome}
          </h1>
          <p className="text-sm text-slate-500">{profile.email}</p>
        </div>
        <Badge variant={profile.status === 'ATIVO' ? 'success' : 'secondary'}>
          {profile.status}
        </Badge>
      </div>

      <EditarUsuarioForm
        userId={userId}
        profile={{
          nome: profile.nome,
          fone: profile.fone ?? '',
          userType: profile.userType,
          status: profile.status,
          roleId: currentRoleId ? String(currentRoleId) : '',
        }}
        roles={roles.map(r => ({ id: String(r.id), nome: r.nome }))}
        actorType={actor?.userType ?? ''}
      />

      {can(actor, 'users.delete') && actor?.userId !== userId && (
        <Card className="border-red-200">
          <CardHeader>
            <CardTitle className="text-sm text-red-700">Zona de perigo</CardTitle>
          </CardHeader>
          <CardContent className="flex items-center justify-between">
            <p className="text-sm text-slate-600">Excluir este usuário permanentemente (exclusão lógica).</p>
            <ExcluirButton userId={userId} />
          </CardContent>
        </Card>
      )}

      {logs.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-sm">Últimas ações deste usuário</CardTitle>
          </CardHeader>
          <CardContent className="p-0">
            <div className="divide-y">
              {logs.map(l => (
                <div key={String(l.id)} className="px-4 py-3 flex items-start justify-between gap-4">
                  <p className="text-sm text-slate-700">{l.log ?? l.recurso}</p>
                  <span className="text-xs text-slate-400 shrink-0">{formatDateTime(l.dataHora)}</span>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  )
}
