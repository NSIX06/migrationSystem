'use client'

import { useActionState } from 'react'
import { Button } from '@/components/ui/button'
import { inativarUsuario, ativarUsuario, excluirUsuario, type ActionState } from '@/actions/usuarios'

const initial: ActionState = {}

export function InativarButton({ userId, status }: { userId: string; status: string }) {
  const action = status === 'ATIVO' ? inativarUsuario : ativarUsuario
  const label = status === 'ATIVO' ? 'Inativar' : 'Reativar'
  const [, formAction, pending] = useActionState(action, initial)
  return (
    <form action={formAction}>
      <input type="hidden" name="userId" value={userId} />
      <Button
        type="submit"
        variant={status === 'ATIVO' ? 'outline' : 'secondary'}
        size="sm"
        disabled={pending}
      >
        {pending ? '…' : label}
      </Button>
    </form>
  )
}

export function ExcluirButton({ userId }: { userId: string }) {
  const [state, formAction, pending] = useActionState(excluirUsuario, initial)
  return (
    <form action={formAction} onSubmit={(e) => {
      if (!confirm('Excluir este usuário permanentemente? Esta ação não pode ser desfeita.')) {
        e.preventDefault()
      }
    }}>
      <input type="hidden" name="userId" value={userId} />
      {state?.error && <p className="text-xs text-red-600 mb-1">{state.error}</p>}
      <Button type="submit" variant="destructive" size="sm" disabled={pending}>
        {pending ? '…' : 'Excluir'}
      </Button>
    </form>
  )
}
