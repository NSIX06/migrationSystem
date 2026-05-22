'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import {
  LayoutDashboard, Users, Building2, FileText,
  DollarSign, BarChart3, Settings, LogOut, Stethoscope,
  Shield, ScrollText, UserCog,
} from 'lucide-react'
import { cn } from '@/lib/utils'
import { Button } from '@/components/ui/button'
import { logoutAction } from '@/actions/auth'

type NavItem = {
  href: string
  label: string
  icon: React.ElementType
  permission?: string
  children?: { href: string; label: string; icon: React.ElementType }[]
}

const navItems: NavItem[] = [
  { href: '/dashboard',   label: 'Dashboard',     icon: LayoutDashboard, permission: 'dashboard.view' },
  { href: '/conveniados', label: 'Beneficiários',  icon: Users,           permission: 'beneficiarios.view' },
  { href: '/prestadores', label: 'Prestadores',    icon: Building2,       permission: 'prestadores.view' },
  { href: '/guias',       label: 'Autorizações',   icon: FileText,        permission: 'guias.view' },
  { href: '/financeiro',  label: 'Financeiro',     icon: DollarSign,      permission: 'financeiro.view' },
  { href: '/relatorios',  label: 'Relatórios',     icon: BarChart3,       permission: 'relatorios.view' },
  {
    href: '/admin',
    label: 'Administração',
    icon: Settings,
    permission: 'settings.view',
    children: [
      { href: '/admin/usuarios', label: 'Usuários', icon: UserCog },
      { href: '/admin/perfis',   label: 'Perfis',   icon: Shield },
      { href: '/admin/logs',     label: 'Logs',     icon: ScrollText },
    ],
  },
]

type SidebarProps = {
  permissions?: string[]
  userType?: string
}

export function Sidebar({ permissions = [], userType }: SidebarProps) {
  const pathname = usePathname()
  const isAdmin = userType === 'ADMIN'
  const permSet = new Set(permissions)

  const hasAccess = (item: NavItem) => {
    if (!item.permission) return true
    if (isAdmin) return true
    return permSet.has(item.permission)
  }

  const isActive = (href: string) => {
    if (href === '/dashboard') return pathname === href
    return pathname.startsWith(href)
  }

  return (
    <aside className="flex h-full w-60 flex-col bg-sidebar text-sidebar-foreground">
      <div className="flex h-16 items-center gap-2 border-b border-sidebar-border px-4">
        <Stethoscope className="h-6 w-6 text-sidebar-primary" />
        <span className="font-bold text-lg">ServSaúde</span>
      </div>

      <nav className="flex-1 space-y-0.5 p-3 overflow-y-auto">
        {navItems.filter(hasAccess).map(({ href, label, icon: Icon, children }) => {
          const active = isActive(href)
          const showChildren = active && children

          return (
            <div key={href}>
              <Link
                href={children ? children[0].href : href}
                className={cn(
                  'flex items-center gap-3 rounded-md px-3 py-2 text-sm font-medium transition-colors',
                  active
                    ? 'bg-sidebar-accent text-sidebar-accent-foreground'
                    : 'text-sidebar-foreground/70 hover:bg-sidebar-accent/50 hover:text-sidebar-accent-foreground',
                )}
              >
                <Icon className="h-4 w-4 shrink-0" />
                {label}
              </Link>

              {showChildren && (
                <div className="ml-4 mt-0.5 space-y-0.5 border-l border-sidebar-border pl-3">
                  {children.map(({ href: ch, label: cl, icon: CI }) => (
                    <Link
                      key={ch}
                      href={ch}
                      className={cn(
                        'flex items-center gap-2 rounded-md px-3 py-1.5 text-xs font-medium transition-colors',
                        pathname.startsWith(ch)
                          ? 'text-sidebar-accent-foreground'
                          : 'text-sidebar-foreground/60 hover:text-sidebar-accent-foreground',
                      )}
                    >
                      <CI className="h-3.5 w-3.5 shrink-0" />
                      {cl}
                    </Link>
                  ))}
                </div>
              )}
            </div>
          )
        })}
      </nav>

      <div className="border-t border-sidebar-border p-3">
        <form action={logoutAction}>
          <Button
            type="submit"
            variant="ghost"
            className="w-full justify-start gap-3 text-sidebar-foreground/70 hover:bg-sidebar-accent/50 hover:text-sidebar-accent-foreground"
          >
            <LogOut className="h-4 w-4" />
            Sair
          </Button>
        </form>
      </div>
    </aside>
  )
}
