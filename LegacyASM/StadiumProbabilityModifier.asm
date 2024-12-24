#To be inserted @ 8003F834

# macros copied from UnclePunch's asm code

.macro backup
mflr r0
stw r0, 0x4(r1)
stwu	r1,-0x100(r1)	# make space for 12 registers
stmw  r20,0x8(r1)
.endm

 .macro restore
lmw  r20,0x8(r1)
lwz r0, 0x104(r1)
addi	r1,r1,0x100	# release the space
mtlr r0
.endm

# Original code
lwz r28, 0x0004(r3)

mr r3, r28

backup

li r4, 24
mtctr r4

bl StadiumProbability
mflr r4

loop:
  lbz r5, 0(r4)
  stw r5, 4(r3)
  addi r4, r4, 1
  addi r3, r3, 4
bdnz loop
  
b Exit

#############################
StadiumProbability:
blrl

.byte 0 # Drag Race 1
.byte 0 # Drag Race 2
.byte 0 # Drag Race 3
.byte 0 # Drag Race 4
.byte 0 # Air Glider
.byte 0 # Target Flight
.byte 0 # High Jump
.byte 0 # Kirby Melee 1
.byte 0 # Kirby Melee 2
.byte 0 # Destruction Derby 1
.byte 0 # Destruction Derby 2
.byte 0 # Destruction Derby 3
.byte 0 # Destruction Derby 4
.byte 0 # Destruction Derby 5
.byte 0 # Single Race 1 (Fantasy Meadows)
.byte 0 # Single Race 2 (Magma Flows)
.byte 0 # Single Race 3 (Sky Sands)
.byte 0 # Single Race 4 (Frozen Hillside)
.byte 0 # Single Race 5 (Beanstalk Park)
.byte 0 # Single Race 6 (Celestial Vallay)
.byte 0 # Single Race 7 (Machine Passage)
.byte 0 # Single Race 8 (Checker Knights)
.byte 0 # Single Race 9 (Nebula Belt)
.byte 0 # Vs. King Dedede

.align 2

#############################

Exit:
  restore