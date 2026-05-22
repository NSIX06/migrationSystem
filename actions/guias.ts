'use server'

import { revalidatePath } from 'next/cache'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'

const autorizarSchema = z.object({
  guiaId: z.string(),
  dataValidadeSenha: z.string().optional(),
})

const negarSchema = z.object({
  guiaId: z.string(),
  motivoCancelamento: z.string().min(5, 'Informe o motivo (mínimo 5 caracteres)'),
})

export type GuiaActionState = { error?: string; success?: string }

export async function autorizarGuia(
  _prev: GuiaActionState,
  formData: FormData,
): Promise<GuiaActionState> {
  const parsed = autorizarSchema.safeParse({ guiaId: formData.get('guiaId') })
  if (!parsed.success) return { error: 'Dados inválidos.' }

  const id = BigInt(parsed.data.guiaId)
  const senha = Math.floor(100000 + Math.random() * 900000)
  const dataValidadeSenha = new Date()
  dataValidadeSenha.setDate(dataValidadeSenha.getDate() + 30)

  await prisma.guia.update({
    where: { id },
    data: {
      status: 'AUTORIZADA',
      dataAutorizacao: new Date(),
      senha,
      dataValidadeSenha,
      autenticada: true,
    },
  })

  revalidatePath('/guias')
  revalidatePath(`/guias/${parsed.data.guiaId}`)
  return { success: `Guia autorizada. Senha: ${senha}` }
}

export async function negarGuia(
  _prev: GuiaActionState,
  formData: FormData,
): Promise<GuiaActionState> {
  const parsed = negarSchema.safeParse({
    guiaId: formData.get('guiaId'),
    motivoCancelamento: formData.get('motivoCancelamento'),
  })
  if (!parsed.success) {
    return { error: parsed.error.errors[0].message }
  }

  const id = BigInt(parsed.data.guiaId)

  await prisma.guia.update({
    where: { id },
    data: {
      status: 'NEGADA',
      motivoCancelamento: parsed.data.motivoCancelamento,
      dataHoraCancelamento: new Date(),
    },
  })

  revalidatePath('/guias')
  revalidatePath(`/guias/${parsed.data.guiaId}`)
  return { success: 'Guia negada.' }
}
