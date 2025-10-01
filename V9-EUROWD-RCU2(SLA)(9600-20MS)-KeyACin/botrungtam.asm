_xuat_32bit:
;init.c,2 :: 		void xuat_32bit(unsigned long data_dich){
MOV	R1, R0
; data_dich start address is: 4 (R1)
;init.c,3 :: 		unsigned char vt_dich=32;
MOVS	R0, #32
;init.c,4 :: 		unsigned long shift_data=data_dich;
; shift_data start address is: 12 (R3)
MOV	R3, R1
; data_dich end address is: 4 (R1)
;init.c,5 :: 		OE=1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
; shift_data end address is: 12 (R3)
UXTB	R2, R0
MOV	R0, R3
;init.c,6 :: 		do{
IT	AL
BAL	L_xuat_32bit0
L__xuat_32bit187:
;init.c,11 :: 		}while(vt_dich>0);
UXTB	R2, R3
;init.c,6 :: 		do{
L_xuat_32bit0:
;init.c,7 :: 		vt_dich--;
; vt_dich start address is: 8 (R2)
SUBS	R1, R2, #1
UXTB	R1, R1
; vt_dich end address is: 8 (R2)
; vt_dich start address is: 12 (R3)
UXTB	R3, R1
;init.c,8 :: 		DS=(shift_data>>vt_dich);
LSR	R2, R0, R1
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
;init.c,9 :: 		xung_dich
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
STR	R2, [R1, #0]
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
STR	R2, [R1, #0]
;init.c,10 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_xuat_32bit3:
SUBS	R7, R7, #1
BNE	L_xuat_32bit3
NOP
NOP
NOP
;init.c,11 :: 		}while(vt_dich>0);
CMP	R3, #0
IT	HI
BHI	L__xuat_32bit187
; vt_dich end address is: 12 (R3)
;init.c,12 :: 		OE=0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
;init.c,13 :: 		xung_xuat
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
;init.c,14 :: 		Delay_us(10);
MOVW	R7, #119
MOVT	R7, #0
NOP
NOP
L_xuat_32bit5:
SUBS	R7, R7, #1
BNE	L_xuat_32bit5
NOP
NOP
NOP
;init.c,15 :: 		}
L_end_xuat_32bit:
BX	LR
; end of _xuat_32bit
_timer1_init:
;init.c,17 :: 		void timer1_init(){ //20 ms
;init.c,18 :: 		TIM1_CR1bits.DIR_=0;  // directon 0:upcounter, 1: down
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_CR1bits+0)
MOVT	R0, #hi_addr(TIM1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,19 :: 		TIM1_CR1bits.ARPE=0; // auto-reload Preload Enable
MOVW	R0, #lo_addr(TIM1_CR1bits+0)
MOVT	R0, #hi_addr(TIM1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,20 :: 		TIM1_CR1bits.OPM=0;     // one pulse mode / 0: counter non-stop; 1: stop when CEN bit clear
MOVW	R0, #lo_addr(TIM1_CR1bits+0)
MOVT	R0, #hi_addr(TIM1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,21 :: 		TIM1_PSC=10000;  // PRESCALE VALUE(16bit)  frequency = Fclk/(PSC+1)
MOVW	R1, #10000
MOVW	R0, #lo_addr(TIM1_PSC+0)
MOVT	R0, #hi_addr(TIM1_PSC+0)
STR	R1, [R0, #0]
;init.c,22 :: 		TIM1_ARR=144;    // AUTO-RELOAD VALUE
MOVS	R1, #144
MOVW	R0, #lo_addr(TIM1_ARR+0)
MOVT	R0, #hi_addr(TIM1_ARR+0)
STR	R1, [R0, #0]
;init.c,25 :: 		TIM1_CNT=0;      // counter value
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM1_CNT+0)
MOVT	R0, #hi_addr(TIM1_CNT+0)
STR	R1, [R0, #0]
;init.c,26 :: 		TIM1_DIERbits.UIE=1;  // DMA interrup enable Register  - UIE: update interrup enable
MOVS	R3, #1
SXTB	R3, R3
MOVW	R0, #lo_addr(TIM1_DIERbits+0)
MOVT	R0, #hi_addr(TIM1_DIERbits+0)
STR	R3, [R0, #0]
;init.c,27 :: 		NVIC_SETENA0bits.SETENA25=1;
MOVW	R1, #lo_addr(NVIC_SETENA0bits+0)
MOVT	R1, #hi_addr(NVIC_SETENA0bits+0)
LDR	R0, [R1, #0]
BFI	R0, R3, #25, #1
STR	R0, [R1, #0]
;init.c,28 :: 		NVIC_IP6bits.PRI_25=0x00;
MOVS	R2, #0
MOVW	R1, #lo_addr(NVIC_IP6bits+0)
MOVT	R1, #hi_addr(NVIC_IP6bits+0)
LDRH	R0, [R1, #0]
BFI	R0, R2, #8, #8
STRH	R0, [R1, #0]
;init.c,29 :: 		TIM1_CR1bits.CEN=1;    //1 enable counter
MOVW	R0, #lo_addr(TIM1_CR1bits+0)
MOVT	R0, #hi_addr(TIM1_CR1bits+0)
STR	R3, [R0, #0]
;init.c,30 :: 		NVIC_IP8bits.PRI_32=0xf0; // priority
MOVS	R2, #240
MOVW	R1, #lo_addr(NVIC_IP8bits+0)
MOVT	R1, #hi_addr(NVIC_IP8bits+0)
LDRB	R0, [R1, #0]
BFI	R0, R2, #0, #8
STRB	R0, [R1, #0]
;init.c,31 :: 		}
L_end_timer1_init:
BX	LR
; end of _timer1_init
_usart1_init:
;init.c,33 :: 		void usart1_init(){
;init.c,34 :: 		USART1_CR1bits.UE=1; // enable uart1
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R2, [R0, #0]
;init.c,35 :: 		USART1_CR1bits.M=0;  // 8bit data
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,36 :: 		USART1_CR1bits.PCE=0; // no parity
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,37 :: 		USART1_CR1bits.RXNEIE=1;// enable interrupt receiver
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R2, [R0, #0]
;init.c,38 :: 		USART1_CR1bits.RE=1; // enable receiver
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R2, [R0, #0]
;init.c,39 :: 		USART1_CR1bits.TE=1;  //enable transmitter
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R2, [R0, #0]
;init.c,40 :: 		USART1_BRR=0X1D4C;    // bauld=9600;
MOVW	R1, #7500
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;init.c,41 :: 		USART1_CR2=0;   // 1 stop bit
MOVS	R1, #0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;init.c,42 :: 		USART1_CR3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;init.c,44 :: 		NVIC_SETENA1bits.SETENA37=1; //enable interrupt usart
MOVW	R1, #lo_addr(NVIC_SETENA1bits+0)
MOVT	R1, #hi_addr(NVIC_SETENA1bits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #5, #1
STR	R0, [R1, #0]
;init.c,45 :: 		NVIC_IP11bits.PRI_44=0x10; // priority
MOVS	R2, #16
MOVW	R1, #lo_addr(NVIC_IP11bits+0)
MOVT	R1, #hi_addr(NVIC_IP11bits+0)
LDRB	R0, [R1, #0]
BFI	R0, R2, #0, #8
STRB	R0, [R1, #0]
;init.c,46 :: 		}
L_end_usart1_init:
BX	LR
; end of _usart1_init
_uart1_chr:
;init.c,48 :: 		void uart1_chr(unsigned char data_usart1_tx){
;init.c,49 :: 		while(USART1_SRbits.TC==0);
L_uart1_chr7:
MOVW	R2, #lo_addr(USART1_SRbits+0)
MOVT	R2, #hi_addr(USART1_SRbits+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_uart1_chr8
IT	AL
BAL	L_uart1_chr7
L_uart1_chr8:
;init.c,50 :: 		USART1_DRbits.DR=data_usart1_tx;
UXTB	R3, R0
MOVW	R2, #lo_addr(USART1_DRbits+0)
MOVT	R2, #hi_addr(USART1_DRbits+0)
LDRH	R1, [R2, #0]
BFI	R1, R3, #0, #9
STRH	R1, [R2, #0]
;init.c,51 :: 		}
L_end_uart1_chr:
BX	LR
; end of _uart1_chr
_uart1_string:
;init.c,52 :: 		void uart1_string(unsigned char *s){
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R4, R0
;init.c,53 :: 		while(*s){
L_uart1_string9:
; s start address is: 16 (R4)
LDRB	R1, [R4, #0]
CMP	R1, #0
IT	EQ
BEQ	L_uart1_string10
;init.c,54 :: 		uart1_chr(*s++);
LDRB	R1, [R4, #0]
UXTB	R0, R1
BL	_uart1_chr+0
ADDS	R4, R4, #1
;init.c,55 :: 		}
; s end address is: 16 (R4)
IT	AL
BAL	L_uart1_string9
L_uart1_string10:
;init.c,56 :: 		}
L_end_uart1_string:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _uart1_string
_uart4__init:
;init.c,58 :: 		void uart4__init(){
;init.c,60 :: 		UART4_CR1bits.UE=1; // enable uart1
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R2, [R0, #0]
;init.c,61 :: 		UART4_CR1bits.M=0;  // 8bit data
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R1, [R0, #0]
;init.c,62 :: 		UART4_CR1bits.PCE=0; // no parity
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R1, [R0, #0]
;init.c,63 :: 		UART4_CR1bits.RXNEIE=1;// enable interrupt receiver
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R2, [R0, #0]
;init.c,64 :: 		UART4_CR1bits.RE=1; // enable receiver
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R2, [R0, #0]
;init.c,65 :: 		UART4_CR1bits.TE=1;  //enable transmitter
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R2, [R0, #0]
;init.c,66 :: 		UART4_BRR=0X1D4C;   // bauld=9600;
MOVW	R1, #7500
MOVW	R0, #lo_addr(UART4_BRR+0)
MOVT	R0, #hi_addr(UART4_BRR+0)
STR	R1, [R0, #0]
;init.c,69 :: 		UART4_CR2=0;   // 1 stop bit
MOVS	R1, #0
MOVW	R0, #lo_addr(UART4_CR2+0)
MOVT	R0, #hi_addr(UART4_CR2+0)
STR	R1, [R0, #0]
;init.c,70 :: 		UART4_CR3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(UART4_CR3+0)
MOVT	R0, #hi_addr(UART4_CR3+0)
STR	R1, [R0, #0]
;init.c,72 :: 		NVIC_SETENA1bits.SETENA52=1; //enable interrupt usart
MOVW	R1, #lo_addr(NVIC_SETENA1bits+0)
MOVT	R1, #hi_addr(NVIC_SETENA1bits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #20, #1
STR	R0, [R1, #0]
;init.c,73 :: 		NVIC_IP14bits.PRI_59=0x00; // priority
MOVS	R2, #0
MOVW	R1, #lo_addr(NVIC_IP14bits+0)
MOVT	R1, #hi_addr(NVIC_IP14bits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #24, #8
STR	R0, [R1, #0]
;init.c,74 :: 		}
L_end_uart4__init:
BX	LR
; end of _uart4__init
_uart4_chr:
;init.c,76 :: 		void uart4_chr(unsigned char data_usart4_tx){
;init.c,77 :: 		while(UART4_SRbits.TC==0);
L_uart4_chr11:
MOVW	R2, #lo_addr(UART4_SRbits+0)
MOVT	R2, #hi_addr(UART4_SRbits+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_uart4_chr12
IT	AL
BAL	L_uart4_chr11
L_uart4_chr12:
;init.c,78 :: 		UART4_DRbits.DR=data_usart4_tx;
UXTB	R3, R0
MOVW	R2, #lo_addr(UART4_DRbits+0)
MOVT	R2, #hi_addr(UART4_DRbits+0)
LDRH	R1, [R2, #0]
BFI	R1, R3, #0, #9
STRH	R1, [R2, #0]
;init.c,79 :: 		}
L_end_uart4_chr:
BX	LR
; end of _uart4_chr
_rs485_u4:
;init.c,81 :: 		void rs485_u4(unsigned char buf_rs4[],unsigned int count_buf){
; count_buf start address is: 4 (R1)
; count_buf end address is: 4 (R1)
; count_buf start address is: 4 (R1)
;init.c,82 :: 		unsigned char i = 0;
;init.c,83 :: 		UART4_CR1bits.RE=0;
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(UART4_CR1bits+0)
MOVT	R2, #hi_addr(UART4_CR1bits+0)
STR	R3, [R2, #0]
;init.c,84 :: 		TRAN_4
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
STR	R3, [R2, #0]
;init.c,85 :: 		for (i = 0; i < count_buf; i++) {
; i start address is: 20 (R5)
MOVS	R5, #0
; count_buf end address is: 4 (R1)
; i end address is: 20 (R5)
L_rs485_u413:
; i start address is: 20 (R5)
; count_buf start address is: 4 (R1)
CMP	R5, R1
IT	CS
BCS	L_rs485_u414
; count_buf end address is: 4 (R1)
; i end address is: 20 (R5)
;init.c,86 :: 		while(UART4_SRbits.TC==0);
L_rs485_u416:
; count_buf start address is: 4 (R1)
; i start address is: 20 (R5)
MOVW	R3, #lo_addr(UART4_SRbits+0)
MOVT	R3, #hi_addr(UART4_SRbits+0)
LDR	R2, [R3, #0]
CMP	R2, #0
IT	NE
BNE	L_rs485_u417
IT	AL
BAL	L_rs485_u416
L_rs485_u417:
;init.c,87 :: 		UART4_DRbits.DR = buf_rs4[i];
ADDS	R2, R0, R5
LDRB	R2, [R2, #0]
UXTB	R4, R2
MOVW	R3, #lo_addr(UART4_DRbits+0)
MOVT	R3, #hi_addr(UART4_DRbits+0)
LDRH	R2, [R3, #0]
BFI	R2, R4, #0, #9
STRH	R2, [R3, #0]
;init.c,85 :: 		for (i = 0; i < count_buf; i++) {
ADDS	R5, R5, #1
UXTB	R5, R5
;init.c,89 :: 		}
; count_buf end address is: 4 (R1)
; i end address is: 20 (R5)
IT	AL
BAL	L_rs485_u413
L_rs485_u414:
;init.c,90 :: 		while(UART4_SRbits.TC==0);
L_rs485_u418:
MOVW	R3, #lo_addr(UART4_SRbits+0)
MOVT	R3, #hi_addr(UART4_SRbits+0)
LDR	R2, [R3, #0]
CMP	R2, #0
IT	NE
BNE	L_rs485_u419
IT	AL
BAL	L_rs485_u418
L_rs485_u419:
;init.c,91 :: 		REC_4
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
STR	R3, [R2, #0]
;init.c,92 :: 		UART4_CR1bits.RE=1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(UART4_CR1bits+0)
MOVT	R2, #hi_addr(UART4_CR1bits+0)
STR	R3, [R2, #0]
;init.c,93 :: 		}
L_end_rs485_u4:
BX	LR
; end of _rs485_u4
_uart4_string:
;init.c,95 :: 		void uart4_string(unsigned char *s){
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R4, R0
;init.c,96 :: 		while(*s){
L_uart4_string20:
; s start address is: 16 (R4)
LDRB	R1, [R4, #0]
CMP	R1, #0
IT	EQ
BEQ	L_uart4_string21
;init.c,97 :: 		uart4_chr(*s++);
LDRB	R1, [R4, #0]
UXTB	R0, R1
BL	_uart4_chr+0
ADDS	R4, R4, #1
;init.c,98 :: 		}
; s end address is: 16 (R4)
IT	AL
BAL	L_uart4_string20
L_uart4_string21:
;init.c,99 :: 		}
L_end_uart4_string:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _uart4_string
_usart2_init:
;init.c,101 :: 		void usart2_init(){
;init.c,102 :: 		USART2_CR1bits.UE=1; // enable uart1
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R2, [R0, #0]
;init.c,103 :: 		USART2_BRR=0X1D4C;    // bauld=9600;
MOVW	R1, #7500
MOVW	R0, #lo_addr(USART2_BRR+0)
MOVT	R0, #hi_addr(USART2_BRR+0)
STR	R1, [R0, #0]
;init.c,104 :: 		USART2_CR1bits.M=0;  // 8bit data
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R1, [R0, #0]
;init.c,105 :: 		USART2_CR1bits.PCE=0; // no parity
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R1, [R0, #0]
;init.c,106 :: 		USART2_CR1bits.RXNEIE=1;// enable interrupt receiver
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R2, [R0, #0]
;init.c,107 :: 		USART2_CR1bits.RE=1; // enable receiver
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R2, [R0, #0]
;init.c,108 :: 		USART2_CR1bits.TE=1;  //enable transmitter
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R2, [R0, #0]
;init.c,109 :: 		USART2_CR2=0;   // 1 stop bit
MOVS	R1, #0
MOVW	R0, #lo_addr(USART2_CR2+0)
MOVT	R0, #hi_addr(USART2_CR2+0)
STR	R1, [R0, #0]
;init.c,110 :: 		USART2_CR3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(USART2_CR3+0)
MOVT	R0, #hi_addr(USART2_CR3+0)
STR	R1, [R0, #0]
;init.c,114 :: 		}
L_end_usart2_init:
BX	LR
; end of _usart2_init
_uart2_chr:
;init.c,116 :: 		void uart2_chr(unsigned char data_usart2_tx){
;init.c,117 :: 		while(USART2_SRbits.TC==0);
L_uart2_chr22:
MOVW	R2, #lo_addr(USART2_SRbits+0)
MOVT	R2, #hi_addr(USART2_SRbits+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_uart2_chr23
IT	AL
BAL	L_uart2_chr22
L_uart2_chr23:
;init.c,118 :: 		USART2_DR=data_usart2_tx;
MOVW	R1, #lo_addr(USART2_DR+0)
MOVT	R1, #hi_addr(USART2_DR+0)
STR	R0, [R1, #0]
;init.c,119 :: 		}
L_end_uart2_chr:
BX	LR
; end of _uart2_chr
_uart2_string:
;init.c,120 :: 		void uart2_string(unsigned char *s){
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R3, R0
;init.c,121 :: 		while(*s){
L_uart2_string24:
; s start address is: 12 (R3)
LDRB	R1, [R3, #0]
CMP	R1, #0
IT	EQ
BEQ	L_uart2_string25
;init.c,122 :: 		uart2_chr(*s++);
LDRB	R1, [R3, #0]
UXTB	R0, R1
BL	_uart2_chr+0
ADDS	R3, R3, #1
;init.c,123 :: 		}
; s end address is: 12 (R3)
IT	AL
BAL	L_uart2_string24
L_uart2_string25:
;init.c,124 :: 		}
L_end_uart2_string:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _uart2_string
_set_value_dim:
;init.c,126 :: 		void set_value_dim(unsigned char value_dim,unsigned char channel){
; channel start address is: 4 (R1)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; channel end address is: 4 (R1)
; channel start address is: 4 (R1)
;init.c,127 :: 		unsigned char data_dim[3]={0xfa,0x00,0x00},k;
MOVS	R2, #250
STRB	R2, [SP, #4]
MOVS	R2, #0
STRB	R2, [SP, #5]
MOVS	R2, #0
STRB	R2, [SP, #6]
;init.c,128 :: 		data_dim[1]=channel;
ADD	R3, SP, #4
ADDS	R2, R3, #1
STRB	R1, [R2, #0]
; channel end address is: 4 (R1)
;init.c,129 :: 		data_dim[2]=value_dim;
ADDS	R2, R3, #2
STRB	R0, [R2, #0]
;init.c,130 :: 		for(k=0;k<3;k++){
; k start address is: 12 (R3)
MOVS	R3, #0
; k end address is: 12 (R3)
L_set_value_dim26:
; k start address is: 12 (R3)
CMP	R3, #3
IT	CS
BCS	L_set_value_dim27
;init.c,131 :: 		uart2_chr(data_dim[k]);
ADD	R2, SP, #4
ADDS	R2, R2, R3
LDRB	R2, [R2, #0]
UXTB	R0, R2
BL	_uart2_chr+0
;init.c,130 :: 		for(k=0;k<3;k++){
ADDS	R3, R3, #1
UXTB	R3, R3
;init.c,132 :: 		}
; k end address is: 12 (R3)
IT	AL
BAL	L_set_value_dim26
L_set_value_dim27:
;init.c,133 :: 		}
L_end_set_value_dim:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _set_value_dim
_gpio_init:
;init.c,135 :: 		void gpio_init(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;init.c,136 :: 		RCC_APB2ENR=(1<<AFIOEN)|(1<<IOPAEN)|(1<<IOPBEN)|(1<<IOPCEN)|(1<<IOPDEN)|(1<<IOPEEN)|(1<<TIM1EN)|(1<<SPI1EN)|(1<<USART1EN);
MOVW	R1, #22653
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;init.c,137 :: 		RCC_APB1ENR=(1<<UART4EN)|(1<<USART2EN);
MOV	R1, #655360
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;init.c,139 :: 		AFIO_MAPR|=0x02000000;
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #33554432
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;init.c,141 :: 		GPIOA_CRL&=0xffff0000;
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #65535
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;init.c,142 :: 		GPIOA_CRL|=0x00004938;
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #18744
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;init.c,143 :: 		GPIOA_CRH&=0x0ff00000;
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
AND	R1, R0, #267386880
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;init.c,144 :: 		GPIOA_CRH|=0x30003490;
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #13456
MOVT	R0, #12288
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;init.c,145 :: 		GPIOA_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;init.c,146 :: 		GPIOA_ODR|=0B0000000000000001;
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;init.c,148 :: 		GPIOB_CRL&=0x00fff000;
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #61440
MOVT	R0, #255
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;init.c,149 :: 		GPIOB_CRL|=0x38000383;
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #899
MOVT	R0, #14336
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;init.c,150 :: 		GPIOB_CRH=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOB_CRH+0)
MOVT	R0, #hi_addr(GPIOB_CRH+0)
STR	R1, [R0, #0]
;init.c,151 :: 		GPIOB_CRH|=0x83838338;
MOVW	R0, #lo_addr(GPIOB_CRH+0)
MOVT	R0, #hi_addr(GPIOB_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #33592
MOVT	R0, #33667
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOB_CRH+0)
MOVT	R0, #hi_addr(GPIOB_CRH+0)
STR	R1, [R0, #0]
;init.c,152 :: 		GPIOB_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;init.c,153 :: 		GPIOB_ODR|=0B1010100101000010;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R1, [R0, #0]
MOVW	R0, #43330
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;init.c,155 :: 		GPIOC_CRL&=0x000f0000;
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
LDR	R0, [R0, #0]
AND	R1, R0, #983040
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;init.c,156 :: 		GPIOC_CRL|=0x83803838;
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #14392
MOVT	R0, #33664
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;init.c,157 :: 		GPIOC_CRH&=0xff0000f0;
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #240
MOVT	R0, #65280
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;init.c,158 :: 		GPIOC_CRH|=0x00234903;
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #18691
MOVT	R0, #35
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;init.c,159 :: 		GPIOC_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;init.c,160 :: 		GPIOC_ODR|=0B0000000010100101;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #165
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;init.c,162 :: 		GPIOD_CRL&=0xff000000;
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
AND	R1, R0, #-16777216
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;init.c,163 :: 		GPIOD_CRL|=0x00833333;
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #13107
MOVT	R0, #131
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;init.c,164 :: 		GPIOD_CRH=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;init.c,165 :: 		GPIOD_CRH|=0x83838383;
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #-2088533117
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;init.c,166 :: 		GPIOD_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;init.c,167 :: 		GPIOD_ODR|=0B1010101000100000;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R1, [R0, #0]
MOVW	R0, #43552
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;init.c,169 :: 		GPIOE_CRL=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;init.c,170 :: 		GPIOE_CRL|=0x88383838;
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #14392
MOVT	R0, #34872
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;init.c,171 :: 		GPIOE_CRH=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;init.c,172 :: 		GPIOE_CRH|=0x83838383;
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #-2088533117
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;init.c,173 :: 		GPIOE_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;init.c,174 :: 		GPIOE_ODR|=0B1010101011010101;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
LDR	R1, [R0, #0]
MOVW	R0, #43733
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;init.c,175 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_7);
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;init.c,176 :: 		}
L_end_gpio_init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _gpio_init
_chuoi_so:
;init.c,177 :: 		unsigned long chuoi_so(unsigned char *so,unsigned char vt_bd,unsigned char vt_kt){
; vt_kt start address is: 8 (R2)
; vt_bd start address is: 4 (R1)
UXTB	R3, R2
; vt_kt end address is: 8 (R2)
; vt_bd end address is: 4 (R1)
; vt_bd start address is: 4 (R1)
; vt_kt start address is: 12 (R3)
;init.c,180 :: 		gt_so=0;
; gt_so start address is: 20 (R5)
MOVS	R5, #0
;init.c,181 :: 		for(sb=vt_bd;sb<=vt_kt;sb++){
; sb start address is: 8 (R2)
UXTB	R2, R1
; vt_bd end address is: 4 (R1)
; vt_kt end address is: 12 (R3)
; gt_so end address is: 20 (R5)
; sb end address is: 8 (R2)
MOV	R1, R0
UXTB	R0, R3
L_chuoi_so29:
; sb start address is: 8 (R2)
; so start address is: 4 (R1)
; gt_so start address is: 20 (R5)
; so start address is: 4 (R1)
; so end address is: 4 (R1)
CMP	R2, R0
IT	HI
BHI	L_chuoi_so30
; so end address is: 4 (R1)
;init.c,182 :: 		gt_so*=10;
; so start address is: 4 (R1)
MOVS	R3, #10
MUL	R4, R5, R3
; gt_so end address is: 20 (R5)
;init.c,183 :: 		gt_so+=(*(so+sb)-0x30);
ADDS	R3, R1, R2
LDRB	R3, [R3, #0]
SUBS	R3, #48
SXTH	R3, R3
ADDS	R3, R4, R3
; gt_so start address is: 20 (R5)
MOV	R5, R3
;init.c,181 :: 		for(sb=vt_bd;sb<=vt_kt;sb++){
ADDS	R2, R2, #1
UXTB	R2, R2
;init.c,184 :: 		}
; so end address is: 4 (R1)
; sb end address is: 8 (R2)
IT	AL
BAL	L_chuoi_so29
L_chuoi_so30:
;init.c,185 :: 		return gt_so;
MOV	R0, R5
; gt_so end address is: 20 (R5)
;init.c,186 :: 		}
L_end_chuoi_so:
BX	LR
; end of _chuoi_so
_get_point:
;init.c,187 :: 		unsigned char get_point(unsigned char *s,unsigned char start,unsigned char end){
; end start address is: 8 (R2)
; start start address is: 4 (R1)
UXTB	R3, R2
UXTB	R2, R1
; end end address is: 8 (R2)
; start end address is: 4 (R1)
; start start address is: 8 (R2)
; end start address is: 12 (R3)
;init.c,188 :: 		unsigned char locate_point=0;
;init.c,189 :: 		for(locate_point=start;locate_point<end;locate_point++){
; locate_point start address is: 4 (R1)
UXTB	R1, R2
; end end address is: 12 (R3)
; locate_point end address is: 4 (R1)
MOV	R4, R0
UXTB	R0, R3
L_get_point32:
; locate_point start address is: 4 (R1)
; start start address is: 8 (R2)
; start end address is: 8 (R2)
; s start address is: 16 (R4)
CMP	R1, R0
IT	CS
BCS	L_get_point33
; start end address is: 8 (R2)
;init.c,190 :: 		if((*(s+start)=='.')||(*(s+start)==' ')){
; start start address is: 8 (R2)
ADDS	R3, R4, R2
LDRB	R3, [R3, #0]
CMP	R3, #46
IT	EQ
BEQ	L__get_point190
ADDS	R3, R4, R2
LDRB	R3, [R3, #0]
CMP	R3, #32
IT	EQ
BEQ	L__get_point189
IT	AL
BAL	L_get_point37
; start end address is: 8 (R2)
; s end address is: 16 (R4)
L__get_point190:
L__get_point189:
;init.c,191 :: 		break;
IT	AL
BAL	L_get_point33
;init.c,192 :: 		}
L_get_point37:
;init.c,193 :: 		s++;
; s start address is: 16 (R4)
; start start address is: 8 (R2)
ADDS	R4, R4, #1
;init.c,189 :: 		for(locate_point=start;locate_point<end;locate_point++){
ADDS	R1, R1, #1
UXTB	R1, R1
;init.c,194 :: 		}
; start end address is: 8 (R2)
; s end address is: 16 (R4)
IT	AL
BAL	L_get_point32
L_get_point33:
;init.c,195 :: 		return locate_point;
UXTB	R0, R1
; locate_point end address is: 4 (R1)
;init.c,196 :: 		}
L_end_get_point:
BX	LR
; end of _get_point
_putChar:
;botrungtam.c,130 :: 		void putChar(unsigned char c){
;botrungtam.c,131 :: 		while(UART4_SRbits.TC==0);
L_putChar38:
MOVW	R2, #lo_addr(UART4_SRbits+0)
MOVT	R2, #hi_addr(UART4_SRbits+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_putChar39
IT	AL
BAL	L_putChar38
L_putChar39:
;botrungtam.c,132 :: 		UART4_DRbits.DR = c;
UXTB	R3, R0
MOVW	R2, #lo_addr(UART4_DRbits+0)
MOVT	R2, #hi_addr(UART4_DRbits+0)
LDRH	R1, [R2, #0]
BFI	R1, R3, #0, #9
STRH	R1, [R2, #0]
;botrungtam.c,133 :: 		}
L_end_putChar:
BX	LR
; end of _putChar
_timer1_isr:
;botrungtam.c,135 :: 		void timer1_isr() iv IVT_INT_TIM1_UP ics ICS_AUTO { //20 ms
SUB	SP, SP, #4
STR	LR, [SP, #0]
;botrungtam.c,136 :: 		unsigned char i_isr=0,but_isr=0;
;botrungtam.c,139 :: 		unsigned long shift=1;
;botrungtam.c,141 :: 		if(TIM1_SRbits.UIF==1)
MOVW	R1, #lo_addr(TIM1_SRbits+0)
MOVT	R1, #hi_addr(TIM1_SRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr40
;botrungtam.c,143 :: 		TIM1_SRbits.UIF=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_SRbits+0)
MOVT	R0, #hi_addr(TIM1_SRbits+0)
STR	R1, [R0, #0]
;botrungtam.c,146 :: 		but_sample[0][SAMPLE-1]=!BUT1_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+1)
MOVT	R0, #hi_addr(_but_sample+1)
STRB	R1, [R0, #0]
;botrungtam.c,147 :: 		but_sample[1][SAMPLE-1]=!BUT1_1;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+3)
MOVT	R0, #hi_addr(_but_sample+3)
STRB	R1, [R0, #0]
;botrungtam.c,148 :: 		but_sample[2][SAMPLE-1]=!BUT1_2;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+5)
MOVT	R0, #hi_addr(_but_sample+5)
STRB	R1, [R0, #0]
;botrungtam.c,150 :: 		but_sample[3][SAMPLE-1]=!BUT2_0;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+7)
MOVT	R0, #hi_addr(_but_sample+7)
STRB	R1, [R0, #0]
;botrungtam.c,151 :: 		but_sample[4][SAMPLE-1]=!BUT2_1;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+9)
MOVT	R0, #hi_addr(_but_sample+9)
STRB	R1, [R0, #0]
;botrungtam.c,152 :: 		but_sample[5][SAMPLE-1]=!BUT2_2;
MOVW	R1, #lo_addr(GPIOA_IDR+0)
MOVT	R1, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+11)
MOVT	R0, #hi_addr(_but_sample+11)
STRB	R1, [R0, #0]
;botrungtam.c,154 :: 		but_sample[6][SAMPLE-1]=!BUT3_0;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+13)
MOVT	R0, #hi_addr(_but_sample+13)
STRB	R1, [R0, #0]
;botrungtam.c,155 :: 		but_sample[7][SAMPLE-1]=!BUT3_1;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+15)
MOVT	R0, #hi_addr(_but_sample+15)
STRB	R1, [R0, #0]
;botrungtam.c,156 :: 		but_sample[8][SAMPLE-1]=!BUT3_2;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+17)
MOVT	R0, #hi_addr(_but_sample+17)
STRB	R1, [R0, #0]
;botrungtam.c,158 :: 		but_sample[9][SAMPLE-1]=!BUT4_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+19)
MOVT	R0, #hi_addr(_but_sample+19)
STRB	R1, [R0, #0]
;botrungtam.c,159 :: 		but_sample[10][SAMPLE-1]=!BUT4_1;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+21)
MOVT	R0, #hi_addr(_but_sample+21)
STRB	R1, [R0, #0]
;botrungtam.c,161 :: 		but_sample[11][SAMPLE-1]=!BUT5_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+23)
MOVT	R0, #hi_addr(_but_sample+23)
STRB	R1, [R0, #0]
;botrungtam.c,162 :: 		but_sample[12][SAMPLE-1]=!BUT5_1;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+25)
MOVT	R0, #hi_addr(_but_sample+25)
STRB	R1, [R0, #0]
;botrungtam.c,164 :: 		but_sample[13][SAMPLE-1]=!BUT6_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+27)
MOVT	R0, #hi_addr(_but_sample+27)
STRB	R1, [R0, #0]
;botrungtam.c,166 :: 		but_sample[14][SAMPLE-1]=!BUT7_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+29)
MOVT	R0, #hi_addr(_but_sample+29)
STRB	R1, [R0, #0]
;botrungtam.c,168 :: 		but_sample[15][SAMPLE-1]=!BUT8_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+31)
MOVT	R0, #hi_addr(_but_sample+31)
STRB	R1, [R0, #0]
;botrungtam.c,169 :: 		but_sample[16][SAMPLE-1]=!BUT8_1;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+33)
MOVT	R0, #hi_addr(_but_sample+33)
STRB	R1, [R0, #0]
;botrungtam.c,171 :: 		but_sample[17][SAMPLE-1]=!BUT9_0;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+35)
MOVT	R0, #hi_addr(_but_sample+35)
STRB	R1, [R0, #0]
;botrungtam.c,172 :: 		but_sample[18][SAMPLE-1]=!BUT9_1;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+37)
MOVT	R0, #hi_addr(_but_sample+37)
STRB	R1, [R0, #0]
;botrungtam.c,174 :: 		but_sample[19][SAMPLE-1]=!BUT10_0;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+39)
MOVT	R0, #hi_addr(_but_sample+39)
STRB	R1, [R0, #0]
;botrungtam.c,175 :: 		but_sample[20][SAMPLE-1]=!BUT10_1;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+41)
MOVT	R0, #hi_addr(_but_sample+41)
STRB	R1, [R0, #0]
;botrungtam.c,177 :: 		but_sample[21][SAMPLE-1]=!BUT11_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+43)
MOVT	R0, #hi_addr(_but_sample+43)
STRB	R1, [R0, #0]
;botrungtam.c,178 :: 		but_sample[22][SAMPLE-1]=!BUT11_1;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+45)
MOVT	R0, #hi_addr(_but_sample+45)
STRB	R1, [R0, #0]
;botrungtam.c,180 :: 		but_sample[23][SAMPLE-1]=!BUT12_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+47)
MOVT	R0, #hi_addr(_but_sample+47)
STRB	R1, [R0, #0]
;botrungtam.c,182 :: 		but_sample[24][SAMPLE-1]=!BUT13_0;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+49)
MOVT	R0, #hi_addr(_but_sample+49)
STRB	R1, [R0, #0]
;botrungtam.c,184 :: 		for(but_isr=0;but_isr<SUM_BUT;but_isr++){
; but_isr start address is: 12 (R3)
MOVS	R3, #0
; but_isr end address is: 12 (R3)
L_timer1_isr41:
; but_isr start address is: 12 (R3)
CMP	R3, #25
IT	CS
BCS	L_timer1_isr42
;botrungtam.c,185 :: 		for(i_isr=0;i_isr<SAMPLE-1;i_isr++){
; i_isr start address is: 16 (R4)
MOVS	R4, #0
; i_isr end address is: 16 (R4)
; but_isr end address is: 12 (R3)
L_timer1_isr44:
; i_isr start address is: 16 (R4)
; but_isr start address is: 12 (R3)
CMP	R4, #1
IT	CS
BCS	L_timer1_isr45
;botrungtam.c,186 :: 		but_sample[but_isr][i_isr]=but_sample[but_isr][i_isr+1];
LSLS	R1, R3, #1
MOVW	R0, #lo_addr(_but_sample+0)
MOVT	R0, #hi_addr(_but_sample+0)
ADDS	R2, R0, R1
ADDS	R1, R2, R4
ADDS	R0, R4, #1
SXTH	R0, R0
ADDS	R0, R2, R0
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;botrungtam.c,185 :: 		for(i_isr=0;i_isr<SAMPLE-1;i_isr++){
ADDS	R4, R4, #1
UXTB	R4, R4
;botrungtam.c,187 :: 		}
; i_isr end address is: 16 (R4)
IT	AL
BAL	L_timer1_isr44
L_timer1_isr45:
;botrungtam.c,188 :: 		but_sum_sample[but_isr]=0;
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;botrungtam.c,189 :: 		for(i_isr=0;i_isr<SAMPLE;i_isr++){
; i_isr start address is: 16 (R4)
MOVS	R4, #0
; i_isr end address is: 16 (R4)
; but_isr end address is: 12 (R3)
L_timer1_isr47:
; i_isr start address is: 16 (R4)
; but_isr start address is: 12 (R3)
CMP	R4, #2
IT	CS
BCS	L_timer1_isr48
;botrungtam.c,190 :: 		but_sum_sample[but_isr]+=but_sample[but_isr][i_isr];
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R2, R0, R3
LSLS	R1, R3, #1
MOVW	R0, #lo_addr(_but_sample+0)
MOVT	R0, #hi_addr(_but_sample+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R4
LDRB	R1, [R0, #0]
LDRB	R0, [R2, #0]
ADDS	R0, R0, R1
STRB	R0, [R2, #0]
;botrungtam.c,189 :: 		for(i_isr=0;i_isr<SAMPLE;i_isr++){
ADDS	R4, R4, #1
UXTB	R4, R4
;botrungtam.c,191 :: 		}
; i_isr end address is: 16 (R4)
IT	AL
BAL	L_timer1_isr47
L_timer1_isr48:
;botrungtam.c,192 :: 		if(but_sum_sample[but_isr]>=PRESS){
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	CC
BCC	L_timer1_isr50
;botrungtam.c,193 :: 		but_state[but_isr]=PRESS;
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R1, R0, R3
MOVS	R0, #2
STRB	R0, [R1, #0]
;botrungtam.c,194 :: 		}
IT	AL
BAL	L_timer1_isr51
L_timer1_isr50:
;botrungtam.c,195 :: 		else if(but_sum_sample[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr52
;botrungtam.c,196 :: 		but_state[but_isr]=UNPRESS;
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;botrungtam.c,197 :: 		}
L_timer1_isr52:
L_timer1_isr51:
;botrungtam.c,198 :: 		if(but_state[but_isr]==PRESS){
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_timer1_isr53
;botrungtam.c,199 :: 		if(but_status[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr54
;botrungtam.c,200 :: 		but_status[but_isr]=PRES_DOW;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #5
STRB	R0, [R1, #0]
;botrungtam.c,201 :: 		}
IT	AL
BAL	L_timer1_isr55
L_timer1_isr54:
;botrungtam.c,202 :: 		else if(but_status[but_isr]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr56
;botrungtam.c,203 :: 		but_status[but_isr]=PRESSING;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #6
STRB	R0, [R1, #0]
;botrungtam.c,204 :: 		}
IT	AL
BAL	L_timer1_isr57
L_timer1_isr56:
;botrungtam.c,205 :: 		else if(but_status[but_isr]==PRESSING){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	NE
BNE	L_timer1_isr58
;botrungtam.c,206 :: 		but_status[but_isr]=PRESSING;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #6
STRB	R0, [R1, #0]
;botrungtam.c,207 :: 		}
L_timer1_isr58:
L_timer1_isr57:
L_timer1_isr55:
;botrungtam.c,208 :: 		}
IT	AL
BAL	L_timer1_isr59
L_timer1_isr53:
;botrungtam.c,209 :: 		else if(but_state[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr60
;botrungtam.c,210 :: 		if ((but_status[but_isr]==PRESSING)||(but_status[but_isr]==PRES_DOW)){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	EQ
BEQ	L__timer1_isr193
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L__timer1_isr192
IT	AL
BAL	L_timer1_isr63
L__timer1_isr193:
L__timer1_isr192:
;botrungtam.c,211 :: 		but_status[but_isr]=PRES_UP;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #4
STRB	R0, [R1, #0]
;botrungtam.c,212 :: 		}
IT	AL
BAL	L_timer1_isr64
L_timer1_isr63:
;botrungtam.c,213 :: 		else if(but_status[but_isr]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr65
;botrungtam.c,214 :: 		but_status[but_isr]=UNPRESS;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;botrungtam.c,215 :: 		}
IT	AL
BAL	L_timer1_isr66
L_timer1_isr65:
;botrungtam.c,216 :: 		else if(but_status[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr67
;botrungtam.c,217 :: 		but_status[but_isr]=UNPRESS;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;botrungtam.c,218 :: 		}
L_timer1_isr67:
L_timer1_isr66:
L_timer1_isr64:
;botrungtam.c,219 :: 		}
L_timer1_isr60:
L_timer1_isr59:
;botrungtam.c,184 :: 		for(but_isr=0;but_isr<SUM_BUT;but_isr++){
ADDS	R3, R3, #1
UXTB	R3, R3
;botrungtam.c,220 :: 		}
; but_isr end address is: 12 (R3)
IT	AL
BAL	L_timer1_isr41
L_timer1_isr42:
;botrungtam.c,250 :: 		duphong67_A8=~duphong67_A8;             // LED INDICAROR QUET BAN PHIM
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,254 :: 		if(but_status[0]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr68
;botrungtam.c,256 :: 		}
IT	AL
BAL	L_timer1_isr69
L_timer1_isr68:
;botrungtam.c,257 :: 		else if(but_status[0]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr70
;botrungtam.c,259 :: 		}
L_timer1_isr70:
L_timer1_isr69:
;botrungtam.c,261 :: 		if(but_status[1]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+1)
MOVT	R0, #hi_addr(_but_status+1)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr71
;botrungtam.c,264 :: 		RS485_CONTROL_S9_S11=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_RS485_CONTROL_S9_S11+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S9_S11+0)
STRB	R1, [R0, #0]
;botrungtam.c,265 :: 		RS485_STATUS_S9_S11^=1;
MOVW	R1, #lo_addr(_RS485_STATUS_S9_S11+0)
MOVT	R1, #hi_addr(_RS485_STATUS_S9_S11+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,266 :: 		}
IT	AL
BAL	L_timer1_isr72
L_timer1_isr71:
;botrungtam.c,267 :: 		else if(but_status[1]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+1)
MOVT	R0, #hi_addr(_but_status+1)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr73
;botrungtam.c,269 :: 		}
L_timer1_isr73:
L_timer1_isr72:
;botrungtam.c,271 :: 		if(but_status[2]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+2)
MOVT	R0, #hi_addr(_but_status+2)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr74
;botrungtam.c,273 :: 		RS485_CONTROL_S10=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_RS485_CONTROL_S10+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S10+0)
STRB	R1, [R0, #0]
;botrungtam.c,274 :: 		RS485_STATUS_S10^=1;
MOVW	R1, #lo_addr(_RS485_STATUS_S10+0)
MOVT	R1, #hi_addr(_RS485_STATUS_S10+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,275 :: 		}
IT	AL
BAL	L_timer1_isr75
L_timer1_isr74:
;botrungtam.c,276 :: 		else if(but_status[2]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+2)
MOVT	R0, #hi_addr(_but_status+2)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr76
;botrungtam.c,278 :: 		}
L_timer1_isr76:
L_timer1_isr75:
;botrungtam.c,281 :: 		if(but_status[3]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+3)
MOVT	R0, #hi_addr(_but_status+3)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr77
;botrungtam.c,283 :: 		}
IT	AL
BAL	L_timer1_isr78
L_timer1_isr77:
;botrungtam.c,284 :: 		else if(but_status[3]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+3)
MOVT	R0, #hi_addr(_but_status+3)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr79
;botrungtam.c,286 :: 		}
L_timer1_isr79:
L_timer1_isr78:
;botrungtam.c,288 :: 		if(but_status[4]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+4)
MOVT	R0, #hi_addr(_but_status+4)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr80
;botrungtam.c,292 :: 		AMBIENT_BEDROOM=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_AMBIENT_BEDROOM+0)
MOVT	R0, #hi_addr(_AMBIENT_BEDROOM+0)
STRB	R1, [R0, #0]
;botrungtam.c,293 :: 		AMBIENT_STATUS^=1;
MOVW	R1, #lo_addr(_AMBIENT_STATUS+0)
MOVT	R1, #hi_addr(_AMBIENT_STATUS+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,294 :: 		}
IT	AL
BAL	L_timer1_isr81
L_timer1_isr80:
;botrungtam.c,295 :: 		else if(but_status[4]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+4)
MOVT	R0, #hi_addr(_but_status+4)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr82
;botrungtam.c,297 :: 		}
L_timer1_isr82:
L_timer1_isr81:
;botrungtam.c,299 :: 		if(but_status[5]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+5)
MOVT	R0, #hi_addr(_but_status+5)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr83
;botrungtam.c,301 :: 		ACCENT_BEDROOM=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ACCENT_BEDROOM+0)
MOVT	R0, #hi_addr(_ACCENT_BEDROOM+0)
STRB	R1, [R0, #0]
;botrungtam.c,302 :: 		ACCENT_STATUS^=1;
MOVW	R1, #lo_addr(_ACCENT_STATUS+0)
MOVT	R1, #hi_addr(_ACCENT_STATUS+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,303 :: 		}
IT	AL
BAL	L_timer1_isr84
L_timer1_isr83:
;botrungtam.c,304 :: 		else if(but_status[5]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+5)
MOVT	R0, #hi_addr(_but_status+5)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr85
;botrungtam.c,306 :: 		}
L_timer1_isr85:
L_timer1_isr84:
;botrungtam.c,310 :: 		if(but_status[6]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+6)
MOVT	R0, #hi_addr(_but_status+6)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr86
;botrungtam.c,312 :: 		}
IT	AL
BAL	L_timer1_isr87
L_timer1_isr86:
;botrungtam.c,313 :: 		else if(but_status[6]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+6)
MOVT	R0, #hi_addr(_but_status+6)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr88
;botrungtam.c,315 :: 		}
L_timer1_isr88:
L_timer1_isr87:
;botrungtam.c,317 :: 		if(but_status[7]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+7)
MOVT	R0, #hi_addr(_but_status+7)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr89
;botrungtam.c,320 :: 		RS485_CONTROL_S9=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_RS485_CONTROL_S9+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S9+0)
STRB	R1, [R0, #0]
;botrungtam.c,321 :: 		RS485_STATUS_S9^=1;
MOVW	R1, #lo_addr(_RS485_STATUS_S9+0)
MOVT	R1, #hi_addr(_RS485_STATUS_S9+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,323 :: 		}
IT	AL
BAL	L_timer1_isr90
L_timer1_isr89:
;botrungtam.c,324 :: 		else if(but_status[7]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+7)
MOVT	R0, #hi_addr(_but_status+7)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr91
;botrungtam.c,327 :: 		}
L_timer1_isr91:
L_timer1_isr90:
;botrungtam.c,329 :: 		if(but_status[8]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+8)
MOVT	R0, #hi_addr(_but_status+8)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr92
;botrungtam.c,330 :: 		LED_3_2=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,331 :: 		out_relay^=RELAY_2;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #2
STR	R0, [R1, #0]
;botrungtam.c,332 :: 		}
IT	AL
BAL	L_timer1_isr93
L_timer1_isr92:
;botrungtam.c,333 :: 		else if(but_status[8]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+8)
MOVT	R0, #hi_addr(_but_status+8)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr94
;botrungtam.c,334 :: 		LED_3_2=(out_relay&RELAY_2)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #2
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr95
; ?FLOC___timer1_isr?T441 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T441 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr96
L_timer1_isr95:
; ?FLOC___timer1_isr?T441 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T441 end address is: 4 (R1)
L_timer1_isr96:
; ?FLOC___timer1_isr?T441 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T441 end address is: 4 (R1)
;botrungtam.c,335 :: 		}
L_timer1_isr94:
L_timer1_isr93:
;botrungtam.c,338 :: 		if(but_status[9]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+9)
MOVT	R0, #hi_addr(_but_status+9)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr97
;botrungtam.c,340 :: 		AMBIENT_BEDROOM=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_AMBIENT_BEDROOM+0)
MOVT	R0, #hi_addr(_AMBIENT_BEDROOM+0)
STRB	R1, [R0, #0]
;botrungtam.c,341 :: 		AMBIENT_STATUS^=1;
MOVW	R1, #lo_addr(_AMBIENT_STATUS+0)
MOVT	R1, #hi_addr(_AMBIENT_STATUS+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,342 :: 		}
IT	AL
BAL	L_timer1_isr98
L_timer1_isr97:
;botrungtam.c,343 :: 		else if(but_status[9]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+9)
MOVT	R0, #hi_addr(_but_status+9)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr99
;botrungtam.c,347 :: 		}
L_timer1_isr99:
L_timer1_isr98:
;botrungtam.c,349 :: 		if(but_status[10]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+10)
MOVT	R0, #hi_addr(_but_status+10)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr100
;botrungtam.c,352 :: 		ACCENT_BEDROOM=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ACCENT_BEDROOM+0)
MOVT	R0, #hi_addr(_ACCENT_BEDROOM+0)
STRB	R1, [R0, #0]
;botrungtam.c,353 :: 		ACCENT_STATUS^=1;
MOVW	R1, #lo_addr(_ACCENT_STATUS+0)
MOVT	R1, #hi_addr(_ACCENT_STATUS+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,354 :: 		}
IT	AL
BAL	L_timer1_isr101
L_timer1_isr100:
;botrungtam.c,355 :: 		else if(but_status[10]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+10)
MOVT	R0, #hi_addr(_but_status+10)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr102
;botrungtam.c,358 :: 		}
L_timer1_isr102:
L_timer1_isr101:
;botrungtam.c,363 :: 		if(but_status[11]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+11)
MOVT	R0, #hi_addr(_but_status+11)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr103
;botrungtam.c,364 :: 		LED_5_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,366 :: 		RS485_CONTROL_S9=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_RS485_CONTROL_S9+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S9+0)
STRB	R1, [R0, #0]
;botrungtam.c,367 :: 		RS485_STATUS_S9^=1;
MOVW	R1, #lo_addr(_RS485_STATUS_S9+0)
MOVT	R1, #hi_addr(_RS485_STATUS_S9+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,368 :: 		}
IT	AL
BAL	L_timer1_isr104
L_timer1_isr103:
;botrungtam.c,369 :: 		else if(but_status[11]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+11)
MOVT	R0, #hi_addr(_but_status+11)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr105
;botrungtam.c,372 :: 		}
L_timer1_isr105:
L_timer1_isr104:
;botrungtam.c,374 :: 		if(but_status[12]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+12)
MOVT	R0, #hi_addr(_but_status+12)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr106
;botrungtam.c,375 :: 		LED_5_1=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,376 :: 		out_relay^=RELAY_1;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,377 :: 		}
IT	AL
BAL	L_timer1_isr107
L_timer1_isr106:
;botrungtam.c,378 :: 		else if(but_status[12]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+12)
MOVT	R0, #hi_addr(_but_status+12)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr108
;botrungtam.c,379 :: 		LED_5_1=(out_relay&RELAY_1)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #1
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr109
; ?FLOC___timer1_isr?T469 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T469 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr110
L_timer1_isr109:
; ?FLOC___timer1_isr?T469 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T469 end address is: 4 (R1)
L_timer1_isr110:
; ?FLOC___timer1_isr?T469 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T469 end address is: 4 (R1)
;botrungtam.c,380 :: 		}
L_timer1_isr108:
L_timer1_isr107:
;botrungtam.c,384 :: 		if(but_status[13]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+13)
MOVT	R0, #hi_addr(_but_status+13)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr111
;botrungtam.c,385 :: 		LED_6_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,386 :: 		out_relay^=RELAY_16;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #32768
STR	R0, [R1, #0]
;botrungtam.c,387 :: 		}
IT	AL
BAL	L_timer1_isr112
L_timer1_isr111:
;botrungtam.c,388 :: 		else if(but_status[13]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+13)
MOVT	R0, #hi_addr(_but_status+13)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr113
;botrungtam.c,389 :: 		LED_6_0=(out_relay&RELAY_16)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #32768
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr114
; ?FLOC___timer1_isr?T480 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T480 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr115
L_timer1_isr114:
; ?FLOC___timer1_isr?T480 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T480 end address is: 4 (R1)
L_timer1_isr115:
; ?FLOC___timer1_isr?T480 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T480 end address is: 4 (R1)
;botrungtam.c,390 :: 		}
L_timer1_isr113:
L_timer1_isr112:
;botrungtam.c,393 :: 		if(but_status[14]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+14)
MOVT	R0, #hi_addr(_but_status+14)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr116
;botrungtam.c,395 :: 		MASTER_BEDROOM=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_MASTER_BEDROOM+0)
MOVT	R0, #hi_addr(_MASTER_BEDROOM+0)
STRB	R1, [R0, #0]
;botrungtam.c,396 :: 		MASTER_BEDROOM_STATUS^=1;
MOVW	R1, #lo_addr(_MASTER_BEDROOM_STATUS+0)
MOVT	R1, #hi_addr(_MASTER_BEDROOM_STATUS+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,398 :: 		}
IT	AL
BAL	L_timer1_isr117
L_timer1_isr116:
;botrungtam.c,399 :: 		else if(but_status[14]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+14)
MOVT	R0, #hi_addr(_but_status+14)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr118
;botrungtam.c,401 :: 		}
L_timer1_isr118:
L_timer1_isr117:
;botrungtam.c,404 :: 		if(but_status[15]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+15)
MOVT	R0, #hi_addr(_but_status+15)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr119
;botrungtam.c,406 :: 		AMBIENT_BEDROOM=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_AMBIENT_BEDROOM+0)
MOVT	R0, #hi_addr(_AMBIENT_BEDROOM+0)
STRB	R1, [R0, #0]
;botrungtam.c,407 :: 		AMBIENT_STATUS^=1;
MOVW	R1, #lo_addr(_AMBIENT_STATUS+0)
MOVT	R1, #hi_addr(_AMBIENT_STATUS+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,408 :: 		}
IT	AL
BAL	L_timer1_isr120
L_timer1_isr119:
;botrungtam.c,409 :: 		else if(but_status[15]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+15)
MOVT	R0, #hi_addr(_but_status+15)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr121
;botrungtam.c,411 :: 		}
L_timer1_isr121:
L_timer1_isr120:
;botrungtam.c,414 :: 		if(but_status[16]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+16)
MOVT	R0, #hi_addr(_but_status+16)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr122
;botrungtam.c,416 :: 		ACCENT_BEDROOM=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ACCENT_BEDROOM+0)
MOVT	R0, #hi_addr(_ACCENT_BEDROOM+0)
STRB	R1, [R0, #0]
;botrungtam.c,417 :: 		ACCENT_STATUS^=1;
MOVW	R1, #lo_addr(_ACCENT_STATUS+0)
MOVT	R1, #hi_addr(_ACCENT_STATUS+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,418 :: 		}
IT	AL
BAL	L_timer1_isr123
L_timer1_isr122:
;botrungtam.c,419 :: 		else if(but_status[16]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+16)
MOVT	R0, #hi_addr(_but_status+16)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr124
;botrungtam.c,422 :: 		}
L_timer1_isr124:
L_timer1_isr123:
;botrungtam.c,425 :: 		if(but_status[17]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+17)
MOVT	R0, #hi_addr(_but_status+17)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr125
;botrungtam.c,427 :: 		}
IT	AL
BAL	L_timer1_isr126
L_timer1_isr125:
;botrungtam.c,428 :: 		else if(but_status[17]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+17)
MOVT	R0, #hi_addr(_but_status+17)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr127
;botrungtam.c,430 :: 		}
L_timer1_isr127:
L_timer1_isr126:
;botrungtam.c,433 :: 		if(but_status[18]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+18)
MOVT	R0, #hi_addr(_but_status+18)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr128
;botrungtam.c,435 :: 		}
IT	AL
BAL	L_timer1_isr129
L_timer1_isr128:
;botrungtam.c,436 :: 		else if(but_status[18]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+18)
MOVT	R0, #hi_addr(_but_status+18)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr130
;botrungtam.c,438 :: 		}
L_timer1_isr130:
L_timer1_isr129:
;botrungtam.c,441 :: 		if(but_status[19]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+19)
MOVT	R0, #hi_addr(_but_status+19)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr131
;botrungtam.c,443 :: 		}
IT	AL
BAL	L_timer1_isr132
L_timer1_isr131:
;botrungtam.c,444 :: 		else if(but_status[19]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+19)
MOVT	R0, #hi_addr(_but_status+19)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr133
;botrungtam.c,446 :: 		}
L_timer1_isr133:
L_timer1_isr132:
;botrungtam.c,448 :: 		if(but_status[20]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+20)
MOVT	R0, #hi_addr(_but_status+20)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr134
;botrungtam.c,450 :: 		}
IT	AL
BAL	L_timer1_isr135
L_timer1_isr134:
;botrungtam.c,451 :: 		else if(but_status[20]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+20)
MOVT	R0, #hi_addr(_but_status+20)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr136
;botrungtam.c,453 :: 		}
L_timer1_isr136:
L_timer1_isr135:
;botrungtam.c,456 :: 		if(but_status[21]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+21)
MOVT	R0, #hi_addr(_but_status+21)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr137
;botrungtam.c,458 :: 		}
IT	AL
BAL	L_timer1_isr138
L_timer1_isr137:
;botrungtam.c,459 :: 		else if(but_status[21]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+21)
MOVT	R0, #hi_addr(_but_status+21)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr139
;botrungtam.c,461 :: 		}
L_timer1_isr139:
L_timer1_isr138:
;botrungtam.c,463 :: 		if(but_status[22]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+22)
MOVT	R0, #hi_addr(_but_status+22)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr140
;botrungtam.c,465 :: 		}
IT	AL
BAL	L_timer1_isr141
L_timer1_isr140:
;botrungtam.c,466 :: 		else if(but_status[22]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+22)
MOVT	R0, #hi_addr(_but_status+22)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr142
;botrungtam.c,468 :: 		}
L_timer1_isr142:
L_timer1_isr141:
;botrungtam.c,471 :: 		if(but_status[23]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+23)
MOVT	R0, #hi_addr(_but_status+23)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr143
;botrungtam.c,473 :: 		MASTER_BEDROOM=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_MASTER_BEDROOM+0)
MOVT	R0, #hi_addr(_MASTER_BEDROOM+0)
STRB	R1, [R0, #0]
;botrungtam.c,474 :: 		MASTER_BEDROOM_STATUS^=1;
MOVW	R1, #lo_addr(_MASTER_BEDROOM_STATUS+0)
MOVT	R1, #hi_addr(_MASTER_BEDROOM_STATUS+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,475 :: 		}
IT	AL
BAL	L_timer1_isr144
L_timer1_isr143:
;botrungtam.c,476 :: 		else if(but_status[23]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+23)
MOVT	R0, #hi_addr(_but_status+23)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr145
;botrungtam.c,479 :: 		}
L_timer1_isr145:
L_timer1_isr144:
;botrungtam.c,482 :: 		if(but_status[24]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+24)
MOVT	R0, #hi_addr(_but_status+24)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr146
;botrungtam.c,483 :: 		STAT = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,484 :: 		KEYCARD_INSERT=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
STRB	R1, [R0, #0]
;botrungtam.c,485 :: 		KEYCARD_ENABLE=1;       // enable xuat_32bit(out_relay)
MOVS	R1, #1
MOVW	R0, #lo_addr(_KEYCARD_ENABLE+0)
MOVT	R0, #hi_addr(_KEYCARD_ENABLE+0)
STRB	R1, [R0, #0]
;botrungtam.c,486 :: 		}
IT	AL
BAL	L_timer1_isr147
L_timer1_isr146:
;botrungtam.c,487 :: 		else if(but_status[24]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+24)
MOVT	R0, #hi_addr(_but_status+24)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr148
;botrungtam.c,488 :: 		STAT = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,489 :: 		KEYCARD_INSERT=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
STRB	R1, [R0, #0]
;botrungtam.c,490 :: 		}
L_timer1_isr148:
L_timer1_isr147:
;botrungtam.c,492 :: 		if(KEYCARD_ENABLE==1){
MOVW	R0, #lo_addr(_KEYCARD_ENABLE+0)
MOVT	R0, #hi_addr(_KEYCARD_ENABLE+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_timer1_isr149
;botrungtam.c,494 :: 		if(MASTER_BEDROOM==1){
MOVW	R0, #lo_addr(_MASTER_BEDROOM+0)
MOVT	R0, #hi_addr(_MASTER_BEDROOM+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_timer1_isr150
;botrungtam.c,495 :: 		if( MASTER_BEDROOM_STATUS!=0){
MOVW	R0, #lo_addr(_MASTER_BEDROOM_STATUS+0)
MOVT	R0, #hi_addr(_MASTER_BEDROOM_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr151
;botrungtam.c,497 :: 		out_relay|=S12;       // S12=RELAY_7;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #64
STR	R0, [R1, #0]
;botrungtam.c,498 :: 		out_relay|=S13A;      //S13A=RELAY_6;
ORR	R0, R0, #32
STR	R0, [R1, #0]
;botrungtam.c,499 :: 		out_relay|=S17;       // S17=RELAY_3;
ORR	R0, R0, #4
STR	R0, [R1, #0]
;botrungtam.c,500 :: 		LED_12_0=1;    // MASTER_BD BUTTON1-PORT12
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,501 :: 		LED_7_0=1;     // MASTER_BD BUTTON1-PORT7
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,502 :: 		LED_2_1=1;        // AMBIENT(S12+S13A) BUTTON2-PORT2
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,503 :: 		LED_4_0=1;        // AMBIENT(S12+S13A) BUTTON2-PORT4
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,504 :: 		LED_8_0=1;        // AMBIENT(S12+S13A) BUTTON2-PORT8
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,505 :: 		LED_2_2=1;     // ACCENT(S17) BUTTON1-PORT2
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,506 :: 		LED_4_1=1;     // ACCENT(S17) BUTTON1-PORT4
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,507 :: 		LED_8_1=1;     // ACCENT(S17) BUTTON1-PORT8
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,508 :: 		}
L_timer1_isr151:
;botrungtam.c,509 :: 		if( MASTER_BEDROOM_STATUS==0){
MOVW	R0, #lo_addr(_MASTER_BEDROOM_STATUS+0)
MOVT	R0, #hi_addr(_MASTER_BEDROOM_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr152
;botrungtam.c,511 :: 		out_relay&=~S12;       // S12=RELAY_7;
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #64
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,512 :: 		out_relay&=~S13A;      //S13A=RELAY_6;
MVN	R0, #32
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,513 :: 		out_relay&=~S17;       // S17=RELAY_3;
MVN	R0, #4
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,514 :: 		LED_12_0=0;    // MASTER_BD BUTTON1-PORT12
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,515 :: 		LED_7_0=0;     // MASTER_BD BUTTON1-PORT7
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,516 :: 		LED_2_1=0;        // AMBIENT(S12+S13A) BUTTON2-PORT2
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,517 :: 		LED_4_0=0;        // AMBIENT(S12+S13A) BUTTON2-PORT4
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,518 :: 		LED_8_0=0;        // AMBIENT(S12+S13A) BUTTON2-PORT8
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,519 :: 		LED_2_2=0;     // ACCENT(S17) BUTTON1-PORT2
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,520 :: 		LED_4_1=0;     // ACCENT(S17) BUTTON1-PORT4
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,521 :: 		LED_8_1=0;     // ACCENT(S17) BUTTON1-PORT8
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,522 :: 		}
L_timer1_isr152:
;botrungtam.c,523 :: 		MASTER_BEDROOM=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_MASTER_BEDROOM+0)
MOVT	R0, #hi_addr(_MASTER_BEDROOM+0)
STRB	R1, [R0, #0]
;botrungtam.c,524 :: 		}
L_timer1_isr150:
;botrungtam.c,526 :: 		if(AMBIENT_BEDROOM==1){
MOVW	R0, #lo_addr(_AMBIENT_BEDROOM+0)
MOVT	R0, #hi_addr(_AMBIENT_BEDROOM+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_timer1_isr153
;botrungtam.c,527 :: 		if( AMBIENT_STATUS!=0){
MOVW	R0, #lo_addr(_AMBIENT_STATUS+0)
MOVT	R0, #hi_addr(_AMBIENT_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr154
;botrungtam.c,529 :: 		out_relay|=S12;  // S12=RELAY_7
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #64
STR	R0, [R1, #0]
;botrungtam.c,530 :: 		out_relay|=S13A;  // S13A(S13+S16)=RELAY_6
ORR	R0, R0, #32
STR	R0, [R1, #0]
;botrungtam.c,531 :: 		LED_2_1=1;       // AMBIENT(S12+S13A) BUTTON2-PORT2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,532 :: 		LED_4_0=1;       // AMBIENT(S12+S13A) BUTTON2-PORT4
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,533 :: 		LED_8_0=1;       // AMBIENT(S12+S13A) BUTTON2-PORT8
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,534 :: 		}
L_timer1_isr154:
;botrungtam.c,535 :: 		if(AMBIENT_STATUS==0){
MOVW	R0, #lo_addr(_AMBIENT_STATUS+0)
MOVT	R0, #hi_addr(_AMBIENT_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr155
;botrungtam.c,537 :: 		out_relay&=~S12;  // S12=RELAY_7
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #64
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,538 :: 		out_relay&=~S13A;  // S13A(S13+S16)=RELAY_6
MVN	R0, #32
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,539 :: 		LED_2_1=0;        // AMBIENT(S12+S13A) BUTTON2-PORT2
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,540 :: 		LED_4_0=0;        // AMBIENT(S12+S13A) BUTTON2-PORT4
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,541 :: 		LED_8_0=0;        // AMBIENT(S12+S13A) BUTTON2-PORT8
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,542 :: 		}
L_timer1_isr155:
;botrungtam.c,543 :: 		AMBIENT_BEDROOM=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_AMBIENT_BEDROOM+0)
MOVT	R0, #hi_addr(_AMBIENT_BEDROOM+0)
STRB	R1, [R0, #0]
;botrungtam.c,544 :: 		}
L_timer1_isr153:
;botrungtam.c,546 :: 		if(ACCENT_BEDROOM==1){
MOVW	R0, #lo_addr(_ACCENT_BEDROOM+0)
MOVT	R0, #hi_addr(_ACCENT_BEDROOM+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_timer1_isr156
;botrungtam.c,547 :: 		if( ACCENT_STATUS!=0){
MOVW	R0, #lo_addr(_ACCENT_STATUS+0)
MOVT	R0, #hi_addr(_ACCENT_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr157
;botrungtam.c,549 :: 		out_relay|=S17;  // S17=RELAY_3;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #4
STR	R0, [R1, #0]
;botrungtam.c,550 :: 		LED_2_2=1;     // ACCENT(S17) BUTTON1-PORT2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,551 :: 		LED_4_1=1;     // ACCENT(S17) BUTTON1-PORT4
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,552 :: 		LED_8_1=1;     // ACCENT(S17) BUTTON1-PORT8
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,553 :: 		}
L_timer1_isr157:
;botrungtam.c,554 :: 		if(ACCENT_STATUS==0){
MOVW	R0, #lo_addr(_ACCENT_STATUS+0)
MOVT	R0, #hi_addr(_ACCENT_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr158
;botrungtam.c,556 :: 		out_relay&=~S17;     //S17= RELAY_3;
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #4
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,557 :: 		LED_2_2=0;     // ACCENT(S17) BUTTON1-PORT2
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,558 :: 		LED_4_1=0;     // ACCENT(S17) BUTTON1-PORT4
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,559 :: 		LED_8_1=0;     // ACCENT(S17) BUTTON1-PORT8
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,560 :: 		}
L_timer1_isr158:
;botrungtam.c,561 :: 		ACCENT_BEDROOM=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ACCENT_BEDROOM+0)
MOVT	R0, #hi_addr(_ACCENT_BEDROOM+0)
STRB	R1, [R0, #0]
;botrungtam.c,562 :: 		}
L_timer1_isr156:
;botrungtam.c,563 :: 		xuat_32bit(out_relay);
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
BL	_xuat_32bit+0
;botrungtam.c,564 :: 		}
L_timer1_isr149:
;botrungtam.c,566 :: 		if(KEYCARD_ENABLE==0)
MOVW	R0, #lo_addr(_KEYCARD_ENABLE+0)
MOVT	R0, #hi_addr(_KEYCARD_ENABLE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr159
;botrungtam.c,567 :: 		{out_relay=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
STR	R1, [R0, #0]
;botrungtam.c,568 :: 		ACCENT_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ACCENT_STATUS+0)
MOVT	R0, #hi_addr(_ACCENT_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,569 :: 		AMBIENT_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_AMBIENT_STATUS+0)
MOVT	R0, #hi_addr(_AMBIENT_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,570 :: 		MASTER_BEDROOM_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_MASTER_BEDROOM_STATUS+0)
MOVT	R0, #hi_addr(_MASTER_BEDROOM_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,571 :: 		RS485_CONTROL_S9=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_CONTROL_S9+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S9+0)
STRB	R1, [R0, #0]
;botrungtam.c,572 :: 		RS485_CONTROL_S10=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_CONTROL_S10+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S10+0)
STRB	R1, [R0, #0]
;botrungtam.c,573 :: 		RS485_CONTROL_S9_S11=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_CONTROL_S9_S11+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S9_S11+0)
STRB	R1, [R0, #0]
;botrungtam.c,574 :: 		RS485_STATUS_S9=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_STATUS_S9+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S9+0)
STRB	R1, [R0, #0]
;botrungtam.c,575 :: 		RS485_STATUS_S10=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_STATUS_S10+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S10+0)
STRB	R1, [R0, #0]
;botrungtam.c,576 :: 		RS485_STATUS_S9_S11=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_STATUS_S9_S11+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S9_S11+0)
STRB	R1, [R0, #0]
;botrungtam.c,577 :: 		xuat_32bit(out_relay);
MOV	R0, #0
BL	_xuat_32bit+0
;botrungtam.c,578 :: 		}
L_timer1_isr159:
;botrungtam.c,579 :: 		}
L_timer1_isr40:
;botrungtam.c,580 :: 		}
L_end_timer1_isr:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _timer1_isr
_uart4_rx:
;botrungtam.c,582 :: 		void uart4_rx() iv IVT_INT_UART4 ics ICS_AUTO {
;botrungtam.c,585 :: 		if(UART4_SRbits.RXNE){   // RXNE: Read data register not empty
MOVW	R1, #lo_addr(UART4_SRbits+0)
MOVT	R1, #hi_addr(UART4_SRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_uart4_rx160
;botrungtam.c,586 :: 		UART4_SRbits.RXNE=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(UART4_SRbits+0)
MOVT	R0, #hi_addr(UART4_SRbits+0)
STR	R1, [R0, #0]
;botrungtam.c,587 :: 		data_rc=UART4_DRbits.DR;
MOVW	R0, #lo_addr(UART4_DRbits+0)
MOVT	R0, #hi_addr(UART4_DRbits+0)
LDRH	R0, [R0, #0]
UBFX	R0, R0, #0, #9
; data_rc start address is: 12 (R3)
UXTB	R3, R0
;botrungtam.c,591 :: 		if(DATA_TRUE){
MOVW	R0, #lo_addr(_DATA_TRUE+0)
MOVT	R0, #hi_addr(_DATA_TRUE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_uart4_rx161
;botrungtam.c,592 :: 		buf_rc_u4[count_buf_rc_4++]=data_rc;
MOVW	R2, #lo_addr(_count_buf_rc_4+0)
MOVT	R2, #hi_addr(_count_buf_rc_4+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_buf_rc_u4+0)
MOVT	R0, #hi_addr(_buf_rc_u4+0)
ADDS	R0, R0, R1
STRB	R3, [R0, #0]
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
STRB	R0, [R2, #0]
;botrungtam.c,593 :: 		}
L_uart4_rx161:
;botrungtam.c,594 :: 		if(count_buf_rc_4==0){    // received header
MOVW	R0, #lo_addr(_count_buf_rc_4+0)
MOVT	R0, #hi_addr(_count_buf_rc_4+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_uart4_rx162
;botrungtam.c,595 :: 		if(data_rc==0x4B){    // header is "K"
CMP	R3, #75
IT	NE
BNE	L_uart4_rx163
;botrungtam.c,597 :: 		DATA_TRUE=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_DATA_TRUE+0)
MOVT	R0, #hi_addr(_DATA_TRUE+0)
STRB	R1, [R0, #0]
;botrungtam.c,599 :: 		}
L_uart4_rx163:
;botrungtam.c,600 :: 		}
L_uart4_rx162:
;botrungtam.c,602 :: 		if(count_buf_rc_4>=6){
MOVW	R0, #lo_addr(_count_buf_rc_4+0)
MOVT	R0, #hi_addr(_count_buf_rc_4+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	CC
BCC	L_uart4_rx164
;botrungtam.c,604 :: 		DATA_TRUE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_DATA_TRUE+0)
MOVT	R0, #hi_addr(_DATA_TRUE+0)
STRB	R1, [R0, #0]
;botrungtam.c,605 :: 		if(data_rc==0x4D){    // "M"
CMP	R3, #77
IT	NE
BNE	L_uart4_rx165
; data_rc end address is: 12 (R3)
;botrungtam.c,606 :: 		PROCESSING_RS485=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_PROCESSING_RS485+0)
MOVT	R0, #hi_addr(_PROCESSING_RS485+0)
STRB	R1, [R0, #0]
;botrungtam.c,607 :: 		count_buf_rc_4=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_count_buf_rc_4+0)
MOVT	R0, #hi_addr(_count_buf_rc_4+0)
STRB	R1, [R0, #0]
;botrungtam.c,609 :: 		}
L_uart4_rx165:
;botrungtam.c,610 :: 		}
L_uart4_rx164:
;botrungtam.c,612 :: 		}
L_uart4_rx160:
;botrungtam.c,613 :: 		}
L_end_uart4_rx:
BX	LR
; end of _uart4_rx
_main:
;botrungtam.c,615 :: 		void main() {
;botrungtam.c,616 :: 		gpio_init();
BL	_gpio_init+0
;botrungtam.c,617 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_14);   // KICK MOSFET IRF9530 FOR RELAY 12V
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,618 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_15);
MOVW	R1, #32768
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,619 :: 		duphong8_C14=0;      // KICK MOSFET IRF9530 FOR RELAY 12V
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,620 :: 		duphong9_C15=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,621 :: 		out_relay=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
STR	R1, [R0, #0]
;botrungtam.c,622 :: 		xuat_32bit(out_relay);
MOV	R0, #0
BL	_xuat_32bit+0
;botrungtam.c,623 :: 		delay_ms(1500);
MOVW	R7, #43135
MOVT	R7, #274
NOP
NOP
L_main166:
SUBS	R7, R7, #1
BNE	L_main166
NOP
NOP
NOP
;botrungtam.c,625 :: 		buf_rc_u4[0]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+0)
MOVT	R0, #hi_addr(_buf_rc_u4+0)
STRB	R1, [R0, #0]
;botrungtam.c,626 :: 		buf_rc_u4[1]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+1)
MOVT	R0, #hi_addr(_buf_rc_u4+1)
STRB	R1, [R0, #0]
;botrungtam.c,627 :: 		buf_rc_u4[2]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+2)
MOVT	R0, #hi_addr(_buf_rc_u4+2)
STRB	R1, [R0, #0]
;botrungtam.c,628 :: 		buf_rc_u4[3]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+3)
MOVT	R0, #hi_addr(_buf_rc_u4+3)
STRB	R1, [R0, #0]
;botrungtam.c,629 :: 		buf_rc_u4[4]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+4)
MOVT	R0, #hi_addr(_buf_rc_u4+4)
STRB	R1, [R0, #0]
;botrungtam.c,630 :: 		buf_rc_u4[5]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+5)
MOVT	R0, #hi_addr(_buf_rc_u4+5)
STRB	R1, [R0, #0]
;botrungtam.c,631 :: 		buf_rc_u4[6]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+6)
MOVT	R0, #hi_addr(_buf_rc_u4+6)
STRB	R1, [R0, #0]
;botrungtam.c,632 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_12);   // den bao mau xanh da troi Port A12
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,633 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_8);   //
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,634 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_9);   // KICK MOSFET IRF9530 FOR RELAY 12V
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,637 :: 		GPIO_Digital_Input (&GPIOD_BASE, _GPIO_PINMASK_6 );  // button ACinput here!
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
;botrungtam.c,639 :: 		GPIO_Config(&GPIOD_BASE,_GPIO_PINMASK_6,_GPIO_CFG_MODE_INPUT | _GPIO_CFG_PULL_UP);
MOVS	R2, #130
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Config+0
;botrungtam.c,642 :: 		GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_7);   //
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,643 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_3);   //
MOVW	R1, #8
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,644 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_4);   //
MOVW	R1, #16
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,645 :: 		STAT=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,646 :: 		duphong66_C9=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,647 :: 		duphong67_A8=1;
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,648 :: 		duphong88_D7=1;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,649 :: 		duphong89_B3=1;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,650 :: 		duphong90_B4=1;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,652 :: 		usart2_init();
BL	_usart2_init+0
;botrungtam.c,653 :: 		uart4__init();   //bauld=9600 rs485 uart 4
BL	_uart4__init+0
;botrungtam.c,664 :: 		timer1_init();
BL	_timer1_init+0
;botrungtam.c,665 :: 		memset(but_state,0,24);
MOVS	R2, #24
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
BL	_memset+0
;botrungtam.c,666 :: 		delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main168:
SUBS	R7, R7, #1
BNE	L_main168
NOP
NOP
NOP
;botrungtam.c,668 :: 		RCC_APB1ENR.B11 = 1;            // Enable clock gating for Watchdog Timer 0 module
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;botrungtam.c,669 :: 		WWDG_CFR = 1;                   // Write window value to be compared to the downcounter
MOVS	R1, #1
MOVW	R0, #lo_addr(WWDG_CFR+0)
MOVT	R0, #hi_addr(WWDG_CFR+0)
STR	R1, [R0, #0]
;botrungtam.c,670 :: 		while(1){
L_main170:
;botrungtam.c,675 :: 		if(KEYCARD_INSERT){KEYCARD_COUNTER_CLOSE=0;}
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main172
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_COUNTER_CLOSE+0)
MOVT	R0, #hi_addr(_KEYCARD_COUNTER_CLOSE+0)
STR	R1, [R0, #0]
L_main172:
;botrungtam.c,677 :: 		if(!KEYCARD_INSERT){
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main173
;botrungtam.c,678 :: 		KEYCARD_COUNTER_CLOSE++;
MOVW	R2, #lo_addr(_KEYCARD_COUNTER_CLOSE+0)
MOVT	R2, #hi_addr(_KEYCARD_COUNTER_CLOSE+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #1
STR	R1, [R2, #0]
;botrungtam.c,679 :: 		if(KEYCARD_COUNTER_CLOSE>=0x001fffff) {
MOVW	R0, #65535
MOVT	R0, #31
CMP	R1, R0
IT	CC
BCC	L_main174
;botrungtam.c,680 :: 		KEYCARD_COUNTER_CLOSE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_COUNTER_CLOSE+0)
MOVT	R0, #hi_addr(_KEYCARD_COUNTER_CLOSE+0)
STR	R1, [R0, #0]
;botrungtam.c,681 :: 		KEYCARD_ENABLE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_ENABLE+0)
MOVT	R0, #hi_addr(_KEYCARD_ENABLE+0)
STRB	R1, [R0, #0]
;botrungtam.c,683 :: 		out_relay=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
STR	R1, [R0, #0]
;botrungtam.c,685 :: 		STAT=0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,686 :: 		MASTER_BEDROOM_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_MASTER_BEDROOM_STATUS+0)
MOVT	R0, #hi_addr(_MASTER_BEDROOM_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,687 :: 		AMBIENT_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_AMBIENT_STATUS+0)
MOVT	R0, #hi_addr(_AMBIENT_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,688 :: 		ACCENT_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ACCENT_STATUS+0)
MOVT	R0, #hi_addr(_ACCENT_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,689 :: 		RS485_CONTROL_S9=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_CONTROL_S9+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S9+0)
STRB	R1, [R0, #0]
;botrungtam.c,690 :: 		RS485_CONTROL_S10=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_CONTROL_S10+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S10+0)
STRB	R1, [R0, #0]
;botrungtam.c,691 :: 		RS485_CONTROL_S9_S11=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_CONTROL_S9_S11+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S9_S11+0)
STRB	R1, [R0, #0]
;botrungtam.c,692 :: 		RS485_STATUS_S9=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_STATUS_S9+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S9+0)
STRB	R1, [R0, #0]
;botrungtam.c,693 :: 		RS485_STATUS_S10=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_STATUS_S10+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S10+0)
STRB	R1, [R0, #0]
;botrungtam.c,694 :: 		RS485_STATUS_S9_S11=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_STATUS_S9_S11+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S9_S11+0)
STRB	R1, [R0, #0]
;botrungtam.c,697 :: 		LED_11_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,698 :: 		LED_11_1=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,699 :: 		LED_9_0=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,700 :: 		LED_9_1=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,701 :: 		LED_7_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,703 :: 		LED_10_0=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,704 :: 		LED_10_1=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,706 :: 		LED_8_0=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,707 :: 		LED_8_1=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,709 :: 		LED_6_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,711 :: 		LED_5_0=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,712 :: 		LED_5_1=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,714 :: 		LED_4_0=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,715 :: 		LED_4_1=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,717 :: 		LED_3_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,719 :: 		LED_3_2=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,721 :: 		LED_2_0=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,722 :: 		LED_2_1=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,723 :: 		LED_2_2=0;
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,725 :: 		LED_1_0=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,726 :: 		LED_1_1=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,727 :: 		LED_1_2=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,728 :: 		}
L_main174:
;botrungtam.c,729 :: 		}
L_main173:
;botrungtam.c,731 :: 		if(PROCESSING_RS485){
MOVW	R0, #lo_addr(_PROCESSING_RS485+0)
MOVT	R0, #hi_addr(_PROCESSING_RS485+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main175
;botrungtam.c,740 :: 		PROCESSING_RS485=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_PROCESSING_RS485+0)
MOVT	R0, #hi_addr(_PROCESSING_RS485+0)
STRB	R1, [R0, #0]
;botrungtam.c,741 :: 		if(buf_rc_u4[4]==0x45){ // 0x4D= "E"
MOVW	R0, #lo_addr(_buf_rc_u4+4)
MOVT	R0, #hi_addr(_buf_rc_u4+4)
LDRB	R0, [R0, #0]
CMP	R0, #69
IT	NE
BNE	L_main176
;botrungtam.c,742 :: 		KEYCARD_INSERT=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
STRB	R1, [R0, #0]
;botrungtam.c,743 :: 		buf_rc_u4[5]=0; // CLEAR DATA
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+5)
MOVT	R0, #hi_addr(_buf_rc_u4+5)
STRB	R1, [R0, #0]
;botrungtam.c,744 :: 		STAT = ~STAT;
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,745 :: 		}
L_main176:
;botrungtam.c,747 :: 		if(buf_rc_u4[4]==0x48){ // 0x4D= "H"
MOVW	R0, #lo_addr(_buf_rc_u4+4)
MOVT	R0, #hi_addr(_buf_rc_u4+4)
LDRB	R0, [R0, #0]
CMP	R0, #72
IT	NE
BNE	L_main177
;botrungtam.c,748 :: 		KEYCARD_INSERT=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
STRB	R1, [R0, #0]
;botrungtam.c,749 :: 		KEYCARD_ENABLE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_ENABLE+0)
MOVT	R0, #hi_addr(_KEYCARD_ENABLE+0)
STRB	R1, [R0, #0]
;botrungtam.c,751 :: 		out_relay=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
STR	R1, [R0, #0]
;botrungtam.c,753 :: 		STAT=0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,754 :: 		MASTER_BEDROOM_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_MASTER_BEDROOM_STATUS+0)
MOVT	R0, #hi_addr(_MASTER_BEDROOM_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,755 :: 		AMBIENT_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_AMBIENT_STATUS+0)
MOVT	R0, #hi_addr(_AMBIENT_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,756 :: 		ACCENT_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ACCENT_STATUS+0)
MOVT	R0, #hi_addr(_ACCENT_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,757 :: 		RS485_CONTROL_S9=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_CONTROL_S9+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S9+0)
STRB	R1, [R0, #0]
;botrungtam.c,758 :: 		RS485_CONTROL_S10=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_CONTROL_S10+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S10+0)
STRB	R1, [R0, #0]
;botrungtam.c,759 :: 		RS485_CONTROL_S9_S11=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_CONTROL_S9_S11+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S9_S11+0)
STRB	R1, [R0, #0]
;botrungtam.c,760 :: 		RS485_STATUS_S9=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_STATUS_S9+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S9+0)
STRB	R1, [R0, #0]
;botrungtam.c,761 :: 		RS485_STATUS_S10=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_STATUS_S10+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S10+0)
STRB	R1, [R0, #0]
;botrungtam.c,762 :: 		RS485_STATUS_S9_S11=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_STATUS_S9_S11+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S9_S11+0)
STRB	R1, [R0, #0]
;botrungtam.c,764 :: 		LED_11_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,765 :: 		LED_11_1=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,766 :: 		LED_9_0=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,767 :: 		LED_9_1=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,768 :: 		LED_7_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,770 :: 		LED_10_0=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,771 :: 		LED_10_1=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,773 :: 		LED_8_0=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,774 :: 		LED_8_1=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,776 :: 		LED_6_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,778 :: 		LED_5_0=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,779 :: 		LED_5_1=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,781 :: 		LED_4_0=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,782 :: 		LED_4_1=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,784 :: 		LED_3_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,786 :: 		LED_3_2=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,788 :: 		LED_2_0=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,789 :: 		LED_2_1=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,790 :: 		LED_2_2=0;
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,792 :: 		LED_1_0=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,793 :: 		LED_1_1=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,794 :: 		LED_1_2=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,795 :: 		}
L_main177:
;botrungtam.c,796 :: 		}
L_main175:
;botrungtam.c,798 :: 		if(RS485_CONTROL_S9_S11){
MOVW	R0, #lo_addr(_RS485_CONTROL_S9_S11+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S9_S11+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main178
;botrungtam.c,799 :: 		RS485_CONTROL_S9_S11=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_CONTROL_S9_S11+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S9_S11+0)
STRB	R1, [R0, #0]
;botrungtam.c,800 :: 		STAT=~STAT;
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,801 :: 		if(RS485_STATUS_S9_S11==1)
MOVW	R0, #lo_addr(_RS485_STATUS_S9_S11+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S9_S11+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main179
;botrungtam.c,803 :: 		out_relay|=S8;        // S8=RELAY_8
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #128
STR	R0, [R1, #0]
;botrungtam.c,804 :: 		LED_1_1=1;            // LED BUTTON2-PORT1 ON
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,805 :: 		TRAN_4
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,807 :: 		uart4_chr(0x4B);    //"K"
MOVS	R0, #75
BL	_uart4_chr+0
;botrungtam.c,808 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,809 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,810 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,811 :: 		uart4_chr(0x42);    //"B"
MOVS	R0, #66
BL	_uart4_chr+0
;botrungtam.c,812 :: 		uart4_chr(0x33);    //"3"
MOVS	R0, #51
BL	_uart4_chr+0
;botrungtam.c,813 :: 		uart4_chr(0x4D);    //"M"
MOVS	R0, #77
BL	_uart4_chr+0
;botrungtam.c,814 :: 		uart4_chr(0x0D);
MOVS	R0, #13
BL	_uart4_chr+0
;botrungtam.c,815 :: 		uart4_chr(0x0A);
MOVS	R0, #10
BL	_uart4_chr+0
;botrungtam.c,816 :: 		REC_4
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,817 :: 		}
L_main179:
;botrungtam.c,818 :: 		if(RS485_STATUS_S9_S11==0)
MOVW	R0, #lo_addr(_RS485_STATUS_S9_S11+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S9_S11+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main180
;botrungtam.c,820 :: 		out_relay&=~S8;   // s8=RELAY_8
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
AND	R0, R0, #127
STR	R0, [R1, #0]
;botrungtam.c,821 :: 		LED_1_1=0;            // LED BUTTON2-PORT1 OFF
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,822 :: 		TRAN_4              // send : K000T3M
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,823 :: 		uart4_chr(0x4B);    //"K"
MOVS	R0, #75
BL	_uart4_chr+0
;botrungtam.c,824 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,825 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,826 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,827 :: 		uart4_chr(0x54);    //"T"
MOVS	R0, #84
BL	_uart4_chr+0
;botrungtam.c,828 :: 		uart4_chr(0x33);    //"3'
MOVS	R0, #51
BL	_uart4_chr+0
;botrungtam.c,829 :: 		uart4_chr(0x4D);    //"M"
MOVS	R0, #77
BL	_uart4_chr+0
;botrungtam.c,830 :: 		uart4_chr(0x0D);
MOVS	R0, #13
BL	_uart4_chr+0
;botrungtam.c,831 :: 		uart4_chr(0x0A);
MOVS	R0, #10
BL	_uart4_chr+0
;botrungtam.c,832 :: 		REC_4
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,833 :: 		}
L_main180:
;botrungtam.c,834 :: 		}
L_main178:
;botrungtam.c,836 :: 		if(RS485_CONTROL_S9==1){
MOVW	R0, #lo_addr(_RS485_CONTROL_S9+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S9+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main181
;botrungtam.c,837 :: 		RS485_CONTROL_S9=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_CONTROL_S9+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S9+0)
STRB	R1, [R0, #0]
;botrungtam.c,838 :: 		STAT=~STAT;
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,839 :: 		if(RS485_STATUS_S9)
MOVW	R0, #lo_addr(_RS485_STATUS_S9+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S9+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main182
;botrungtam.c,841 :: 		LED_3_0=1;       // LED PORT3 ON
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,842 :: 		LED_5_0=1;       // LED PORT5 ON
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,843 :: 		out_relay|=S12;      // S12 - RELAY_7
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #64
STR	R0, [R1, #0]
;botrungtam.c,844 :: 		TRAN_4   // send : K000B2M
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,845 :: 		uart4_chr(0x4B);    //"K"
MOVS	R0, #75
BL	_uart4_chr+0
;botrungtam.c,846 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,847 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,848 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,849 :: 		uart4_chr(0x42);    //"B"
MOVS	R0, #66
BL	_uart4_chr+0
;botrungtam.c,850 :: 		uart4_chr(0x32);    //"2"
MOVS	R0, #50
BL	_uart4_chr+0
;botrungtam.c,851 :: 		uart4_chr(0x4D);    //"M"
MOVS	R0, #77
BL	_uart4_chr+0
;botrungtam.c,852 :: 		uart4_chr(0x0D);
MOVS	R0, #13
BL	_uart4_chr+0
;botrungtam.c,853 :: 		uart4_chr(0x0A);
MOVS	R0, #10
BL	_uart4_chr+0
;botrungtam.c,854 :: 		REC_4
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,855 :: 		}
L_main182:
;botrungtam.c,856 :: 		if(!RS485_STATUS_S9)
MOVW	R0, #lo_addr(_RS485_STATUS_S9+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S9+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main183
;botrungtam.c,858 :: 		LED_3_0=0;            // LED PORT3 OFF
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,859 :: 		LED_5_0=0;           // LED PORT5 OFF
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,860 :: 		out_relay&=~S12;      // S12 - RELAY_7
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #64
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,861 :: 		TRAN_4               // send : K000T2M
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,862 :: 		uart4_chr(0x4B);    //"K"
MOVS	R0, #75
BL	_uart4_chr+0
;botrungtam.c,863 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,864 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,865 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,866 :: 		uart4_chr(0x54);    //"T"
MOVS	R0, #84
BL	_uart4_chr+0
;botrungtam.c,867 :: 		uart4_chr(0x32);    //"2"
MOVS	R0, #50
BL	_uart4_chr+0
;botrungtam.c,868 :: 		uart4_chr(0x4D);    //"M"
MOVS	R0, #77
BL	_uart4_chr+0
;botrungtam.c,869 :: 		uart4_chr(0x0D);
MOVS	R0, #13
BL	_uart4_chr+0
;botrungtam.c,870 :: 		uart4_chr(0x0A);
MOVS	R0, #10
BL	_uart4_chr+0
;botrungtam.c,871 :: 		REC_4
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,872 :: 		}
L_main183:
;botrungtam.c,873 :: 		}
L_main181:
;botrungtam.c,874 :: 		if(RS485_CONTROL_S10==1){
MOVW	R0, #lo_addr(_RS485_CONTROL_S10+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S10+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main184
;botrungtam.c,875 :: 		RS485_CONTROL_S10=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_RS485_CONTROL_S10+0)
MOVT	R0, #hi_addr(_RS485_CONTROL_S10+0)
STRB	R1, [R0, #0]
;botrungtam.c,876 :: 		STAT=~STAT;
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,877 :: 		if(RS485_STATUS_S10)
MOVW	R0, #lo_addr(_RS485_STATUS_S10+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S10+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main185
;botrungtam.c,878 :: 		{LED_1_2=1;     // LED PORT1 0N
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,879 :: 		TRAN_4              // send : K000B1M
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,880 :: 		uart4_chr(0x4B);    //"K"
MOVS	R0, #75
BL	_uart4_chr+0
;botrungtam.c,881 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,882 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,883 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,884 :: 		uart4_chr(0x42);    //"B"
MOVS	R0, #66
BL	_uart4_chr+0
;botrungtam.c,885 :: 		uart4_chr(0x31);    //"1"
MOVS	R0, #49
BL	_uart4_chr+0
;botrungtam.c,886 :: 		uart4_chr(0x4D);    //"M"
MOVS	R0, #77
BL	_uart4_chr+0
;botrungtam.c,887 :: 		uart4_chr(0x0D);
MOVS	R0, #13
BL	_uart4_chr+0
;botrungtam.c,888 :: 		uart4_chr(0x0A);
MOVS	R0, #10
BL	_uart4_chr+0
;botrungtam.c,889 :: 		REC_4
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,890 :: 		}
L_main185:
;botrungtam.c,891 :: 		if(!RS485_STATUS_S10)
MOVW	R0, #lo_addr(_RS485_STATUS_S10+0)
MOVT	R0, #hi_addr(_RS485_STATUS_S10+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main186
;botrungtam.c,892 :: 		{LED_1_2=0;     // LED PORT1 0ff
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,893 :: 		TRAN_4              // send : K00001M
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,894 :: 		uart4_chr(0x4B);    //"K"
MOVS	R0, #75
BL	_uart4_chr+0
;botrungtam.c,895 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,896 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,897 :: 		uart4_chr(0x30);    //0
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,898 :: 		uart4_chr(0x54);    //"T"
MOVS	R0, #84
BL	_uart4_chr+0
;botrungtam.c,899 :: 		uart4_chr(0x31);    //"1"
MOVS	R0, #49
BL	_uart4_chr+0
;botrungtam.c,900 :: 		uart4_chr(0x4D);    //"M"
MOVS	R0, #77
BL	_uart4_chr+0
;botrungtam.c,901 :: 		uart4_chr(0x0D);
MOVS	R0, #13
BL	_uart4_chr+0
;botrungtam.c,902 :: 		uart4_chr(0x0A);
MOVS	R0, #10
BL	_uart4_chr+0
;botrungtam.c,903 :: 		REC_4
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,904 :: 		}
L_main186:
;botrungtam.c,905 :: 		}
L_main184:
;botrungtam.c,910 :: 		}
IT	AL
BAL	L_main170
;botrungtam.c,911 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
