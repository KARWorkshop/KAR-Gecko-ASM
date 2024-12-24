
.macro CheckWearHat reg_playerdata, LoadHatAddr

.set REG_RIDER_TABLE,24
.set REG_RIDER_PARAM,24
.set REG_RIDER_INDEX,25
.set REG_FLAGS,25

backup

# player id
lbz r3, 0x08 (\reg_playerdata) 

# get rider id and rider table
lwz REG_RIDER_TABLE, OFST_RiderTable(rtoc)
lwz REG_RIDER_INDEX, 0x04(REG_RIDER_TABLE)
lbzx REG_RIDER_INDEX, r3, REG_RIDER_INDEX

# if kirby always load hat
cmpwi REG_RIDER_INDEX, 0
beq LoadHat

# load param kexData
lwz REG_RIDER_PARAM, OFST_RiderParamTable(rtoc)
mulli REG_RIDER_INDEX, REG_RIDER_INDEX, 4
lwzx REG_RIDER_PARAM, REG_RIDER_INDEX, REG_RIDER_PARAM

# REG_RIDER_PARAM is now pointing to param data
lwz REG_FLAGS, 0x00 (REG_RIDER_PARAM)
andi. REG_FLAGS, REG_FLAGS, 0x0002
cmpwi REG_FLAGS, 0
beq DoNotLoadHat
b LoadHat

LoadHat:
  restore

# load hat
  mr r3, r31
  branchl r12, \LoadHatAddr
  b End

DoNotLoadHat:
  restore
  b End

End:
  nop

.endm
