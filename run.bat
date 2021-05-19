@echo off
cd src
nasm bootloader.asm -f bin -o ../bin/bootloader.bin
nasm ExtendedProgram.asm -f bin -o ../bin/ExtendedProgram.bin
cd ../
cd bin
copy /b bootloader.bin+extendedprogram.bin bootloader.flp
7z a -t7z out.7z bootloader.flp
cd ../
py -3 makecode.py
cd bin
qemu-system-x86_64 bootloader.flp
cd ../