#To be inserted @ 80023e7c
.include "../Common.s"
.include "../kex.s"

lwz r10,OFST_SelectVehicleIDs(rtoc)
lbzx r4,r10,r0
