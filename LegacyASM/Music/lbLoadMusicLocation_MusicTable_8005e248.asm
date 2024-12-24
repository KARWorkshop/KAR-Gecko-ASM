#To be inserted @ 8005e248
.include "../Common.s"
.include "../kex.s"

lwz r5, OFST_MusicTable(rtoc)
lwz r5, 0x04(r5)
