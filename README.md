to run on linux/ubuntu just do: 

nasm -f bin bootloader.asm -o bootloader.bin
nasm -f bin kernel.asm -o kernel.bin
dd if=/dev/zero of=disk.img bs=512 count=2880
dd if=bootloader.bin of=disk.img bs=512 count=1 conv=notrunc
dd if=kernel.bin of=disk.img bs=512 seek=1 count=1 conv=notrunc
qemu-system-x86_64 -drive format=raw,file=disk.img -no-reboot

requirements: have NASM, gcc and qemu

thanks ;)
