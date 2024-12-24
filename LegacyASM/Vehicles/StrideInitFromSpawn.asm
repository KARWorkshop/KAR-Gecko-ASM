#To be inserted @ 801c5034
.include "../Common.s"
.include "../kex.s"

lwz r28,OFST_VehicleMetadata(rtoc)
lwz r28,0x00(r28)
mulli r28,r28,4
mullw r7,r7,r28