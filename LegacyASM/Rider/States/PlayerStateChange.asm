#To be inserted @ 8018e7b4
.include "../../Common.s"
.include "../../kex.s"

.set REG_RIDER_INDEX, 25
.set REG_PLAYER_DATA, 28

backup
cmpwi r31, 400
blt Exit

# get rider id
lbz REG_RIDER_INDEX, 0x08(REG_PLAYER_DATA)
lwz r24, OFST_RuntimeRiderSelection(rtoc)
lbzx REG_RIDER_INDEX, REG_RIDER_INDEX, r24

# get move logic pointer
lwz r24, OFST_StateLogicTable(rtoc)
mulli REG_RIDER_INDEX, REG_RIDER_INDEX, 4
lwzx r3, REG_RIDER_INDEX, r24

# check if null
cmpwi r3, 0
beq Exit

# adjust pointer to state
subi r31, r31, 400
mulli r31, r31, 0x20
add r3, r3, r31

# restore and return to function
restore
# temp override anim id param
li r29, -1
mr r31, r3
branch r0, 0x8018e7dc

Exit:
restore
lwz r0, 0x20(r28)
cmpw r31, r0

