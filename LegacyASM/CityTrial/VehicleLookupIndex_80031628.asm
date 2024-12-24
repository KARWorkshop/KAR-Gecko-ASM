#To be inserted @ 80031628
.include "../Common.s"
.include "../kex.s"

lwz r10,OFST_SelectVehicleIDs(rtoc)
lbzx r4,r10,r0