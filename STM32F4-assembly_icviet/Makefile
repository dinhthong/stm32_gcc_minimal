BUILD_OBJ=STM32F4
CC=arm-none-eabi-gcc
LD=arm-none-eabi-ld
OBJCOPY=arm-none-eabi-objcopy
OBJDUMP=arm-none-eabi-objdump

INC_DIR=inc
SRC_DIR=src
OUTPUT_DIR=OUTPUT_BUILD

LDSCRIPT=linker.lds

C_SRC=$(SRC_DIR)/main.c

A_SRC=$(SRC_DIR)/start.s

OBJS=$(C_SRC:$(SRC_DIR)/%.c=%.o)
OBJS+=$(A_SRC:$(SRC_DIR)/%.s=%.o)

OBJS_OUT+=$(OBJS:%.o=$(OUTPUT_DIR)/%.o)

CFLAGS=-mcpu=cortex-m4 -mtune=cortex-m4 -c -DUSE_FULL_ASSERT -mlong-calls -fdata-sections -funsigned-char -ffunction-sections -Wall -mfpu=neon -mfloat-abi=softfp -std=c11 -g -O2 -I$(INC_DIR)
LINKER_FLAGS=-Xlinker -o$(BUILD_OBJ).elf -Xlinker -M -Xlinker -Map=$(BUILD_OBJ).map -T$(LDSCRIPT)

all: $(OUTPUT_DIR) $(OBJS) build_elf_file build_bin_file create_disassembly

$(OUTPUT_DIR):
	@mkdir $@

%.o : $(SRC_DIR)/%.s
	@echo "ASM: $^"
	@$(CC) $(CFLAGS) $^ -o $(OUTPUT_DIR)/$@

%.o : $(SRC_DIR)/%.c
	@echo "C: $^"
	@$(CC) $(CFLAGS) $^ -o $(OUTPUT_DIR)/$@

build_elf_file:
	@echo "Build elf file: $(BUILD_OBJ).elf"
	@$(CC) $(CFLAGSA) $(OBJS_OUT) -nostartfiles $(LINKER_FLAGS)

build_bin_file:
	arm-none-eabi-objcopy -O binary ${BUILD_OBJ}.elf ${BUILD_OBJ}.bin 

create_disassembly:
	arm-none-eabi-objdump -D ${BUILD_OBJ}.elf > disassembly.txt

clean:
	@echo "clean"
	@rm -rf $(OUTPUT_DIR); rm -rf *.map; rm -rf *.elf; rm -rf *.bin; rm -rf *.txt;
