import { prisma } from '@/lib/prisma'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { formatCnpj } from '@/lib/utils'
import { Building2, Package, Briefcase, SlidersHorizontal } from 'lucide-react'

export const metadata = { title: 'Administração — ServSaúde' }

type AdminTab = 'operadora' | 'produtos' | 'cargos' | 'parametros'

const tabs: { key: AdminTab; label: string; icon: React.ElementType }[] = [
  { key: 'operadora',  label: 'Operadora',   icon: Building2 },
  { key: 'produtos',   label: 'Produtos',     icon: Package },
  { key: 'cargos',     label: 'Cargos',       icon: Briefcase },
  { key: 'parametros', label: 'Parâmetros',   icon: SlidersHorizontal },
]

async function getAdminData(operadoraId: bigint) {
  const [operadora, produtos, cargos, parametros] = await Promise.all([
    prisma.operadora.findFirst({
      where: { id: operadoraId, deletedAt: null },
    }),
    prisma.produto.findMany({
      where: { operadoraId, deletedAt: null },
      select: {
        id: true, descricao: true, abrangencia: true,
        tipoContratacao: true, tipoAcomodacao: true,
        dataInicio: true, dataFim: true, ativo: true,
        _count: { select: { adesoes: { where: { status: 'ATIVO', deletedAt: null } } } },
      },
      orderBy: { descricao: 'asc' },
    }),
    prisma.cargo.findMany({
      where: { deletedAt: null },
      select: {
        id: true, descricao: true, ativo: true,
        _count: { select: { conveniados: { where: { deletedAt: null } } } },
      },
      orderBy: { descricao: 'asc' },
    }),
    prisma.parametro.findMany({
      where: { deletedAt: null },
      orderBy: { parameter: 'asc' },
    }),
  ])
  return { operadora, produtos, cargos, parametros }
}

function InfoRow({ label, value }: { label: string; value?: string | null }) {
  return (
    <div className="flex flex-col gap-0.5">
      <span className="text-xs text-muted-foreground">{label}</span>
      <span className="text-sm font-medium">{value ?? '—'}</span>
    </div>
  )
}

const abrangenciaLabel: Record<string, string> = {
  MUNICIPAL: 'Municipal', ESTADUAL: 'Estadual', NACIONAL: 'Nacional', GRUPO_MUNICIP: 'Grupo Municipal',
}
const contratacaoLabel: Record<string, string> = {
  COLETIVO_EMPRESARIAL: 'Coletivo Empresarial', COLETIVO_ADESAO: 'Coletivo por Adesão', INDIVIDUAL: 'Individual/Familiar',
}
const acomodacaoLabel: Record<string, string> = {
  ENFERMARIA: 'Enfermaria', APARTAMENTO: 'Apartamento',
}

export default async function AdminPage({
  searchParams,
}: {
  searchParams: Promise<{ aba?: string }>
}) {
  const { aba = 'operadora' } = await searchParams
  const tab = (tabs.map(t => t.key).includes(aba as AdminTab) ? aba : 'operadora') as AdminTab

  const operadoraId = BigInt(process.env.DEV_OPERADORA_ID ?? 1)
  const { operadora, produtos, cargos, parametros } = await getAdminData(operadoraId)

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-slate-900">Administração</h1>
        <p className="text-sm text-slate-500">Configurações do sistema</p>
      </div>

      {/* Tabs */}
      <div className="flex gap-1 border-b">
        {tabs.map(({ key, label, icon: Icon }) => (
          <a
            key={key}
            href={`/admin?aba=${key}`}
            className={`flex items-center gap-2 px-4 py-2 text-sm font-medium border-b-2 transition-colors ${
              tab === key
                ? 'border-primary text-primary'
                : 'border-transparent text-muted-foreground hover:text-foreground'
            }`}
          >
            <Icon className="h-3.5 w-3.5" />
            {label}
          </a>
        ))}
      </div>

      {/* ── Operadora ── */}
      {tab === 'operadora' && operadora && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2">
              <Building2 className="h-4 w-4" />
              Dados da Operadora
            </CardTitle>
          </CardHeader>
          <CardContent className="grid grid-cols-2 md:grid-cols-3 gap-6">
            <InfoRow label="Nome fantasia" value={operadora.nome} />
            <InfoRow label="Razão social" value={operadora.razaoSocial} />
            <InfoRow label="CNPJ" value={formatCnpj(operadora.cpfCnpj)} />
            <InfoRow label="Código ANS" value={operadora.codigoAns} />
            <InfoRow label="E-mail" value={operadora.email} />
            <InfoRow label="Telefone" value={operadora.fone} />
            <InfoRow label="CPF do responsável" value={operadora.cpfResponsavel} />
            <InfoRow label="Inscrição municipal" value={operadora.inscricaoMunicipal} />
            <InfoRow label="Inscrição estadual" value={operadora.inscricaoEstadual} />
            <InfoRow label="CNES" value={operadora.cnes} />
            <div className="flex flex-col gap-0.5">
              <span className="text-xs text-muted-foreground">Situação</span>
              <Badge variant={operadora.ativo ? 'success' : 'destructive'} className="w-fit">
                {operadora.ativo ? 'Ativa' : 'Inativa'}
              </Badge>
            </div>
            <InfoRow
              label="% máx. desconto copart."
              value={`${Number(operadora.percentualMaxDescontoCoparticipacao).toFixed(1)}%`}
            />
          </CardContent>
        </Card>
      )}

      {/* ── Produtos ── */}
      {tab === 'produtos' && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2">
              <Package className="h-4 w-4" />
              Produtos / Planos ({produtos.length})
            </CardTitle>
          </CardHeader>
          <CardContent className="p-0">
            {produtos.length === 0 ? (
              <p className="text-sm text-muted-foreground text-center py-10">Nenhum produto cadastrado.</p>
            ) : (
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b bg-slate-50">
                      <th className="text-left px-4 py-3 font-medium text-slate-600">Descrição</th>
                      <th className="text-left px-4 py-3 font-medium text-slate-600">Abrangência</th>
                      <th className="text-left px-4 py-3 font-medium text-slate-600">Contratação</th>
                      <th className="text-left px-4 py-3 font-medium text-slate-600">Acomodação</th>
                      <th className="text-right px-4 py-3 font-medium text-slate-600">Beneficiários</th>
                      <th className="text-left px-4 py-3 font-medium text-slate-600">Status</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y">
                    {produtos.map((p) => (
                      <tr key={String(p.id)} className="hover:bg-slate-50">
                        <td className="px-4 py-3 font-medium">{p.descricao}</td>
                        <td className="px-4 py-3 text-slate-600">{abrangenciaLabel[p.abrangencia] ?? p.abrangencia}</td>
                        <td className="px-4 py-3 text-slate-600">{contratacaoLabel[p.tipoContratacao] ?? p.tipoContratacao}</td>
                        <td className="px-4 py-3 text-slate-600">{acomodacaoLabel[p.tipoAcomodacao] ?? p.tipoAcomodacao}</td>
                        <td className="px-4 py-3 text-right font-medium">{p._count.adesoes}</td>
                        <td className="px-4 py-3">
                          <Badge variant={p.ativo ? 'success' : 'secondary'}>
                            {p.ativo ? 'Ativo' : 'Inativo'}
                          </Badge>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </CardContent>
        </Card>
      )}

      {/* ── Cargos ── */}
      {tab === 'cargos' && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2">
              <Briefcase className="h-4 w-4" />
              Cargos ({cargos.length})
            </CardTitle>
          </CardHeader>
          <CardContent className="p-0">
            {cargos.length === 0 ? (
              <p className="text-sm text-muted-foreground text-center py-10">Nenhum cargo cadastrado.</p>
            ) : (
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b bg-slate-50">
                      <th className="text-left px-4 py-3 font-medium text-slate-600">#</th>
                      <th className="text-left px-4 py-3 font-medium text-slate-600">Descrição</th>
                      <th className="text-right px-4 py-3 font-medium text-slate-600">Beneficiários</th>
                      <th className="text-left px-4 py-3 font-medium text-slate-600">Status</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y">
                    {cargos.map((c) => (
                      <tr key={String(c.id)} className="hover:bg-slate-50">
                        <td className="px-4 py-3 text-slate-400">{String(c.id)}</td>
                        <td className="px-4 py-3 font-medium">{c.descricao}</td>
                        <td className="px-4 py-3 text-right">{c._count.conveniados}</td>
                        <td className="px-4 py-3">
                          <Badge variant={c.ativo ? 'success' : 'secondary'}>
                            {c.ativo ? 'Ativo' : 'Inativo'}
                          </Badge>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </CardContent>
        </Card>
      )}

      {/* ── Parâmetros ── */}
      {tab === 'parametros' && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2">
              <SlidersHorizontal className="h-4 w-4" />
              Parâmetros do sistema ({parametros.length})
            </CardTitle>
          </CardHeader>
          <CardContent className="p-0">
            {parametros.length === 0 ? (
              <p className="text-sm text-muted-foreground text-center py-10">
                Nenhum parâmetro cadastrado.
              </p>
            ) : (
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b bg-slate-50">
                      <th className="text-left px-4 py-3 font-medium text-slate-600">Parâmetro</th>
                      <th className="text-left px-4 py-3 font-medium text-slate-600">Label</th>
                      <th className="text-left px-4 py-3 font-medium text-slate-600">Valor</th>
                      <th className="text-left px-4 py-3 font-medium text-slate-600">Valores possíveis</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y">
                    {parametros.map((p) => (
                      <tr key={String(p.id)} className="hover:bg-slate-50">
                        <td className="px-4 py-3 font-mono text-xs text-slate-600">{p.parameter}</td>
                        <td className="px-4 py-3 font-medium">{p.fieldLabel}</td>
                        <td className="px-4 py-3">
                          {p.value
                            ? <Badge variant="secondary">{p.value}</Badge>
                            : <span className="text-slate-400">—</span>}
                        </td>
                        <td className="px-4 py-3 text-slate-500 text-xs">{p.possibleValues ?? '—'}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </CardContent>
        </Card>
      )}
    </div>
  )
}
