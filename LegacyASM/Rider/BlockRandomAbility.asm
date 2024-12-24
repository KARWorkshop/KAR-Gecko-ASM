#To be inserted @ 801ae564
.include "../Common.s"
.include "../kex.s"

mr r31, r3
GetPlayerParameter

lwz r3, 0x00 (r3)
andi. r3, r3, 0x0001
cmpwi r3, 0
beq DoNothing
b ContinueFunction

DoNothing:
branch r12, 0x801ae6c0

ContinueFunction:
mr r3, r31
or r31, r4, r4