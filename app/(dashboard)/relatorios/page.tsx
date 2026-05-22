import { prisma } from '@/lib/prisma'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { formatCurrency } from '@/lib/utils'
import {
  Users, FileText, DollarSign, TrendingUp,
  TrendingDown, Clock, CheckCircle, XCircle, AlertTriangle,
} from 'lucide-react'

export const metadata = { title: 'Relatórios — ServSaúde' }

async function getRelatorios(operadoraId: bigint) {
  const hoje = new Date()
  const inicioMes = new Date(hoje.getFullYear(), hoje.getMonth(), 1)
  const fimMes = new Date(hoje.getFullYear(), hoje.getMonth() + 1, 0)

  const [
    totalAtivos, totalSuspensos, totalEncerrados,
    guiasPorStatus, guiasPorTipo, guiasUrgentes,
    lancPorStatus, lancPorTipo, receitaMes,
    produtosComBenef,
  ] = await Promise.all([
    prisma.adesao.count({ where: { operadoraId, status: 'ATIVO', deletedAt: null } }),
    prisma.adesao.count({ where: { operadoraId, status: 'SUSPENSO', deletedAt: null } }),
    prisma.adesao.count({ where: { operadoraId, status: 'ENCERRADO', deletedAt: null } }),

    prisma.guia.groupBy({
      by: ['status'],
      where: { operadoraId, deletedAt: null },
      _count: true,
    }),
    prisma.guia.groupBy({
      by: ['tipo'],
      where: { operadoraId, deletedAt: null },
      _count: true,
    }),
    prisma.guia.count({ where: { operadoraId, urgente: true, deletedAt: null } }),

    prisma.lancamento.groupBy({
      by: ['status'],
      where: { operadoraId, deletedAt: null },
      _count: true,
      _sum: { valor: true },
    }),
    prisma.lancamento.groupBy({
      by: ['tipoLancamento'],
      where: { operadoraId, deletedAt: null },
      _count: true,
      _sum: { valor: true },
    }),
    prisma.lancamento.aggregate({
      where: {
        operadoraId,
        status: 'PAGO',
        dataBaixa: { gte: inicioMes, lte: fimMes },
        deletedAt: null,
      },
      _sum: { valor: true },
      _count: true,
    }),

    prisma.produto.findMany({
      where: { operadoraId, ativo: true, deletedAt: null },
      select: {
        id: true,
        descricao: true,
        _count: { select: { adesoes: { where: { status: 'ATIVO', deletedAt: null } } } },
      },
      orderBy: { descricao: 'asc' },
    }),
  ])

  return {
    beneficiarios: { ativos: totalAtivos, suspensos: totalSuspensos, encerrados: totalEncerrados },
    guias: { porStatus: guiasPorStatus, porTipo: guiasPorTipo, urgentes: guiasUrgentes },
    financeiro: { porStatus: lancPorStatus, porTipo: lancPorTipo, receitaMes },
    produtos: produtosComBenef,
  }
}

const statusGuiaLabel: Record<string, string> = {
  SOLICITADA: 'Solicitada', AUTORIZADA: 'Autorizada', NEGADA: 'Negada',
  EM_AUDITORIA: 'Em Auditoria', CANCELADA: 'Cancelada', FATURADA: 'Faturada',
}
const tipoGuiaLabel: Record<string, string> = {
  CONSULTA: 'Consulta', SADT: 'SADT', INTERNACAO: 'Internação',
  HONORARIO: 'Honorário', OUTROS: 'Outros',
}
const statusLancLabel: Record<string, string> = {
  ABERTO: 'Em Aberto', PAGO: 'Pago', VENCIDO: 'Vencido', CANCELADO: 'Cancelado',
}
const tipoLancLabel: Record<string, string> = {
  MENSALIDADE: 'Mensalidade', COPARTICIPACAO: 'Coparticipação',
  PAGAMENTO_PRESTADOR: 'Pagamento Prestador', ESTORNO: 'Estorno', OUTROS: 'Outros',
}

function KpiCard({
  title, value, sub, icon: Icon, color = 'text-slate-900',
}: {
  title: string
  value: string | number
  sub?: string
  icon: React.ElementType
  color?: string
}) {
  return (
    <Card>
      <CardHeader className="flex flex-row items-center justify-between pb-2">
        <span className="text-sm font-medium text-muted-foreground">{title}</span>
        <Icon className="h-4 w-4 text-muted-foreground" />
      </CardHeader>
      <CardContent>
        <p className={`text-2xl font-bold ${color}`}>{value}</p>
        {sub && <p className="text-xs text-muted-foreground mt-1">{sub}</p>}
      </CardContent>
    </Card>
  )
}

function Section({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div className="space-y-3">
      <h2 className="text-base font-semibold text-slate-700 border-b pb-1">{title}</h2>
      {children}
    </div>
  )
}

function DistribTable({
  rows,
}: {
  rows: { label: string; count: number; valor?: number }[]
}) {
  const total = rows.reduce((s, r) => s + r.count, 0)
  return (
    <div className="rounded-md border overflow-hidden">
      <table className="w-full text-sm">
        <thead>
          <tr className="bg-slate-50 border-b">
            <th className="text-left px-4 py-2 font-medium text-slate-600">Item</th>
            <th className="text-right px-4 py-2 font-medium text-slate-600">Qtd</th>
            <th className="text-right px-4 py-2 font-medium text-slate-600">%</th>
            {rows[0]?.valor !== undefined && (
              <th className="text-right px-4 py-2 font-medium text-slate-600">Valor</th>
            )}
          </tr>
        </thead>
        <tbody className="divide-y">
          {rows.map((r) => (
            <tr key={r.label} className="hover:bg-slate-50">
              <td className="px-4 py-2">{r.label}</td>
              <td className="px-4 py-2 text-right font-medium">{r.count}</td>
              <td className="px-4 py-2 text-right text-slate-500">
                {total > 0 ? ((r.count / total) * 100).toFixed(1) : '0'}%
              </td>
              {r.valor !== undefined && (
                <td className="px-4 py-2 text-right">{formatCurrency(r.valor)}</td>
              )}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}

export default async function RelatoriosPage() {
  const operadoraId = BigInt(process.env.DEV_OPERADORA_ID ?? 1)
  const r = await getRelatorios(operadoraId)

  const totalBenef = r.beneficiarios.ativos + r.beneficiarios.suspensos + r.beneficiarios.encerrados
  const totalGuias = r.guias.porStatus.reduce((s, g) => s + g._count, 0)

  const receitaMes = Number(r.financeiro.receitaMes._sum.valor ?? 0)
  const totalAberto = r.financeiro.porStatus.find(s => s.status === 'ABERTO')?._sum.valor
  const totalVencido = r.financeiro.porStatus.find(s => s.status === 'VENCIDO')?._sum.valor

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-2xl font-bold text-slate-900">Relatórios</h1>
        <p className="text-sm text-slate-500">Visão consolidada do sistema</p>
      </div>

      {/* ── Beneficiários ── */}
      <Section title="Beneficiários">
        <div className="grid gap-4 md:grid-cols-4">
          <KpiCard title="Total de vínculos" value={totalBenef} icon={Users} />
          <KpiCard title="Ativos" value={r.beneficiarios.ativos} icon={CheckCircle} color="text-green-600" />
          <KpiCard title="Suspensos" value={r.beneficiarios.suspensos} icon={Clock} color="text-yellow-600" />
          <KpiCard title="Encerrados" value={r.beneficiarios.encerrados} icon={XCircle} color="text-slate-500" />
        </div>

        {r.produtos.length > 0 && (
          <Card>
            <CardHeader>
              <CardTitle className="text-sm font-medium text-muted-foreground">Beneficiários ativos por produto</CardTitle>
            </CardHeader>
            <CardContent className="p-0">
              <DistribTable
                rows={r.produtos.map(p => ({
                  label: p.descricao,
                  count: p._count.adesoes,
                }))}
              />
            </CardContent>
          </Card>
        )}
      </Section>

      {/* ── Autorizações (Guias) ── */}
      <Section title="Autorizações (Guias)">
        <div className="grid gap-4 md:grid-cols-3">
          <KpiCard title="Total de guias" value={totalGuias} icon={FileText} />
          <KpiCard
            title="Urgentes"
            value={r.guias.urgentes}
            icon={AlertTriangle}
            color={r.guias.urgentes > 0 ? 'text-red-600' : 'text-slate-900'}
          />
          <KpiCard
            title="Pendentes"
            value={r.guias.porStatus.find(s => s.status === 'SOLICITADA')?._count ?? 0}
            sub="Aguardando autorização"
            icon={Clock}
            color="text-yellow-600"
          />
        </div>

        <div className="grid gap-4 md:grid-cols-2">
          <Card>
            <CardHeader>
              <CardTitle className="text-sm font-medium text-muted-foreground">Por status</CardTitle>
            </CardHeader>
            <CardContent className="p-0">
              <DistribTable
                rows={r.guias.porStatus.map(s => ({
                  label: statusGuiaLabel[s.status] ?? s.status,
                  count: s._count,
                }))}
              />
            </CardContent>
          </Card>
          <Card>
            <CardHeader>
              <CardTitle className="text-sm font-medium text-muted-foreground">Por tipo de guia</CardTitle>
            </CardHeader>
            <CardContent className="p-0">
              <DistribTable
                rows={r.guias.porTipo.map(t => ({
                  label: tipoGuiaLabel[t.tipo] ?? t.tipo,
                  count: t._count,
                }))}
              />
            </CardContent>
          </Card>
        </div>
      </Section>

      {/* ── Financeiro ── */}
      <Section title="Financeiro">
        <div className="grid gap-4 md:grid-cols-3">
          <KpiCard
            title="Receita do mês"
            value={formatCurrency(receitaMes)}
            sub={`${r.financeiro.receitaMes._count} pagamentos`}
            icon={TrendingUp}
            color="text-green-600"
          />
          <KpiCard
            title="Em aberto"
            value={formatCurrency(Number(totalAberto ?? 0))}
            icon={DollarSign}
            color="text-yellow-600"
          />
          <KpiCard
            title="Vencido"
            value={formatCurrency(Number(totalVencido ?? 0))}
            icon={TrendingDown}
            color="text-red-600"
          />
        </div>

        <div className="grid gap-4 md:grid-cols-2">
          <Card>
            <CardHeader>
              <CardTitle className="text-sm font-medium text-muted-foreground">Lançamentos por status</CardTitle>
            </CardHeader>
            <CardContent className="p-0">
              <DistribTable
                rows={r.financeiro.porStatus.map(s => ({
                  label: statusLancLabel[s.status] ?? s.status,
                  count: s._count,
                  valor: Number(s._sum.valor ?? 0),
                }))}
              />
            </CardContent>
          </Card>
          <Card>
            <CardHeader>
              <CardTitle className="text-sm font-medium text-muted-foreground">Lançamentos por tipo</CardTitle>
            </CardHeader>
            <CardContent className="p-0">
              <DistribTable
                rows={r.financeiro.porTipo.map(t => ({
                  label: tipoLancLabel[t.tipoLancamento] ?? t.tipoLancamento,
                  count: t._count,
                  valor: Number(t._sum.valor ?? 0),
                }))}
              />
            </CardContent>
          </Card>
        </div>
      </Section>
    </div>
  )
}
