#To be inserted @ 801c85b4
.include "../Common.s"
.include "../kex.s"

lwz r28,OFST_VehicleMetadata(rtoc)
lwz r28,0x00(r28)
add r3,r3,r28
