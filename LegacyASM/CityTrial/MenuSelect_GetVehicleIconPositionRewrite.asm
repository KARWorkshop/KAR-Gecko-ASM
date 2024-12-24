#To be inserted @ 8015bafc
.include "../Common.s"
.include "../kex.s"

.set REG_JOBJ,3
.set REG_CURRENT_INDEX,10
.set REG_POSITION_INDEX,30

backup

# get position live jobj
lwz REG_JOBJ,0x87C(r3)
lwz REG_JOBJ,0x28(REG_JOBJ)

#child of child
lwz REG_JOBJ,0x10(REG_JOBJ)

# check if jobj exists
cmpwi REG_JOBJ,0
beq RETURN

lwz REG_JOBJ,0x10(REG_JOBJ)

# check if jobj exists
cmpwi REG_JOBJ,0
beq RETURN

li REG_CURRENT_INDEX,0

SEARCH_LOOP:

# increment count
cmpw REG_POSITION_INDEX,REG_CURRENT_INDEX
beq END_LOOP
addi REG_CURRENT_INDEX,REG_CURRENT_INDEX,1

# go to next jobj
lwz REG_JOBJ,0x08(REG_JOBJ)

# check if jobj exists
cmpwi REG_JOBJ,0
beq RETURN

b SEARCH_LOOP

END_LOOP:

# copy jobj position to return vector values

li r4,0
mr r5,r31
branchl r12,0x80053f34

RETURN:

# return
restore
branch r12,0x8015bb30