#To be inserted @ 801EF414

  lbz r0, 3120(r31)
  cmpwi r0, 0xE0
  blt- loc_0x1C
  lbz r14, 1647(r31)
  cmpwi r14, 0x2
  bne- loc_0x1C
  li r0, 0x0

loc_0x1C:



