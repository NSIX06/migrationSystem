'use server'

import { revalidatePath } from 'next/cache'
import { prisma } from '@/lib/prisma'
import { getCurrentUser, can } from '@/lib/auth'

export type ActionState = { error?: string; success?: string }

export async function atualizarPermissoesRole(
  _prev: ActionState,
  formData: FormData,
): Promise<ActionState> {
  const actor = await getCurrentUser()
  if (!can(actor, 'roles.update')) return { error: 'Sem permissão.' }

  const roleId = BigInt(formData.get('roleId') as string)
  const slugsSelecionados = formData.getAll('permissao') as string[]

  const todasPermissoes = await prisma.permissao.findMany({ where: { ativo: true } })
  const permissoesSelecionadas = todasPermissoes.filter(p =>
    slugsSelecionados.includes(String(p.id)),
  )

  // Substitui todas as permissões do role
  await prisma.$transaction([
    prisma.rolePermissao.deleteMany({ where: { roleId } }),
    prisma.rolePermissao.createMany({
      data: permissoesSelecionadas.map(p => ({ roleId, permissaoId: p.id })),
      skipDuplicates: true,
    }),
  ])

  await prisma.auditLog.create({
    data: {
      userId: actor?.userId,
      usuarioNome: actor?.nome,
      recurso: 'roles',
      action: 2,
      log: `Permissões do perfil ${roleId} atualizadas (${permissoesSelecionadas.length} permissões)`,
    },
  })

  revalidatePath(`/admin/perfis/${roleId}`)
  revalidatePath('/admin/perfis')
  return { success: 'Permissões atualizadas com sucesso!' }
}
