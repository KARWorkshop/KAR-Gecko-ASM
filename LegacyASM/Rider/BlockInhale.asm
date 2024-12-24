#To be inserted @ 8019c5c4
.include "../Common.s"
.include "../kex.s"

mr r3, r30
GetPlayerParameter

# REG_RIDER_PARAM is now pointing to param data
lwz r3, 0x00 (r3)
andi. r3, r3, 0x0001
cmpwi r3, 0
beq DoNothing
b ContinueFunction

DoNothing:
branch r12, 0x8019c624

ContinueFunction:
mr r3, r30
branchl r12,  0x801a617c