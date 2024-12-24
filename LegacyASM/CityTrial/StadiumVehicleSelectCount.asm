#To be inserted @ 8002f0b8
.include "../Common.s"
.include "../kex.s"

lwz r27,OFST_VehicleMetadata(rtoc)
lwz r27,0x08(r27)
stb r27 ,0x65 (r30)

