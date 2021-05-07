nasm src/bootloader.asm -f bin -o bin/bootloader.bin
nasm src/ExtendedProgram.asm -f bin -o bin/ExtendedProgram.bin
cd bin
copy /b bootloader.bin+ExtendedProgram.bin bootloader.flp
qemu-system-x86_64 bootloader.flp
cd ../