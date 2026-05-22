import { notFound } from 'next/navigation'
import Link from 'next/link'
import { prisma } from '@/lib/prisma'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { formatCpf, formatDate } from '@/lib/utils'
import { parseBigIntId } from '@/lib/route-params'
import { ArrowLeft, User, FileText } from 'lucide-react'

const statusLabels: Record<string, { label: string; variant: 'success' | 'destructive' | 'warning' | 'secondary' }> = {
  ATIVO: { label: 'Ativo', variant: 'success' },
  INATIVO: { label: 'Inativo', variant: 'destructive' },
  SUSPENSO: { label: 'Suspenso', variant: 'warning' },
  CANCELADO: { label: 'Cancelado', variant: 'secondary' },
}

const sexoLabels: Record<string, string> = {
  MASCULINO: 'Masculino',
  FEMININO: 'Feminino',
  OUTRO: 'Outro',
}

const estadoCivilLabels: Record<string, string> = {
  SOLTEIRO: 'Solteiro(a)',
  CASADO: 'Casado(a)',
  DIVORCIADO: 'Divorciado(a)',
  VIUVO: 'Viúvo(a)',
  UNIAO_ESTAVEL: 'União Estável',
}

function InfoRow({ label, value }: { label: string; value?: string | null }) {
  return (
    <div className="flex flex-col gap-0.5">
      <span className="text-xs text-muted-foreground">{label}</span>
      <span className="text-sm font-medium">{value ?? '—'}</span>
    </div>
  )
}

export default async function ConveniadoDetalhePage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const conveniadoId = parseBigIntId(id)
  if (!conveniadoId) notFound()

  const operadoraId = BigInt(process.env.DEV_OPERADORA_ID ?? 1)

  const conveniado = await prisma.conveniado.findFirst({
    where: { id: conveniadoId, deletedAt: null },
    include: {
      naturalidadeCidade: {
        select: { nome: true, estado: { select: { uf: true } } },
      },
      cargo: { select: { descricao: true } },
      adesoes: {
        where: { operadoraId, deletedAt: null },
        include: { produto: { select: { descricao: true } } },
        orderBy: { createdAt: 'desc' },
      },
    },
  })

  if (!conveniado) notFound()

  return (
    <div className="space-y-6 max-w-4xl">
      <div className="flex items-center gap-4">
        <Button asChild variant="ghost" size="sm">
          <Link href="/conveniados">
            <ArrowLeft className="h-4 w-4 mr-1" />
            Voltar
          </Link>
        </Button>
        <div>
          <h1 className="text-2xl font-bold text-slate-900">{conveniado.nome}</h1>
          <p className="text-sm text-slate-500">CPF: {formatCpf(conveniado.cpf)}</p>
        </div>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <User className="h-4 w-4" />
            Dados Pessoais
          </CardTitle>
        </CardHeader>
        <CardContent className="grid grid-cols-2 md:grid-cols-3 gap-6">
          <InfoRow label="Nome completo" value={conveniado.nome} />
          <InfoRow label="CPF" value={formatCpf(conveniado.cpf)} />
          <InfoRow label="Data de nascimento" value={formatDate(conveniado.dataNascimento)} />
          <InfoRow label="Sexo" value={sexoLabels[conveniado.sexo] ?? conveniado.sexo} />
          <InfoRow label="Estado civil" value={estadoCivilLabels[conveniado.estadoCivil] ?? conveniado.estadoCivil} />
          <InfoRow label="Nome da mãe" value={conveniado.nomeMae} />
          <InfoRow label="Nome do pai" value={conveniado.nomePai} />
          <InfoRow
            label="Naturalidade"
            value={
              conveniado.naturalidadeCidade
                ? `${conveniado.naturalidadeCidade.nome} / ${conveniado.naturalidadeCidade.estado?.uf ?? ''}`
                : null
            }
          />
          <InfoRow label="Cargo" value={conveniado.cargo?.descricao} />
          <InfoRow label="E-mail" value={conveniado.email} />
          <InfoRow label="Telefone 1" value={conveniado.fone1} />
          <InfoRow label="Telefone 2" value={conveniado.fone2} />
          <InfoRow label="CNS" value={conveniado.cns} />
          <InfoRow label="RG" value={conveniado.rg} />
          <InfoRow label="Cadastrado em" value={formatDate(conveniado.createdAt)} />
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <FileText className="h-4 w-4" />
            Adesões ({conveniado.adesoes.length})
          </CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          {conveniado.adesoes.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-6">Nenhuma adesão encontrada.</p>
          ) : (
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b bg-slate-50">
                  <th className="text-left px-4 py-3 font-medium text-slate-600">Plano</th>
                  <th className="text-left px-4 py-3 font-medium text-slate-600">Matrícula</th>
                  <th className="text-left px-4 py-3 font-medium text-slate-600">Tipo</th>
                  <th className="text-left px-4 py-3 font-medium text-slate-600">Início</th>
                  <th className="text-left px-4 py-3 font-medium text-slate-600">Status</th>
                </tr>
              </thead>
              <tbody className="divide-y">
                {conveniado.adesoes.map((a) => {
                  const status = statusLabels[a.status] ?? { label: a.status, variant: 'secondary' as const }
                  return (
                    <tr key={String(a.id)}>
                      <td className="px-4 py-3 font-medium">{a.produto.descricao}</td>
                      <td className="px-4 py-3 text-slate-600">{a.matricula ?? '—'}</td>
                      <td className="px-4 py-3 text-slate-600">{a.tipoCliente}</td>
                      <td className="px-4 py-3 text-slate-600">{formatDate(a.dataInicio)}</td>
                      <td className="px-4 py-3">
                        <Badge variant={status.variant}>{status.label}</Badge>
                      </td>
                    </tr>
                  )
                })}
              </tbody>
            </table>
          )}
        </CardContent>
      </Card>
    </div>
  )
}
