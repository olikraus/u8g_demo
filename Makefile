#-ffunction-sections
#-fdata-sections
#-Wl,--gc-sections

SERIAL		:= /dev/ttyS0
BURNER		:= stk500v1
DEVICE		:= atmega328
PARTNO		:= m328p

CC		:= avr-gcc
CFLAGS		:= -mmcu=$(DEVICE) \
		   -Wa,-L \
		   -std=gnu99 \
		   -Os \
		   -Wall \
		   -fpack-struct \
		   -fshort-enums \
		   -funsigned-char \
		   -funsigned-bitfields \
		   -DF_CPU=8000000L \
		   -ffunction-sections \
		   -fdata-sections \
		   -Wl,--gc-sections \
		   -Wl,--relax \
		   -mcall-prologues
CPPFLAGS	:=
NAME		:= main

SRCS		:= $(wildcard *.c)
OBJS		:= $(SRCS:.c=.o)

all: $(OBJS)
	@echo [LD] $(NAME).elf
	@$(CC) -Wl,-Map,$(NAME).map $(CFLAGS) -o $(NAME).elf $(OBJS)
	@avr-objcopy -j .text -j .data -O ihex $(NAME).elf $(NAME).hex
	@avr-size $(NAME).elf

upload: all
	@avrdude -P $(SERIAL) -c $(BURNER) -p $(PARTNO) -U flash:w:$(NAME).hex

clean:
	@echo [RM] *.o
	@rm -rf $(OBJS)

%.o: %.c
	@echo [CC] $<
	@$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
