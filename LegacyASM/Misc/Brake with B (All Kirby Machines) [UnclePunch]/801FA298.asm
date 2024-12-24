#To be inserted @ 801FA298

  mr r3, r31
  lbz r14, 1647(r31)
  cmpwi r14, 0x2
  bne- loc_0x20
  lis r15, 0x801F
  ori r15, r15, 0xA2A0
  mtctr r15
  bctr 

loc_0x20:


