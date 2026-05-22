# 10 — Plano de Implantação

> Passos para provisionar e implantar o novo sistema ServSaúde em produção usando Supabase (banco + auth + storage) e Vercel (Next.js).

---

## 1. Visão Geral da Infraestrutura

```
┌───────────────────────────────────────────────────────────────┐
│                      PRODUÇÃO                                  │
│                                                               │
│  ┌──────────────────┐      ┌──────────────────────────────┐  │
│  │     Vercel       │      │         Supabase             │  │
│  │                  │      │                              │  │
│  │  Next.js App     │─────►│  PostgreSQL (Prisma)         │  │
│  │  App Router      │      │  Auth (e-mail/senha)         │  │
│  │  Server Actions  │      │  Storage (fotos, anexos)     │  │
│  │                  │      │  Realtime (guias)            │  │
│  └──────────────────┘      │  Vault (secrets bancários)   │  │
│                             └──────────────────────────────┘  │
│                                                               │
│  ┌──────────────────┐                                        │
│  │  Sentry          │  ← Monitoramento de erros             │
│  └──────────────────┘                                        │
└───────────────────────────────────────────────────────────────┘

Ambientes:
  production:  app.servsaude.com.br → Vercel prod + Supabase prod
  staging:     staging.servsaude.com.br → Vercel preview + Supabase staging
  development: localhost:3000 → Supabase local (supabase start)
```

---

## 2. Pré-requisitos

### 2.1 — Contas e Acessos Necessários

| Serviço | Plano | Custo estimado |
|---|---|---|
| Vercel | Pro | ~$20/mês |
| Supabase | Pro | ~$25/mês |
| Sentry | Developer (free) | Gratuito |
| Domínio `servsaude.com.br` | Registro.br | ~R$ 40/ano |

### 2.2 — Ferramentas Locais Necessárias

```bash
# Verificar versões mínimas
node --version      # >= 20.0
pnpm --version      # >= 8.0
npx supabase --version  # >= 1.100
```

---

## 3. Configuração do Supabase

### 3.1 — Criar Projeto Supabase

1. Acessar [supabase.com](https://supabase.com) → New Project
2. Configurar:
   - **Nome**: `servsaude-prod`
   - **Senha do banco**: gerar senha forte (mínimo 32 chars)
   - **Região**: `South America (São Paulo)` — latência mínima para usuários brasileiros
   - **Plano**: Pro (necessário para PITR backup)

3. Guardar as credenciais (só aparecem uma vez):
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`
   - `SUPABASE_SERVICE_ROLE_KEY`
   - `DATABASE_URL` (connection string direta)

### 3.2 — Executar Migrations do Prisma

```bash
# 1. Configurar .env.local com DATABASE_URL do Supabase
cp .env.local.example .env.local
# Editar DATABASE_URL com a connection string do Supabase (modo de transação)

# 2. Gerar o client Prisma
npx prisma generate

# 3. Executar migrations (cria todas as tabelas e enums)
npx prisma migrate deploy

# 4. Verificar no Supabase Studio que as tabelas foram criadas
# Table Editor → deve aparecer todos os modelos do schema.prisma
```

### 3.3 — Configurar Row Level Security (RLS)

```sql
-- Executar no SQL Editor do Supabase (produção)
-- Habilitar RLS em todas as tabelas de negócio

ALTER TABLE "Conveniado" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Adesao" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Guia" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Lancamento" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Boleto" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Prestador" ENABLE ROW LEVEL SECURITY;
-- (repetir para todas as tabelas com operadoraId)

-- Policy: usuário só acessa dados da sua operadora
CREATE POLICY "operadora_isolation" ON "Conveniado"
    FOR ALL
    USING (
        "operadoraId" = (
            SELECT "operadoraId"
            FROM "OperadoraUsuario"
            WHERE "usuarioId" = auth.uid()
            LIMIT 1
        )
    );
-- Criar policy equivalente em cada tabela
```

### 3.4 — Configurar Supabase Storage

```bash
# Via Supabase CLI ou Studio:
# Criar buckets:
# - 'fotos-conveniados'     (público para leitura após auth, privado para escrita)
# - 'anexos-guias'          (privado — só operadora acessa)
# - 'documentos-credenciamento' (privado)

# Policy de storage para fotos:
# Conveniado pode fazer GET da própria foto; admin pode fazer PUT/DELETE
```

### 3.5 — Configurar Supabase Vault (Secrets Bancários)

```sql
-- Armazenar credenciais bancárias de forma segura
SELECT vault.create_secret(
    'boleto_client_secret_operadora_1',
    'valor_do_secret',
    'Secret da API bancária da Operadora Municipal'
);

-- Acessar via função:
SELECT vault.decrypted_secrets WHERE name = 'boleto_client_secret_operadora_1';
```

### 3.6 — Configurar Supabase Auth

1. Acessar Authentication → Providers → Email: habilitar
2. Authentication → Email Templates: personalizar com logo ServSaúde
3. Authentication → URL Configuration:
   - Site URL: `https://app.servsaude.com.br`
   - Redirect URLs: `https://app.servsaude.com.br/auth/callback`
4. Authentication → Sessions: JWT expiry = 3600s (1h), refresh token rotation = enabled

---

## 4. Configuração do Vercel

### 4.1 — Deploy Inicial

```bash
# 1. Instalar Vercel CLI
pnpm add -g vercel

# 2. Fazer login
vercel login

# 3. Vincular projeto ao repositório Git
vercel link

# 4. Configurar variáveis de ambiente de produção
vercel env add NEXT_PUBLIC_SUPABASE_URL production
vercel env add NEXT_PUBLIC_SUPABASE_ANON_KEY production
vercel env add SUPABASE_SERVICE_ROLE_KEY production
vercel env add DATABASE_URL production
vercel env add DIRECT_URL production
# (ver .env.local.example para lista completa)

# 5. Deploy
vercel --prod
```

### 4.2 — Configurar Domínio Personalizado

```bash
# Adicionar domínio no painel Vercel:
# Settings → Domains → Add Domain → app.servsaude.com.br

# Configurar DNS no Registro.br:
# Tipo: CNAME
# Nome: app
# Valor: cname.vercel-dns.com
```

### 4.3 — Configurar Vercel para Next.js

```javascript
// next.config.ts
const nextConfig = {
  experimental: {
    serverActions: { allowedOrigins: ['app.servsaude.com.br'] },
  },
  images: {
    remotePatterns: [{
      protocol: 'https',
      hostname: '*.supabase.co',  // Supabase Storage
    }],
  },
}
export default nextConfig
```

---

## 5. Configuração de Monitoramento

### 5.1 — Sentry (Erros)

```bash
pnpm add @sentry/nextjs
npx @sentry/wizard@latest -i nextjs
```

```javascript
// sentry.client.config.ts
Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.NODE_ENV,
  tracesSampleRate: 0.1,  // 10% das transações em produção
})
```

### 5.2 — Alertas Críticos (via Supabase + Sentry)

| Evento | Alerta | Canal |
|---|---|---|
| Erro HTTP 5xx > 5 em 5min | Sentry alert | E-mail + Slack |
| Login falho > 10 em 1min | Supabase Auth | E-mail segurança |
| CPU banco > 80% por 5min | Supabase Monitoring | E-mail TI |
| Storage > 80% do limite | Supabase Monitoring | E-mail TI |

---

## 6. Pipeline CI/CD (GitHub Actions)

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v2
      - run: pnpm install
      - run: pnpm test         # Vitest
      - run: pnpm type-check   # tsc --noEmit

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v2
      - run: pnpm install
      - run: npx prisma migrate deploy
        env:
          DATABASE_URL: ${{ secrets.DATABASE_URL }}
      - uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: '--prod'
```

---

## 7. Checklist de Go-Live

### D-14 (Duas semanas antes)

- [ ] Supabase projeto de produção criado
- [ ] Migrations executadas no banco de produção
- [ ] RLS policies aplicadas e testadas
- [ ] Buckets de storage criados com policies corretas
- [ ] Credenciais bancárias armazenadas no Vault
- [ ] Domínio `app.servsaude.com.br` configurado no Vercel
- [ ] Certificado TLS emitido e válido
- [ ] Variáveis de ambiente de produção configuradas no Vercel

### D-7 (Uma semana antes)

- [ ] Dry run completo do ETL no ambiente de staging com dados reais mascarados
- [ ] Testes de performance (k6) executados e aprovados (< 500ms P95)
- [ ] Smoke test em staging: todos os 9 itens passando
- [ ] Treinamento de usuários por perfil concluído
- [ ] Plano de rollback documentado e testado
- [ ] Backup do banco legado criado e restauração testada
- [ ] Comunicado enviado aos usuários sobre a janela de manutenção

### D-1 (Véspera)

- [ ] Backup final do MySQL legado
- [ ] Congelar novas adesões e guias não-urgentes (comunicar)
- [ ] Equipe de plantão escalada para o dia seguinte

### D-0 (Dia do go-live)

- [ ] 00h: Início da janela de manutenção — legado em modo read-only
- [ ] 00h-02h: ETL Fase 4b — guias recentes e financeiro
- [ ] 02h-04h: Validação completa (scripts de conferência)
- [ ] 04h: Decisão GO/NO-GO baseada nos relatórios de validação
- [ ] 04h30: Apontar DNS para Vercel (se GO)
- [ ] 06h: Monitorar por 2h — verificar Sentry, Supabase Logs, feedback de usuários
- [ ] 08h: Declarar go-live bem-sucedido (ou acionar rollback)

### D+7 (Uma semana após)

- [ ] Revisar erros no Sentry — corrigir issues críticos
- [ ] Avaliar performance real vs esperada
- [ ] Coletar feedback dos usuários
- [ ] Desligar servidores legados (manter backup por 90 dias)

---

## 8. Estrutura de Arquivos do Projeto

```
servsaude/
├── app/                          # Next.js App Router
│   ├── (auth)/                   # Rotas de autenticação
│   │   └── login/page.tsx
│   ├── (dashboard)/              # Rotas protegidas
│   │   ├── layout.tsx            # Layout com sidebar
│   │   ├── dashboard/page.tsx
│   │   ├── conveniados/
│   │   │   ├── page.tsx          # Lista
│   │   │   └── [id]/page.tsx     # Detalhe
│   │   ├── guias/
│   │   │   ├── page.tsx
│   │   │   ├── nova/page.tsx
│   │   │   └── [id]/page.tsx
│   │   └── financeiro/
│   └── api/                      # Route Handlers (webhooks)
│       └── boletos/retorno/route.ts
├── actions/                      # Server Actions
│   ├── conveniados.ts
│   ├── guias.ts
│   └── financeiro.ts
├── components/                   # Componentes React
│   ├── ui/                       # Shadcn/ui
│   └── servsaude/                # Componentes de domínio
├── lib/
│   ├── prisma.ts                 # Prisma client singleton
│   ├── supabase/
│   │   ├── client.ts             # Supabase client (browser)
│   │   └── server.ts             # Supabase client (server)
│   └── validations/              # Schemas Zod
├── prisma/
│   ├── schema.prisma
│   └── migrations/
├── scripts/
│   └── etl/                      # Scripts de migração
└── docs/                         # Esta documentação
```
