#To be inserted @ 8000bbc8
.include "../Common.s"
.include "../kex.s"

# load playlist pointer
lwz r10, OFST_MusicTable(rtoc)
lwz r10, 0x08(r10)

# get total chance
lwz r11, 0x00(r10)
lwz r12, 0x04(r10)
li r3, 0

LOOP:
# add chance
lbz r10, 0x00(r12)
add r3, r3, r10

# move to next entry
addi r12, r12, 4

# loop
subi r11, r11, 1
cmpwi r11, 0
beq END
b LOOP

END:

#random from chances
branchl r12,0x8041e668

# search for this random number
# load playlist pointer
lwz r10, OFST_MusicTable(rtoc)
lwz r10, 0x08(r10)

# get total chance
lwz r11, 0x00(r10)
lwz r12, 0x04(r10)

LOOP2:
# add chance
lbz r10, 0x00(r12)
cmpw r10, r3
bge END2

# decrement 
sub r3, r3, r10

# move to next entry
addi r12, r12, 4

# loop
subi r11, r11, 1
b LOOP2

END2:

lwz r3, 0x00(r12)
andi. r3, r3, 0xFFFF