#To be inserted @ 80028430
.include "../Common.s"
.include "../kex.s"

  mr r3, r25
  # mr r4, r4 r4 is already input
  mr r5, r31
  branchl r12, Menu_SelectRiderLogic
  extsb. r0, r3
