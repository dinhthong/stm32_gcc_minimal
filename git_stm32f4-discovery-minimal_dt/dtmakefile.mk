SRCS=toggle.c

STM_PERIPH=STM32F4xx_DSP_StdPeriph_Lib_V1.8.0

CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy
OBJDUMP=arm-none-eabi-objdump

CFLAGS = -g -O2 -Wall 
CFLAGS += -T./STM32F417IG_FLASH.ld
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4 -mthumb-interwork
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
CFLAGS += --specs=nosys.specs
CFLAGS += -DUSE_STDPERIPH_DRIVER
CFLAGS += -DSTM32F40_41xxx
CFLAGS += -I.
CFLAGS += -I$(STM_PERIPH)/Libraries/CMSIS/Include
CFLAGS += -I$(STM_PERIPH)/Libraries/CMSIS/Device/ST/STM32F4xx/Include
CFLAGS += -I$(STM_PERIPH)/Libraries/STM32F4xx_StdPeriph_Driver/inc
CFLAGS += -I$(STM_PERIPH)/Project/STM32F4xx_StdPeriph_Templates

SRCS += $(STM_PERIPH)/Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_gpio.c
SRCS += $(STM_PERIPH)/Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_rcc.c
SRCS += $(STM_PERIPH)/Project/STM32F4xx_StdPeriph_Templates/system_stm32f4xx.c
SRCS += ./startup_stm32f40xx.s

.PHONY: dttoggle

all: dttoggle

dttoggle: dttoggle.elf
	@echo "create disassembly file"
	$(OBJDUMP) -D $< > disassembly.txt
# create_disassembly:	dttoggle.elf
	
dttoggle.elf: $(SRCS)
	#@echo "hello print $(SRCS)" # to see what happen ... under the hood
	$(CC) $(CFLAGS) $^ -o $@ 
	@echo "hello print $^ $@"
	$(OBJCOPY) -O binary $@ dttoggle.bin

flash: dttoggle
	st-flash write dttoggle.bin 0x8000000

clean:
	rm -f dttoggle.elf dttoggle.bin disassembly.txt
