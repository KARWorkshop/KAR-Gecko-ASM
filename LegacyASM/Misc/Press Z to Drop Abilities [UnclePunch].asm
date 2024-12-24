#To be inserted @ 801A7CEC


  lwz r0, 20(r1)
  lwz r17, 996(r31)
  cmpwi r17, 0x10
  bne- loc_0x18
  li r18, 0x0
  stw r18, 2332(r31)

loc_0x18:
