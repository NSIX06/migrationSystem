import { prisma } from '@/lib/prisma'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { formatCurrency, formatDate } from '@/lib/utils'
import { DollarSign, TrendingUp, TrendingDown, Clock } from 'lucide-react'

export const metadata = { title: 'Financeiro — ServSaúde' }

type StatusFilter = 'ABERTO' | 'PAGO' | 'VENCIDO' | 'CANCELADO' | 'TODOS'

const statusConfig: Record<string, { label: string; variant: 'warning' | 'success' | 'destructive' | 'secondary' }> = {
  ABERTO:    { label: 'Aberto',    variant: 'warning' },
  PAGO:      { label: 'Pago',      variant: 'success' },
  VENCIDO:   { label: 'Vencido',   variant: 'destructive' },
  CANCELADO: { label: 'Cancelado', variant: 'secondary' },
}

const tipoLabels: Record<string, string> = {
  MENSALIDADE:         'Mensalidade',
  COPARTICIPACAO:      'Coparticipação',
  PAGAMENTO_PRESTADOR: 'Pagamento Prestador',
  ESTORNO:             'Estorno',
  OUTROS:              'Outros',
}

const tabs: { key: StatusFilter; label: string }[] = [
  { key: 'ABERTO',    label: 'Em Aberto' },
  { key: 'VENCIDO',   label: 'Vencidos' },
  { key: 'PAGO',      label: 'Pagos' },
  { key: 'TODOS',     label: 'Todos' },
]

async function getLancamentos(operadoraId: bigint, status: StatusFilter) {
  return prisma.lancamento.findMany({
    where: {
      operadoraId,
      deletedAt: null,
      ...(status !== 'TODOS' ? { status } : {}),
    },
    include: {
      conveniado: { select: { nome: true } },
      prestador:  { select: { nome: true } },
    },
    orderBy: { dataVencimento: 'asc' },
    take: 50,
  })
}

async function getResumo(operadoraId: bigint) {
  const [aberto, pago, vencido] = await Promise.all([
    prisma.lancamento.aggregate({
      where: { operadoraId, status: 'ABERTO',  deletedAt: null },
      _sum: { valor: true }, _count: true,
    }),
    prisma.lancamento.aggregate({
      where: { operadoraId, status: 'PAGO',    deletedAt: null },
      _sum: { valor: true }, _count: true,
    }),
    prisma.lancamento.aggregate({
      where: { operadoraId, status: 'VENCIDO', deletedAt: null },
      _sum: { valor: true }, _count: true,
    }),
  ])
  return { aberto, pago, vencido }
}

export default async function FinanceiroPage({
  searchParams,
}: {
  searchParams: Promise<{ status?: string }>
}) {
  const { status: statusParam = 'ABERTO' } = await searchParams
  const status = (tabs.map(t => t.key).includes(statusParam as StatusFilter)
    ? statusParam : 'ABERTO') as StatusFilter

  const operadoraId = BigInt(process.env.DEV_OPERADORA_ID ?? 1)
  const [lancamentos, resumo] = await Promise.all([
    getLancamentos(operadoraId, status),
    getResumo(operadoraId),
  ])

  const totalAberto  = Number(resumo.aberto._sum.valor  ?? 0)
  const totalPago    = Number(resumo.pago._sum.valor    ?? 0)
  const totalVencido = Number(resumo.vencido._sum.valor ?? 0)

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-slate-900">Financeiro</h1>
        <p className="text-sm text-slate-500">Lançamentos e cobranças</p>
      </div>

      {/* Resumo */}
      <div className="grid gap-4 md:grid-cols-3">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <span className="text-sm font-medium text-muted-foreground">Em Aberto</span>
            <Clock className="h-4 w-4 text-yellow-500" />
          </CardHeader>
          <CardContent>
            <p className="text-2xl font-bold">{formatCurrency(totalAberto)}</p>
            <p className="text-xs text-muted-foreground mt-1">{resumo.aberto._count} lançamento(s)</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <span className="text-sm font-medium text-muted-foreground">Vencidos</span>
            <TrendingDown className="h-4 w-4 text-red-500" />
          </CardHeader>
          <CardContent>
            <p className="text-2xl font-bold text-red-600">{formatCurrency(totalVencido)}</p>
            <p className="text-xs text-muted-foreground mt-1">{resumo.vencido._count} lançamento(s)</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <span className="text-sm font-medium text-muted-foreground">Recebido (mês)</span>
            <TrendingUp className="h-4 w-4 text-green-500" />
          </CardHeader>
          <CardContent>
            <p className="text-2xl font-bold text-green-600">{formatCurrency(totalPago)}</p>
            <p className="text-xs text-muted-foreground mt-1">{resumo.pago._count} lançamento(s)</p>
          </CardContent>
        </Card>
      </div>

      {/* Abas */}
      <div className="flex gap-1 border-b">
        {tabs.map((tab) => (
          <a
            key={tab.key}
            href={`/financeiro?status=${tab.key}`}
            className={`px-4 py-2 text-sm font-medium border-b-2 transition-colors ${
              status === tab.key
                ? 'border-primary text-primary'
                : 'border-transparent text-muted-foreground hover:text-foreground'
            }`}
          >
            {tab.label}
          </a>
        ))}
      </div>

      {/* Tabela */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <DollarSign className="h-4 w-4" />
            Lançamentos — {tabs.find(t => t.key === status)?.label} ({lancamentos.length})
          </CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          {lancamentos.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-10">
              Nenhum lançamento neste status.
            </p>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b bg-slate-50">
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Descrição</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Tipo</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Beneficiário / Prestador</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Vencimento</th>
                    <th className="text-right px-4 py-3 font-medium text-slate-600">Valor</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Status</th>
                  </tr>
                </thead>
                <tbody className="divide-y">
                  {lancamentos.map((l) => {
                    const cfg = statusConfig[l.status] ?? { label: l.status, variant: 'secondary' as const }
                    const referencia = l.conveniado?.nome ?? l.prestador?.nome ?? '—'
                    const vencido = l.status === 'ABERTO' && new Date(l.dataVencimento) < new Date()
                    return (
                      <tr key={String(l.id)} className="hover:bg-slate-50 transition-colors">
                        <td className="px-4 py-3 font-medium">{l.descricao ?? tipoLabels[l.tipoLancamento]}</td>
                        <td className="px-4 py-3 text-slate-600">{tipoLabels[l.tipoLancamento]}</td>
                        <td className="px-4 py-3 text-slate-600">{referencia}</td>
                        <td className={`px-4 py-3 ${vencido ? 'text-red-600 font-medium' : 'text-slate-500'}`}>
                          {formatDate(l.dataVencimento)}
                        </td>
                        <td className="px-4 py-3 text-right font-medium">
                          {formatCurrency(Number(l.valor))}
                        </td>
                        <td className="px-4 py-3">
                          <Badge variant={vencido ? 'destructive' : cfg.variant}>
                            {vencido ? 'Vencido' : cfg.label}
                          </Badge>
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
