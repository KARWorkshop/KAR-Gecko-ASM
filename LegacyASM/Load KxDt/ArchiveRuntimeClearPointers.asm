#To be inserted @ 801c6c70
.include "../Common.s"
.include "../kex.s"

.set REG_POINTER,10
.set REG_COUNT,11

#load vehicle count
lwz REG_POINTER,OFST_VehicleMetadata(rtoc)
lwz REG_COUNT,0x00(REG_POINTER)
lwz REG_POINTER,0x04(REG_POINTER)
add REG_COUNT,REG_COUNT,REG_POINTER

#load runtime pointer
lwz REG_POINTER,OFST_VehicleArchiveRuntimes(rtoc)
li r12,0

CLEAR_LOOP:
stw r12,0x00(REG_POINTER)
addi REG_POINTER,REG_POINTER,4
subi REG_COUNT,REG_COUNT,1
cmpwi REG_COUNT,0
beq CLEAR_RIDER_POINTER
b CLEAR_LOOP


CLEAR_RIDER_POINTER:
#load vehicle count
lwz REG_POINTER,OFST_RiderTable(rtoc)
lwz REG_COUNT,0x00(REG_POINTER)

#load runtime pointer
lwz REG_POINTER,0x0C(REG_POINTER)
li r12,0

CLEAR_RIDER_LOOP:
stw r12,0x00(REG_POINTER)
addi REG_POINTER,REG_POINTER,4
subi REG_COUNT,REG_COUNT,1
cmpwi REG_COUNT,0
beq EXIT
b CLEAR_RIDER_LOOP


EXIT:
subi r7,r3,0x5f98
