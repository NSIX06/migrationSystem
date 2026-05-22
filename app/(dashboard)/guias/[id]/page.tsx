import { notFound } from 'next/navigation'
import Link from 'next/link'
import { prisma } from '@/lib/prisma'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { formatCpf, formatDate, formatDateTime } from '@/lib/utils'
import { parseBigIntId } from '@/lib/route-params'
import { ArrowLeft, FileText, AlertTriangle } from 'lucide-react'
import { AutorizarNegarForm } from '@/components/servsaude/autorizar-negar-form'

const statusConfig: Record<string, { label: string; variant: 'warning' | 'success' | 'destructive' | 'secondary' | 'info' }> = {
  SOLICITADA:    { label: 'Solicitada',    variant: 'warning' },
  AUTORIZADA:    { label: 'Autorizada',    variant: 'success' },
  NEGADA:        { label: 'Negada',        variant: 'destructive' },
  EM_AUDITORIA:  { label: 'Em Auditoria',  variant: 'info' },
  CANCELADA:     { label: 'Cancelada',     variant: 'secondary' },
  FATURADA:      { label: 'Faturada',      variant: 'secondary' },
}

const tipoLabels: Record<string, string> = {
  CONSULTA: 'Consulta', SADT: 'SADT', INTERNACAO: 'Internação', HONORARIO: 'Honorário', OUTROS: 'Outros',
}

const caraterLabels: Record<string, string> = {
  ELETIVO: 'Eletivo', URGENCIA_EMERGENCIA: 'Urgência / Emergência',
}

function InfoRow({ label, value }: { label: string; value?: string | null }) {
  return (
    <div className="flex flex-col gap-0.5">
      <span className="text-xs text-muted-foreground">{label}</span>
      <span className="text-sm font-medium">{value ?? '—'}</span>
    </div>
  )
}

export default async function GuiaDetalhePage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const guiaId = parseBigIntId(id)
  if (!guiaId) notFound()

  const guia = await prisma.guia.findFirst({
    where: { id: guiaId, deletedAt: null },
    include: {
      conveniado: { select: { nome: true, cpf: true } },
      prestador:  { select: { nome: true } },
      profissional: { select: { nome: true } },
      itens: {
        where: { deletedAt: null },
        select: {
          id: true, tipo: true, referenciaTabela: true,
          quantidadeSolicitada: true, quantidadeAtendida: true,
          status: true, dataExecucao: true,
        },
      },
      historico: {
        orderBy: { createdAt: 'desc' },
        select: { id: true, historico: true, dataHora: true, createdAt: true },
      },
    },
  })

  if (!guia) notFound()

  const cfg = statusConfig[guia.status] ?? { label: guia.status, variant: 'secondary' as const }
  const podAutorizar = guia.status === 'SOLICITADA' || guia.status === 'EM_AUDITORIA'

  return (
    <div className="space-y-6 max-w-4xl">
      <div className="flex items-center gap-4">
        <Button asChild variant="ghost" size="sm">
          <Link href="/guias">
            <ArrowLeft className="h-4 w-4 mr-1" />
            Voltar
          </Link>
        </Button>
        <div className="flex-1">
          <h1 className="text-2xl font-bold text-slate-900 flex items-center gap-2">
            Guia #{id}
            {guia.urgente && <AlertTriangle className="h-5 w-5 text-red-500" />}
          </h1>
          <p className="text-sm text-slate-500">{tipoLabels[guia.tipo]} · {formatDateTime(guia.createdAt)}</p>
        </div>
        <Badge variant={cfg.variant}>{cfg.label}</Badge>
      </div>

      <div className="grid md:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2">
              <FileText className="h-4 w-4" />
              Dados da Guia
            </CardTitle>
          </CardHeader>
          <CardContent className="grid grid-cols-2 gap-4">
            <InfoRow label="Beneficiário" value={guia.conveniado?.nome} />
            <InfoRow label="CPF" value={guia.conveniado?.cpf ? formatCpf(guia.conveniado.cpf) : null} />
            <InfoRow label="Prestador" value={guia.prestador?.nome} />
            <InfoRow label="Profissional" value={guia.profissional?.nome} />
            <InfoRow label="Tipo de guia" value={tipoLabels[guia.tipo]} />
            <InfoRow label="Caráter" value={caraterLabels[guia.caraterAtendimento]} />
            <InfoRow label="Indicação clínica" value={guia.indicacaoClinica} />
            <InfoRow label="Observações" value={guia.observacoes} />
            {guia.status === 'AUTORIZADA' && (
              <>
                <InfoRow label="Data autorização" value={guia.dataAutorizacao ? formatDate(guia.dataAutorizacao) : null} />
                <InfoRow label="Senha" value={guia.senha?.toString()} />
                <InfoRow label="Validade senha" value={guia.dataValidadeSenha ? formatDate(guia.dataValidadeSenha) : null} />
              </>
            )}
            {guia.status === 'NEGADA' && (
              <div className="col-span-2">
                <InfoRow label="Motivo da negativa" value={guia.motivoCancelamento} />
              </div>
            )}
          </CardContent>
        </Card>

        {podAutorizar && (
          <AutorizarNegarForm guiaId={id} />
        )}
      </div>

      {guia.itens.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Itens da Guia ({guia.itens.length})</CardTitle>
          </CardHeader>
          <CardContent className="p-0">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b bg-slate-50">
                  <th className="text-left px-4 py-3 font-medium text-slate-600">Tabela</th>
                  <th className="text-left px-4 py-3 font-medium text-slate-600">Tipo</th>
                  <th className="text-left px-4 py-3 font-medium text-slate-600">Qtd. Sol.</th>
                  <th className="text-left px-4 py-3 font-medium text-slate-600">Qtd. Atend.</th>
                  <th className="text-left px-4 py-3 font-medium text-slate-600">Data Exec.</th>
                  <th className="text-left px-4 py-3 font-medium text-slate-600">Status</th>
                </tr>
              </thead>
              <tbody className="divide-y">
                {guia.itens.map((item) => (
                  <tr key={String(item.id)}>
                    <td className="px-4 py-3">{item.referenciaTabela}</td>
                    <td className="px-4 py-3 text-slate-600">{item.tipo}</td>
                    <td className="px-4 py-3 text-slate-600">{item.quantidadeSolicitada?.toString() ?? '—'}</td>
                    <td className="px-4 py-3 text-slate-600">{item.quantidadeAtendida?.toString() ?? '—'}</td>
                    <td className="px-4 py-3 text-slate-500">{item.dataExecucao ? formatDate(item.dataExecucao) : '—'}</td>
                    <td className="px-4 py-3">
                      <Badge variant="secondary">{item.status}</Badge>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </CardContent>
        </Card>
      )}

      {guia.historico.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Histórico</CardTitle>
          </CardHeader>
          <CardContent className="p-0">
            <div className="divide-y">
              {guia.historico.map((h) => (
                <div key={String(h.id)} className="px-4 py-3 flex items-start justify-between gap-4">
                  <p className="text-sm text-slate-700">{h.historico}</p>
                  <span className="text-xs text-slate-400 shrink-0">{formatDateTime(h.dataHora)}</span>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  )
}
