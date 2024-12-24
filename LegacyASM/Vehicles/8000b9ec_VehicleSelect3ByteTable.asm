#To be inserted @ 8000b9ec
.include "../Common.s"
.include "../kex.s"

lwz r0,OFST_SelectVehicle3ByteTable(rtoc)
add r3,r0,r4
