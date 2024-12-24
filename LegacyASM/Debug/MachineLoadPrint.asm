#To be inserted @ 801c5200
.include "../Common.s"
.include "../kex.s" 

stb r0,0x1BBD(r31)

#OSReport
  bl  NoFileString
  mflr  r3
  lwz r4,0x10(r31)
  lbz r5,0x24(r31)
  lwz r6,0x2C(r31)
  branchl r12,0x803d4ce8

NoFileString:
blrl
.string "Loading Vehicle %d %d %8X\n"
.align 2