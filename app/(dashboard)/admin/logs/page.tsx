import { prisma } from '@/lib/prisma'
import { getCurrentUser, can } from '@/lib/auth'
import { redirect } from 'next/navigation'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { formatDateTime } from '@/lib/utils'
import { ScrollText } from 'lucide-react'

export const metadata = { title: 'Logs de Auditoria — ServSaúde' }

const actionLabel: Record<number, string> = {
  1: 'Criação', 2: 'Edição', 3: 'Inativação', 4: 'Exclusão', 5: 'Acesso negado',
}
const actionVariant: Record<number, 'success' | 'warning' | 'destructive' | 'secondary' | 'default'> = {
  1: 'success', 2: 'default', 3: 'warning', 4: 'destructive', 5: 'destructive',
}

export default async function LogsPage({
  searchParams,
}: {
  searchParams: Promise<{ recurso?: string; acao?: string }>
}) {
  const actor = await getCurrentUser()
  if (!can(actor, 'logs.view')) redirect('/acesso-negado')

  const { recurso = '', acao = '' } = await searchParams

  const logs = await prisma.auditLog.findMany({
    where: {
      ...(recurso ? { recurso: { contains: recurso, mode: 'insensitive' } } : {}),
      ...(acao ? { action: parseInt(acao) } : {}),
    },
    orderBy: { dataHora: 'desc' },
    take: 200,
  })

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-slate-900">Logs de Auditoria</h1>
        <p className="text-sm text-slate-500">Registro de ações no sistema</p>
      </div>

      <form method="GET" className="flex gap-2 flex-wrap">
        <input
          name="recurso"
          defaultValue={recurso}
          placeholder="Filtrar por recurso…"
          className="px-3 py-2 text-sm border rounded-md bg-background focus:outline-none focus:ring-1 focus:ring-ring"
        />
        <select
          name="acao"
          defaultValue={acao}
          className="px-3 py-2 text-sm border rounded-md bg-background focus:outline-none focus:ring-1 focus:ring-ring"
        >
          <option value="">Todas as ações</option>
          {Object.entries(actionLabel).map(([k, v]) => (
            <option key={k} value={k}>{v}</option>
          ))}
        </select>
        <button type="submit" className="px-4 py-2 text-sm bg-slate-900 text-white rounded-md hover:bg-slate-800">
          Filtrar
        </button>
      </form>

      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <ScrollText className="h-4 w-4" />
            {logs.length} registro(s)
          </CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          {logs.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-10">Nenhum log encontrado.</p>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b bg-slate-50">
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Data/Hora</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Usuário</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Ação</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Recurso</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Detalhe</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">IP</th>
                  </tr>
                </thead>
                <tbody className="divide-y">
                  {logs.map((l) => (
                    <tr key={String(l.id)} className="hover:bg-slate-50">
                      <td className="px-4 py-3 text-slate-500 whitespace-nowrap">{formatDateTime(l.dataHora)}</td>
                      <td className="px-4 py-3 text-slate-700">{l.usuarioNome ?? '—'}</td>
                      <td className="px-4 py-3">
                        {l.action != null ? (
                          <Badge variant={actionVariant[l.action] ?? 'secondary'}>
                            {actionLabel[l.action] ?? l.action}
                          </Badge>
                        ) : <span className="text-slate-400">—</span>}
                      </td>
                      <td className="px-4 py-3 text-slate-600 font-mono text-xs">{l.recurso ?? '—'}</td>
                      <td className="px-4 py-3 text-slate-600 max-w-xs truncate">{l.log ?? '—'}</td>
                      <td className="px-4 py-3 text-slate-400 text-xs">{l.ip ?? '—'}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  )
}
