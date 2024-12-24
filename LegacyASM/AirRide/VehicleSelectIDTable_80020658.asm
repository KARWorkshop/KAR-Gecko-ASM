#To be inserted @ 800206dc
.include "../Common.s"
.include "../kex.s"

lwz r10,OFST_SelectVehicleIDs(rtoc)
lbz r0,0x2d (r28)
lbzx r0,r10,r0
stb r0,0x61 (r28)
