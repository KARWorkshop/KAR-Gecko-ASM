#To be inserted @ 8015c684
.include "../Common.s"
.include "../kex.s"

cmpwi r0,20
bge SHIFT_INDEX
b END

SHIFT_INDEX:
#dedede costume count
lwz r10,OFST_VehicleMetadata(rtoc)
lwz r10,0x10(r10)
add r0,r0,r10

#meta knight costume count
lwz r10,OFST_VehicleMetadata(rtoc)
lwz r10,0x14(r10)
add r0,r0,r10

mr r29,r0

b END

END:
cmpwi r0,0x12
