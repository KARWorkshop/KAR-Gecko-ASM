#To be inserted @ 801B8F60

  lfs f0, 148(r3)
  lwz r14, -1768(r3)
  rlwinm. r14, r14, 0, 22, 22
  beq- loc_0x20
  lis r14, 0x4000
  stw r14, -4(r1)
  lfs f14, -4(r1)
  fmuls f0, f0, f14

loc_0x20:

