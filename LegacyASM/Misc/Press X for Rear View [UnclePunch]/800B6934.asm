#To be inserted @ 800B6934

  lfs f0, -29976(r2)
  lis r19, 0x805F
  ori r19, r19, 0x6430
  rlwinm. r17, r17, 0, 21, 21
  beq- loc_0x2C
  lis r18, 0x4046
  ori r18, r18, 0x62B9
  stw r18, 136(r3)
  li r20, 0x1
  stbx r20, r30, r19
  b loc_0x44

loc_0x2C:
  lbzx r20, r30, r19
  cmpwi r20, 0x0
  beq- loc_0x44
  stw r20, 136(r3)
  li r20, 0x0
  stbx r20, r30, r19

loc_0x44:
