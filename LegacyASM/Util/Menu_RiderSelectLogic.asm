#To be inserted @ 800037e0
.include "../Common.s"
.include "../kex.s"

# r3=player_index
# r4=input
# r5=menu_vehicle_data pointer
# --r6=update color
# returns 1 if selection is made

.set REG_VALUE, 24
.set REG_RIDERCOUNT, 25
.set REG_RIDERSELECT, 26
.set REG_PLAYERINDEXBACKUP, 27

#########################################################
backup

    mr REG_PLAYERINDEXBACKUP, r3

    # load rider type from kex data
    lwz REG_RIDERSELECT, OFST_RiderTable(rtoc)
    lwz REG_RIDERCOUNT, 0x00(REG_RIDERSELECT)
    lwz REG_RIDERSELECT, 0x04(REG_RIDERSELECT)
    lbzx REG_VALUE, r3, REG_RIDERSELECT

    andi. r0, r4, 0x0020
    bne SELECTION_RIGHT

    andi. r0, r4, 0x0040
    bne SELECTION_LEFT

    b Exit

    SELECTION_RIGHT:
    addi REG_VALUE, REG_VALUE, 1
    cmpw REG_VALUE, REG_RIDERCOUNT
    bge WRAP_RIGHT
    b SELECTION_EXIT

    SELECTION_LEFT:
    subi REG_VALUE, REG_VALUE, 1
    cmpwi REG_VALUE, 0
    blt WRAP_LEFT
    b SELECTION_EXIT

    WRAP_RIGHT:
    li REG_VALUE, 0
    b SELECTION_EXIT

    WRAP_LEFT:
    mr REG_VALUE, REG_RIDERCOUNT
    subi REG_VALUE, REG_VALUE, 1
    b SELECTION_EXIT

    SELECTION_EXIT:
    stbx REG_VALUE, REG_PLAYERINDEXBACKUP, REG_RIDERSELECT

/*    # optional load color?
    cmpwi r6, 0
    beq Skip_Color

    # load default color param from kxdt
    mr r3, REG_VALUE
    mulli r3, r3, 4
    lwz REG_RIDERSELECT, OFST_RiderTable(rtoc)
    lwz REG_RIDERSELECT, 0x10(REG_RIDERSELECT)
    add r3, REG_RIDERSELECT, r3
    lwz r3, 0(r3)
    lbz r4, 0(r3)

    # store loaded value minus 1
    mr r3, REG_PLAYERINDEXBACKUP
    addi r3, r3, 0x51
    cmpwi r4, 0
    beq EdgeCase
    subi r4, r4, 2
    b StoreColor

    EdgeCase:
    subi r4, r4, 1

    StoreColor:
    stbx r4, r3, r5

    # update color
    mr r3, REG_PLAYERINDEXBACKUP
    li r4, 0x0 # add to index
    branchl r28, 0x80021654*/

    Skip_Color:
    li r3, 1

Exit:
restore
blr

#########################################################
