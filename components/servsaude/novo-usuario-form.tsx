'use client'

import { useActionState } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { criarUsuario, type ActionState } from '@/actions/usuarios'
import { UserPlus } from 'lucide-react'

const initial: ActionState = {}

const userTypes = [
  { value: 'ADMIN',          label: 'Administrador' },
  { value: 'GESTOR',         label: 'Gestor' },
  { value: 'ATENDIMENTO',    label: 'Atendimento' },
  { value: 'FINANCEIRO',     label: 'Financeiro' },
  { value: 'AUDITORIA',      label: 'Auditoria' },
  { value: 'CREDENCIAMENTO', label: 'Credenciamento' },
  { value: 'BENEFICIARIO',   label: 'Beneficiário' },
  { value: 'PRESTADOR',      label: 'Prestador' },
  { value: 'VISUALIZADOR',   label: 'Visualizador' },
]

function Field({ label, required, children }: { label: string; required?: boolean; children: React.ReactNode }) {
  return (
    <div className="space-y-1">
      <label className="text-sm font-medium text-slate-700">
        {label}{required && <span className="text-red-500 ml-0.5">*</span>}
      </label>
      {children}
    </div>
  )
}

const inputClass = "w-full px-3 py-2 text-sm border rounded-md bg-background focus:outline-none focus:ring-1 focus:ring-ring"

export function NovoUsuarioForm({ roles }: { roles: { id: string; nome: string }[] }) {
  const [state, action, pending] = useActionState(criarUsuario, initial)

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base flex items-center gap-2">
          <UserPlus className="h-4 w-4" />
          Dados do usuário
        </CardTitle>
      </CardHeader>
      <CardContent>
        <form action={action} className="space-y-4">
          {state.error && (
            <div className="rounded-md bg-red-50 border border-red-200 px-3 py-2 text-sm text-red-800">
              {state.error}
            </div>
          )}
          {state.success && (
            <div className="rounded-md bg-green-50 border border-green-200 px-3 py-2 text-sm text-green-800">
              {state.success}
            </div>
          )}

          <div className="grid grid-cols-2 gap-4">
            <Field label="Nome completo" required>
              <input name="nome" required minLength={3} className={inputClass} placeholder="Ex: João da Silva" />
            </Field>
            <Field label="E-mail" required>
              <input name="email" type="email" required className={inputClass} placeholder="joao@email.com" />
            </Field>
            <Field label="CPF">
              <input name="cpf" className={inputClass} placeholder="000.000.000-00" maxLength={14} />
            </Field>
            <Field label="Telefone">
              <input name="fone" className={inputClass} placeholder="(11) 99999-9999" />
            </Field>
            <Field label="Tipo de usuário" required>
              <select name="userType" required className={inputClass}>
                <option value="">Selecione…</option>
                {userTypes.map(t => (
                  <option key={t.value} value={t.value}>{t.label}</option>
                ))}
              </select>
            </Field>
            <Field label="Perfil de acesso" required>
              <select name="roleId" required className={inputClass}>
                <option value="">Selecione…</option>
                {roles.map(r => (
                  <option key={r.id} value={r.id}>{r.nome}</option>
                ))}
              </select>
            </Field>
            <Field label="Status">
              <select name="status" className={inputClass} defaultValue="ATIVO">
                <option value="ATIVO">Ativo</option>
                <option value="PENDENTE">Pendente</option>
                <option value="INATIVO">Inativo</option>
                <option value="BLOQUEADO">Bloqueado</option>
              </select>
            </Field>
            <Field label="Senha temporária" required>
              <input name="password" type="password" required minLength={8} className={inputClass} placeholder="Mín. 8 caracteres" />
            </Field>
          </div>

          <div className="flex gap-2 pt-2">
            <Button type="submit" disabled={pending}>
              {pending ? 'Criando…' : 'Criar usuário'}
            </Button>
            <Button type="button" variant="outline" onClick={() => history.back()}>
              Cancelar
            </Button>
          </div>
        </form>
      </CardContent>
    </Card>
  )
}
