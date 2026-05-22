import { prisma } from '@/lib/prisma'
import { getCurrentUser, can } from '@/lib/auth'
import { redirect } from 'next/navigation'
import Link from 'next/link'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Shield } from 'lucide-react'

export const metadata = { title: 'Perfis — ServSaúde' }

export default async function PerfisPage() {
  const actor = await getCurrentUser()
  if (!can(actor, 'roles.view')) redirect('/acesso-negado')

  const roles = await prisma.role.findMany({
    include: {
      permissoes: { include: { permissao: true } },
      _count: { select: { usuarios: true } },
    },
    orderBy: { nome: 'asc' },
  })

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-slate-900">Perfis de Acesso</h1>
        <p className="text-sm text-slate-500">Gerenciamento de perfis e permissões</p>
      </div>

      <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
        {roles.map((role) => {
          const modulos = [...new Set(role.permissoes.map(rp => rp.permissao.modulo))]
          return (
            <Card key={String(role.id)} className="flex flex-col">
              <CardHeader className="flex flex-row items-start justify-between pb-2">
                <div>
                  <CardTitle className="text-base flex items-center gap-2">
                    <Shield className="h-4 w-4 text-primary" />
                    {role.nome}
                  </CardTitle>
                  {role.descricao && (
                    <p className="text-xs text-muted-foreground mt-0.5">{role.descricao}</p>
                  )}
                </div>
                <Badge variant={role.ativo ? 'success' : 'secondary'}>
                  {role.ativo ? 'Ativo' : 'Inativo'}
                </Badge>
              </CardHeader>
              <CardContent className="flex-1 space-y-3">
                <div className="flex gap-4 text-sm text-muted-foreground">
                  <span><strong className="text-slate-900">{role._count.usuarios}</strong> usuário(s)</span>
                  <span><strong className="text-slate-900">{role.permissoes.length}</strong> permissão(ões)</span>
                </div>

                {modulos.length > 0 && (
                  <div className="flex flex-wrap gap-1">
                    {modulos.map(m => (
                      <Badge key={m} variant="secondary" className="text-xs">{m}</Badge>
                    ))}
                  </div>
                )}

                {can(actor, 'roles.update') && (
                  <Button asChild variant="outline" size="sm" className="w-full mt-auto">
                    <Link href={`/admin/perfis/${role.id}`}>Gerenciar permissões</Link>
                  </Button>
                )}
              </CardContent>
            </Card>
          )
        })}
      </div>
    </div>
  )
}
