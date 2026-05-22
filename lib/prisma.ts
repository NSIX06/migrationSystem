import { PrismaClient } from '@prisma/client'

const globalForPrisma = globalThis as unknown as {
  prisma?: PrismaClient
  prismaDatasourceUrl?: string
}

const datasourceUrl =
  process.env.NODE_ENV === 'production'
    ? process.env.DATABASE_URL
    : process.env.DIRECT_URL ?? process.env.DATABASE_URL

const shouldReusePrisma =
  globalForPrisma.prisma && globalForPrisma.prismaDatasourceUrl === datasourceUrl

export const prisma: PrismaClient =
  shouldReusePrisma
    ? globalForPrisma.prisma!
    : new PrismaClient({
    datasources: datasourceUrl ? { db: { url: datasourceUrl } } : undefined,
    log: process.env.NODE_ENV === 'development' ? ['query', 'error', 'warn'] : ['error'],
  })

if (process.env.NODE_ENV !== 'production') {
  globalForPrisma.prisma = prisma
  globalForPrisma.prismaDatasourceUrl = datasourceUrl
}
