import { LoginForm } from '@/components/servsaude/login-form'

export const metadata = { title: 'Entrar — ServSaúde' }

export default function LoginPage() {
  return (
    <div className="w-full max-w-sm space-y-6 px-4">
      <div className="text-center space-y-2">
        <div className="flex items-center justify-center gap-2">
          <span className="text-2xl">🏥</span>
          <h1 className="text-2xl font-bold text-slate-900">ServSaúde</h1>
        </div>
        <p className="text-sm text-slate-500">Gestão de Operadora de Plano de Saúde</p>
      </div>
      <LoginForm />
    </div>
  )
}
