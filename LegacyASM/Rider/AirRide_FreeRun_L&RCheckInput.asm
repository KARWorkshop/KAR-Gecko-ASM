#To be inserted @ 800283bc
.include "../Common.s"
.include "../kex.s"

# check l and r press
andi. r0, r4, 0x0060
bne Equals

rlwinm. r0, r4, 0x0, 0x14, 0x15
beq NotEquals
b Equals

NotEquals:
branch r12, 0x80028524

Equals:
branch r12, 0x800283c4