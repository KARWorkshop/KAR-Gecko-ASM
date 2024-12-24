#To be inserted @ 8018df88
.include "../Common.s"
.include "../kex.s"

.set REG_NEW_RIDERDATA,3
.set REG_NEW_EXTDATA,24
.set REG_ORG_RIDERDATA,25
.set REG_RIDER_TABLE,27
.set REG_RIDER_INDEX,28
.set REG_RIDER_OFFSET,29
.set REG_PLAYER_DATA,31

# original instruction
stb r0, 0xA9D(r31)

##########################################################
backup

lwz REG_RIDER_TABLE, OFST_RiderTable(rtoc)

mr r3, r31
branchl r12, Rider_GetRiderID
cmpwi r3, 0
ble DO_NOTHING

mr REG_RIDER_INDEX, r3
mr REG_RIDER_OFFSET, r3
mulli REG_RIDER_OFFSET, REG_RIDER_OFFSET, 4

##########################################################
LOAD_RIDER:

# check if archive already loaded
  lwz r3, 0x0C(REG_RIDER_TABLE)
  add r3, r3, REG_RIDER_OFFSET
  lwz r5, 0x00(r3)
  mr REG_NEW_EXTDATA, r5

  cmpwi r5, 0
  bne INIT_NEW_RIDER

##########################################################
LOAD_ARCHIVE:
.set PARAM_UNK, 3
.set PARAM_FILE_STRING, 4
.set PARAM_POINTER1, 5
.set PARAM_SYMBOL1, 6
.set PARAM_POINTER2, 7
.set PARAM_SYMBOL2, 8
.set PARAM_END, 9

# runtime storage for rider data
  mr PARAM_POINTER1, r3

# runtime storage for rdFunction
  lwz PARAM_POINTER2, 0x14(REG_RIDER_TABLE)
  add PARAM_POINTER2, PARAM_POINTER2, REG_RIDER_OFFSET

# get string offset
  mr r6, REG_RIDER_INDEX
  mulli r6, r6, 8
  lwz r3, 0x08(REG_RIDER_TABLE) 
  add r6, r6, r3

# load the string values
  lwz PARAM_FILE_STRING, 0x00(r6)
  lwz PARAM_SYMBOL1, 0x04(r6)
  bl rdFunctionString
  mflr PARAM_SYMBOL2

# setup lbLoadArchiveParameters
  li PARAM_UNK, 0
  li PARAM_END, 0
  crxor 4*cr1+eq,4*cr1+eq,4*cr1+eq

# load symbols
  branchl r12, 0x80059a20

##########################################################
INIT_FUNCTION:
# if rdFunction symbol was loaded initialize it
  mr r4, REG_RIDER_INDEX
  mulli r4, r4, 4
  lwz r3, 0x14(REG_RIDER_TABLE)
  add r3, r3, r4
  lwz r3, 0x00(r3)
  branchl r12, Reloc

  mr r4, REG_RIDER_INDEX
  mulli r4, r4, 4
  lwz r3, 0x14(REG_RIDER_TABLE)
  add r3, r3, r4
  lwz r3, 0x00(r3)
  mr r4, REG_RIDER_INDEX
  branchl r12, InitRdFunction

##########################################################
LOAD_MODEL_SYMBOL:
# load symbol into new model register
  lwz REG_NEW_EXTDATA, 0x0C(REG_RIDER_TABLE)
  add REG_NEW_EXTDATA, REG_NEW_EXTDATA, REG_RIDER_OFFSET
  lwz REG_NEW_EXTDATA, 0x00(REG_NEW_EXTDATA)

##########################################################
INIT_NEW_RIDER:

# alloc new rider data struct
# size 0x40
bl AllocStruct
mflr r3
branchl r12, 0x804180e4

# copy rider data
lwz r4, 0x18(r31)
li r5, 0x40
branchl r12, 0x80003268

mr r8, REG_NEW_RIDERDATA

# set new model data
# loop copy ext data

.set REG_LOOP, 26
.set REG_VALUE, 30

  li REG_LOOP, 0

  LOOP:
  lwzx REG_VALUE, REG_LOOP, REG_NEW_EXTDATA

  cmpwi REG_VALUE, 0
  beq CONTINUE_LOOP
  stwx REG_VALUE, REG_LOOP, REG_NEW_RIDERDATA

  CONTINUE_LOOP:
  addi REG_LOOP, REG_LOOP, 4
  cmpwi REG_LOOP, 8 * 4
  bge Exit
  b LOOP

##########################################################
AllocStruct:
blrl
.long 0
.long 0
.long 1
.long 0

.long 1
.long -1
.long 0
.long -1

.long 0x40
.long 4
.long 0

.align 2

##########################################################
rdFunctionString:
blrl
.string "rdFunction"
.align 2

##########################################################
Exit:
# store new rider data struct
stw r8, 0x18(REG_PLAYER_DATA)

##########################################################
DO_NOTHING:
restore