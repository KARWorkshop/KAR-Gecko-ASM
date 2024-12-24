#To be inserted @ 800037e4
.include "../Common.s"
.include "../kex.s"

# r3=gobj
# r4=player_index

.set REG_GOBJ, 3
.set REG_PLAYER_INDEX, 4

.set REG_RIDER_INDEX,24
.set REG_TEMP_MATH,25
.set REG_JOBJ_FLAGS,26

.set REG_JOINT_INDEX,27
.set REG_JOINT,28

############################################
backup

# get rider index
lwz REG_RIDER_INDEX, OFST_RiderTable(rtoc)
lwz REG_RIDER_INDEX, 0x04(REG_RIDER_INDEX)
lbzx REG_RIDER_INDEX, REG_PLAYER_INDEX, REG_RIDER_INDEX

# get joint
lwz REG_JOINT, 0x28 (REG_GOBJ)
lwz REG_JOINT, 0x10 (REG_JOINT) # child
lwz REG_JOINT, 0x08 (REG_JOINT) # next
lwz REG_JOINT, 0x08 (REG_JOINT) # next
cmpwi REG_JOINT, 0
beq END

# adjust position based on player index
  #lfs f0, 0(DISTANCE)
  #lfs f1, 
  #fmuls f0, f0, f1
  #stfs f0, 0x3C(REG_JOINT)
  #mullw REG_JOINT_INDEX, REG_JOINT_INDEX, REG_PLAYER_INDEX
  #addi REG_JOINT_INDEX, REG_JOINT_INDEX, 5
  #stw REG_JOINT_INDEX, 0x3C(REG_JOINT)

# get first child
  lwz REG_JOINT, 0x10(REG_JOINT) # child
# init joint index
  li REG_JOINT_INDEX, -2


/*# metaknight and dedede hack
  lis REG_TEMP_MATH, 0x80535B0F @h
  ori REG_TEMP_MATH, REG_TEMP_MATH, 0x80535B0F @l
  lbzx REG_TEMP_MATH, REG_PLAYER_INDEX, REG_TEMP_MATH

# meta knight
  cmpwi REG_TEMP_MATH, 0xA
  beq ICON_METAKNIGHT

# dedede
  cmpwi REG_TEMP_MATH, 0x13
  beq ICON_DEDEDE
*/
  b LOOP

ICON_METAKNIGHT:
  li REG_RIDER_INDEX, -1
  b LOOP

ICON_DEDEDE:
  li REG_RIDER_INDEX, -2
  b LOOP


LOOP:
# make sure not null
  cmpwi REG_JOINT, 0
  beq END

# set hidden flag
  cmpw REG_JOINT_INDEX, REG_RIDER_INDEX
  beq SET_VISIBLE
  b SET_HIDDEN

NEXT_JOINT:
  lwz REG_JOINT, 0x08(REG_JOINT)
  addi REG_JOINT_INDEX, REG_JOINT_INDEX, 1
  b LOOP


SET_HIDDEN:
  lwz REG_JOBJ_FLAGS, 0x14(REG_JOINT)
  ori REG_JOBJ_FLAGS, REG_JOBJ_FLAGS, 0x10
  stw REG_JOBJ_FLAGS, 0x14(REG_JOINT)
  b NEXT_JOINT

SET_VISIBLE:
  lwz REG_JOBJ_FLAGS, 0x14(REG_JOINT)
  li REG_TEMP_MATH, 0x10
  nor REG_TEMP_MATH, REG_TEMP_MATH, REG_TEMP_MATH
  and REG_JOBJ_FLAGS, REG_JOBJ_FLAGS, REG_TEMP_MATH
  stw REG_JOBJ_FLAGS, 0x14(REG_JOINT)
  b NEXT_JOINT

END:
restore
blr

############################################