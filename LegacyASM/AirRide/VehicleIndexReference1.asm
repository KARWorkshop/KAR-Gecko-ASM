#To be inserted @ 800286d8
.include "../Common.s"
.include "../kex.s"

lwz r26,OFST_SelectVehicleIDs(rtoc)
lbzx r3,r26,r3

