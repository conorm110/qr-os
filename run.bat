cd src
nasm bootloader.asm -f bin -o ../bin/bootloader.bin
nasm ExtendedProgram.asm -f bin -o ../bin/ExtendedProgram.bin
cd ../
cd bin
copy /b bootloader.bin+extendedprogram.bin bootloader.flp
qemu-system-x86_64 bootloader.flp
cd ../