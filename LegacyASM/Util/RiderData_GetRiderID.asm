#To be inserted @ 800037d8
.include "../Common.s"
.include "../kex.s"

# r3=RiderData pointer
# return is rider data
# -1 if not a costume

.set REG_RIDERDATA, 3

.set REG_PLAYER_ID, 24
.set REG_RIDER_TABLE, 25

################################################
    backup

    # check if kirby
    lwz r24, 0x04 (r3)
    cmpwi r24, 0
    bne NOT_CUSTOM_RIDER

    # player id
    lbz REG_PLAYER_ID, 0x08 (r3)

    # get rider id
    lwz REG_RIDER_TABLE, OFST_RuntimeRiderSelection(rtoc)
    lbzx r3, REG_PLAYER_ID, REG_RIDER_TABLE

    restore
    blr

NOT_CUSTOM_RIDER:
    restore
    li r3, -1
    blr

################################################