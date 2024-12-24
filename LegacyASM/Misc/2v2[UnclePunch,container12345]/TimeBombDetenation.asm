#To be inserted @ 8022933C

  lwz r3, 8(r30)
  cmpw r3, r31
  beq- loc_0x34
  lwz r3, 44(r3)
  lwz r4, 44(r31)
  lbz r3, 10(r3)
  lbz r4, 10(r4)
  cmpw r3, r4
  bne- loc_0x34
  lis r12, 0x8022
  ori r12, r12, 0x9378
  mtctr r12
  bctr 

loc_0x34:
  mr r3, r31

