#To be inserted @ 801c6de8
.include "../Common.s"
.include "../kex.s"

lwz r28,OFST_VehicleArchiveRuntimes(rtoc)
add r28,r28,r4
# add offset
add r5,r28,r0