#To be inserted @ 800315c4
.include "../Common.s"
.include "../kex.s"

lwz r10,OFST_SelectVehicleIDs(rtoc)
lbzx r0,r10,r27
stb r0,0x61(r3)