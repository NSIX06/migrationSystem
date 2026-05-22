import { notFound } from 'next/navigation'
import Link from 'next/link'
import { prisma } from '@/lib/prisma'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { formatCpf, formatCnpj, formatDate } from '@/lib/utils'
import { parseBigIntId } from '@/lib/route-params'
import { ArrowLeft, Building2, Stethoscope } from 'lucide-react'

function InfoRow({ label, value }: { label: string; value?: string | null }) {
  return (
    <div className="flex flex-col gap-0.5">
      <span className="text-xs text-muted-foreground">{label}</span>
      <span className="text-sm font-medium">{value ?? '—'}</span>
    </div>
  )
}

export default async function PrestadorDetalhePage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const prestadorId = parseBigIntId(id)
  if (!prestadorId) notFound()

  const prestador = await prisma.prestador.findFirst({
    where: { id: prestadorId, deletedAt: null },
    include: {
      prestadorTipo: { select: { descricao: true } },
      classificacaoEstabelecimento: { select: { nome: true, codigo: true } },
      especialidades: {
        include: { especialidade: { select: { descricao: true } } },
      },
    },
  })

  if (!prestador) notFound()

  const doc = prestador.tipo === 'PESSOA_FISICA'
    ? formatCpf(prestador.cpfCnpj.replace(/\D/g, ''))
    : formatCnpj(prestador.cpfCnpj.replace(/\D/g, ''))

  return (
    <div className="space-y-6 max-w-4xl">
      <div className="flex items-center gap-4">
        <Button asChild variant="ghost" size="sm">
          <Link href="/prestadores">
            <ArrowLeft className="h-4 w-4 mr-1" />
            Voltar
          </Link>
        </Button>
        <div>
          <h1 className="text-2xl font-bold text-slate-900">{prestador.nome}</h1>
          <p className="text-sm text-slate-500">{doc}</p>
        </div>
        <Badge variant={prestador.ativo ? 'success' : 'destructive'} className="ml-auto">
          {prestador.ativo ? 'Ativo' : 'Inativo'}
        </Badge>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Building2 className="h-4 w-4" />
            Dados Cadastrais
          </CardTitle>
        </CardHeader>
        <CardContent className="grid grid-cols-2 md:grid-cols-3 gap-6">
          <InfoRow label="Nome / Nome Social" value={prestador.nome} />
          <InfoRow label="Razão Social" value={prestador.razaoSocial} />
          <InfoRow label={prestador.tipo === 'PESSOA_FISICA' ? 'CPF' : 'CNPJ'} value={doc} />
          <InfoRow label="Tipo" value={prestador.tipo === 'PESSOA_FISICA' ? 'Pessoa Física' : 'Pessoa Jurídica'} />
          <InfoRow label="Especialidade" value={prestador.prestadorTipo?.descricao} />
          <InfoRow label="Classificação" value={`${prestador.classificacaoEstabelecimento.nome} (${prestador.classificacaoEstabelecimento.codigo})`} />
          <InfoRow label="E-mail" value={prestador.email} />
          <InfoRow label="Telefone" value={prestador.fone} />
          {prestador.tipo === 'PESSOA_FISICA' && (
            <>
              <InfoRow label="Data de Nascimento" value={prestador.dataNascimento ? formatDate(prestador.dataNascimento) : null} />
              <InfoRow label="RG" value={prestador.rg} />
              <InfoRow label="Órgão Expedidor" value={prestador.orgaoExpedidor} />
            </>
          )}
          <InfoRow label="Contato Financeiro" value={prestador.financeiroContatoNome} />
          <InfoRow label="Fone Financeiro" value={prestador.financeiroContatoFone} />
          <InfoRow label="E-mail Financeiro" value={prestador.financeiroContatoEmail} />
          <InfoRow label="Cadastrado em" value={formatDate(prestador.createdAt)} />
        </CardContent>
      </Card>

      <div className="grid md:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2">
              <Stethoscope className="h-4 w-4" />
              Especialidades ({prestador.especialidades.length})
            </CardTitle>
          </CardHeader>
          <CardContent>
            {prestador.especialidades.length === 0 ? (
              <p className="text-sm text-muted-foreground">Nenhuma especialidade cadastrada.</p>
            ) : (
              <div className="flex flex-wrap gap-2">
                {prestador.especialidades.map((e) => (
                  <Badge key={String(e.especialidadeId)} variant="secondary">
                    {e.especialidade.descricao}
                  </Badge>
                ))}
              </div>
            )}
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-base">Aceita</CardTitle>
          </CardHeader>
          <CardContent className="flex flex-wrap gap-2">
            {prestador.procedimentos && <Badge variant="info">Procedimentos</Badge>}
            {prestador.material && <Badge variant="info">Materiais</Badge>}
            {prestador.taxa && <Badge variant="info">Taxas</Badge>}
            {prestador.medicamentos && <Badge variant="info">Medicamentos</Badge>}
            {!prestador.procedimentos && !prestador.material && !prestador.taxa && !prestador.medicamentos && (
              <span className="text-sm text-muted-foreground">Nenhum item configurado.</span>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  )
}
