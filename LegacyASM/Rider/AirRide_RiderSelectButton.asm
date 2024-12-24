#To be inserted @ 80024dd8
.include "../Common.s"
.include "../kex.s"

  mr r3, r30
  mr r4, r26
  mr r5, r29
  branchl r12, Menu_SelectRiderLogic
  extsb. r0, r3
