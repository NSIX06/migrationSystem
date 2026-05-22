import { cache } from 'react'
import { createClient } from '@/lib/supabase/server'
import { prisma } from '@/lib/prisma'

export type CurrentUser = {
  userId: string
  email: string
  nome: string
  userType: string
  status: string
  permissions: Set<string>
}

export const getCurrentUser = cache(async (): Promise<CurrentUser | null> => {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return null

  const profile = await prisma.profile.findUnique({
    where: { userId: user.id, deletedAt: null },
    include: {
      roles: {
        include: {
          role: {
            include: {
              permissoes: {
                include: { permissao: true },
              },
            },
          },
        },
      },
      permissoes: {
        include: { permissao: true },
      },
    },
  })

  if (!profile) return null
  if (profile.status === 'INATIVO' || profile.status === 'BLOQUEADO') return null

  const permissions = new Set<string>()

  for (const ur of profile.roles) {
    for (const rp of ur.role.permissoes) {
      if (rp.permissao.ativo) permissions.add(rp.permissao.slug)
    }
  }

  // User-level overrides
  for (const pu of profile.permissoes) {
    if (pu.concedido) {
      permissions.add(pu.permissao.slug)
    } else {
      permissions.delete(pu.permissao.slug)
    }
  }

  return {
    userId: profile.userId,
    email: profile.email,
    nome: profile.nome,
    userType: profile.userType,
    status: profile.status,
    permissions,
  }
})

export function can(user: CurrentUser | null, slug: string): boolean {
  if (!user) return false
  if (user.userType === 'ADMIN') return true
  return user.permissions.has(slug)
}

export function canAny(user: CurrentUser | null, slugs: string[]): boolean {
  return slugs.some(s => can(user, s))
}
