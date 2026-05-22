import Link from 'next/link'
import { prisma } from '@/lib/prisma'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { formatDate } from '@/lib/utils'
import { FileText, AlertTriangle } from 'lucide-react'

export const metadata = { title: 'Autorizações — ServSaúde' }

type StatusFilter = 'SOLICITADA' | 'AUTORIZADA' | 'NEGADA' | 'TODAS'

const statusConfig: Record<string, { label: string; variant: 'warning' | 'success' | 'destructive' | 'secondary' | 'info' }> = {
  SOLICITADA:    { label: 'Solicitada',    variant: 'warning' },
  AUTORIZADA:    { label: 'Autorizada',    variant: 'success' },
  NEGADA:        { label: 'Negada',        variant: 'destructive' },
  EM_AUDITORIA:  { label: 'Em Auditoria',  variant: 'info' },
  CANCELADA:     { label: 'Cancelada',     variant: 'secondary' },
  FATURADA:      { label: 'Faturada',      variant: 'secondary' },
}

const tipoLabels: Record<string, string> = {
  CONSULTA:    'Consulta',
  SADT:        'SADT',
  INTERNACAO:  'Internação',
  HONORARIO:   'Honorário',
  OUTROS:      'Outros',
}

const tabs: { key: StatusFilter; label: string }[] = [
  { key: 'SOLICITADA', label: 'Pendentes' },
  { key: 'AUTORIZADA', label: 'Autorizadas' },
  { key: 'NEGADA',     label: 'Negadas' },
  { key: 'TODAS',      label: 'Todas' },
]

async function getGuias(operadoraId: bigint, status: StatusFilter) {
  return prisma.guia.findMany({
    where: {
      operadoraId,
      deletedAt: null,
      ...(status !== 'TODAS' ? { status } : {}),
    },
    include: {
      conveniado: { select: { nome: true, cpf: true } },
      prestador:  { select: { nome: true } },
    },
    orderBy: { createdAt: 'asc' },
    take: 50,
  })
}

async function getCounts(operadoraId: bigint) {
  const [solicitadas, autorizadas, negadas, total] = await Promise.all([
    prisma.guia.count({ where: { operadoraId, status: 'SOLICITADA', deletedAt: null } }),
    prisma.guia.count({ where: { operadoraId, status: 'AUTORIZADA', deletedAt: null } }),
    prisma.guia.count({ where: { operadoraId, status: 'NEGADA',     deletedAt: null } }),
    prisma.guia.count({ where: { operadoraId, deletedAt: null } }),
  ])
  return { SOLICITADA: solicitadas, AUTORIZADA: autorizadas, NEGADA: negadas, TODAS: total }
}

export default async function GuiasPage({
  searchParams,
}: {
  searchParams: Promise<{ status?: string }>
}) {
  const { status: statusParam = 'SOLICITADA' } = await searchParams
  const status = (tabs.map(t => t.key).includes(statusParam as StatusFilter)
    ? statusParam
    : 'SOLICITADA') as StatusFilter

  const operadoraId = BigInt(process.env.DEV_OPERADORA_ID ?? 1)
  const [guias, counts] = await Promise.all([
    getGuias(operadoraId, status),
    getCounts(operadoraId),
  ])

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-slate-900">Autorizações de Guias</h1>
        <p className="text-sm text-slate-500">{counts.SOLICITADA} guia(s) aguardando autorização</p>
      </div>

      {/* Abas de status */}
      <div className="flex gap-1 border-b">
        {tabs.map((tab) => (
          <Link
            key={tab.key}
            href={`/guias?status=${tab.key}`}
            className={`px-4 py-2 text-sm font-medium border-b-2 transition-colors ${
              status === tab.key
                ? 'border-primary text-primary'
                : 'border-transparent text-muted-foreground hover:text-foreground'
            }`}
          >
            {tab.label}
            <span className="ml-2 rounded-full bg-muted px-1.5 py-0.5 text-xs">
              {counts[tab.key]}
            </span>
          </Link>
        ))}
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <FileText className="h-4 w-4" />
            {tabs.find(t => t.key === status)?.label} ({guias.length})
          </CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          {guias.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-10">
              Nenhuma guia neste status.
            </p>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b bg-slate-50">
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Nº</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Beneficiário</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Prestador</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Tipo</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Data</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Status</th>
                    <th />
                  </tr>
                </thead>
                <tbody className="divide-y">
                  {guias.map((g) => {
                    const cfg = statusConfig[g.status] ?? { label: g.status, variant: 'secondary' as const }
                    return (
                      <tr key={String(g.id)} className="hover:bg-slate-50 transition-colors">
                        <td className="px-4 py-3 text-slate-500 font-mono">#{String(g.id)}</td>
                        <td className="px-4 py-3">
                          <p className="font-medium">{g.conveniado?.nome ?? '—'}</p>
                        </td>
                        <td className="px-4 py-3 text-slate-600">{g.prestador?.nome ?? '—'}</td>
                        <td className="px-4 py-3">
                          <div className="flex items-center gap-1">
                            {g.urgente && <AlertTriangle className="h-3.5 w-3.5 text-red-500" />}
                            {tipoLabels[g.tipo] ?? g.tipo}
                          </div>
                        </td>
                        <td className="px-4 py-3 text-slate-500">{formatDate(g.createdAt)}</td>
                        <td className="px-4 py-3">
                          <Badge variant={cfg.variant}>{cfg.label}</Badge>
                        </td>
                        <td className="px-4 py-3">
                          <Button asChild variant="ghost" size="sm">
                            <Link href={`/guias/${g.id}`}>Ver</Link>
                          </Button>
                        </td>
                      </tr>
                    )
                  })}
                </tbody>
              </table>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  )
}
