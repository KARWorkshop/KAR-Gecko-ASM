#To be inserted @ 80038bb8
.include "../Common.s"
.include "../kex.s"

lwz r10,OFST_SelectVehicleIDs(rtoc)
lbzx r3,r10,r3