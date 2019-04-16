

LIB_STM32_DIR:= $(dir $(lastword $(MAKEFILE_LIST)))

COMPILER?=gcc

FAMILLY_UPPER=$(shell echo $(FAMILLY) | tr '[:lower:]' '[:upper:]')
DEVICE_UPPER=$(shell echo $(DEVICE) | tr '[:lower:]' '[:upper:]')
DEVICE_IC=$(DEVICE_UPPER)$(DEVICE_SUFFIX)

DEVICE_IC_LOWER=$(shell echo $(DEVICE_IC) | tr '[:upper:]' '[:lower:]')

LIB_STM32_TEMPLATES_DIR=$(LIB_STM32_DIR)/CMSIS/Device/ST/$(FAMILLY_UPPER)xx/Source/Templates
LIB_STM32_DRV_DIR=$(LIB_STM32_DIR)/STM32F0xx_HAL_Driver
LIB_STM32_CMSIS_DIR=$(LIB_STM32_DIR)/CMSIS

$(info *********************************)
$(info FAMILLY_UPPER:$(FAMILLY_UPPER)   )
$(info DEVICE_UPPER :$(DEVICE_UPPER)    )
$(info DEVICE_IC    :$(DEVICE_IC)       )
$(info COMPILER     :$(COMPILER)        )
$(info *********************************)

INCLUDEPATHS += \
        $(LIB_STM32_DIR)/CMSIS/Include \
        $(LIB_STM32_DIR)/CMSIS/Device/ST/$(FAMILLY_UPPER)xx/Include \
        $(LIB_STM32_DIR)/$(FAMILLY_UPPER)xx_HAL_Driver/Inc \

C_SRC += \
    $(LIB_STM32_TEMPLATES_DIR)/system_$(FAMILLY)xx.c \

S_SRC += \
    $(LIB_STM32_TEMPLATES_DIR)/$(COMPILER)/startup_$(DEVICE_IC_LOWER).s \

CFLAGS +=-D$(FAMILLY_UPPER)=1
CFLAGS += -mcpu=cortex-m0
CFLAGS += -mthumb 
CFLAGS += -D$(DEVICE_IC)=1 

LDFLAGS += -mcpu=cortex-m0
LDFLAGS += -mthumb 
LDFLAGS += -specs=nano.specs

