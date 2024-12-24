#To be inserted @ 801D70E4

  lwz r3, 4(r29)
  cmpwi r3, 0x0
  beq- loc_0x40
  lwz r4, 4(r30)
  cmpwi r4, 0x0
  beq- loc_0x40
  lwz r3, 44(r3)
  lwz r4, 44(r4)
  lbz r3, 10(r3)
  lbz r4, 10(r4)
  cmpw r3, r4
  bne- loc_0x40
  lis r12, 0x801D
  ori r12, r12, 0x70F0
  mtctr r12
  bctr 

loc_0x40:
  lwz r3, 1632(r29)