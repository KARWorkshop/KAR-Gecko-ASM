#To be inserted @ 8005e270
.include "../Common.s"
.include "../kex.s"

lwz r10, OFST_MusicTable(rtoc)
lwz r0, 0x00(r10)
