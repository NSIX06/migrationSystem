import { Suspense } from 'react'
import { createClient } from '@/lib/supabase/server'
import { prisma } from '@/lib/prisma'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { formatCurrency, formatDate } from '@/lib/utils'
import { Users, FileText, DollarSign, Clock } from 'lucide-react'

export const metadata = { title: 'Dashboard — ServSaúde' }

async function getDashboardStats(operadoraId: bigint) {
  const [totalBeneficiarios, guiasPendentes, totalEmAberto] = await Promise.all([
    prisma.adesao.count({
      where: { operadoraId, status: 'ATIVO', deletedAt: null },
    }),
    prisma.guia.count({
      where: { operadoraId, status: 'SOLICITADA', deletedAt: null },
    }),
    prisma.lancamento.aggregate({
      where: { operadoraId, status: 'ABERTO' },
      _sum: { valor: true },
    }),
  ])

  return {
    totalBeneficiarios,
    guiasPendentes,
    totalEmAberto: totalEmAberto._sum.valor ?? 0,
  }
}

async function getGuiasPendentes(operadoraId: bigint) {
  return prisma.guia.findMany({
    where: { operadoraId, status: 'SOLICITADA', deletedAt: null },
    include: {
      conveniado: { select: { nome: true } },
      prestador: { select: { nome: true } },
    },
    orderBy: { createdAt: 'asc' },
    take: 5,
  })
}

function StatCard({
  title, value, description, icon: Icon,
}: {
  title: string
  value: string | number
  description?: string
  icon: React.ElementType
}) {
  return (
    <Card>
      <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
        <CardTitle className="text-sm font-medium">{title}</CardTitle>
        <Icon className="h-4 w-4 text-muted-foreground" />
      </CardHeader>
      <CardContent>
        <div className="text-2xl font-bold">{value}</div>
        {description && <p className="text-xs text-muted-foreground mt-1">{description}</p>}
      </CardContent>
    </Card>
  )
}

export default async function DashboardPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  const operadoraId = BigInt(process.env.DEV_OPERADORA_ID ?? 1)

  const [stats, guiasPendentes] = await Promise.all([
    getDashboardStats(operadoraId),
    getGuiasPendentes(operadoraId),
  ])

  const hoje = new Date().toLocaleDateString('pt-BR', {
    weekday: 'long', day: 'numeric', month: 'long', year: 'numeric',
  })

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-slate-900">
          Bom dia{user?.user_metadata?.nome ? `, ${user.user_metadata.nome}` : ''}
        </h1>
        <p className="text-sm text-slate-500 capitalize">{hoje}</p>
      </div>

      <div className="grid gap-4 md:grid-cols-3">
        <StatCard
          title="Beneficiários Ativos"
          value={stats.totalBeneficiarios.toLocaleString('pt-BR')}
          icon={Users}
        />
        <StatCard
          title="Guias Pendentes"
          value={stats.guiasPendentes}
          description="Aguardando autorização"
          icon={Clock}
        />
        <StatCard
          title="Financeiro em Aberto"
          value={formatCurrency(Number(stats.totalEmAberto))}
          icon={DollarSign}
        />
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <FileText className="h-4 w-4" />
            Guias Pendentes de Autorização ({stats.guiasPendentes})
          </CardTitle>
        </CardHeader>
        <CardContent>
          {guiasPendentes.length === 0 ? (
            <p className="text-sm text-muted-foreground py-4 text-center">
              Nenhuma guia pendente no momento.
            </p>
          ) : (
            <div className="space-y-2">
              {guiasPendentes.map((guia) => (
                <div
                  key={guia.id}
                  className="flex items-center justify-between rounded-md border px-4 py-3 hover:bg-slate-50"
                >
                  <div className="space-y-0.5">
                    <p className="text-sm font-medium">{guia.conveniado?.nome}</p>
                    <p className="text-xs text-muted-foreground">
                      {guia.prestador?.nome} · {formatDate(guia.createdAt)}
                    </p>
                  </div>
                  <div className="flex items-center gap-2">
                    <Badge variant="warning">
                      {guia.tipo.charAt(0) + guia.tipo.slice(1).toLowerCase()}
                    </Badge>
                  </div>
                </div>
              ))}
              {stats.guiasPendentes > 5 && (
                <a
                  href="/guias?status=SOLICITADA"
                  className="block text-center text-sm text-primary hover:underline pt-2"
                >
                  Ver todas as guias pendentes ({stats.guiasPendentes})
                </a>
              )}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  )
}
