#To be inserted @ 801a81c4
.include "../Common.s"
.include "../kex.s"
 
mr r28, r3
GetPlayerParameter

lwz r3, 0x00 (r3)
andi. r3, r3, 0x0001
cmpwi r3, 0
beq DoNothing
b ContinueFunction

DoNothing:
branch r12, 0x801a8268

ContinueFunction:
mr r3, r28