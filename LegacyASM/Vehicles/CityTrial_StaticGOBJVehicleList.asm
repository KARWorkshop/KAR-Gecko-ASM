#To be inserted @ 801dff94
.include "../Common.s"
.include "../kex.s"

/*lwz r10,OFST_VehicleMetadata(rtoc)
lwz r3,0x00(r10)
lwz r10,0x04(r10)
add r3,r3,r10

subf r4, r5, r3
mtspr CTR ,r4
cmpw r5, r3*/

subfic r4, r5, 0x19
mtspr CTR, r4
cmpwi r5, 0x19
