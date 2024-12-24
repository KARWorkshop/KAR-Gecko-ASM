#To be inserted @ 8018e55c
.include "../../Common.s"
.include "../../kex.s"

#original code
branchl r12, 0x8019f41c

mr r3, r31
li r4, rd_OnInit
branchl r12, Rider_ExecuteRdFunction
