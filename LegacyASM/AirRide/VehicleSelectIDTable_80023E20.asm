#To be inserted @ 80023e30
.include "../Common.s"
.include "../kex.s"

lwz r10,OFST_SelectVehicleIDs(rtoc)
lbzx r0,r10,r0
stb r0,0x61(r3)
