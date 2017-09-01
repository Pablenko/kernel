TOOLCHAIN_DIR=/home/pablos/opt/cross/bin
CFLAGS=-std=gnu99 -ffreestanding -O2 -Wall -Wextra
LFLAGS=-nostdlib -lgcc

build_dir:
	mkdir build

clean:
	rm -rf build

boot_data:
	${TOOLCHAIN_DIR}/i686-elf-as boot.s -o build/boot.o

kernel_data:
	${TOOLCHAIN_DIR}/i686-elf-gcc -c kernel.c -o build/kernel.o ${CFLAGS}

all: clean build_dir boot_data kernel_data
	${TOOLCHAIN_DIR}/i686-elf-gcc -T linker.ld -o build/myos.bin ${CFLAGS} ${LFLAGS} build/boot.o build/kernel.o

run:
	qemu-system-i386 -kernel build/myos.bin
