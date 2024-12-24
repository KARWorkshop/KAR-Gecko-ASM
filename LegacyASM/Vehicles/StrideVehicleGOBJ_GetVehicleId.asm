#To be inserted @ 801c85d0
.include "../Common.s"
.include "../kex.s"

lwz r10,OFST_VehicleMetadata(rtoc)
lwz r10,0x00(r10)
add r3,r3,r10

#addi r3,r3,0x13
