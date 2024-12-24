#To be inserted @ 801c6e00
.include "../Common.s"
.include "../kex.s"

lwz r3,OFST_VehicleFileStrings(rtoc)
lwzx r4,r3,r31
