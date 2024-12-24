#To be inserted @ 8015b698
.include "../Common.s"
.include "../kex.s"

.set REG_GOBJ, 3

# mr r3, r3
mr r4, r31
branchl r12, Menu_UpdateColorBox

lwz r31, 0x28 (REG_GOBJ)