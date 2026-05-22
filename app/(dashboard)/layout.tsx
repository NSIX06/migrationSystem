import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import { prisma } from '@/lib/prisma'
import { Sidebar } from '@/components/servsaude/sidebar'

export default async function DashboardLayout({ children }: { children: React.ReactNode }) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) redirect('/login')

  // Carrega perfil e permissões para o sidebar
  const profile = await prisma.profile.findUnique({
    where: { userId: user.id, deletedAt: null },
    include: {
      roles: {
        include: {
          role: {
            include: { permissoes: { include: { permissao: true } } },
          },
        },
      },
      permissoes: { include: { permissao: true } },
    },
  }).catch(() => null)

  let permissions: string[] = []
  let userType: string | undefined

  if (profile) {
    if (profile.status === 'INATIVO' || profile.status === 'BLOQUEADO') {
      redirect('/login')
    }

    const permSet = new Set<string>()
    for (const ur of profile.roles) {
      for (const rp of ur.role.permissoes) {
        if (rp.permissao.ativo) permSet.add(rp.permissao.slug)
      }
    }
    for (const pu of profile.permissoes) {
      if (pu.concedido) permSet.add(pu.permissao.slug)
      else permSet.delete(pu.permissao.slug)
    }
    permissions = [...permSet]
    userType = profile.userType
  }

  return (
    <div className="flex h-screen overflow-hidden">
      <Sidebar permissions={permissions} userType={userType} />
      <main className="flex-1 overflow-y-auto bg-slate-50">
        <div className="p-6">{children}</div>
      </main>
    </div>
  )
}
