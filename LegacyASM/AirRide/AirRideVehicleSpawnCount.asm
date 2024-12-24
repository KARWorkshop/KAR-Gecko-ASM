#--To be inserted @ 80021498
.include "../Common.s"
.include "../kex.s"

#load vehicle count
lwz r28,OFST_VehicleMetadata(rtoc)
lwz r28,0x08(r28)
stb r28,0x65(r31)
