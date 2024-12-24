#To be inserted @ 8002de9c
.include "../Common.s"
.include "../kex.s"

lwz r10,OFST_SelectVehicleIDs(rtoc)
lbz r3,0x2d (r28)
lbzx r3,r10,r3
stb r3, 0x61(r28 )
