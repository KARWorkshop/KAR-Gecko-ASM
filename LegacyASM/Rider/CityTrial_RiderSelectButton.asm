#To be inserted @ 80036d60
.include "../Common.s"
.include "../kex.s"

  mr r3, r28
  # mr r4, r4
  mr r5, r31
  branchl r12, Menu_SelectRiderLogic
  extsb. r0, r3
