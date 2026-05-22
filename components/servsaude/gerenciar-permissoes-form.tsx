'use client'

import { useActionState } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { atualizarPermissoesRole, type ActionState } from '@/actions/perfis'
import { Lock } from 'lucide-react'

const initial: ActionState = {}

type Permissao = { id: bigint; modulo: string; nome: string; slug: string; descricao: string | null }

export function GerenciarPermissoesForm({
  roleId,
  porModulo,
  permissoesAtivas,
}: {
  roleId: string
  porModulo: Record<string, Permissao[]>
  permissoesAtivas: Set<string>
}) {
  const [state, action, pending] = useActionState(atualizarPermissoesRole, initial)

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base flex items-center gap-2">
          <Lock className="h-4 w-4" />
          Permissões
        </CardTitle>
      </CardHeader>
      <CardContent>
        <form action={action} className="space-y-6">
          <input type="hidden" name="roleId" value={roleId} />

          {state.error && (
            <div className="rounded-md bg-red-50 border border-red-200 px-3 py-2 text-sm text-red-800">
              {state.error}
            </div>
          )}
          {state.success && (
            <div className="rounded-md bg-green-50 border border-green-200 px-3 py-2 text-sm text-green-800">
              {state.success}
            </div>
          )}

          {Object.entries(porModulo).map(([modulo, perms]) => (
            <div key={modulo} className="space-y-2">
              <p className="text-xs font-semibold text-muted-foreground uppercase border-b pb-1">
                {modulo}
              </p>
              <div className="grid grid-cols-2 gap-2">
                {perms.map((p) => (
                  <label
                    key={String(p.id)}
                    className="flex items-center gap-2 cursor-pointer group"
                  >
                    <input
                      type="checkbox"
                      name="permissao"
                      value={String(p.id)}
                      defaultChecked={permissoesAtivas.has(String(p.id))}
                      className="h-4 w-4 rounded border-slate-300 text-primary focus:ring-primary"
                    />
                    <span className="text-sm text-slate-700 group-hover:text-slate-900">
                      {p.nome}
                    </span>
                  </label>
                ))}
              </div>
            </div>
          ))}

          <Button type="submit" disabled={pending} className="w-full">
            {pending ? 'Salvando…' : 'Salvar permissões'}
          </Button>
        </form>
      </CardContent>
    </Card>
  )
}
