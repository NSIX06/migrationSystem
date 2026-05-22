import { prisma } from '@/lib/prisma'
import { getCurrentUser, can } from '@/lib/auth'
import { redirect } from 'next/navigation'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { ArrowLeft } from 'lucide-react'
import { NovoUsuarioForm } from '@/components/servsaude/novo-usuario-form'

export const metadata = { title: 'Novo Usuário — ServSaúde' }

export default async function NovoUsuarioPage() {
  const actor = await getCurrentUser()
  if (!can(actor, 'users.create')) redirect('/acesso-negado')

  const roles = await prisma.role.findMany({
    where: { ativo: true },
    orderBy: { nome: 'asc' },
    select: { id: true, nome: true },
  })

  return (
    <div className="space-y-6 max-w-2xl">
      <div className="flex items-center gap-4">
        <Button asChild variant="ghost" size="sm">
          <Link href="/admin/usuarios">
            <ArrowLeft className="h-4 w-4 mr-1" />
            Voltar
          </Link>
        </Button>
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Novo Usuário</h1>
          <p className="text-sm text-slate-500">Cadastrar usuário no sistema</p>
        </div>
      </div>

      <NovoUsuarioForm roles={roles.map(r => ({ id: String(r.id), nome: r.nome }))} />
    </div>
  )
}
