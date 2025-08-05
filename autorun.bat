@echo off
del /f /q "output\*" & for /d %%i in ("output\*") do rd /s /q "%%i"
nasm -f bin source/boot.asm -o output/boot.img
nasm -f bin source/main.asm -o output/main.bin
copy /b output\boot.img + output\main.bin output\floppy.img
qemu-system-x86_64.exe output/floppy.img
