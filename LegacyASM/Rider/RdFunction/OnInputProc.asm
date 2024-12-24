#To be inserted @ 8018EF24
.include "../../Common.s"
.include "../../kex.s"

backup

# backup reg 4
  mr r24, r4

# execute function
  mr r3, r31
  li r4, rd_OnInput
  branchl r12, Rider_ExecuteRdFunction

# restore r4
  mr r4, r24

restore

mr r3, r31