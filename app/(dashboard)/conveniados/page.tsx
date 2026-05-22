import Link from 'next/link'
import { prisma } from '@/lib/prisma'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { formatCpf, formatDate } from '@/lib/utils'
import { Users, Search } from 'lucide-react'

export const metadata = { title: 'Beneficiários — ServSaúde' }

async function getConveniados(operadoraId: bigint, busca: string) {
  return prisma.conveniado.findMany({
    where: {
      deletedAt: null,
      adesoes: { some: { operadoraId, deletedAt: null } },
      ...(busca
        ? {
            OR: [
              { nome: { contains: busca, mode: 'insensitive' } },
              { cpf: { contains: busca.replace(/\D/g, '') } },
              { email: { contains: busca, mode: 'insensitive' } },
            ],
          }
        : {}),
    },
    include: {
      adesoes: {
        where: { operadoraId, deletedAt: null },
        select: { status: true, matricula: true, produto: { select: { descricao: true } } },
        orderBy: { createdAt: 'desc' },
        take: 1,
      },
    },
    orderBy: { nome: 'asc' },
    take: 50,
  })
}

const statusLabels: Record<string, { label: string; variant: 'success' | 'destructive' | 'warning' | 'secondary' }> = {
  ATIVO: { label: 'Ativo', variant: 'success' },
  INATIVO: { label: 'Inativo', variant: 'destructive' },
  SUSPENSO: { label: 'Suspenso', variant: 'warning' },
  CANCELADO: { label: 'Cancelado', variant: 'secondary' },
}

export default async function ConvieniadosPage({
  searchParams,
}: {
  searchParams: Promise<{ busca?: string }>
}) {
  const { busca = '' } = await searchParams
  const operadoraId = BigInt(process.env.DEV_OPERADORA_ID ?? 1)
  const conveniados = await getConveniados(operadoraId, busca)

  return (
    <div className="space-y-6">
      <div>
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Beneficiários</h1>
          <p className="text-sm text-slate-500">{conveniados.length} encontrado(s)</p>
        </div>
      </div>

      <form method="GET" className="flex gap-2 max-w-sm">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
          <Input
            name="busca"
            defaultValue={busca}
            placeholder="Nome, CPF ou e-mail..."
            className="pl-9"
          />
        </div>
        <Button type="submit" variant="secondary">Buscar</Button>
      </form>

      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Users className="h-4 w-4" />
            Lista de Beneficiários
          </CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          {conveniados.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-10">
              {busca ? `Nenhum beneficiário encontrado para "${busca}".` : 'Nenhum beneficiário cadastrado.'}
            </p>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b bg-slate-50">
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Nome</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">CPF</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Plano</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Matrícula</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Status</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Cadastro</th>
                    <th />
                  </tr>
                </thead>
                <tbody className="divide-y">
                  {conveniados.map((c) => {
                    const adesao = c.adesoes[0]
                    const status = adesao ? statusLabels[adesao.status] ?? { label: adesao.status, variant: 'secondary' as const } : null
                    return (
                      <tr key={String(c.id)} className="hover:bg-slate-50 transition-colors">
                        <td className="px-4 py-3 font-medium">{c.nome}</td>
                        <td className="px-4 py-3 text-slate-600">{formatCpf(c.cpf)}</td>
                        <td className="px-4 py-3 text-slate-600">{adesao?.produto.descricao ?? '—'}</td>
                        <td className="px-4 py-3 text-slate-600">{adesao?.matricula ?? '—'}</td>
                        <td className="px-4 py-3">
                          {status ? (
                            <Badge variant={status.variant}>{status.label}</Badge>
                          ) : (
                            <span className="text-slate-400 text-xs">Sem adesão</span>
                          )}
                        </td>
                        <td className="px-4 py-3 text-slate-500">{formatDate(c.createdAt)}</td>
                        <td className="px-4 py-3">
                          <Button asChild variant="ghost" size="sm">
                            <Link href={`/conveniados/${c.id}`}>Ver</Link>
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
