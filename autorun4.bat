@echo off
del /f /q output\* 2>nul
nasm -f bin source/boot.asm -o output/boot.bin
i686-elf-gcc -m32 -ffreestanding -c source/kernel.c -o output/kernel.o
i686-elf-ld -T source/link.ld -m elf_i386 output/kernel.o -o output/kernel.elf
i686-elf-objcopy -O binary output/kernel.elf output/kernel.bin

copy /b output\boot.bin + output\kernel.bin output\os.img

qemu-system-i386.exe -drive format=raw,file=output\os.img
