#To be inserted @ 80023874
.include "../Common.s"
.include "../kex.s"

lwz r25,OFST_SelectVehicleIDs(rtoc)
lbzx r4,r25,r4
