#To be inserted @ 8002f204
.include "../Common.s"
.include "../kex.s"

lwz r3,OFST_SelectVehicleIDs(rtoc)
lbzx r3, r3, r25
