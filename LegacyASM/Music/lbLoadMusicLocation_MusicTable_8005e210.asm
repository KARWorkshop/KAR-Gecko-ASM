#To be inserted @ 8005e210
.include "../Common.s"
.include "../kex.s"

lwz r8, OFST_MusicTable(rtoc)
lwz r8, 0x04(r8)
