PROJECT_DIR:=.
STM_PERIPH=../STM32F4xx_DSP_StdPeriph_Lib_V1.8.0
OUTPUT_PATH=$(PROJECT_DIR)/build_output

CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy

CFLAGS = -g -O2 -Wall
# Linker file
CFLAGS += -T$(STM_PERIPH)/Project/STM32F4xx_StdPeriph_Templates/TrueSTUDIO/STM32F40_41xxx/STM32F417IG_FLASH.ld
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4 -mthumb-interwork
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
CFLAGS += --specs=nosys.specs
CFLAGS += -DUSE_STDPERIPH_DRIVER
CFLAGS += -DSTM32F40_41xxx #Update this to match your board.
CFLAGS += -I.
CFLAGS += -I./inc
CFLAGS += -I$(STM_PERIPH)/Libraries/STM32F4xx_StdPeriph_Driver/inc

#SRCS=toggle.c
SRCS=toggle_delay.c
SRCS += $(STM_PERIPH)/Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_gpio.c
SRCS += $(STM_PERIPH)/Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_rcc.c
SRCS += $(STM_PERIPH)/Project/STM32F4xx_StdPeriph_Templates/system_stm32f4xx.c
#SRCS += $(STM_PERIPH)/Libraries/CMSIS/Device/ST/STM32F4xx/Source/Templates/TrueSTUDIO/startup_stm32f40xx.s
SRCS += ./startup_stm32f40xx.s
.PHONY: toggle

all: clean toggle hex bin
	@echo "finished !"
toggle: toggle.elf

toggle.elf: $(SRCS)
	@echo "create output folder"
	mkdir $(OUTPUT_PATH)
	@echo "compile everything"
	$(CC) $(CFLAGS) $^ -o $(OUTPUT_PATH)/$@ 
#	$(OBJCOPY) -O binary $(OUTPUT_PATH)/toggle.elf $(OUTPUT_PATH)/toggle.bin
bin: $(OUTPUT_PATH)/toggle.elf
	$(OBJCOPY) -O binary $(OUTPUT_PATH)/toggle.elf $(OUTPUT_PATH)/toggle.bin
#determine prerequisite
hex: $(OUTPUT_PATH)/toggle.elf
	$(OBJCOPY) -O ihex $(OUTPUT_PATH)/toggle.elf $(OUTPUT_PATH)/toggle.hex

flash: clean toggle
	st-flash write $(OUTPUT_PATH)/toggle.bin 0x8000000

clean:
	@echo "remove build output folder"
	@rm -rf $(OUTPUT_PATH)
