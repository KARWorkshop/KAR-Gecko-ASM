#To be inserted @ 801D7034

  lwz r4, 4(r30)
  cmpwi r4, 0x0
  beq- loc_0x34
  lwz r3, 44(r31)
  lwz r4, 44(r4)
  lbz r3, 10(r3)
  lbz r4, 10(r4)
  cmpw r3, r4
  bne- loc_0x34
  lis r12, 0x801D
  ori r12, r12, 0x7048
  mtctr r12
  bctr 

loc_0x34:
  mr r3, r31