#To be inserted @ 801c857c
.include "../Common.s"
.include "../kex.s"

cmpw r3,0x13

backup

    lwz r24,OFST_VehicleMetadata(rtoc)
    lwz r24,0x00(r24)

    cmpw r3, r24
    bge IsWheel

# Is Star
    li r0,0x0
    stw r0,0x0(r4)
    stb r3,0x0(r5)
    b Return

IsWheel:
    li r6, 0x1
    sub r0, r3, r24
    stw r6, 0x0(r4)
    stb r0, 0x0(r5)
    b Return

Return:
restore
branch r0, 0x801c85a4