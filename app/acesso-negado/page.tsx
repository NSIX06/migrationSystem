import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { ShieldX } from 'lucide-react'

export const metadata = { title: 'Acesso Negado — ServSaúde' }

export default function AcessoNegadoPage() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-slate-50">
      <div className="text-center space-y-4 max-w-md px-6">
        <div className="flex justify-center">
          <div className="rounded-full bg-red-100 p-4">
            <ShieldX className="h-12 w-12 text-red-500" />
          </div>
        </div>
        <h1 className="text-2xl font-bold text-slate-900">Acesso Negado</h1>
        <p className="text-slate-500">
          Você não tem permissão para acessar esta página.
          Entre em contato com o administrador do sistema caso precise de acesso.
        </p>
        <div className="flex gap-2 justify-center">
          <Button asChild>
            <Link href="/dashboard">Ir para o Dashboard</Link>
          </Button>
          <Button asChild variant="outline">
            <Link href="javascript:history.back()">Voltar</Link>
          </Button>
        </div>
      </div>
    </div>
  )
}
