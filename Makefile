NAME=sios

SHELL := /bin/bash
ASM=nasm

BUILD_DIR=build
SRC_DIR=src

#
# Floppy Disk
#
floppy: $(BUILD_DIR)/$(NAME).img
$(BUILD_DIR)/$(NAME).img: bootloader kernel
	- dd if=/dev/zero of=$(BUILD_DIR)/$(NAME).img bs=512 count=2880
	- /usr/sbin/mkfs.fat -F 12 -n "Simple-OS" $(BUILD_DIR)/$(NAME).img
	- dd if=$(BUILD_DIR)/bootloader.bin of=$(BUILD_DIR)/$(NAME).img conv=notrunc
	- mcopy -i $(BUILD_DIR)/$(NAME).img $(BUILD_DIR)/kernel.bin "::kernel.bin"
#
# Bootloader 
#
bootloader: $(BUILD_DIR)/bootloader.bin
$(BUILD_DIR)/bootloader.bin:
	- $(ASM) -f bin -o $(BUILD_DIR)/bootloader.bin $(SRC_DIR)/bootloader/boot.asm

#
# Kernel
#
kernel: $(BUILD_DIR)/kernel.bin
$(BUILD_DIR)/kernel.bin:
	- $(ASM) -f bin -o $(BUILD_DIR)/kernel.bin $(SRC_DIR)/kernel/main.asm

clean:
	rm -r $(BUILD_DIR)/*
