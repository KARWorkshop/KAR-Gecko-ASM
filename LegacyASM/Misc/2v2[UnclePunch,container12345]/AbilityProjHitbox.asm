#To be inserted @ 801D71B0

  lwz r3, 44(r31)
  lwz r3, 8(r3)
  cmpwi r3, 0x0
  beq- loc_0x4C
  lwz r4, 4(r29)
  cmpwi r4, 0x0
  beq- loc_0x4C
  lwz r3, 44(r3)
  lwz r4, 44(r4)
  cmpw r3, r4
  beq- loc_0x4C
  lbz r3, 10(r3)
  lbz r4, 10(r4)
  cmpw r3, r4
  bne- loc_0x4C
  lis r12, 0x801D
  ori r12, r12, 0x71C4
  mtctr r12
  bctr 

loc_0x4C:
  mr r3, r31
