@echo off
del /f /q "output\*" & for /d %%i in ("output\*") do rd /s /q "%%i"
nasm -f bin source/boot.asm -o output/boot.o
nasm -f bin source/main.asm -o output/main.o
i686-elf-gcc -m32 -ffreestanding -g -c source/kernel.c -o output/kernel.o
i686-elf-ld -T source/link.ld -m elf_i386 output/kernel.o -o output/kernel.elf
i686-elf-objcopy -O binary output/kernel.elf output/kernel.bin
copy /b output\boot.o + output\main.o + output\kernel.bin output\floppy.img
qemu-system-x86_64.exe -d int  output/floppy.img
