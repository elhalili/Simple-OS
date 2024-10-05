NAME=sios

ASM=nasm

BUILD_DIR=build
SRC_DIR=src

$(BUILD_DIR)/$(NAME).img: $(BUILD_DIR)/$(NAME).bin
	cp $(BUILD_DIR)/$(NAME).bin $(BUILD_DIR)/$(NAME).img
	truncate -s 1440k $(BUILD_DIR)/$(NAME).img

$(BUILD_DIR)/$(NAME).bin: $(SRC_DIR)/main.asm
	nasm -f bin -o $(BUILD_DIR)/$(NAME).bin $(SRC_DIR)/main.asm


clean:
	rm -r $(BUILD_DIR)/*