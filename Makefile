# Definindo variáveis
NASM = nasm
QEMU = qemu-system-x86_64
DD = dd
IMG = disk.img
BOOTLOADER = bootloader.asm
KERNEL = kernel.asm
BOOTLOADER_BIN = bootloader.bin
KERNEL_BIN = kernel.bin

# Regra padrão para compilar tudo e rodar o QEMU
all: $(IMG)
	$(QEMU) -drive format=raw,file=$(IMG) -no-reboot

# Compilar bootloader.asm para bootloader.bin
$(BOOTLOADER_BIN): $(BOOTLOADER)
	$(NASM) -f bin $(BOOTLOADER) -o $(BOOTLOADER_BIN)

# Compilar kernel.asm para kernel.bin
$(KERNEL_BIN): $(KERNEL)
	$(NASM) -f bin $(KERNEL) -o $(KERNEL_BIN)

# Criar a imagem do disco
$(IMG): $(BOOTLOADER_BIN) $(KERNEL_BIN)
	$(DD) if=/dev/zero of=$(IMG) bs=512 count=2880
	$(DD) if=$(BOOTLOADER_BIN) of=$(IMG) bs=512 count=1 conv=notrunc
	$(DD) if=$(KERNEL_BIN) of=$(IMG) bs=512 seek=1 count=1 conv=notrunc

# Limpeza dos arquivos temporários
clean:
	rm -f $(BOOTLOADER_BIN) $(KERNEL_BIN) $(IMG)
