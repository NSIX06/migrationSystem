import Link from 'next/link'
import { prisma } from '@/lib/prisma'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { formatCpf, formatCnpj } from '@/lib/utils'
import { Building2, Search } from 'lucide-react'

export const metadata = { title: 'Prestadores — ServSaúde' }

async function getPrestadores(busca: string) {
  return prisma.prestador.findMany({
    where: {
      deletedAt: null,
      ...(busca
        ? {
            OR: [
              { nome: { contains: busca, mode: 'insensitive' } },
              { razaoSocial: { contains: busca, mode: 'insensitive' } },
              { cpfCnpj: { contains: busca.replace(/\D/g, '') } },
              { email: { contains: busca, mode: 'insensitive' } },
            ],
          }
        : {}),
    },
    include: {
      prestadorTipo: { select: { descricao: true } },
      classificacaoEstabelecimento: { select: { nome: true } },
    },
    orderBy: { nome: 'asc' },
    take: 50,
  })
}

function formatDoc(tipo: string, doc: string) {
  const digits = doc.replace(/\D/g, '')
  if (tipo === 'PESSOA_FISICA') return formatCpf(digits)
  return formatCnpj(digits)
}

export default async function PrestadoresPage({
  searchParams,
}: {
  searchParams: Promise<{ busca?: string }>
}) {
  const { busca = '' } = await searchParams
  const prestadores = await getPrestadores(busca)

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Prestadores</h1>
          <p className="text-sm text-slate-500">{prestadores.length} encontrado(s)</p>
        </div>
      </div>

      <form method="GET" className="flex gap-2 max-w-sm">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
          <Input
            name="busca"
            defaultValue={busca}
            placeholder="Nome, CNPJ/CPF ou e-mail..."
            className="pl-9"
          />
        </div>
        <Button type="submit" variant="secondary">Buscar</Button>
      </form>

      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Building2 className="h-4 w-4" />
            Lista de Prestadores
          </CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          {prestadores.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-10">
              {busca ? `Nenhum prestador encontrado para "${busca}".` : 'Nenhum prestador cadastrado.'}
            </p>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b bg-slate-50">
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Nome / Razão Social</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">CPF / CNPJ</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Tipo</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Classificação</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Contato</th>
                    <th className="text-left px-4 py-3 font-medium text-slate-600">Status</th>
                    <th />
                  </tr>
                </thead>
                <tbody className="divide-y">
                  {prestadores.map((p) => (
                    <tr key={String(p.id)} className="hover:bg-slate-50 transition-colors">
                      <td className="px-4 py-3">
                        <p className="font-medium">{p.nome}</p>
                        {p.nome !== p.razaoSocial && (
                          <p className="text-xs text-slate-500">{p.razaoSocial}</p>
                        )}
                      </td>
                      <td className="px-4 py-3 text-slate-600">{formatDoc(p.tipo, p.cpfCnpj)}</td>
                      <td className="px-4 py-3 text-slate-600">{p.prestadorTipo?.descricao ?? '—'}</td>
                      <td className="px-4 py-3 text-slate-600">{p.classificacaoEstabelecimento.nome}</td>
                      <td className="px-4 py-3 text-slate-500 text-xs">
                        {p.email ?? p.fone ?? '—'}
                      </td>
                      <td className="px-4 py-3">
                        <Badge variant={p.ativo ? 'success' : 'destructive'}>
                          {p.ativo ? 'Ativo' : 'Inativo'}
                        </Badge>
                      </td>
                      <td className="px-4 py-3">
                        <Button asChild variant="ghost" size="sm">
                          <Link href={`/prestadores/${p.id}`}>Ver</Link>
                        </Button>
                      </td>
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
