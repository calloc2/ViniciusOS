@echo off
del /f /q "C:\Users\suliv\Desktop\ViniciusOS\output\*" & for /d %%i in ("C:\Users\suliv\Desktop\ViniciusOS\output\*") do rd /s /q "%%i"
nasm -f bin source/boot.asm -o output/boot.o
nasm -f bin source/main.asm -o output/main.o
copy /b output\boot.o + output\main.o output\floppy.img
qemu-system-x86_64.exe output/floppy.img
