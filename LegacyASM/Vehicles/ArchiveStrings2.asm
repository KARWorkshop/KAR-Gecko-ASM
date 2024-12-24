#To be inserted @ 801c8cc4
.include "../Common.s"
.include "../kex.s"

lwz r10,OFST_VehicleFileStrings(rtoc)
lwzx r3,r10,r0