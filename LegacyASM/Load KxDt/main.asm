#To be inserted @ 80410168
.include "../Common.s"
.include "../kex.s"

.set  REG_HeapLo,31
.set  REG_FileSize,28
.set  REG_File,27
.set  REG_HeapID,26
.set  REG_Archive,25
.set  REG_kexData,24

backup

#Check if file exists
  bl  FileName
  mflr  r3
  branchl r12,0x803c4ed4
  cmpwi r3,-1
  beq FileNotExist
  
# Init audio heap alloc callbacks
# this is usually done after InitComponent, but the file load func
# needs these callbacks
  load r3,0x80059d28
  load r4,0x80059d50
  branchl r12,0x804479d4

#Get size of KxDt.dat
  bl  FileName
  mflr  r3
  branchl r12,0x8005915c
  addi  REG_FileSize,r3,0
#Align
  addi  REG_FileSize,REG_FileSize,31
  rlwinm	REG_FileSize, REG_FileSize, 0, 0, 26
#Create heap of this size
  lwz	REG_HeapLo, 0x11B0 (r13)
  add r4,REG_HeapLo,REG_FileSize     #heap hi = start + filesize
  addi  r4,r4,32*5              #plus 96 for header
  mr  r3,REG_HeapLo                  #heap lo = start
  mr  REG_HeapLo,r4             #new start = heap hi
  branchl r12,0x803d3804
  mr  REG_HeapID,r3
#Alloc header
  li  r4,68
  branchl r12,0x803d360c
  mr  REG_Archive,r3
#Alloc from this heap
  mr  r3,REG_HeapID
  mr  r4,REG_FileSize
  branchl r12,0x803d360c
  mr  REG_File,r3
#Load file here
  bl  FileName
  mflr  r3
  mr r4, REG_File
  addi	r5, sp, 0x80
  branchl	r12,0x80059364
#Init Archive
  lwz r5,0x80(sp)
  mr  r3,REG_Archive   #store header
  mr  r4,REG_File      #file
  branchl r12,0x80059484
#Get symbol offset
  mr  r3,REG_Archive
  bl  SymbolName
  mflr  r4
  branchl r12,0x8041e390
  mr.  REG_kexData,r3
  beq SymbolNotExist
  stw REG_kexData,OFST_kexData(rtoc)

#Copy table pointers
.set  REG_Offsets,9
.set  REG_Count,8
.set  REG_currOffset,7
.set  REG_currArchOffset,6
  bl  rtocOffsets
  mflr  REG_Offsets
  subi  REG_Offsets,REG_Offsets,2
  li  REG_Count,0
CopyPointers_Loop:
#Get offset of rtoc
  mulli REG_currOffset,REG_Count,4
CopyPointers_InitWalkLoop:
#If no more, exit
  lhz r3,0x2(REG_Offsets)
  extsh r3,r3
  cmpwi r3,-1
  beq CopyPointers_Exit
  mr  REG_currArchOffset,REG_kexData
CopyPointers_WalkLoop:
#Get bottom of chain
  lhzu  r3,0x2(REG_Offsets)
  extsh r3,r3
  cmpwi r3,-1
  beq CopyPointers_WalkLoopExit
#Access pointer
  lwzx  REG_currArchOffset,r3,REG_currArchOffset
  b CopyPointers_WalkLoop
CopyPointers_WalkLoopExit:
#Store to
  stwx  REG_currArchOffset,REG_currOffset,rtoc
CopyPointers_IncLoop:
  addi  REG_Count,REG_Count,1
  b CopyPointers_Loop
CopyPointers_Exit:

  b Exit

FileName:
blrl
.string "KxDt.dat"
.align 2
SymbolName:
blrl
.string "kexData"
.align 2
Assert_Name:
blrl
.string "k-ex"
.align 2
NoFileString:
blrl
.string "Error: %s not found on disc\n"
.align 2
NoSymbolString:
blrl
.string "Error: symbol %s not found in %s\n"
.align 2

FileNotExist:
#OSReport
  bl  NoFileString
  mflr  r3
  bl FileName
  mflr r4
  branchl r12,0x803d4ce8
  b Assert

SymbolNotExist:
#OSReport
  bl  NoSymbolString
  mflr  r3
  bl SymbolName
  mflr r4
  bl FileName
  mflr r5
  branchl r12,0x803d4ce8
  b Assert

Assert:
#Assert
  bl  Assert_Name
  mflr  r3
  li  r4,0
  load  r5,0x805d73b8
  branchl r12,0x804284b8

rtocOffsets:
  blrl
  #indexed by rtoc order
  .hword Arch_VehicleTable,Arch_VehicleMetaData,-1
  .hword Arch_VehicleTable,Arch_VehicleArchiveStrings,-1
  .hword Arch_VehicleTable,Arch_VehicleArchiveRuntimes,-1
  .hword Arch_VehicleTable,Arch_VehicleFunctions1,-1
  .hword Arch_VehicleTable,Arch_VehicleFunctions2,-1
  .hword Arch_VehicleTable,Arch_SelectVehicleIDs,-1
  .hword Arch_VehicleTable,Arch_SelectVehicle3ByteTable,-1
  .hword Arch_VehicleTable,Arch_SelectVehicleSISNameIndex,-1
  .hword Arch_VehicleTable,Arch_SelectVehicleSISDescIndex,-1
  .hword Arch_MusicTable,-1
  .hword Arch_RiderTable,-1
  .hword Arch_RiderTable,Arch_RiderRuntimeSelection,-1
  .hword Arch_RiderTable,Arch_RiderSymbolRuntime,-1
  .hword Arch_RiderTable,Arch_RiderFunctionRuntime,-1
  .hword Arch_RiderTable,Arch_RiderParams,-1
  .hword Arch_RiderFunctionTable,-1
  .hword Arch_RiderFunctionTable,Arch_StateLogicTable,-1
  .hword  -1
  .align 2
  
Exit:
# Update heap low
  stw	REG_HeapLo, 0x11B0 (r13)
  restore
  lwz	r3, 0x11B0 (r13)
  lwz	r4, 0x11B4 (r13)