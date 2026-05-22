'use client'

import { useActionState } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { autorizarGuia, negarGuia, type GuiaActionState } from '@/actions/guias'
import { CheckCircle, XCircle } from 'lucide-react'

const initialState: GuiaActionState = {}

function AutorizarForm({ guiaId }: { guiaId: string }) {
  const [state, action, pending] = useActionState(autorizarGuia, initialState)
  return (
    <form action={action} className="space-y-3">
      <input type="hidden" name="guiaId" value={guiaId} />
      {state.success && (
        <div className="rounded-md bg-green-50 border border-green-200 px-3 py-2 text-sm text-green-800">
          {state.success}
        </div>
      )}
      {state.error && (
        <div className="rounded-md bg-red-50 border border-red-200 px-3 py-2 text-sm text-red-800">
          {state.error}
        </div>
      )}
      <Button type="submit" className="w-full bg-green-600 hover:bg-green-700" disabled={pending}>
        <CheckCircle className="h-4 w-4 mr-2" />
        {pending ? 'Autorizando...' : 'Autorizar Guia'}
      </Button>
    </form>
  )
}

function NegarForm({ guiaId }: { guiaId: string }) {
  const [state, action, pending] = useActionState(negarGuia, initialState)
  return (
    <form action={action} className="space-y-3">
      <input type="hidden" name="guiaId" value={guiaId} />
      <div>
        <label htmlFor="motivoCancelamento" className="text-xs text-muted-foreground block mb-1">
          Motivo da negativa *
        </label>
        <textarea
          id="motivoCancelamento"
          name="motivoCancelamento"
          rows={3}
          className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm resize-none focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring"
          placeholder="Descreva o motivo da negativa..."
          required
        />
      </div>
      {state.error && (
        <div className="rounded-md bg-red-50 border border-red-200 px-3 py-2 text-sm text-red-800">
          {state.error}
        </div>
      )}
      <Button type="submit" variant="destructive" className="w-full" disabled={pending}>
        <XCircle className="h-4 w-4 mr-2" />
        {pending ? 'Negando...' : 'Negar Guia'}
      </Button>
    </form>
  )
}

export function AutorizarNegarForm({ guiaId }: { guiaId: string }) {
  return (
    <Card className="border-orange-200 bg-orange-50">
      <CardHeader>
        <CardTitle className="text-base text-orange-800">Decisão de Autorização</CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <AutorizarForm guiaId={guiaId} />
        <div className="relative">
          <div className="absolute inset-0 flex items-center">
            <span className="w-full border-t" />
          </div>
          <div className="relative flex justify-center text-xs uppercase">
            <span className="bg-orange-50 px-2 text-muted-foreground">ou</span>
          </div>
        </div>
        <NegarForm guiaId={guiaId} />
      </CardContent>
    </Card>
  )
}
