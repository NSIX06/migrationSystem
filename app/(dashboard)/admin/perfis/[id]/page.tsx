import { prisma } from '@/lib/prisma'
import { getCurrentUser, can } from '@/lib/auth'
import { redirect, notFound } from 'next/navigation'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { parseBigIntId } from '@/lib/route-params'
import { ArrowLeft, Shield } from 'lucide-react'
import { GerenciarPermissoesForm } from '@/components/servsaude/gerenciar-permissoes-form'

export const metadata = { title: 'Gerenciar Perfil — ServSaúde' }

export default async function PerfilDetalhePage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const actor = await getCurrentUser()
  if (!can(actor, 'roles.view')) redirect('/acesso-negado')

  const { id } = await params
  const roleId = parseBigIntId(id)
  if (!roleId) notFound()

  const [role, todasPermissoes] = await Promise.all([
    prisma.role.findUnique({
      where: { id: roleId },
      include: {
        permissoes: { include: { permissao: true } },
        _count: { select: { usuarios: true } },
      },
    }),
    prisma.permissao.findMany({
      where: { ativo: true },
      orderBy: [{ modulo: 'asc' }, { nome: 'asc' }],
    }),
  ])

  if (!role) notFound()

  const permissoesAtivas = new Set(role.permissoes.map(rp => String(rp.permissaoId)))

  // Agrupa por módulo
  const porModulo = todasPermissoes.reduce<Record<string, typeof todasPermissoes>>((acc, p) => {
    if (!acc[p.modulo]) acc[p.modulo] = []
    acc[p.modulo].push(p)
    return acc
  }, {})

  return (
    <div className="space-y-6 max-w-3xl">
      <div className="flex items-center gap-4">
        <Button asChild variant="ghost" size="sm">
          <Link href="/admin/perfis">
            <ArrowLeft className="h-4 w-4 mr-1" />
            Voltar
          </Link>
        </Button>
        <div className="flex-1">
          <h1 className="text-2xl font-bold text-slate-900 flex items-center gap-2">
            <Shield className="h-5 w-5 text-primary" />
            {role.nome}
          </h1>
          <p className="text-sm text-slate-500">
            {role._count.usuarios} usuário(s) · {role.permissoes.length} permissão(ões)
          </p>
        </div>
        <Badge variant={role.ativo ? 'success' : 'secondary'}>
          {role.ativo ? 'Ativo' : 'Inativo'}
        </Badge>
      </div>

      {can(actor, 'roles.update') ? (
        <GerenciarPermissoesForm
          roleId={String(role.id)}
          porModulo={porModulo}
          permissoesAtivas={permissoesAtivas}
        />
      ) : (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Permissões deste perfil</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            {Object.entries(porModulo).map(([modulo, perms]) => (
              <div key={modulo}>
                <p className="text-xs font-semibold text-muted-foreground uppercase mb-2">{modulo}</p>
                <div className="flex flex-wrap gap-2">
                  {perms.map(p => (
                    <Badge
                      key={String(p.id)}
                      variant={permissoesAtivas.has(String(p.id)) ? 'default' : 'secondary'}
                    >
                      {p.nome}
                    </Badge>
                  ))}
                </div>
              </div>
            ))}
          </CardContent>
        </Card>
      )}
    </div>
  )
}
