CROSS_COMPILE = arm-none-eabi-

CC            = $(CROSS_COMPILE)gcc
AS            = $(CROSS_COMPILE)as
LD            = $(CROSS_COMPILE)ld
OBJCOPY       = $(CROSS_COMPILE)objcopy
STL           = st-flash

CFLAGS += -mthumb -Wall -Werror -O0 -mcpu=cortex-m3 -ggdb -nodefaultlibs
CLFAGS += -nostdlib -nostartfiles -ffreestanding

all: app.bin

crt.o: crt.s
	$(AS) -o crt.o crt.s

main.o: main.c
	$(CC) $(CFLAGS) -c -o main.o main.c

app.elf: linker.ld crt.o main.o
	$(LD) -T linker.ld -o app.elf crt.o main.o

app.bin: app.elf
	$(OBJCOPY) -O binary app.elf app.bin

clean:
	rm -f *.o *.elf *.bin

flash: app.bin
	$(STL) write app.bin 0x8000000

erase:
	$(STL) erase