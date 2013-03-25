#
# Standard N64 Makefile
#

# Name!
PRJNAME = hellworld
PARTS = $(PRJNAME).o

# Vars
INC_FLAGS = -I. -I../include
LIB_FLAGS = -L. -T mario64.x
ROOT = ..
N64ROOT = ../root
N64PREFIX = mips64-
N64BIN = ${N64ROOT}/bin

# Flags
NOBUILTIN=-fno-builtin
CFLAGS=-std=gnu99 -nodefaultlibs -march=vr4300 -mtune=vr4300 -mabi=32 ${INC_FLAGS}  $(NOBUILTIN) -o3
ASFLAGS = -march=vr4300 -mabi=32
LINK_FLAGS=${LIB_FLAGS} ${LIBS}

# Programs
CC      = $(N64BIN)/mips64-gcc
LD      = $(N64BIN)/mips64-ld
OBJCOPY = $(N64BIN)/mips64-objcopy
CHEAT   = $(N64BIN)/nemucheat
BINCODE = $(N64BIN)/bin2code

# Awwright
all: $(PRJNAME).bin
	$(BINCODE) $(PRJNAME).bin 80400000 codes.txt # Turn binary into GS code
	cat hook.txt codes.txt | $(CHEAT) "Mario 64" 0 > Cheats.ini # Turn into Nemu cheat

$(PRJNAME).bin: $(PRJNAME).elf
	$(OBJCOPY) $(PRJNAME).elf $(PRJNAME).bin -O binary

$(PRJNAME).elf: $(PARTS)
	$(LD) -o $(PRJNAME).elf	$(PARTS) $(LINK_FLAGS) 
	
clean:
	rm *.o *.elf *~ *.bin Cheats.ini codes.txt -vf
