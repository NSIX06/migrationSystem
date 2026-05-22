'use server'

import { revalidatePath } from 'next/cache'
import { prisma } from '@/lib/prisma'
import { createAdminClient } from '@/lib/supabase/server'
import { getCurrentUser, can } from '@/lib/auth'
import { z } from 'zod'

export type ActionState = { error?: string; success?: string }

const CreateUsuarioSchema = z.object({
  nome: z.string().min(3, 'Nome deve ter ao menos 3 caracteres'),
  email: z.string().email('E-mail inválido'),
  cpf: z.string().optional(),
  fone: z.string().optional(),
  userType: z.enum(['ADMIN','GESTOR','ATENDIMENTO','FINANCEIRO','AUDITORIA','CREDENCIAMENTO','BENEFICIARIO','PRESTADOR','VISUALIZADOR']),
  roleId: z.string().min(1, 'Selecione um perfil'),
  status: z.enum(['ATIVO','INATIVO','BLOQUEADO','PENDENTE']).default('ATIVO'),
  password: z.string().min(8, 'Senha mínima de 8 caracteres'),
})

const UpdateUsuarioSchema = z.object({
  userId: z.string().uuid(),
  nome: z.string().min(3),
  fone: z.string().optional(),
  userType: z.enum(['ADMIN','GESTOR','ATENDIMENTO','FINANCEIRO','AUDITORIA','CREDENCIAMENTO','BENEFICIARIO','PRESTADOR','VISUALIZADOR']),
  roleId: z.string().min(1),
  status: z.enum(['ATIVO','INATIVO','BLOQUEADO','PENDENTE']),
})

async function findAuthUserByEmail(email: string) {
  const supabaseAdmin = createAdminClient()
  const normalizedEmail = email.trim().toLowerCase()
  const perPage = 100

  for (let page = 1; ; page++) {
    const { data, error } = await supabaseAdmin.auth.admin.listUsers({ page, perPage })
    if (error) throw error

    const user = data.users.find((candidate) => candidate.email?.toLowerCase() === normalizedEmail)
    if (user || data.users.length < perPage) return user ?? null
  }
}

export async function criarUsuario(_prev: ActionState, formData: FormData): Promise<ActionState> {
  const actor = await getCurrentUser()
  if (!can(actor, 'users.create')) return { error: 'Sem permissão para criar usuários.' }

  const parsed = CreateUsuarioSchema.safeParse(Object.fromEntries(formData))
  if (!parsed.success) return { error: parsed.error.errors[0].message }

  const { nome, email, cpf, fone, userType, roleId, status, password } = parsed.data

  const supabaseAdmin = createAdminClient()
  const existingProfile = await prisma.profile.findFirst({
    where: { email: { equals: email, mode: 'insensitive' }, deletedAt: null },
    select: { userId: true },
  })

  if (existingProfile) return { error: 'Já existe um usuário cadastrado com esse e-mail.' }

  let authUser = await findAuthUserByEmail(email)
  let createdAuthUser = false

  if (authUser) {
    const { data, error } = await supabaseAdmin.auth.admin.updateUserById(authUser.id, {
      password,
      email_confirm: true,
      user_metadata: { ...authUser.user_metadata, nome },
    })

    if (error || !data.user) return { error: error?.message ?? 'Erro ao preparar usuário no Auth.' }
    authUser = data.user
  } else {
    const { data, error } = await supabaseAdmin.auth.admin.createUser({
      email,
      password,
      email_confirm: true,
      user_metadata: { nome },
    })

    if (error || !data.user) return { error: error?.message ?? 'Erro ao criar usuário no Auth.' }
    authUser = data.user
    createdAuthUser = true
  }

  const userId = authUser.id

  try {
    await prisma.$transaction(async (tx) => {
      await tx.profile.create({
        data: {
          userId,
          nome,
          email,
          cpf: cpf || null,
          fone: fone || null,
          userType: userType as any,
          status: status as any,
        },
      })

      await tx.usuarioRole.create({
        data: { userId, roleId: BigInt(roleId) },
      })
    })

    await prisma.auditLog.create({
      data: {
        userId: actor?.userId,
        usuarioNome: actor?.nome,
        recurso: 'profiles',
        action: 1,
        log: `Usuário ${email} criado com perfil ${roleId}`,
      },
    })
  } catch (e) {
    // Rollback Auth users created by this action if the app profile fails.
    if (createdAuthUser) await supabaseAdmin.auth.admin.deleteUser(userId)
    return { error: 'Erro ao salvar perfil. Tente novamente.' }
  }

  revalidatePath('/admin/usuarios')
  return { success: `Usuário ${nome} criado com sucesso!` }
}

export async function atualizarUsuario(_prev: ActionState, formData: FormData): Promise<ActionState> {
  const actor = await getCurrentUser()
  if (!can(actor, 'users.update')) return { error: 'Sem permissão para editar usuários.' }

  const parsed = UpdateUsuarioSchema.safeParse(Object.fromEntries(formData))
  if (!parsed.success) return { error: parsed.error.errors[0].message }

  const { userId, nome, fone, userType, roleId, status } = parsed.data

  // Impede autoelevação para ADMIN por não-admin
  if (userType === 'ADMIN' && actor?.userType !== 'ADMIN') {
    return { error: 'Somente administradores podem definir tipo ADMIN.' }
  }

  const existing = await prisma.profile.findUnique({ where: { userId } })
  if (!existing) return { error: 'Usuário não encontrado.' }

  await prisma.$transaction([
    prisma.profile.update({
      where: { userId },
      data: { nome, fone: fone || null, userType: userType as any, status: status as any },
    }),
    prisma.usuarioRole.deleteMany({ where: { userId } }),
    prisma.usuarioRole.create({ data: { userId, roleId: BigInt(roleId) } }),
  ])

  await prisma.auditLog.create({
    data: {
      userId: actor?.userId,
      usuarioNome: actor?.nome,
      recurso: 'profiles',
      registroId: null,
      action: 2,
      log: `Usuário ${existing.email} atualizado`,
    },
  })

  revalidatePath('/admin/usuarios')
  revalidatePath(`/admin/usuarios/${userId}`)
  return { success: 'Usuário atualizado com sucesso!' }
}

export async function inativarUsuario(_prev: ActionState, formData: FormData): Promise<ActionState> {
  const actor = await getCurrentUser()
  if (!can(actor, 'users.disable')) return { error: 'Sem permissão.' }

  const userId = formData.get('userId') as string
  if (!userId) return { error: 'ID inválido.' }

  await prisma.profile.update({
    where: { userId },
    data: { status: 'INATIVO' },
  })

  await prisma.auditLog.create({
    data: {
      userId: actor?.userId,
      usuarioNome: actor?.nome,
      recurso: 'profiles',
      action: 3,
      log: `Usuário ${userId} inativado`,
    },
  })

  revalidatePath('/admin/usuarios')
  return { success: 'Usuário inativado.' }
}

export async function ativarUsuario(_prev: ActionState, formData: FormData): Promise<ActionState> {
  const actor = await getCurrentUser()
  if (!can(actor, 'users.disable')) return { error: 'Sem permissão.' }

  const userId = formData.get('userId') as string
  await prisma.profile.update({
    where: { userId },
    data: { status: 'ATIVO' },
  })

  revalidatePath('/admin/usuarios')
  return { success: 'Usuário reativado.' }
}

export async function excluirUsuario(_prev: ActionState, formData: FormData): Promise<ActionState> {
  const actor = await getCurrentUser()
  if (!can(actor, 'users.delete')) return { error: 'Sem permissão para excluir usuários.' }

  const userId = formData.get('userId') as string
  if (userId === actor?.userId) return { error: 'Você não pode excluir sua própria conta.' }

  await prisma.profile.update({
    where: { userId },
    data: { deletedAt: new Date(), status: 'INATIVO' },
  })

  await prisma.auditLog.create({
    data: {
      userId: actor?.userId,
      usuarioNome: actor?.nome,
      recurso: 'profiles',
      action: 4,
      log: `Usuário ${userId} excluído logicamente`,
    },
  })

  revalidatePath('/admin/usuarios')
  return { success: 'Usuário excluído.' }
}
