export function parseBigIntId(value: string) {
  return /^[1-9]\d*$/.test(value) ? BigInt(value) : null
}
