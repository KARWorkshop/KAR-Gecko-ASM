#To be inserted @ 8005e1e0
.include "../Common.s"
.include "../kex.s"

lwz r10, OFST_MusicTable(rtoc)
lwz r10, 0x00(r10)
cmpw r3, r10
