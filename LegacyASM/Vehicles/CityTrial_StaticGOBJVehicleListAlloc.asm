#To be inserted @ 801dfeb4
.include "../Common.s"
.include "../kex.s"

/*lwz r10,OFST_VehicleMetadata(rtoc)
lwz r3,0x00(r10)
lwz r10,0x04(r10)
add r3,r3,r10
mulli r3,r3,8*/

li r3, 0xD0
