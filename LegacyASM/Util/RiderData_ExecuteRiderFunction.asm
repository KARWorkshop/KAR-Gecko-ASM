#To be inserted @ 800037dc
.include "../Common.s"
.include "../kex.s"

.set REG_PLAYERDATA, 3
.set REG_FUNCTION_ID, 4

.set REG_FUNCTION, 24
.set REG_FUNCTION_OFFSET, 25
.set REG_PLAYERDATA_BACKUP, 31

###############################################
    backup

    mr REG_PLAYERDATA_BACKUP, r3

    lwz REG_FUNCTION, OFST_RdFunctionTable(rtoc)
    mr REG_FUNCTION_OFFSET, REG_FUNCTION_ID
    mulli REG_FUNCTION_OFFSET, REG_FUNCTION_OFFSET, 4
    lwzx REG_FUNCTION, REG_FUNCTION_OFFSET, REG_FUNCTION

    # get rider id
    mr r3, REG_PLAYERDATA_BACKUP
    branchl r26, Rider_GetRiderID

    # if rider id is not a costume exit
    cmpwi r3, 0
    ble Exit

    # load function pointer
    mulli r3, r3, 4
    lwzx r3, r3, REG_FUNCTION

    # check if function is null
    cmpwi r3, 0
    beq Exit

    # execute function
    mtctr r3
    mr r3, REG_PLAYERDATA_BACKUP
    bctrl

    Exit:
    restore
    blr
###############################################