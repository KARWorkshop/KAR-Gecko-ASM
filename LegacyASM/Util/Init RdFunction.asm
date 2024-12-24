#To be inserted @ 800037d4
.include "../Common.s"
.include "../kex.s"

#r3 = xFunction ptr
#r4 = rider_id

.set REG_FUNCTION,3
.set REG_RIDER_ID,4

.set REG_CODE,24
.set REG_INDEX,25
.set REG_COUNT,26
.set REG_TABLE,27

.set REG_TABLE_INDEX,28
.set REG_CODE_OFFSET,29

.set REG_KXTable,30

#########################################
  backup

  lwz REG_KXTable, OFST_RdFunctionTable(rtoc)
  lwz REG_CODE, 0x00(REG_FUNCTION)
  lwz REG_TABLE, 0x0C(REG_FUNCTION)
  lwz REG_COUNT, 0x10(REG_FUNCTION)
  mulli REG_COUNT, REG_COUNT, 8

  li REG_INDEX, 0

  mulli REG_RIDER_ID, REG_RIDER_ID, 4

LOOP:
  cmpw REG_INDEX, REG_COUNT
  bge Exit
  
  # load table index
  lwzx REG_TABLE_INDEX, REG_INDEX, REG_TABLE
  addi REG_INDEX, REG_INDEX, 4

  # load code offset
  lwzx REG_CODE_OFFSET, REG_INDEX, REG_TABLE
  addi REG_INDEX, REG_INDEX, 4
  
  # get kxdt table offset
  mulli REG_TABLE_INDEX, REG_TABLE_INDEX, 4
  lwzx REG_TABLE_INDEX, REG_TABLE_INDEX, REG_KXTable

  # get actual code offset
  add REG_CODE_OFFSET, REG_CODE_OFFSET, REG_CODE
  
  # store code pointer
  stwx REG_CODE_OFFSET, REG_RIDER_ID, REG_TABLE_INDEX

  b LOOP

Exit:
  restore
  blr
#########################################