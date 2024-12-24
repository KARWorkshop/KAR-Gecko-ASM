#To be inserted @ 80023ea0
.include "../Common.s"
.include "../kex.s"

lwz r5,OFST_SelectVehicleIDs(rtoc)
lbzx r5,r5,r0

