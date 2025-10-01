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
L__xuat_32bit454:
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
BHI	L__xuat_32bit454
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
BEQ	L__get_point457
ADDS	R3, R4, R2
LDRB	R3, [R3, #0]
CMP	R3, #32
IT	EQ
BEQ	L__get_point456
IT	AL
BAL	L_get_point37
; start end address is: 8 (R2)
; s end address is: 16 (R4)
L__get_point457:
L__get_point456:
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
_settingEthenet:
;botrungtam.c,148 :: 		void settingEthenet(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;botrungtam.c,149 :: 		ptr = (unsigned long*)Address;
MOVW	R2, #lo_addr(_Address+0)
MOVT	R2, #hi_addr(_Address+0)
LDR	R1, [R2, #0]
MOVW	R0, #lo_addr(_ptr+0)
MOVT	R0, #hi_addr(_ptr+0)
STR	R1, [R0, #0]
;botrungtam.c,150 :: 		i=*ptr;
MOV	R0, R2
LDR	R0, [R0, #0]
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STR	R1, [R0, #0]
;botrungtam.c,151 :: 		if(i==0xffffffff){    // khi moi nap frimware thi dia chi ip se la fffffff
CMP	R1, #-1
IT	NE
BNE	L_settingEthenet38
;botrungtam.c,152 :: 		FLASH_ErasePage(Address);
MOVW	R0, #lo_addr(_Address+0)
MOVT	R0, #hi_addr(_Address+0)
LDR	R0, [R0, #0]
BL	_FLASH_ErasePage+0
;botrungtam.c,158 :: 		FLASH_Write_Word(Address,0xC0A8017B);     // c0:a8:01:7B  = 192.168.1.123
MOVW	R0, #lo_addr(_Address+0)
MOVT	R0, #hi_addr(_Address+0)
LDR	R0, [R0, #0]
MOVW	R1, #379
MOVT	R1, #49320
BL	_FLASH_Write_Word+0
;botrungtam.c,159 :: 		}
L_settingEthenet38:
;botrungtam.c,161 :: 		myIpAddr[0]=i>>24;
MOVW	R1, #lo_addr(_i+0)
MOVT	R1, #hi_addr(_i+0)
LDR	R0, [R1, #0]
LSRS	R0, R0, #24
MOVW	R4, #lo_addr(_myIpAddr+0)
MOVT	R4, #hi_addr(_myIpAddr+0)
STRB	R0, [R4, #0]
;botrungtam.c,162 :: 		myIpAddr[1]=i>>16;
MOV	R0, R1
LDR	R0, [R0, #0]
LSRS	R0, R0, #16
MOVW	R3, #lo_addr(_myIpAddr+1)
MOVT	R3, #hi_addr(_myIpAddr+1)
STRB	R0, [R3, #0]
;botrungtam.c,163 :: 		myIpAddr[2]=i>>8;
MOV	R0, R1
LDR	R0, [R0, #0]
LSRS	R0, R0, #8
MOVW	R2, #lo_addr(_myIpAddr+2)
MOVT	R2, #hi_addr(_myIpAddr+2)
STRB	R0, [R2, #0]
;botrungtam.c,164 :: 		myIpAddr[3]=i;
MOV	R0, R1
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_myIpAddr+3)
MOVT	R0, #hi_addr(_myIpAddr+3)
STRB	R1, [R0, #0]
;botrungtam.c,165 :: 		gwIpAddr[0]=myIpAddr[0];
MOV	R0, R4
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_gwIpAddr+0)
MOVT	R0, #hi_addr(_gwIpAddr+0)
STRB	R1, [R0, #0]
;botrungtam.c,166 :: 		gwIpAddr[1]=myIpAddr[1];
MOV	R0, R3
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_gwIpAddr+1)
MOVT	R0, #hi_addr(_gwIpAddr+1)
STRB	R1, [R0, #0]
;botrungtam.c,167 :: 		gwIpAddr[2]=myIpAddr[2];
MOV	R0, R2
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_gwIpAddr+2)
MOVT	R0, #hi_addr(_gwIpAddr+2)
STRB	R1, [R0, #0]
;botrungtam.c,168 :: 		gwIpAddr[3]=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_gwIpAddr+3)
MOVT	R0, #hi_addr(_gwIpAddr+3)
STRB	R1, [R0, #0]
;botrungtam.c,169 :: 		SPI_Ethernet_Init(myMacAddr, myIpAddr, SPI_Ethernet_FULLDUPLEX);
MOVS	R2, #1
MOVW	R1, #lo_addr(_myIpAddr+0)
MOVT	R1, #hi_addr(_myIpAddr+0)
MOVW	R0, #lo_addr(_myMacAddr+0)
MOVT	R0, #hi_addr(_myMacAddr+0)
BL	_SPI_Ethernet_Init+0
;botrungtam.c,170 :: 		SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr);
MOVW	R2, #lo_addr(_dnsIpAddr+0)
MOVT	R2, #hi_addr(_dnsIpAddr+0)
MOVW	R1, #lo_addr(_gwIpAddr+0)
MOVT	R1, #hi_addr(_gwIpAddr+0)
MOVW	R0, #lo_addr(_ipMask+0)
MOVT	R0, #hi_addr(_ipMask+0)
BL	_SPI_Ethernet_confNetwork+0
;botrungtam.c,171 :: 		}
L_end_settingEthenet:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _settingEthenet
_putChar:
;botrungtam.c,172 :: 		void putChar(unsigned char c){
;botrungtam.c,173 :: 		while(UART4_SRbits.TC==0);
L_putChar39:
MOVW	R2, #lo_addr(UART4_SRbits+0)
MOVT	R2, #hi_addr(UART4_SRbits+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_putChar40
IT	AL
BAL	L_putChar39
L_putChar40:
;botrungtam.c,174 :: 		UART4_DRbits.DR = c;
UXTB	R3, R0
MOVW	R2, #lo_addr(UART4_DRbits+0)
MOVT	R2, #hi_addr(UART4_DRbits+0)
LDRH	R1, [R2, #0]
BFI	R1, R3, #0, #9
STRH	R1, [R2, #0]
;botrungtam.c,175 :: 		}
L_end_putChar:
BX	LR
; end of _putChar
_saveIP:
;botrungtam.c,176 :: 		void saveIP(unsigned char buf[]){
SUB	SP, SP, #16
STR	LR, [SP, #0]
;botrungtam.c,178 :: 		unsigned char i=0,j,pos=0;
; i start address is: 8 (R2)
MOVS	R2, #0
; i end address is: 8 (R2)
;botrungtam.c,179 :: 		while(i<39){
L_saveIP41:
; i start address is: 8 (R2)
CMP	R2, #39
IT	CS
BCS	L_saveIP42
;botrungtam.c,180 :: 		if(buf[i]=='i'&&buf[i+1]=='p'){
ADDS	R1, R0, R2
LDRB	R1, [R1, #0]
CMP	R1, #105
IT	NE
BNE	L__saveIP487
ADDS	R1, R2, #1
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #112
IT	NE
BNE	L__saveIP488
L__saveIP466:
;botrungtam.c,181 :: 		for(j=0;j<4;j++){
MOVS	R1, #0
STRB	R1, [SP, #12]
; i end address is: 8 (R2)
UXTB	R5, R2
L_saveIP46:
; i start address is: 20 (R5)
LDRB	R1, [SP, #12]
CMP	R1, #4
IT	CS
BCS	L_saveIP47
;botrungtam.c,182 :: 		if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]<48||buf[i+5]>57)){
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP470
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP469
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP468
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP467
IT	AL
BAL	L_saveIP53
L__saveIP468:
L__saveIP467:
L__saveIP464:
;botrungtam.c,183 :: 		ipAddress[j]=buf[i+4]-48;
LDRB	R2, [SP, #12]
MOVW	R1, #lo_addr(_ipAddress+0)
MOVT	R1, #hi_addr(_ipAddress+0)
ADDS	R2, R1, R2
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
SUBS	R1, #48
STRB	R1, [R2, #0]
;botrungtam.c,184 :: 		i+=2;
ADDS	R1, R5, #2
UXTB	R5, R1
;botrungtam.c,185 :: 		}
IT	AL
BAL	L_saveIP54
L_saveIP53:
;botrungtam.c,182 :: 		if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]<48||buf[i+5]>57)){
L__saveIP470:
L__saveIP469:
;botrungtam.c,186 :: 		else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]<48||buf[i+6]>57)){
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP476
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP475
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CS
BCS	L__saveIP472
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	LS
BLS	L__saveIP471
IT	AL
BAL	L_saveIP61
L__saveIP472:
L__saveIP471:
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP474
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP473
IT	AL
BAL	L_saveIP61
L__saveIP474:
L__saveIP473:
L__saveIP461:
;botrungtam.c,187 :: 		ipAddress[j]=10*(buf[i+4]-48)+(buf[i+5]-48);
LDRB	R2, [SP, #12]
MOVW	R1, #lo_addr(_ipAddress+0)
MOVT	R1, #hi_addr(_ipAddress+0)
ADDS	R3, R1, R2
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
SUBW	R2, R1, #48
SXTH	R2, R2
MOVS	R1, #10
SXTH	R1, R1
MULS	R2, R1, R2
SXTH	R2, R2
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
SUBS	R1, #48
SXTH	R1, R1
ADDS	R1, R2, R1
STRB	R1, [R3, #0]
;botrungtam.c,188 :: 		i+=3;
ADDS	R1, R5, #3
; i end address is: 20 (R5)
; i start address is: 4 (R1)
UXTB	R1, R1
;botrungtam.c,189 :: 		}
UXTB	R5, R1
; i end address is: 4 (R1)
IT	AL
BAL	L_saveIP62
L_saveIP61:
;botrungtam.c,186 :: 		else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]<48||buf[i+6]>57)){
; i start address is: 20 (R5)
L__saveIP476:
L__saveIP475:
;botrungtam.c,190 :: 		else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]>=48||buf[i+6]<=57)){
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP485
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP486
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CS
BCS	L__saveIP478
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	LS
BLS	L__saveIP477
UXTB	R1, R5
IT	AL
BAL	L_saveIP69
L__saveIP478:
L__saveIP477:
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CS
BCS	L__saveIP480
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	LS
BLS	L__saveIP479
UXTB	R1, R5
IT	AL
BAL	L_saveIP69
L__saveIP480:
L__saveIP479:
L__saveIP458:
;botrungtam.c,191 :: 		ipAddress[j]=100*(buf[i+4]-48)+10*(buf[i+5]-48)+(buf[i+6]-48);
LDRB	R2, [SP, #12]
MOVW	R1, #lo_addr(_ipAddress+0)
MOVT	R1, #hi_addr(_ipAddress+0)
ADDS	R4, R1, R2
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
SUBW	R2, R1, #48
SXTH	R2, R2
MOVS	R1, #100
SXTH	R1, R1
MUL	R3, R1, R2
SXTH	R3, R3
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
SUBW	R2, R1, #48
SXTH	R2, R2
MOVS	R1, #10
SXTH	R1, R1
MULS	R1, R2, R1
SXTH	R1, R1
ADDS	R2, R3, R1
SXTH	R2, R2
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
SUBS	R1, #48
SXTH	R1, R1
ADDS	R1, R2, R1
STRB	R1, [R4, #0]
;botrungtam.c,192 :: 		i+=4;
ADDS	R1, R5, #4
; i end address is: 20 (R5)
; i start address is: 8 (R2)
UXTB	R2, R1
; i end address is: 8 (R2)
UXTB	R1, R2
;botrungtam.c,193 :: 		}
L_saveIP69:
;botrungtam.c,190 :: 		else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]>=48||buf[i+6]<=57)){
; i start address is: 4 (R1)
; i end address is: 4 (R1)
IT	AL
BAL	L__saveIP482
L__saveIP485:
UXTB	R1, R5
L__saveIP482:
; i start address is: 4 (R1)
; i end address is: 4 (R1)
IT	AL
BAL	L__saveIP481
L__saveIP486:
UXTB	R1, R5
L__saveIP481:
;botrungtam.c,193 :: 		}
; i start address is: 4 (R1)
UXTB	R5, R1
; i end address is: 4 (R1)
L_saveIP62:
; i start address is: 20 (R5)
; i end address is: 20 (R5)
L_saveIP54:
;botrungtam.c,181 :: 		for(j=0;j<4;j++){
; i start address is: 20 (R5)
LDRB	R1, [SP, #12]
ADDS	R1, R1, #1
STRB	R1, [SP, #12]
;botrungtam.c,194 :: 		}
IT	AL
BAL	L_saveIP46
L_saveIP47:
;botrungtam.c,195 :: 		FLASH_ErasePage(Address);
MOVW	R1, #lo_addr(_Address+0)
MOVT	R1, #hi_addr(_Address+0)
LDR	R1, [R1, #0]
STR	R0, [SP, #4]
MOV	R0, R1
BL	_FLASH_ErasePage+0
;botrungtam.c,196 :: 		ipword=(((unsigned long)ipAddress[0])<<24)|(((unsigned long)ipAddress[1])<<16)|(((unsigned long)ipAddress[2])<<8)|(((unsigned long)ipAddress[3]));
MOVW	R1, #lo_addr(_ipAddress+0)
MOVT	R1, #hi_addr(_ipAddress+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #24
MOVW	R1, #lo_addr(_ipAddress+1)
MOVT	R1, #hi_addr(_ipAddress+1)
LDRB	R1, [R1, #0]
LSLS	R1, R1, #16
ORRS	R2, R1
MOVW	R1, #lo_addr(_ipAddress+2)
MOVT	R1, #hi_addr(_ipAddress+2)
LDRB	R1, [R1, #0]
LSLS	R1, R1, #8
ORRS	R2, R1
MOVW	R1, #lo_addr(_ipAddress+3)
MOVT	R1, #hi_addr(_ipAddress+3)
LDRB	R1, [R1, #0]
ORRS	R2, R1
;botrungtam.c,197 :: 		FLASH_Write_Word(Address,ipWord);
MOVW	R1, #lo_addr(_Address+0)
MOVT	R1, #hi_addr(_Address+0)
LDR	R1, [R1, #0]
MOV	R0, R1
MOV	R1, R2
BL	_FLASH_Write_Word+0
LDR	R0, [SP, #4]
;botrungtam.c,198 :: 		settingEthenet();
STRB	R5, [SP, #4]
; i end address is: 20 (R5)
STR	R0, [SP, #8]
BL	_settingEthenet+0
LDR	R0, [SP, #8]
LDRB	R5, [SP, #4]
MOV	R1, R0
UXTB	R0, R5
;botrungtam.c,180 :: 		if(buf[i]=='i'&&buf[i+1]=='p'){
IT	AL
BAL	L__saveIP484
L__saveIP487:
MOV	R1, R0
UXTB	R0, R2
L__saveIP484:
; buf start address is: 4 (R1)
UXTB	R2, R0
; buf end address is: 4 (R1)
MOV	R0, R1
IT	AL
BAL	L__saveIP483
L__saveIP488:
L__saveIP483:
;botrungtam.c,200 :: 		i++;
; i start address is: 8 (R2)
ADDS	R2, R2, #1
UXTB	R2, R2
;botrungtam.c,201 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_saveIP41
L_saveIP42:
;botrungtam.c,202 :: 		}
L_end_saveIP:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _saveIP
_copyBuf:
;botrungtam.c,203 :: 		void copyBuf(unsigned char a[],unsigned char b[],unsigned char size){
; size start address is: 8 (R2)
; b start address is: 4 (R1)
SUB	SP, SP, #4
; size end address is: 8 (R2)
; b end address is: 4 (R1)
; b start address is: 4 (R1)
; size start address is: 8 (R2)
;botrungtam.c,205 :: 		for(index=0;index<size;index++){
; index start address is: 20 (R5)
MOVS	R5, #0
; size end address is: 8 (R2)
; index end address is: 20 (R5)
STRB	R2, [SP, #0]
MOV	R2, R0
LDRB	R0, [SP, #0]
L_copyBuf70:
; index start address is: 20 (R5)
; a start address is: 8 (R2)
; b start address is: 4 (R1)
; b end address is: 4 (R1)
; a start address is: 8 (R2)
; a end address is: 8 (R2)
CMP	R5, R0
IT	CS
BCS	L_copyBuf71
; b end address is: 4 (R1)
; a end address is: 8 (R2)
;botrungtam.c,206 :: 		b[index]=a[index];
; a start address is: 8 (R2)
; b start address is: 4 (R1)
ADDS	R4, R1, R5
ADDS	R3, R2, R5
LDRB	R3, [R3, #0]
STRB	R3, [R4, #0]
;botrungtam.c,205 :: 		for(index=0;index<size;index++){
ADDS	R5, R5, #1
UXTB	R5, R5
;botrungtam.c,207 :: 		}
; b end address is: 4 (R1)
; a end address is: 8 (R2)
; index end address is: 20 (R5)
IT	AL
BAL	L_copyBuf70
L_copyBuf71:
;botrungtam.c,208 :: 		}
L_end_copyBuf:
ADD	SP, SP, #4
BX	LR
; end of _copyBuf
_SPI_Ethernet_UserTCP:
;botrungtam.c,209 :: 		unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags){
; localPort start address is: 8 (R2)
SUB	SP, SP, #40
STR	LR, [SP, #0]
; localPort end address is: 8 (R2)
; localPort start address is: 8 (R2)
; flags start address is: 16 (R4)
LDR	R4, [SP, #40]
; flags end address is: 16 (R4)
;botrungtam.c,210 :: 		unsigned int len=0;
;botrungtam.c,211 :: 		unsigned char vt_button=0;
MOVS	R4, #0
STRB	R4, [SP, #14]
;botrungtam.c,212 :: 		unsigned long shift=1;
MOV	R4, #1
STR	R4, [SP, #16]
;botrungtam.c,214 :: 		unsigned char locate=0,_locate=0,h=0;
;botrungtam.c,216 :: 		if(localPort != 80)
CMP	R2, #80
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP73
; localPort end address is: 8 (R2)
;botrungtam.c,218 :: 		return(0);
MOVS	R0, #0
IT	AL
BAL	L_end_SPI_Ethernet_UserTCP
;botrungtam.c,219 :: 		}
L_SPI_Ethernet_UserTCP73:
;botrungtam.c,220 :: 		for(len = 0;len < 30;len++){
MOVS	R4, #0
STRH	R4, [SP, #12]
L_SPI_Ethernet_UserTCP74:
LDRH	R4, [SP, #12]
CMP	R4, #30
IT	CS
BCS	L_SPI_Ethernet_UserTCP75
;botrungtam.c,221 :: 		getRequest[len] = SPI_Ethernet_getByte();
LDRH	R5, [SP, #12]
MOVW	R4, #lo_addr(_getRequest+0)
MOVT	R4, #hi_addr(_getRequest+0)
ADDS	R4, R4, R5
STR	R4, [SP, #36]
BL	_SPI_Ethernet_getByte+0
LDR	R4, [SP, #36]
STRB	R0, [R4, #0]
;botrungtam.c,220 :: 		for(len = 0;len < 30;len++){
LDRH	R4, [SP, #12]
ADDS	R4, R4, #1
STRH	R4, [SP, #12]
;botrungtam.c,222 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP74
L_SPI_Ethernet_UserTCP75:
;botrungtam.c,223 :: 		getRequest[len] = 0;
LDRH	R5, [SP, #12]
MOVW	R4, #lo_addr(_getRequest+0)
MOVT	R4, #hi_addr(_getRequest+0)
ADDS	R5, R4, R5
MOVS	R4, #0
STRB	R4, [R5, #0]
;botrungtam.c,224 :: 		len = 0;
MOVS	R4, #0
STRH	R4, [SP, #12]
;botrungtam.c,225 :: 		if(memcmp(getRequest, httpMethod, 5))
MOVS	R2, #5
SXTH	R2, R2
MOVW	R1, #lo_addr(_httpMethod+0)
MOVT	R1, #hi_addr(_httpMethod+0)
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_memcmp+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP77
;botrungtam.c,227 :: 		return(0);
MOVS	R0, #0
IT	AL
BAL	L_end_SPI_Ethernet_UserTCP
;botrungtam.c,228 :: 		}
L_SPI_Ethernet_UserTCP77:
;botrungtam.c,230 :: 		if(getRequest[5]=='t'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #116
IT	NE
BNE	L_SPI_Ethernet_UserTCP78
;botrungtam.c,231 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP79
;botrungtam.c,232 :: 		index_page=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBW	R5, R4, #48
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
STRH	R5, [R4, #0]
;botrungtam.c,233 :: 		if(index_page==Page_Setting){
UXTH	R4, R5
CMP	R4, #8
IT	NE
BNE	L_SPI_Ethernet_UserTCP80
;botrungtam.c,234 :: 		_locate=10;
; _locate start address is: 36 (R9)
MOVW	R9, #10
;botrungtam.c,235 :: 		for(h=0;h<4;h++){
; h start address is: 32 (R8)
MOVW	R8, #0
; h end address is: 32 (R8)
; _locate end address is: 36 (R9)
UXTB	R6, R8
UXTB	R8, R9
L_SPI_Ethernet_UserTCP81:
; h start address is: 24 (R6)
; _locate start address is: 32 (R8)
CMP	R6, #4
IT	CS
BCS	L_SPI_Ethernet_UserTCP82
;botrungtam.c,236 :: 		locate=get_point(getRequest,_locate,25);
MOVS	R2, #25
UXTB	R1, R8
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_get_point+0
; locate start address is: 28 (R7)
UXTB	R7, R0
;botrungtam.c,237 :: 		_myip[h]=chuoi_so(getRequest,_locate,(locate-1));
ADD	R5, SP, #4
LSLS	R4, R6, #1
ADDS	R4, R5, R4
STR	R4, [SP, #36]
SUBS	R4, R0, #1
UXTB	R2, R4
UXTB	R1, R8
; _locate end address is: 32 (R8)
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_chuoi_so+0
LDR	R4, [SP, #36]
STRH	R0, [R4, #0]
;botrungtam.c,238 :: 		_locate=locate+1;
ADDS	R4, R7, #1
; locate end address is: 28 (R7)
; _locate start address is: 36 (R9)
UXTB	R9, R4
;botrungtam.c,235 :: 		for(h=0;h<4;h++){
ADDS	R0, R6, #1
UXTB	R0, R0
; h end address is: 24 (R6)
;botrungtam.c,239 :: 		}
UXTB	R8, R9
; _locate end address is: 36 (R9)
UXTB	R6, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP81
L_SPI_Ethernet_UserTCP82:
;botrungtam.c,240 :: 		if((_myip[0]<=255)&&(_myip[1]<=255)&&(_myip[2]<=255)&&(_myip[3]<=255)) {
ADD	R4, SP, #4
LDRH	R4, [R4, #0]
CMP	R4, #255
IT	HI
BHI	L__SPI_Ethernet_UserTCP493
ADD	R4, SP, #4
ADDS	R4, R4, #2
LDRH	R4, [R4, #0]
CMP	R4, #255
IT	HI
BHI	L__SPI_Ethernet_UserTCP492
ADD	R4, SP, #4
ADDS	R4, R4, #4
LDRH	R4, [R4, #0]
CMP	R4, #255
IT	HI
BHI	L__SPI_Ethernet_UserTCP491
ADD	R4, SP, #4
ADDS	R4, R4, #6
LDRH	R4, [R4, #0]
CMP	R4, #255
IT	HI
BHI	L__SPI_Ethernet_UserTCP490
L__SPI_Ethernet_UserTCP489:
;botrungtam.c,241 :: 		for(h=0;h<4;h++){
MOVS	R0, #0
L_SPI_Ethernet_UserTCP87:
CMP	R0, #4
IT	CS
BCS	L_SPI_Ethernet_UserTCP88
;botrungtam.c,242 :: 		myIpAddr[h]=_myip[h];
MOVW	R4, #lo_addr(_myIpAddr+0)
MOVT	R4, #hi_addr(_myIpAddr+0)
ADDS	R6, R4, R0
ADD	R5, SP, #4
LSLS	R4, R0, #1
ADDS	R4, R5, R4
LDRH	R4, [R4, #0]
STRB	R4, [R6, #0]
;botrungtam.c,241 :: 		for(h=0;h<4;h++){
ADDS	R4, R0, #1
; h start address is: 4 (R1)
UXTB	R1, R4
;botrungtam.c,243 :: 		}
UXTB	R0, R1
; h end address is: 4 (R1)
IT	AL
BAL	L_SPI_Ethernet_UserTCP87
L_SPI_Ethernet_UserTCP88:
;botrungtam.c,244 :: 		flag_reset_ip=1;
MOVS	R5, #1
MOVW	R4, #lo_addr(_flag_reset_ip+0)
MOVT	R4, #hi_addr(_flag_reset_ip+0)
STRB	R5, [R4, #0]
;botrungtam.c,240 :: 		if((_myip[0]<=255)&&(_myip[1]<=255)&&(_myip[2]<=255)&&(_myip[3]<=255)) {
L__SPI_Ethernet_UserTCP493:
L__SPI_Ethernet_UserTCP492:
L__SPI_Ethernet_UserTCP491:
L__SPI_Ethernet_UserTCP490:
;botrungtam.c,246 :: 		}
L_SPI_Ethernet_UserTCP80:
;botrungtam.c,247 :: 		}
L_SPI_Ethernet_UserTCP79:
;botrungtam.c,248 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP90
L_SPI_Ethernet_UserTCP78:
;botrungtam.c,249 :: 		else if(getRequest[5] == 's'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #115
IT	NE
BNE	L_SPI_Ethernet_UserTCP91
;botrungtam.c,250 :: 		STAT = ~STAT;         // LED INDICATOR HOPTEST
MOVW	R5, #lo_addr(GPIOA_ODR+0)
MOVT	R5, #hi_addr(GPIOA_ODR+0)
LDR	R4, [R5, #0]
EOR	R4, R4, #1
STR	R4, [R5, #0]
;botrungtam.c,251 :: 		len =  putConstString(httpHeader);
MOVW	R0, #lo_addr(_httpHeader+0)
MOVT	R0, #hi_addr(_httpHeader+0)
BL	_SPI_Ethernet_putConstString+0
STRH	R0, [SP, #12]
;botrungtam.c,252 :: 		len += putConstString(httpMimeTypeHTML);
MOVW	R0, #lo_addr(_httpMimeTypeHTML+0)
MOVT	R0, #hi_addr(_httpMimeTypeHTML+0)
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,253 :: 		switch (index_page) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP92
;botrungtam.c,254 :: 		case Page_Service:
L_SPI_Ethernet_UserTCP94:
;botrungtam.c,255 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_12_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_12_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,256 :: 		LongWordToStr(status_wed_service, dyna);
MOVW	R4, #lo_addr(_status_wed_service+0)
MOVT	R4, #hi_addr(_status_wed_service+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,257 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,258 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP93
;botrungtam.c,259 :: 		case Page_Lighting:
L_SPI_Ethernet_UserTCP95:
;botrungtam.c,260 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_13_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_13_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,261 :: 		LongWordToStr(status_wed_light, dyna);
MOVW	R4, #lo_addr(_status_wed_light+0)
MOVT	R4, #hi_addr(_status_wed_light+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,262 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,263 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP93
;botrungtam.c,264 :: 		case Page_Curtain:
L_SPI_Ethernet_UserTCP96:
;botrungtam.c,265 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_14_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_14_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,266 :: 		LongWordToStr(status_wed_curtain, dyna);
MOVW	R4, #lo_addr(_status_wed_curtain+0)
MOVT	R4, #hi_addr(_status_wed_curtain+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,267 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,268 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP93
;botrungtam.c,269 :: 		case Page_Scenes:
L_SPI_Ethernet_UserTCP97:
;botrungtam.c,270 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_15_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_15_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,271 :: 		LongWordToStr(status_wed_scenes, dyna);
MOVW	R4, #lo_addr(_status_wed_scenes+0)
MOVT	R4, #hi_addr(_status_wed_scenes+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,272 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,273 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP93
;botrungtam.c,274 :: 		case Page_Fan_Speed:
L_SPI_Ethernet_UserTCP98:
;botrungtam.c,275 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_16_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_16_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,276 :: 		LongWordToStr(status_wed_fan, dyna);
MOVW	R4, #lo_addr(_status_wed_fan+0)
MOVT	R4, #hi_addr(_status_wed_fan+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,277 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,278 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP93
;botrungtam.c,279 :: 		case Page_Dimer_Extant:
L_SPI_Ethernet_UserTCP99:
;botrungtam.c,280 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_17_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_17_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,281 :: 		LongWordToStr(status_wed_dimer, dyna);
MOVW	R4, #lo_addr(_status_wed_dimer+0)
MOVT	R4, #hi_addr(_status_wed_dimer+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,282 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,283 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP93
;botrungtam.c,284 :: 		case Page_Device_Extant:
L_SPI_Ethernet_UserTCP100:
;botrungtam.c,285 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_18_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_18_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,286 :: 		LongWordToStr(wed_status_button, dyna);
MOVW	R4, #lo_addr(_wed_status_button+0)
MOVT	R4, #hi_addr(_wed_status_button+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,287 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,288 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP93
;botrungtam.c,289 :: 		default:
L_SPI_Ethernet_UserTCP101:
;botrungtam.c,290 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP93
;botrungtam.c,291 :: 		}
L_SPI_Ethernet_UserTCP92:
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP94
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP95
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP96
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP97
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP98
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #6
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP99
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #7
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP100
IT	AL
BAL	L_SPI_Ethernet_UserTCP101
L_SPI_Ethernet_UserTCP93:
;botrungtam.c,292 :: 		}
L_SPI_Ethernet_UserTCP91:
L_SPI_Ethernet_UserTCP90:
;botrungtam.c,293 :: 		switch (index_page) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP102
;botrungtam.c,294 :: 		case Page_Service:
L_SPI_Ethernet_UserTCP104:
;botrungtam.c,295 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP105
;botrungtam.c,296 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP106
;botrungtam.c,297 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP107
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP107:
;botrungtam.c,298 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP108
;botrungtam.c,299 :: 		case 0://SERVICE_1
L_SPI_Ethernet_UserTCP110:
;botrungtam.c,300 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP109
;botrungtam.c,301 :: 		case 1://SERVICE_2
L_SPI_Ethernet_UserTCP111:
;botrungtam.c,302 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP109
;botrungtam.c,303 :: 		default:
L_SPI_Ethernet_UserTCP112:
;botrungtam.c,304 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP109
;botrungtam.c,305 :: 		}
L_SPI_Ethernet_UserTCP108:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP110
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP111
IT	AL
BAL	L_SPI_Ethernet_UserTCP112
L_SPI_Ethernet_UserTCP109:
;botrungtam.c,306 :: 		}
L_SPI_Ethernet_UserTCP106:
;botrungtam.c,307 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_19_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_19_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,308 :: 		status_wed_service|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_service+0)
MOVT	R5, #hi_addr(_status_wed_service+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,309 :: 		LongWordToStr(status_wed_service, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,310 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,312 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP113
L_SPI_Ethernet_UserTCP105:
;botrungtam.c,313 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP114
;botrungtam.c,314 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP115
;botrungtam.c,315 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP116
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP116:
;botrungtam.c,316 :: 		}
L_SPI_Ethernet_UserTCP115:
;botrungtam.c,317 :: 		status_wed_service|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_service+0)
MOVT	R5, #hi_addr(_status_wed_service+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,318 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_20_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_20_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,319 :: 		LongWordToStr(status_wed_service, dyna);
MOVW	R4, #lo_addr(_status_wed_service+0)
MOVT	R4, #hi_addr(_status_wed_service+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,320 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,321 :: 		}
L_SPI_Ethernet_UserTCP114:
L_SPI_Ethernet_UserTCP113:
;botrungtam.c,322 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP103
;botrungtam.c,323 :: 		case Page_Lighting:
L_SPI_Ethernet_UserTCP117:
;botrungtam.c,324 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP118
;botrungtam.c,325 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP119
;botrungtam.c,326 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP120
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP120:
;botrungtam.c,327 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP121
;botrungtam.c,328 :: 		case 0://ENTRANCE
L_SPI_Ethernet_UserTCP123:
;botrungtam.c,329 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP122
;botrungtam.c,330 :: 		case 1://MASTER
L_SPI_Ethernet_UserTCP124:
;botrungtam.c,331 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP122
;botrungtam.c,332 :: 		case 2://LIGHT_BATH
L_SPI_Ethernet_UserTCP125:
;botrungtam.c,333 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP122
;botrungtam.c,334 :: 		case 3://LIGHT_READING
L_SPI_Ethernet_UserTCP126:
;botrungtam.c,335 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP122
;botrungtam.c,336 :: 		case 4://LIGHT_BEDSIDE
L_SPI_Ethernet_UserTCP127:
;botrungtam.c,337 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP122
;botrungtam.c,338 :: 		default:
L_SPI_Ethernet_UserTCP128:
;botrungtam.c,339 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP122
;botrungtam.c,340 :: 		}
L_SPI_Ethernet_UserTCP121:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP123
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP124
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP125
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP126
LDRB	R4, [SP, #14]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP127
IT	AL
BAL	L_SPI_Ethernet_UserTCP128
L_SPI_Ethernet_UserTCP122:
;botrungtam.c,341 :: 		}
L_SPI_Ethernet_UserTCP119:
;botrungtam.c,342 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_21_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_21_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,343 :: 		status_wed_light|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_light+0)
MOVT	R5, #hi_addr(_status_wed_light+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,344 :: 		LongWordToStr(status_wed_light, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,345 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,346 :: 		xuat_32bit(out_relay);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_xuat_32bit+0
;botrungtam.c,347 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP129
L_SPI_Ethernet_UserTCP118:
;botrungtam.c,348 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP130
;botrungtam.c,349 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP131
;botrungtam.c,350 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP132
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP132:
;botrungtam.c,351 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP133
;botrungtam.c,352 :: 		case 0://ENTRANCE
L_SPI_Ethernet_UserTCP135:
;botrungtam.c,353 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP134
;botrungtam.c,354 :: 		case 1://MASTER
L_SPI_Ethernet_UserTCP136:
;botrungtam.c,355 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP134
;botrungtam.c,356 :: 		case 2://LIGHT_BATH
L_SPI_Ethernet_UserTCP137:
;botrungtam.c,357 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP134
;botrungtam.c,358 :: 		case 3://LIGHT_READING
L_SPI_Ethernet_UserTCP138:
;botrungtam.c,359 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP134
;botrungtam.c,360 :: 		case 4://LIGHT_BEDSIDE
L_SPI_Ethernet_UserTCP139:
;botrungtam.c,361 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP134
;botrungtam.c,362 :: 		default:
L_SPI_Ethernet_UserTCP140:
;botrungtam.c,363 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP134
;botrungtam.c,364 :: 		}
L_SPI_Ethernet_UserTCP133:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP135
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP136
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP137
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP138
LDRB	R4, [SP, #14]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP139
IT	AL
BAL	L_SPI_Ethernet_UserTCP140
L_SPI_Ethernet_UserTCP134:
;botrungtam.c,365 :: 		}
L_SPI_Ethernet_UserTCP131:
;botrungtam.c,366 :: 		flag_but_dimer=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_flag_but_dimer+0)
MOVT	R4, #hi_addr(_flag_but_dimer+0)
STRB	R5, [R4, #0]
;botrungtam.c,367 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_22_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_22_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,368 :: 		status_wed_light|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_light+0)
MOVT	R5, #hi_addr(_status_wed_light+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,369 :: 		LongWordToStr(status_wed_light, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,370 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,371 :: 		}
L_SPI_Ethernet_UserTCP130:
L_SPI_Ethernet_UserTCP129:
;botrungtam.c,372 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP103
;botrungtam.c,373 :: 		case Page_Curtain:
L_SPI_Ethernet_UserTCP141:
;botrungtam.c,374 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP142
;botrungtam.c,375 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP143
;botrungtam.c,376 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP144
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP144:
;botrungtam.c,377 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP145
;botrungtam.c,378 :: 		case 0://CURTAIN_O 1   OPEN THEN CLOSE
L_SPI_Ethernet_UserTCP147:
;botrungtam.c,379 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP146
;botrungtam.c,380 :: 		case 1://CURTAIN_C 1   OPEN THEN STOP
L_SPI_Ethernet_UserTCP148:
;botrungtam.c,381 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP146
;botrungtam.c,382 :: 		case 2://CURTAIN_O 2
L_SPI_Ethernet_UserTCP149:
;botrungtam.c,383 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP146
;botrungtam.c,384 :: 		case 3://CURTAIN_C 2
L_SPI_Ethernet_UserTCP150:
;botrungtam.c,385 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP146
;botrungtam.c,387 :: 		default:
L_SPI_Ethernet_UserTCP151:
;botrungtam.c,388 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP146
;botrungtam.c,389 :: 		}
L_SPI_Ethernet_UserTCP145:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP147
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP148
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP149
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP150
IT	AL
BAL	L_SPI_Ethernet_UserTCP151
L_SPI_Ethernet_UserTCP146:
;botrungtam.c,390 :: 		}
L_SPI_Ethernet_UserTCP143:
;botrungtam.c,391 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_23_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_23_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,392 :: 		status_wed_curtain|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_curtain+0)
MOVT	R5, #hi_addr(_status_wed_curtain+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,393 :: 		LongWordToStr(status_wed_curtain, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,394 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,396 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP152
L_SPI_Ethernet_UserTCP142:
;botrungtam.c,397 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP153
;botrungtam.c,398 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP154
;botrungtam.c,399 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP155
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP155:
;botrungtam.c,400 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP156
;botrungtam.c,401 :: 		case 0://CURTAIN_O 1
L_SPI_Ethernet_UserTCP158:
;botrungtam.c,402 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP157
;botrungtam.c,403 :: 		case 1://CURTAIN_C 1  OPEN THEN STOP ( TURN ON 8&9)
L_SPI_Ethernet_UserTCP159:
;botrungtam.c,404 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP157
;botrungtam.c,405 :: 		case 2://CURTAIN_O 2
L_SPI_Ethernet_UserTCP160:
;botrungtam.c,406 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP157
;botrungtam.c,407 :: 		case 3://CURTAIN_C 2
L_SPI_Ethernet_UserTCP161:
;botrungtam.c,408 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP157
;botrungtam.c,409 :: 		default:
L_SPI_Ethernet_UserTCP162:
;botrungtam.c,410 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP157
;botrungtam.c,411 :: 		}
L_SPI_Ethernet_UserTCP156:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP158
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP159
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP160
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP161
IT	AL
BAL	L_SPI_Ethernet_UserTCP162
L_SPI_Ethernet_UserTCP157:
;botrungtam.c,412 :: 		}
L_SPI_Ethernet_UserTCP154:
;botrungtam.c,413 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_24_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_24_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,414 :: 		status_wed_curtain&=~(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSLS	R4, R5
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_curtain+0)
MOVT	R5, #hi_addr(_status_wed_curtain+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,415 :: 		LongWordToStr(status_wed_curtain, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,416 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,418 :: 		}
L_SPI_Ethernet_UserTCP153:
L_SPI_Ethernet_UserTCP152:
;botrungtam.c,419 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP103
;botrungtam.c,420 :: 		case Page_Scenes:
L_SPI_Ethernet_UserTCP163:
;botrungtam.c,421 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP164
;botrungtam.c,422 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP165
;botrungtam.c,423 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP166
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP166:
;botrungtam.c,424 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP167
;botrungtam.c,425 :: 		case 0://S_RELAX
L_SPI_Ethernet_UserTCP169:
;botrungtam.c,426 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP168
;botrungtam.c,427 :: 		case 1://S_NIGHT
L_SPI_Ethernet_UserTCP170:
;botrungtam.c,428 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP168
;botrungtam.c,429 :: 		case 2://S_PARTY
L_SPI_Ethernet_UserTCP171:
;botrungtam.c,430 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP168
;botrungtam.c,431 :: 		default:
L_SPI_Ethernet_UserTCP172:
;botrungtam.c,432 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP168
;botrungtam.c,433 :: 		}
L_SPI_Ethernet_UserTCP167:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP169
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP170
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP171
IT	AL
BAL	L_SPI_Ethernet_UserTCP172
L_SPI_Ethernet_UserTCP168:
;botrungtam.c,434 :: 		}
L_SPI_Ethernet_UserTCP165:
;botrungtam.c,435 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_25_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_25_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,436 :: 		status_wed_scenes|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_scenes+0)
MOVT	R5, #hi_addr(_status_wed_scenes+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,437 :: 		LongWordToStr(status_wed_scenes, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,438 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,439 :: 		xuat_32bit(out_relay);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_xuat_32bit+0
;botrungtam.c,440 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP173
L_SPI_Ethernet_UserTCP164:
;botrungtam.c,441 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP174
;botrungtam.c,442 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP175
;botrungtam.c,443 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP176
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP176:
;botrungtam.c,444 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP177
;botrungtam.c,445 :: 		case 0://S_RELAX
L_SPI_Ethernet_UserTCP179:
;botrungtam.c,446 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP178
;botrungtam.c,447 :: 		case 1://S_NIGHT
L_SPI_Ethernet_UserTCP180:
;botrungtam.c,448 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP178
;botrungtam.c,449 :: 		case 2://S_PARTY
L_SPI_Ethernet_UserTCP181:
;botrungtam.c,450 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP178
;botrungtam.c,451 :: 		default:
L_SPI_Ethernet_UserTCP182:
;botrungtam.c,452 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP178
;botrungtam.c,453 :: 		}
L_SPI_Ethernet_UserTCP177:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP179
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP180
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP181
IT	AL
BAL	L_SPI_Ethernet_UserTCP182
L_SPI_Ethernet_UserTCP178:
;botrungtam.c,454 :: 		}
L_SPI_Ethernet_UserTCP175:
;botrungtam.c,455 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_26_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_26_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,456 :: 		status_wed_scenes|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_scenes+0)
MOVT	R5, #hi_addr(_status_wed_scenes+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,457 :: 		LongWordToStr(status_wed_scenes, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,458 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,459 :: 		}
L_SPI_Ethernet_UserTCP174:
L_SPI_Ethernet_UserTCP173:
;botrungtam.c,460 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP103
;botrungtam.c,461 :: 		case Page_Fan_Speed:
L_SPI_Ethernet_UserTCP183:
;botrungtam.c,462 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP184
;botrungtam.c,463 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP185
;botrungtam.c,464 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP186
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP186:
;botrungtam.c,465 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP187
;botrungtam.c,466 :: 		case 0://FAN_ON_OFF
L_SPI_Ethernet_UserTCP189:
;botrungtam.c,467 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP188
;botrungtam.c,468 :: 		case 1://FAN_LOW
L_SPI_Ethernet_UserTCP190:
;botrungtam.c,469 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP188
;botrungtam.c,470 :: 		case 2://FAN_MEDIUM
L_SPI_Ethernet_UserTCP191:
;botrungtam.c,471 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP188
;botrungtam.c,472 :: 		case 3://FAN_HIGHT
L_SPI_Ethernet_UserTCP192:
;botrungtam.c,473 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP188
;botrungtam.c,474 :: 		default:
L_SPI_Ethernet_UserTCP193:
;botrungtam.c,475 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP188
;botrungtam.c,476 :: 		}
L_SPI_Ethernet_UserTCP187:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP189
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP190
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP191
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP192
IT	AL
BAL	L_SPI_Ethernet_UserTCP193
L_SPI_Ethernet_UserTCP188:
;botrungtam.c,477 :: 		}
L_SPI_Ethernet_UserTCP185:
;botrungtam.c,478 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_27_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_27_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,479 :: 		if((out_relay&FAN_L)?1:0)status_wed_fan|=(shift<<1);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #512
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP194
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP195
L_SPI_Ethernet_UserTCP194:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP195:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP196
LDR	R4, [SP, #16]
LSLS	R6, R4, #1
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP197
L_SPI_Ethernet_UserTCP196:
;botrungtam.c,480 :: 		else status_wed_fan&=~(shift<<1);
LDR	R4, [SP, #16]
LSLS	R4, R4, #1
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP197:
;botrungtam.c,481 :: 		if((out_relay&FAN_M)?1:0)status_wed_fan|=(shift<<2);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #1024
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP198
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP199
L_SPI_Ethernet_UserTCP198:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP199:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP200
LDR	R4, [SP, #16]
LSLS	R6, R4, #2
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP201
L_SPI_Ethernet_UserTCP200:
;botrungtam.c,482 :: 		else status_wed_fan&=~(shift<<2);
LDR	R4, [SP, #16]
LSLS	R4, R4, #2
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP201:
;botrungtam.c,483 :: 		if((out_relay&FAN_H)?1:0)status_wed_fan|=(shift<<3);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #2048
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP202
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP203
L_SPI_Ethernet_UserTCP202:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP203:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP204
LDR	R4, [SP, #16]
LSLS	R6, R4, #3
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP205
L_SPI_Ethernet_UserTCP204:
;botrungtam.c,484 :: 		else status_wed_fan&=~(shift<<3);
LDR	R4, [SP, #16]
LSLS	R4, R4, #3
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP205:
;botrungtam.c,485 :: 		LongWordToStr(status_wed_fan, dyna);
MOVW	R4, #lo_addr(_status_wed_fan+0)
MOVT	R4, #hi_addr(_status_wed_fan+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,486 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,487 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP206
L_SPI_Ethernet_UserTCP184:
;botrungtam.c,488 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP207
;botrungtam.c,489 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP208
;botrungtam.c,490 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP209
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP209:
;botrungtam.c,491 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP210
;botrungtam.c,492 :: 		case 0://FAN_ON_OFF
L_SPI_Ethernet_UserTCP212:
;botrungtam.c,493 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP211
;botrungtam.c,494 :: 		case 1://FAN_LOW
L_SPI_Ethernet_UserTCP213:
;botrungtam.c,495 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP211
;botrungtam.c,496 :: 		case 2://FAN_MEDIUM
L_SPI_Ethernet_UserTCP214:
;botrungtam.c,497 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP211
;botrungtam.c,498 :: 		case 3://FAN_HIGHT
L_SPI_Ethernet_UserTCP215:
;botrungtam.c,499 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP211
;botrungtam.c,500 :: 		default:
L_SPI_Ethernet_UserTCP216:
;botrungtam.c,501 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP211
;botrungtam.c,502 :: 		}
L_SPI_Ethernet_UserTCP210:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP212
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP213
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP214
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP215
IT	AL
BAL	L_SPI_Ethernet_UserTCP216
L_SPI_Ethernet_UserTCP211:
;botrungtam.c,503 :: 		}
L_SPI_Ethernet_UserTCP208:
;botrungtam.c,504 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_28_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_28_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,505 :: 		if((out_relay&FAN_L)?1:0)status_wed_fan|=(shift<<1);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #512
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP217
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP218
L_SPI_Ethernet_UserTCP217:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP218:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP219
LDR	R4, [SP, #16]
LSLS	R6, R4, #1
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP220
L_SPI_Ethernet_UserTCP219:
;botrungtam.c,506 :: 		else status_wed_fan&=~(shift<<1);
LDR	R4, [SP, #16]
LSLS	R4, R4, #1
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP220:
;botrungtam.c,507 :: 		if((out_relay&FAN_M)?1:0)status_wed_fan|=(shift<<2);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #1024
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP221
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP222
L_SPI_Ethernet_UserTCP221:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP222:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP223
LDR	R4, [SP, #16]
LSLS	R6, R4, #2
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP224
L_SPI_Ethernet_UserTCP223:
;botrungtam.c,508 :: 		else status_wed_fan&=~(shift<<2);
LDR	R4, [SP, #16]
LSLS	R4, R4, #2
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP224:
;botrungtam.c,509 :: 		if((out_relay&FAN_H)?1:0)status_wed_fan|=(shift<<3);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #2048
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP225
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP226
L_SPI_Ethernet_UserTCP225:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP226:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP227
LDR	R4, [SP, #16]
LSLS	R6, R4, #3
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP228
L_SPI_Ethernet_UserTCP227:
;botrungtam.c,510 :: 		else status_wed_fan&=~(shift<<3);
LDR	R4, [SP, #16]
LSLS	R4, R4, #3
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP228:
;botrungtam.c,511 :: 		LongWordToStr(status_wed_fan, dyna);
MOVW	R4, #lo_addr(_status_wed_fan+0)
MOVT	R4, #hi_addr(_status_wed_fan+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,512 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,513 :: 		}
L_SPI_Ethernet_UserTCP207:
L_SPI_Ethernet_UserTCP206:
;botrungtam.c,514 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP103
;botrungtam.c,515 :: 		case Page_Dimer_Extant:
L_SPI_Ethernet_UserTCP229:
;botrungtam.c,516 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP230
;botrungtam.c,517 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP231
;botrungtam.c,518 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP232
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP232:
;botrungtam.c,519 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP233
;botrungtam.c,520 :: 		case 0:
L_SPI_Ethernet_UserTCP235:
;botrungtam.c,521 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP234
;botrungtam.c,522 :: 		case 1:
L_SPI_Ethernet_UserTCP236:
;botrungtam.c,523 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP234
;botrungtam.c,524 :: 		case 2:
L_SPI_Ethernet_UserTCP237:
;botrungtam.c,525 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP234
;botrungtam.c,526 :: 		case 3:
L_SPI_Ethernet_UserTCP238:
;botrungtam.c,527 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP234
;botrungtam.c,528 :: 		case 4:
L_SPI_Ethernet_UserTCP239:
;botrungtam.c,529 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP234
;botrungtam.c,530 :: 		case 5:
L_SPI_Ethernet_UserTCP240:
;botrungtam.c,531 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP234
;botrungtam.c,532 :: 		default:
L_SPI_Ethernet_UserTCP241:
;botrungtam.c,533 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP234
;botrungtam.c,534 :: 		}
L_SPI_Ethernet_UserTCP233:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP235
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP236
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP237
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP238
LDRB	R4, [SP, #14]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP239
LDRB	R4, [SP, #14]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP240
IT	AL
BAL	L_SPI_Ethernet_UserTCP241
L_SPI_Ethernet_UserTCP234:
;botrungtam.c,535 :: 		}
L_SPI_Ethernet_UserTCP231:
;botrungtam.c,536 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_29_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_29_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,537 :: 		status_wed_dimer|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_dimer+0)
MOVT	R5, #hi_addr(_status_wed_dimer+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,538 :: 		LongWordToStr(status_wed_dimer, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,539 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,540 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP242
L_SPI_Ethernet_UserTCP230:
;botrungtam.c,541 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP243
;botrungtam.c,542 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP244
;botrungtam.c,543 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP245
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP245:
;botrungtam.c,544 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP246
;botrungtam.c,545 :: 		case 0://up1
L_SPI_Ethernet_UserTCP248:
;botrungtam.c,546 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP247
;botrungtam.c,547 :: 		case 1://dow1
L_SPI_Ethernet_UserTCP249:
;botrungtam.c,548 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP247
;botrungtam.c,549 :: 		case 2://up34
L_SPI_Ethernet_UserTCP250:
;botrungtam.c,550 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP247
;botrungtam.c,551 :: 		case 3://down34
L_SPI_Ethernet_UserTCP251:
;botrungtam.c,552 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP247
;botrungtam.c,553 :: 		case 4://up3;
L_SPI_Ethernet_UserTCP252:
;botrungtam.c,554 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP247
;botrungtam.c,555 :: 		case 5://down3
L_SPI_Ethernet_UserTCP253:
;botrungtam.c,556 :: 		default:
L_SPI_Ethernet_UserTCP254:
;botrungtam.c,557 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP247
;botrungtam.c,558 :: 		}
L_SPI_Ethernet_UserTCP246:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP248
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP249
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP250
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP251
LDRB	R4, [SP, #14]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP252
LDRB	R4, [SP, #14]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP253
IT	AL
BAL	L_SPI_Ethernet_UserTCP254
L_SPI_Ethernet_UserTCP247:
;botrungtam.c,559 :: 		}
L_SPI_Ethernet_UserTCP244:
;botrungtam.c,560 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_30_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_30_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,561 :: 		status_wed_dimer&=~(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSLS	R4, R5
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_dimer+0)
MOVT	R5, #hi_addr(_status_wed_dimer+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
;botrungtam.c,562 :: 		LongWordToStr(status_wed_dimer, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,563 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,564 :: 		}
L_SPI_Ethernet_UserTCP243:
L_SPI_Ethernet_UserTCP242:
;botrungtam.c,565 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP103
;botrungtam.c,566 :: 		case Page_Device_Extant:
L_SPI_Ethernet_UserTCP255:
;botrungtam.c,567 :: 		if(getRequest[5] == 'd'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #100
IT	NE
BNE	L_SPI_Ethernet_UserTCP256
;botrungtam.c,568 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP257
;botrungtam.c,569 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP258
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP258:
;botrungtam.c,570 :: 		}
L_SPI_Ethernet_UserTCP257:
;botrungtam.c,571 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP259
;botrungtam.c,572 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP260
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
IT	AL
BAL	L_SPI_Ethernet_UserTCP261
L_SPI_Ethernet_UserTCP260:
;botrungtam.c,573 :: 		else if(getRequest[8]=='$')vt_button=chuoi_so(getRequest,6,7);
MOVW	R4, #lo_addr(_getRequest+8)
MOVT	R4, #hi_addr(_getRequest+8)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP262
MOVS	R2, #7
MOVS	R1, #6
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_chuoi_so+0
STRB	R0, [SP, #14]
IT	AL
BAL	L_SPI_Ethernet_UserTCP263
L_SPI_Ethernet_UserTCP262:
;botrungtam.c,574 :: 		else if(getRequest[9]=='$')vt_button=chuoi_so(getRequest,6,8);
MOVW	R4, #lo_addr(_getRequest+9)
MOVT	R4, #hi_addr(_getRequest+9)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP264
MOVS	R2, #8
MOVS	R1, #6
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_chuoi_so+0
STRB	R0, [SP, #14]
L_SPI_Ethernet_UserTCP264:
L_SPI_Ethernet_UserTCP263:
L_SPI_Ethernet_UserTCP261:
;botrungtam.c,575 :: 		}
L_SPI_Ethernet_UserTCP259:
;botrungtam.c,576 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_31_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_31_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,577 :: 		wed_status_button^=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R7, R4, R5
MOVW	R5, #lo_addr(_wed_status_button+0)
MOVT	R5, #hi_addr(_wed_status_button+0)
LDR	R4, [R5, #0]
EOR	R6, R4, R7, LSL #0
STR	R6, [R5, #0]
;botrungtam.c,578 :: 		out_relay^=(shift<<vt_button);
MOVW	R5, #lo_addr(_out_relay+0)
MOVT	R5, #hi_addr(_out_relay+0)
LDR	R4, [R5, #0]
EORS	R4, R7
STR	R4, [R5, #0]
;botrungtam.c,579 :: 		LongWordToStr(wed_status_button, dyna);
MOV	R4, R6
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;botrungtam.c,580 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,582 :: 		}
L_SPI_Ethernet_UserTCP256:
;botrungtam.c,583 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP103
;botrungtam.c,584 :: 		case Page_Setting:
L_SPI_Ethernet_UserTCP265:
;botrungtam.c,585 :: 		copyBuf(getRequest,buf,40);
MOVS	R2, #40
MOVW	R1, #lo_addr(_buf+0)
MOVT	R1, #hi_addr(_buf+0)
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_copyBuf+0
;botrungtam.c,586 :: 		saveIP(buf);
MOVW	R0, #lo_addr(_buf+0)
MOVT	R0, #hi_addr(_buf+0)
BL	_saveIP+0
;botrungtam.c,587 :: 		if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP266
;botrungtam.c,588 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_32_botrungtam+0)
MOVT	R4, #hi_addr(?lstr_32_botrungtam+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,589 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,590 :: 		}
L_SPI_Ethernet_UserTCP266:
;botrungtam.c,591 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP103
;botrungtam.c,592 :: 		default:
L_SPI_Ethernet_UserTCP267:
;botrungtam.c,593 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP103
;botrungtam.c,594 :: 		}
L_SPI_Ethernet_UserTCP102:
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP104
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP117
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP141
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP163
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP183
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #6
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP229
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #7
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP255
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #8
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP265
IT	AL
BAL	L_SPI_Ethernet_UserTCP267
L_SPI_Ethernet_UserTCP103:
;botrungtam.c,595 :: 		if(len == 0){
LDRH	R4, [SP, #12]
CMP	R4, #0
IT	NE
BNE	L_SPI_Ethernet_UserTCP268
;botrungtam.c,596 :: 		len =  putConstString(httpHeader);
MOVW	R0, #lo_addr(_httpHeader+0)
MOVT	R0, #hi_addr(_httpHeader+0)
BL	_SPI_Ethernet_putConstString+0
STRH	R0, [SP, #12]
;botrungtam.c,597 :: 		len += putConstString(httpMimeTypeHTML);
MOVW	R0, #lo_addr(_httpMimeTypeHTML+0)
MOVT	R0, #hi_addr(_httpMimeTypeHTML+0)
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,598 :: 		switch (index_page) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP269
;botrungtam.c,599 :: 		case Page_Login:
L_SPI_Ethernet_UserTCP271:
;botrungtam.c,600 :: 		len += putConstString(LoginPage);
MOVW	R4, #lo_addr(_LoginPage+0)
MOVT	R4, #hi_addr(_LoginPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,601 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP270
;botrungtam.c,602 :: 		case Page_Service:
L_SPI_Ethernet_UserTCP272:
;botrungtam.c,603 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,604 :: 		len += putConstString(ServicePage);
MOVW	R4, #lo_addr(_ServicePage+0)
MOVT	R4, #hi_addr(_ServicePage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,605 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP270
;botrungtam.c,606 :: 		case Page_Lighting:
L_SPI_Ethernet_UserTCP273:
;botrungtam.c,607 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,608 :: 		len += putConstString(LightingPage);
MOVW	R4, #lo_addr(_LightingPage+0)
MOVT	R4, #hi_addr(_LightingPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,609 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP270
;botrungtam.c,610 :: 		case Page_Curtain:
L_SPI_Ethernet_UserTCP274:
;botrungtam.c,611 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,612 :: 		len += putConstString(CurtainPage);
MOVW	R4, #lo_addr(_CurtainPage+0)
MOVT	R4, #hi_addr(_CurtainPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,613 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP270
;botrungtam.c,614 :: 		case Page_Scenes:
L_SPI_Ethernet_UserTCP275:
;botrungtam.c,615 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,616 :: 		len += putConstString(ScenesPage);
MOVW	R4, #lo_addr(_ScenesPage+0)
MOVT	R4, #hi_addr(_ScenesPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,617 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP270
;botrungtam.c,618 :: 		case Page_Fan_Speed:
L_SPI_Ethernet_UserTCP276:
;botrungtam.c,619 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,620 :: 		len += putConstString(Fan_SpeedPage);
MOVW	R4, #lo_addr(_Fan_SpeedPage+0)
MOVT	R4, #hi_addr(_Fan_SpeedPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,621 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP270
;botrungtam.c,622 :: 		case Page_Dimer_Extant:
L_SPI_Ethernet_UserTCP277:
;botrungtam.c,623 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,624 :: 		len += putConstString(Dimer_ExtantPage);
MOVW	R4, #lo_addr(_Dimer_ExtantPage+0)
MOVT	R4, #hi_addr(_Dimer_ExtantPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,625 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP270
;botrungtam.c,626 :: 		case Page_Device_Extant:
L_SPI_Ethernet_UserTCP278:
;botrungtam.c,627 :: 		len += putConstString(Device_ExtantPage);
MOVW	R4, #lo_addr(_Device_ExtantPage+0)
MOVT	R4, #hi_addr(_Device_ExtantPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,628 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP270
;botrungtam.c,629 :: 		case Page_Setting:
L_SPI_Ethernet_UserTCP279:
;botrungtam.c,630 :: 		len += putConstString(SettingPage);
MOVW	R4, #lo_addr(_SettingPage+0)
MOVT	R4, #hi_addr(_SettingPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,631 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP270
;botrungtam.c,632 :: 		case Page_Home:
L_SPI_Ethernet_UserTCP280:
;botrungtam.c,633 :: 		len += putConstString(HomePage);
MOVW	R4, #lo_addr(_HomePage+0)
MOVT	R4, #hi_addr(_HomePage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,634 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP270
;botrungtam.c,635 :: 		default:
L_SPI_Ethernet_UserTCP281:
;botrungtam.c,636 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,637 :: 		len += putConstString(Device_ExtantPage);
MOVW	R4, #lo_addr(_Device_ExtantPage+0)
MOVT	R4, #hi_addr(_Device_ExtantPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;botrungtam.c,638 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP270
;botrungtam.c,639 :: 		}
L_SPI_Ethernet_UserTCP269:
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP271
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP272
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP273
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP274
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP275
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP276
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #6
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP277
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #7
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP278
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #8
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP279
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #9
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP280
IT	AL
BAL	L_SPI_Ethernet_UserTCP281
L_SPI_Ethernet_UserTCP270:
;botrungtam.c,640 :: 		}
L_SPI_Ethernet_UserTCP268:
;botrungtam.c,641 :: 		return(len);
LDRH	R0, [SP, #12]
;botrungtam.c,642 :: 		}
L_end_SPI_Ethernet_UserTCP:
LDR	LR, [SP, #0]
ADD	SP, SP, #40
BX	LR
; end of _SPI_Ethernet_UserTCP
_SPI_Ethernet_UserUDP:
;botrungtam.c,643 :: 		unsigned int    SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags){
; flags start address is: 16 (R4)
SUB	SP, SP, #16
LDR	R4, [SP, #16]
; flags end address is: 16 (R4)
;botrungtam.c,644 :: 		return(0);
MOVS	R0, #0
;botrungtam.c,645 :: 		}
L_end_SPI_Ethernet_UserUDP:
ADD	SP, SP, #16
BX	LR
; end of _SPI_Ethernet_UserUDP
_timer1_isr:
;botrungtam.c,647 :: 		void timer1_isr() iv IVT_INT_TIM1_UP ics ICS_AUTO { //20 ms
SUB	SP, SP, #4
STR	LR, [SP, #0]
;botrungtam.c,648 :: 		unsigned char i_isr=0,but_isr=0;
;botrungtam.c,651 :: 		unsigned long shift=1;
;botrungtam.c,653 :: 		if(TIM1_SRbits.UIF==1)
MOVW	R1, #lo_addr(TIM1_SRbits+0)
MOVT	R1, #hi_addr(TIM1_SRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr282
;botrungtam.c,655 :: 		TIM1_SRbits.UIF=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_SRbits+0)
MOVT	R0, #hi_addr(TIM1_SRbits+0)
STR	R1, [R0, #0]
;botrungtam.c,658 :: 		but_sample[0][SAMPLE-1]=!BUT1_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+1)
MOVT	R0, #hi_addr(_but_sample+1)
STRB	R1, [R0, #0]
;botrungtam.c,659 :: 		but_sample[1][SAMPLE-1]=!BUT1_1;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+3)
MOVT	R0, #hi_addr(_but_sample+3)
STRB	R1, [R0, #0]
;botrungtam.c,660 :: 		but_sample[2][SAMPLE-1]=!BUT1_2;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+5)
MOVT	R0, #hi_addr(_but_sample+5)
STRB	R1, [R0, #0]
;botrungtam.c,662 :: 		but_sample[3][SAMPLE-1]=!BUT2_0;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+7)
MOVT	R0, #hi_addr(_but_sample+7)
STRB	R1, [R0, #0]
;botrungtam.c,663 :: 		but_sample[4][SAMPLE-1]=!BUT2_1;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+9)
MOVT	R0, #hi_addr(_but_sample+9)
STRB	R1, [R0, #0]
;botrungtam.c,664 :: 		but_sample[5][SAMPLE-1]=!BUT2_2;
MOVW	R1, #lo_addr(GPIOA_IDR+0)
MOVT	R1, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+11)
MOVT	R0, #hi_addr(_but_sample+11)
STRB	R1, [R0, #0]
;botrungtam.c,666 :: 		but_sample[6][SAMPLE-1]=!BUT3_0;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+13)
MOVT	R0, #hi_addr(_but_sample+13)
STRB	R1, [R0, #0]
;botrungtam.c,667 :: 		but_sample[7][SAMPLE-1]=!BUT3_1;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+15)
MOVT	R0, #hi_addr(_but_sample+15)
STRB	R1, [R0, #0]
;botrungtam.c,668 :: 		but_sample[8][SAMPLE-1]=!BUT3_2;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+17)
MOVT	R0, #hi_addr(_but_sample+17)
STRB	R1, [R0, #0]
;botrungtam.c,670 :: 		but_sample[9][SAMPLE-1]=!BUT4_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+19)
MOVT	R0, #hi_addr(_but_sample+19)
STRB	R1, [R0, #0]
;botrungtam.c,671 :: 		but_sample[10][SAMPLE-1]=!BUT4_1;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+21)
MOVT	R0, #hi_addr(_but_sample+21)
STRB	R1, [R0, #0]
;botrungtam.c,673 :: 		but_sample[11][SAMPLE-1]=!BUT5_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+23)
MOVT	R0, #hi_addr(_but_sample+23)
STRB	R1, [R0, #0]
;botrungtam.c,674 :: 		but_sample[12][SAMPLE-1]=!BUT5_1;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+25)
MOVT	R0, #hi_addr(_but_sample+25)
STRB	R1, [R0, #0]
;botrungtam.c,676 :: 		but_sample[13][SAMPLE-1]=!BUT6_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+27)
MOVT	R0, #hi_addr(_but_sample+27)
STRB	R1, [R0, #0]
;botrungtam.c,678 :: 		but_sample[14][SAMPLE-1]=!BUT7_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+29)
MOVT	R0, #hi_addr(_but_sample+29)
STRB	R1, [R0, #0]
;botrungtam.c,680 :: 		but_sample[15][SAMPLE-1]=!BUT8_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+31)
MOVT	R0, #hi_addr(_but_sample+31)
STRB	R1, [R0, #0]
;botrungtam.c,681 :: 		but_sample[16][SAMPLE-1]=!BUT8_1;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+33)
MOVT	R0, #hi_addr(_but_sample+33)
STRB	R1, [R0, #0]
;botrungtam.c,683 :: 		but_sample[17][SAMPLE-1]=!BUT9_0;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+35)
MOVT	R0, #hi_addr(_but_sample+35)
STRB	R1, [R0, #0]
;botrungtam.c,684 :: 		but_sample[18][SAMPLE-1]=!BUT9_1;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+37)
MOVT	R0, #hi_addr(_but_sample+37)
STRB	R1, [R0, #0]
;botrungtam.c,686 :: 		but_sample[19][SAMPLE-1]=!BUT10_0;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+39)
MOVT	R0, #hi_addr(_but_sample+39)
STRB	R1, [R0, #0]
;botrungtam.c,687 :: 		but_sample[20][SAMPLE-1]=!BUT10_1;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+41)
MOVT	R0, #hi_addr(_but_sample+41)
STRB	R1, [R0, #0]
;botrungtam.c,689 :: 		but_sample[21][SAMPLE-1]=!BUT11_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+43)
MOVT	R0, #hi_addr(_but_sample+43)
STRB	R1, [R0, #0]
;botrungtam.c,690 :: 		but_sample[22][SAMPLE-1]=!BUT11_1;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+45)
MOVT	R0, #hi_addr(_but_sample+45)
STRB	R1, [R0, #0]
;botrungtam.c,692 :: 		but_sample[23][SAMPLE-1]=!BUT12_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+47)
MOVT	R0, #hi_addr(_but_sample+47)
STRB	R1, [R0, #0]
;botrungtam.c,694 :: 		but_sample[24][SAMPLE-1]=!BUT13_0;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+49)
MOVT	R0, #hi_addr(_but_sample+49)
STRB	R1, [R0, #0]
;botrungtam.c,696 :: 		for(but_isr=0;but_isr<SUM_BUT;but_isr++){
; but_isr start address is: 12 (R3)
MOVS	R3, #0
; but_isr end address is: 12 (R3)
L_timer1_isr283:
; but_isr start address is: 12 (R3)
CMP	R3, #25
IT	CS
BCS	L_timer1_isr284
;botrungtam.c,697 :: 		for(i_isr=0;i_isr<SAMPLE-1;i_isr++){
; i_isr start address is: 16 (R4)
MOVS	R4, #0
; i_isr end address is: 16 (R4)
; but_isr end address is: 12 (R3)
L_timer1_isr286:
; i_isr start address is: 16 (R4)
; but_isr start address is: 12 (R3)
CMP	R4, #1
IT	CS
BCS	L_timer1_isr287
;botrungtam.c,698 :: 		but_sample[but_isr][i_isr]=but_sample[but_isr][i_isr+1];
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
;botrungtam.c,697 :: 		for(i_isr=0;i_isr<SAMPLE-1;i_isr++){
ADDS	R4, R4, #1
UXTB	R4, R4
;botrungtam.c,699 :: 		}
; i_isr end address is: 16 (R4)
IT	AL
BAL	L_timer1_isr286
L_timer1_isr287:
;botrungtam.c,700 :: 		but_sum_sample[but_isr]=0;
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;botrungtam.c,701 :: 		for(i_isr=0;i_isr<SAMPLE;i_isr++){
; i_isr start address is: 16 (R4)
MOVS	R4, #0
; i_isr end address is: 16 (R4)
; but_isr end address is: 12 (R3)
L_timer1_isr289:
; i_isr start address is: 16 (R4)
; but_isr start address is: 12 (R3)
CMP	R4, #2
IT	CS
BCS	L_timer1_isr290
;botrungtam.c,702 :: 		but_sum_sample[but_isr]+=but_sample[but_isr][i_isr];
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
;botrungtam.c,701 :: 		for(i_isr=0;i_isr<SAMPLE;i_isr++){
ADDS	R4, R4, #1
UXTB	R4, R4
;botrungtam.c,703 :: 		}
; i_isr end address is: 16 (R4)
IT	AL
BAL	L_timer1_isr289
L_timer1_isr290:
;botrungtam.c,704 :: 		if(but_sum_sample[but_isr]>=PRESS){
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	CC
BCC	L_timer1_isr292
;botrungtam.c,705 :: 		but_state[but_isr]=PRESS;
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R1, R0, R3
MOVS	R0, #2
STRB	R0, [R1, #0]
;botrungtam.c,706 :: 		}
IT	AL
BAL	L_timer1_isr293
L_timer1_isr292:
;botrungtam.c,707 :: 		else if(but_sum_sample[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr294
;botrungtam.c,708 :: 		but_state[but_isr]=UNPRESS;
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;botrungtam.c,709 :: 		}
L_timer1_isr294:
L_timer1_isr293:
;botrungtam.c,710 :: 		if(but_state[but_isr]==PRESS){
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_timer1_isr295
;botrungtam.c,711 :: 		if(but_status[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr296
;botrungtam.c,712 :: 		but_status[but_isr]=PRES_DOW;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #5
STRB	R0, [R1, #0]
;botrungtam.c,713 :: 		}
IT	AL
BAL	L_timer1_isr297
L_timer1_isr296:
;botrungtam.c,714 :: 		else if(but_status[but_isr]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr298
;botrungtam.c,715 :: 		but_status[but_isr]=PRESSING;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #6
STRB	R0, [R1, #0]
;botrungtam.c,716 :: 		}
IT	AL
BAL	L_timer1_isr299
L_timer1_isr298:
;botrungtam.c,717 :: 		else if(but_status[but_isr]==PRESSING){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	NE
BNE	L_timer1_isr300
;botrungtam.c,718 :: 		but_status[but_isr]=PRESSING;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #6
STRB	R0, [R1, #0]
;botrungtam.c,719 :: 		}
L_timer1_isr300:
L_timer1_isr299:
L_timer1_isr297:
;botrungtam.c,720 :: 		}
IT	AL
BAL	L_timer1_isr301
L_timer1_isr295:
;botrungtam.c,721 :: 		else if(but_state[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr302
;botrungtam.c,722 :: 		if ((but_status[but_isr]==PRESSING)||(but_status[but_isr]==PRES_DOW)){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	EQ
BEQ	L__timer1_isr496
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L__timer1_isr495
IT	AL
BAL	L_timer1_isr305
L__timer1_isr496:
L__timer1_isr495:
;botrungtam.c,723 :: 		but_status[but_isr]=PRES_UP;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #4
STRB	R0, [R1, #0]
;botrungtam.c,724 :: 		}
IT	AL
BAL	L_timer1_isr306
L_timer1_isr305:
;botrungtam.c,725 :: 		else if(but_status[but_isr]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr307
;botrungtam.c,726 :: 		but_status[but_isr]=UNPRESS;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;botrungtam.c,727 :: 		}
IT	AL
BAL	L_timer1_isr308
L_timer1_isr307:
;botrungtam.c,728 :: 		else if(but_status[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr309
;botrungtam.c,729 :: 		but_status[but_isr]=UNPRESS;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;botrungtam.c,730 :: 		}
L_timer1_isr309:
L_timer1_isr308:
L_timer1_isr306:
;botrungtam.c,731 :: 		}
L_timer1_isr302:
L_timer1_isr301:
;botrungtam.c,696 :: 		for(but_isr=0;but_isr<SUM_BUT;but_isr++){
ADDS	R3, R3, #1
UXTB	R3, R3
;botrungtam.c,732 :: 		}
; but_isr end address is: 12 (R3)
IT	AL
BAL	L_timer1_isr283
L_timer1_isr284:
;botrungtam.c,745 :: 		duphong67_A8=~duphong67_A8;             // LED INDICAROR QUET BAN PHIM
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,749 :: 		if(but_status[0]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr310
;botrungtam.c,751 :: 		}
IT	AL
BAL	L_timer1_isr311
L_timer1_isr310:
;botrungtam.c,752 :: 		else if(but_status[0]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr312
;botrungtam.c,754 :: 		}
L_timer1_isr312:
L_timer1_isr311:
;botrungtam.c,756 :: 		if(but_status[1]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+1)
MOVT	R0, #hi_addr(_but_status+1)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr313
;botrungtam.c,758 :: 		}
IT	AL
BAL	L_timer1_isr314
L_timer1_isr313:
;botrungtam.c,759 :: 		else if(but_status[1]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+1)
MOVT	R0, #hi_addr(_but_status+1)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr315
;botrungtam.c,761 :: 		}
L_timer1_isr315:
L_timer1_isr314:
;botrungtam.c,763 :: 		if(but_status[2]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+2)
MOVT	R0, #hi_addr(_but_status+2)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr316
;botrungtam.c,765 :: 		if(!DO_NOT_DISTURB){
MOVW	R0, #lo_addr(_DO_NOT_DISTURB+0)
MOVT	R0, #hi_addr(_DO_NOT_DISTURB+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr317
;botrungtam.c,766 :: 		out_relay|=RELAY_13;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #4096
STR	R0, [R1, #0]
;botrungtam.c,767 :: 		BELL_ENABLE=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_BELL_ENABLE+0)
MOVT	R0, #hi_addr(_BELL_ENABLE+0)
STRB	R1, [R0, #0]
;botrungtam.c,768 :: 		}
L_timer1_isr317:
;botrungtam.c,769 :: 		}
IT	AL
BAL	L_timer1_isr318
L_timer1_isr316:
;botrungtam.c,770 :: 		else if(but_status[2]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+2)
MOVT	R0, #hi_addr(_but_status+2)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr319
;botrungtam.c,772 :: 		}
L_timer1_isr319:
L_timer1_isr318:
;botrungtam.c,775 :: 		if(but_status[3]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+3)
MOVT	R0, #hi_addr(_but_status+3)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr320
;botrungtam.c,776 :: 		LED_2_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,777 :: 		out_relay^=RELAY_8;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #128
STR	R0, [R1, #0]
;botrungtam.c,778 :: 		}
IT	AL
BAL	L_timer1_isr321
L_timer1_isr320:
;botrungtam.c,779 :: 		else if(but_status[3]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+3)
MOVT	R0, #hi_addr(_but_status+3)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr322
;botrungtam.c,780 :: 		LED_2_0=(out_relay&RELAY_8)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #128
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr323
; ?FLOC___timer1_isr?T1128 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1128 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr324
L_timer1_isr323:
; ?FLOC___timer1_isr?T1128 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1128 end address is: 4 (R1)
L_timer1_isr324:
; ?FLOC___timer1_isr?T1128 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1128 end address is: 4 (R1)
;botrungtam.c,781 :: 		LED_9_1=LED_2_0; //VESTIBULE-LIV port9
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,782 :: 		}
L_timer1_isr322:
L_timer1_isr321:
;botrungtam.c,785 :: 		if(but_status[4]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+4)
MOVT	R0, #hi_addr(_but_status+4)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr325
;botrungtam.c,789 :: 		AMBIENT_LIV_STATUS^=1;
MOVW	R1, #lo_addr(_AMBIENT_LIV_STATUS+0)
MOVT	R1, #hi_addr(_AMBIENT_LIV_STATUS+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,790 :: 		AMBIENT_LIVING=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_AMBIENT_LIVING+0)
MOVT	R0, #hi_addr(_AMBIENT_LIVING+0)
STRB	R1, [R0, #0]
;botrungtam.c,791 :: 		}
IT	AL
BAL	L_timer1_isr326
L_timer1_isr325:
;botrungtam.c,792 :: 		else if(but_status[4]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+4)
MOVT	R0, #hi_addr(_but_status+4)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr327
;botrungtam.c,794 :: 		}
L_timer1_isr327:
L_timer1_isr326:
;botrungtam.c,797 :: 		if(but_status[5]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+5)
MOVT	R0, #hi_addr(_but_status+5)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr328
;botrungtam.c,798 :: 		LED_2_2=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,799 :: 		out_relay^=RELAY_3;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #4
STR	R0, [R1, #0]
;botrungtam.c,801 :: 		}
IT	AL
BAL	L_timer1_isr329
L_timer1_isr328:
;botrungtam.c,802 :: 		else if(but_status[5]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+5)
MOVT	R0, #hi_addr(_but_status+5)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr330
;botrungtam.c,803 :: 		LED_2_2=(out_relay&RELAY_3)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #4
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr331
; ?FLOC___timer1_isr?T1147 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1147 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr332
L_timer1_isr331:
; ?FLOC___timer1_isr?T1147 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1147 end address is: 4 (R1)
L_timer1_isr332:
; ?FLOC___timer1_isr?T1147 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1147 end address is: 4 (R1)
;botrungtam.c,804 :: 		}
L_timer1_isr330:
L_timer1_isr329:
;botrungtam.c,808 :: 		if(but_status[6]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+6)
MOVT	R0, #hi_addr(_but_status+6)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr333
;botrungtam.c,810 :: 		}
IT	AL
BAL	L_timer1_isr334
L_timer1_isr333:
;botrungtam.c,811 :: 		else if(but_status[6]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+6)
MOVT	R0, #hi_addr(_but_status+6)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr335
;botrungtam.c,813 :: 		}
L_timer1_isr335:
L_timer1_isr334:
;botrungtam.c,815 :: 		if(but_status[7]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+7)
MOVT	R0, #hi_addr(_but_status+7)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr336
;botrungtam.c,816 :: 		LED_3_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,817 :: 		CURTAIN_1_TIMEOUT=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_CURTAIN_1_TIMEOUT+0)
MOVT	R0, #hi_addr(_CURTAIN_1_TIMEOUT+0)
STRB	R1, [R0, #0]
;botrungtam.c,818 :: 		CURTAIN_1_FORWARD^=1;
MOVW	R1, #lo_addr(_CURTAIN_1_FORWARD+0)
MOVT	R1, #hi_addr(_CURTAIN_1_FORWARD+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,819 :: 		CURTAIN_1_STATUS=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_CURTAIN_1_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_1_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,820 :: 		CURTAIN_1_OFFRELAY=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_1_OFFRELAY+0)
MOVT	R0, #hi_addr(_CURTAIN_1_OFFRELAY+0)
STRB	R1, [R0, #0]
;botrungtam.c,821 :: 		}
IT	AL
BAL	L_timer1_isr337
L_timer1_isr336:
;botrungtam.c,822 :: 		else if(but_status[7]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+7)
MOVT	R0, #hi_addr(_but_status+7)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr338
;botrungtam.c,824 :: 		}
L_timer1_isr338:
L_timer1_isr337:
;botrungtam.c,826 :: 		if(but_status[8]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+8)
MOVT	R0, #hi_addr(_but_status+8)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr339
;botrungtam.c,827 :: 		LED_3_2=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,828 :: 		CURTAIN_1_TIMEOUT=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_CURTAIN_1_TIMEOUT+0)
MOVT	R0, #hi_addr(_CURTAIN_1_TIMEOUT+0)
STRB	R1, [R0, #0]
;botrungtam.c,829 :: 		CURTAIN_1_BACKWARD^=1;
MOVW	R1, #lo_addr(_CURTAIN_1_BACKWARD+0)
MOVT	R1, #hi_addr(_CURTAIN_1_BACKWARD+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,830 :: 		CURTAIN_1_STATUS=2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_CURTAIN_1_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_1_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,831 :: 		CURTAIN_1_OFFRELAY=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_1_OFFRELAY+0)
MOVT	R0, #hi_addr(_CURTAIN_1_OFFRELAY+0)
STRB	R1, [R0, #0]
;botrungtam.c,832 :: 		}
IT	AL
BAL	L_timer1_isr340
L_timer1_isr339:
;botrungtam.c,833 :: 		else if(but_status[8]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+8)
MOVT	R0, #hi_addr(_but_status+8)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr341
;botrungtam.c,835 :: 		}
L_timer1_isr341:
L_timer1_isr340:
;botrungtam.c,839 :: 		if(but_status[9]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+9)
MOVT	R0, #hi_addr(_but_status+9)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr342
;botrungtam.c,840 :: 		LED_4_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,841 :: 		CURTAIN_2_TIMEOUT=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_CURTAIN_2_TIMEOUT+0)
MOVT	R0, #hi_addr(_CURTAIN_2_TIMEOUT+0)
STRB	R1, [R0, #0]
;botrungtam.c,842 :: 		CURTAIN_2_FORWARD^=1;
MOVW	R1, #lo_addr(_CURTAIN_2_FORWARD+0)
MOVT	R1, #hi_addr(_CURTAIN_2_FORWARD+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,843 :: 		CURTAIN_2_STATUS=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_CURTAIN_2_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_2_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,844 :: 		}
IT	AL
BAL	L_timer1_isr343
L_timer1_isr342:
;botrungtam.c,845 :: 		else if(but_status[9]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+9)
MOVT	R0, #hi_addr(_but_status+9)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr344
;botrungtam.c,847 :: 		}
L_timer1_isr344:
L_timer1_isr343:
;botrungtam.c,849 :: 		if(but_status[10]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+10)
MOVT	R0, #hi_addr(_but_status+10)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr345
;botrungtam.c,850 :: 		LED_4_1=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,851 :: 		CURTAIN_2_TIMEOUT=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_CURTAIN_2_TIMEOUT+0)
MOVT	R0, #hi_addr(_CURTAIN_2_TIMEOUT+0)
STRB	R1, [R0, #0]
;botrungtam.c,852 :: 		CURTAIN_2_BACKWARD^=1;
MOVW	R1, #lo_addr(_CURTAIN_2_BACKWARD+0)
MOVT	R1, #hi_addr(_CURTAIN_2_BACKWARD+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,853 :: 		CURTAIN_2_STATUS=2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_CURTAIN_2_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_2_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,854 :: 		}
IT	AL
BAL	L_timer1_isr346
L_timer1_isr345:
;botrungtam.c,855 :: 		else if(but_status[10]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+10)
MOVT	R0, #hi_addr(_but_status+10)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr347
;botrungtam.c,857 :: 		}
L_timer1_isr347:
L_timer1_isr346:
;botrungtam.c,861 :: 		if(but_status[11]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+11)
MOVT	R0, #hi_addr(_but_status+11)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr348
;botrungtam.c,862 :: 		}
IT	AL
BAL	L_timer1_isr349
L_timer1_isr348:
;botrungtam.c,863 :: 		else if(but_status[11]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+11)
MOVT	R0, #hi_addr(_but_status+11)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr350
;botrungtam.c,864 :: 		}
L_timer1_isr350:
L_timer1_isr349:
;botrungtam.c,866 :: 		if(but_status[12]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+12)
MOVT	R0, #hi_addr(_but_status+12)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr351
;botrungtam.c,867 :: 		}
IT	AL
BAL	L_timer1_isr352
L_timer1_isr351:
;botrungtam.c,868 :: 		else if(but_status[12]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+12)
MOVT	R0, #hi_addr(_but_status+12)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr353
;botrungtam.c,869 :: 		}
L_timer1_isr353:
L_timer1_isr352:
;botrungtam.c,872 :: 		if(but_status[13]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+13)
MOVT	R0, #hi_addr(_but_status+13)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr354
;botrungtam.c,874 :: 		}
IT	AL
BAL	L_timer1_isr355
L_timer1_isr354:
;botrungtam.c,875 :: 		else if(but_status[13]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+13)
MOVT	R0, #hi_addr(_but_status+13)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr356
;botrungtam.c,876 :: 		}
L_timer1_isr356:
L_timer1_isr355:
;botrungtam.c,878 :: 		if(but_status[14]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+14)
MOVT	R0, #hi_addr(_but_status+14)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr357
;botrungtam.c,879 :: 		LED_7_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,880 :: 		out_relay^=S6;   //  S6-RL6
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #32
STR	R0, [R1, #0]
;botrungtam.c,881 :: 		}
IT	AL
BAL	L_timer1_isr358
L_timer1_isr357:
;botrungtam.c,882 :: 		else if(but_status[14]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+14)
MOVT	R0, #hi_addr(_but_status+14)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr359
;botrungtam.c,883 :: 		LED_7_0=(out_relay&S6)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #32
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr360
; ?FLOC___timer1_isr?T1202 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1202 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr361
L_timer1_isr360:
; ?FLOC___timer1_isr?T1202 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1202 end address is: 4 (R1)
L_timer1_isr361:
; ?FLOC___timer1_isr?T1202 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1202 end address is: 4 (R1)
;botrungtam.c,884 :: 		}
L_timer1_isr359:
L_timer1_isr358:
;botrungtam.c,887 :: 		if(but_status[15]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+15)
MOVT	R0, #hi_addr(_but_status+15)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr362
;botrungtam.c,888 :: 		LED_8_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,891 :: 		AMBIENT_BATH=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_AMBIENT_BATH+0)
MOVT	R0, #hi_addr(_AMBIENT_BATH+0)
STRB	R1, [R0, #0]
;botrungtam.c,892 :: 		AMBIENT_BATH_STATUS^=1;
MOVW	R1, #lo_addr(_AMBIENT_BATH_STATUS+0)
MOVT	R1, #hi_addr(_AMBIENT_BATH_STATUS+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,893 :: 		}
IT	AL
BAL	L_timer1_isr363
L_timer1_isr362:
;botrungtam.c,894 :: 		else if(but_status[15]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+15)
MOVT	R0, #hi_addr(_but_status+15)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr364
;botrungtam.c,896 :: 		}
L_timer1_isr364:
L_timer1_isr363:
;botrungtam.c,899 :: 		if(but_status[16]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+16)
MOVT	R0, #hi_addr(_but_status+16)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr365
;botrungtam.c,900 :: 		LED_8_1=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,901 :: 		out_relay^=RELAY_16;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #32768
STR	R0, [R1, #0]
;botrungtam.c,904 :: 		}
IT	AL
BAL	L_timer1_isr366
L_timer1_isr365:
;botrungtam.c,905 :: 		else if(but_status[16]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+16)
MOVT	R0, #hi_addr(_but_status+16)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr367
;botrungtam.c,906 :: 		LED_8_1=(out_relay&RELAY_16)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #32768
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr368
; ?FLOC___timer1_isr?T1220 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1220 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr369
L_timer1_isr368:
; ?FLOC___timer1_isr?T1220 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1220 end address is: 4 (R1)
L_timer1_isr369:
; ?FLOC___timer1_isr?T1220 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1220 end address is: 4 (R1)
;botrungtam.c,907 :: 		}
L_timer1_isr367:
L_timer1_isr366:
;botrungtam.c,910 :: 		if(but_status[17]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+17)
MOVT	R0, #hi_addr(_but_status+17)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr370
;botrungtam.c,911 :: 		MASTER_LIV_STATUS^=1;
MOVW	R1, #lo_addr(_MASTER_LIV_STATUS+0)
MOVT	R1, #hi_addr(_MASTER_LIV_STATUS+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;botrungtam.c,912 :: 		MASTER_LIVING=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_MASTER_LIVING+0)
MOVT	R0, #hi_addr(_MASTER_LIVING+0)
STRB	R1, [R0, #0]
;botrungtam.c,913 :: 		}
IT	AL
BAL	L_timer1_isr371
L_timer1_isr370:
;botrungtam.c,914 :: 		else if(but_status[17]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+17)
MOVT	R0, #hi_addr(_but_status+17)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr372
;botrungtam.c,915 :: 		}
L_timer1_isr372:
L_timer1_isr371:
;botrungtam.c,917 :: 		if(but_status[18]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+18)
MOVT	R0, #hi_addr(_but_status+18)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr373
;botrungtam.c,918 :: 		LED_9_1=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,919 :: 		out_relay^=S1A;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #128
STR	R0, [R1, #0]
;botrungtam.c,920 :: 		}
IT	AL
BAL	L_timer1_isr374
L_timer1_isr373:
;botrungtam.c,921 :: 		else if(but_status[18]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+18)
MOVT	R0, #hi_addr(_but_status+18)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr375
;botrungtam.c,922 :: 		LED_9_1=(out_relay&S1A)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #128
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr376
; ?FLOC___timer1_isr?T1236 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1236 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr377
L_timer1_isr376:
; ?FLOC___timer1_isr?T1236 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1236 end address is: 4 (R1)
L_timer1_isr377:
; ?FLOC___timer1_isr?T1236 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1236 end address is: 4 (R1)
;botrungtam.c,923 :: 		LED_2_0=LED_9_1; //VESTIBULE-LIV port2
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,924 :: 		}
L_timer1_isr375:
L_timer1_isr374:
;botrungtam.c,927 :: 		if(but_status[19]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+19)
MOVT	R0, #hi_addr(_but_status+19)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr378
;botrungtam.c,928 :: 		DO_NOT_DISTURB=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_DO_NOT_DISTURB+0)
MOVT	R0, #hi_addr(_DO_NOT_DISTURB+0)
STRB	R1, [R0, #0]
;botrungtam.c,929 :: 		LED_10_0^=1; // LED MUR port10
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,930 :: 		LED_1_0^=1;  // LED MUR port1
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,931 :: 		LED_10_1=0; // LED DND port10 OFF
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,932 :: 		LED_1_1=0;  // LED DND port1  OFF
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,933 :: 		}
IT	AL
BAL	L_timer1_isr379
L_timer1_isr378:
;botrungtam.c,934 :: 		else if(but_status[19]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+19)
MOVT	R0, #hi_addr(_but_status+19)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr380
;botrungtam.c,935 :: 		}
L_timer1_isr380:
L_timer1_isr379:
;botrungtam.c,937 :: 		if(but_status[20]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+20)
MOVT	R0, #hi_addr(_but_status+20)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr381
;botrungtam.c,938 :: 		DO_NOT_DISTURB=(DO_NOT_DISTURB^0x01);
MOVW	R2, #lo_addr(_DO_NOT_DISTURB+0)
MOVT	R2, #hi_addr(_DO_NOT_DISTURB+0)
LDRB	R0, [R2, #0]
EOR	R1, R0, #1
STRB	R1, [R2, #0]
;botrungtam.c,939 :: 		LED_10_1=DO_NOT_DISTURB; // LED DND port10
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,940 :: 		LED_1_1=DO_NOT_DISTURB;  // LED DND port1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,941 :: 		LED_10_0=0; // LED MUR port10 OFF
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,942 :: 		LED_1_0=0;  // LED MUR port1  OFF
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,945 :: 		}
IT	AL
BAL	L_timer1_isr382
L_timer1_isr381:
;botrungtam.c,946 :: 		else if(but_status[20]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+20)
MOVT	R0, #hi_addr(_but_status+20)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr383
;botrungtam.c,947 :: 		}
L_timer1_isr383:
L_timer1_isr382:
;botrungtam.c,949 :: 		if(but_status[21]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+21)
MOVT	R0, #hi_addr(_but_status+21)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr384
;botrungtam.c,950 :: 		LED_11_0^=1;
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,952 :: 		}
IT	AL
BAL	L_timer1_isr385
L_timer1_isr384:
;botrungtam.c,953 :: 		else if(but_status[21]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+21)
MOVT	R0, #hi_addr(_but_status+21)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr386
;botrungtam.c,955 :: 		}
L_timer1_isr386:
L_timer1_isr385:
;botrungtam.c,957 :: 		if(but_status[22]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+22)
MOVT	R0, #hi_addr(_but_status+22)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr387
;botrungtam.c,959 :: 		}
IT	AL
BAL	L_timer1_isr388
L_timer1_isr387:
;botrungtam.c,960 :: 		else if(but_status[22]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+22)
MOVT	R0, #hi_addr(_but_status+22)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr389
;botrungtam.c,962 :: 		}
L_timer1_isr389:
L_timer1_isr388:
;botrungtam.c,965 :: 		if(but_status[23]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+23)
MOVT	R0, #hi_addr(_but_status+23)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr390
;botrungtam.c,969 :: 		}
IT	AL
BAL	L_timer1_isr391
L_timer1_isr390:
;botrungtam.c,970 :: 		else if(but_status[23]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+23)
MOVT	R0, #hi_addr(_but_status+23)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr392
;botrungtam.c,973 :: 		}
L_timer1_isr392:
L_timer1_isr391:
;botrungtam.c,975 :: 		if(but_status[24]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+24)
MOVT	R0, #hi_addr(_but_status+24)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr393
;botrungtam.c,976 :: 		STAT = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,977 :: 		KEYCARD_INSERT=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
STRB	R1, [R0, #0]
;botrungtam.c,979 :: 		KEYCARD_ENABLE=1;       // enable xuat_32bit(out_relay)
MOVS	R1, #1
MOVW	R0, #lo_addr(_KEYCARD_ENABLE+0)
MOVT	R0, #hi_addr(_KEYCARD_ENABLE+0)
STRB	R1, [R0, #0]
;botrungtam.c,980 :: 		}
IT	AL
BAL	L_timer1_isr394
L_timer1_isr393:
;botrungtam.c,981 :: 		else if(but_status[24]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+24)
MOVT	R0, #hi_addr(_but_status+24)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr395
;botrungtam.c,982 :: 		STAT = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,983 :: 		KEYCARD_INSERT=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
STRB	R1, [R0, #0]
;botrungtam.c,984 :: 		}
L_timer1_isr395:
L_timer1_isr394:
;botrungtam.c,988 :: 		if(KEYCARD_ENABLE==1){
MOVW	R0, #lo_addr(_KEYCARD_ENABLE+0)
MOVT	R0, #hi_addr(_KEYCARD_ENABLE+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_timer1_isr396
;botrungtam.c,990 :: 		if(MASTER_LIVING==1){
MOVW	R0, #lo_addr(_MASTER_LIVING+0)
MOVT	R0, #hi_addr(_MASTER_LIVING+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_timer1_isr397
;botrungtam.c,991 :: 		if(MASTER_LIV_STATUS!=0){
MOVW	R0, #lo_addr(_MASTER_LIV_STATUS+0)
MOVT	R0, #hi_addr(_MASTER_LIV_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr398
;botrungtam.c,993 :: 		out_relay|=S2A;   // AMBIENT-LIV
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #64
STR	R0, [R1, #0]
;botrungtam.c,994 :: 		out_relay|=S6;   // POWDER-LIV
ORR	R0, R0, #32
STR	R0, [R1, #0]
;botrungtam.c,995 :: 		out_relay|=S5;   //ACCENT-LIV
ORR	R0, R0, #4
STR	R0, [R1, #0]
;botrungtam.c,996 :: 		LED_9_0=1;        // MASTER-LIV         PORT5
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,997 :: 		LED_2_1=1;        // AMBIENT-LIV s2+s3  PORT2
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,998 :: 		LED_2_2=1;        // ACCENT-LIV s5      PORT2
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,999 :: 		LED_7_0=1;        // POWDER-LIV s6      PORT6
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1000 :: 		}
L_timer1_isr398:
;botrungtam.c,1001 :: 		if(MASTER_LIV_STATUS==0){
MOVW	R0, #lo_addr(_MASTER_LIV_STATUS+0)
MOVT	R0, #hi_addr(_MASTER_LIV_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr399
;botrungtam.c,1003 :: 		out_relay&=~S2A;   // AMBIENT-LIV
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #64
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1004 :: 		out_relay&=~S6;   // POWDER-LIV
MVN	R0, #32
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1005 :: 		out_relay&=~S5;   //ACCENT-LIV
MVN	R0, #4
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1006 :: 		LED_9_0=0;        // MASTER-LIV         PORT5
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1007 :: 		LED_2_1=0;        // AMBIENT-LIV s2+s3  PORT2
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1008 :: 		LED_2_2=0;        // ACCENT-LIV s5      PORT2
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1009 :: 		LED_7_0=0;        // POWDER-LIV s6      PORT6
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1011 :: 		}
L_timer1_isr399:
;botrungtam.c,1012 :: 		MASTER_LIVING=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_MASTER_LIVING+0)
MOVT	R0, #hi_addr(_MASTER_LIVING+0)
STRB	R1, [R0, #0]
;botrungtam.c,1013 :: 		}
L_timer1_isr397:
;botrungtam.c,1015 :: 		if(AMBIENT_LIVING==1){
MOVW	R0, #lo_addr(_AMBIENT_LIVING+0)
MOVT	R0, #hi_addr(_AMBIENT_LIVING+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_timer1_isr400
;botrungtam.c,1016 :: 		if( AMBIENT_LIV_STATUS!=0){
MOVW	R0, #lo_addr(_AMBIENT_LIV_STATUS+0)
MOVT	R0, #hi_addr(_AMBIENT_LIV_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr401
;botrungtam.c,1017 :: 		out_relay|=S2A;   //S2A=RELAY_7 AMBIENT-LIV
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #64
STR	R0, [R1, #0]
;botrungtam.c,1018 :: 		out_relay|=S6;   //S6=RELAY_6 POWDER-LIV
ORR	R0, R0, #32
STR	R0, [R1, #0]
;botrungtam.c,1019 :: 		LED_2_1=1;        // AMBIENT-LIV s2+s3  PORT2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1020 :: 		LED_7_0=1;        // POWDER-LIV s6      PORT6
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1021 :: 		}
L_timer1_isr401:
;botrungtam.c,1022 :: 		if(AMBIENT_LIV_STATUS==0){
MOVW	R0, #lo_addr(_AMBIENT_LIV_STATUS+0)
MOVT	R0, #hi_addr(_AMBIENT_LIV_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr402
;botrungtam.c,1024 :: 		out_relay&=~S2A;
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #64
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1025 :: 		out_relay&=~S6;
MVN	R0, #32
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1026 :: 		LED_2_1=0;        // AMBIENT-LIV s2+s3  PORT2
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1027 :: 		LED_7_0=0;        // POWDER-LIV s6      PORT6
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1028 :: 		}
L_timer1_isr402:
;botrungtam.c,1029 :: 		AMBIENT_LIVING=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_AMBIENT_LIVING+0)
MOVT	R0, #hi_addr(_AMBIENT_LIVING+0)
STRB	R1, [R0, #0]
;botrungtam.c,1030 :: 		}
L_timer1_isr400:
;botrungtam.c,1032 :: 		if(AMBIENT_BATH==1){
MOVW	R0, #lo_addr(_AMBIENT_BATH+0)
MOVT	R0, #hi_addr(_AMBIENT_BATH+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_timer1_isr403
;botrungtam.c,1033 :: 		if(AMBIENT_BATH_STATUS!=0){
MOVW	R0, #lo_addr(_AMBIENT_BATH_STATUS+0)
MOVT	R0, #hi_addr(_AMBIENT_BATH_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr404
;botrungtam.c,1034 :: 		out_relay|=S11;   // S11=RELAY_1
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,1035 :: 		out_relay|=S9;    // S9=RELAY_2
ORR	R0, R0, #2
STR	R0, [R1, #0]
;botrungtam.c,1036 :: 		LED_8_0=1;        // PORT8
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1038 :: 		}
L_timer1_isr404:
;botrungtam.c,1039 :: 		if(AMBIENT_BATH_STATUS==0){
MOVW	R0, #lo_addr(_AMBIENT_BATH_STATUS+0)
MOVT	R0, #hi_addr(_AMBIENT_BATH_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr405
;botrungtam.c,1041 :: 		out_relay&=~S11;   //S11=RELAY_1
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #1
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1042 :: 		out_relay&=~S9;   //S9=RELAY_2
MVN	R0, #2
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1043 :: 		LED_8_0=0;        // PORT8
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1045 :: 		}
L_timer1_isr405:
;botrungtam.c,1046 :: 		AMBIENT_BATH=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_AMBIENT_BATH+0)
MOVT	R0, #hi_addr(_AMBIENT_BATH+0)
STRB	R1, [R0, #0]
;botrungtam.c,1048 :: 		}
L_timer1_isr403:
;botrungtam.c,1049 :: 		xuat_32bit(out_relay);
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
BL	_xuat_32bit+0
;botrungtam.c,1050 :: 		}
L_timer1_isr396:
;botrungtam.c,1052 :: 		if(KEYCARD_ENABLE==0)
MOVW	R0, #lo_addr(_KEYCARD_ENABLE+0)
MOVT	R0, #hi_addr(_KEYCARD_ENABLE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr406
;botrungtam.c,1054 :: 		out_relay=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
STR	R1, [R0, #0]
;botrungtam.c,1055 :: 		xuat_32bit(out_relay);
MOV	R0, #0
BL	_xuat_32bit+0
;botrungtam.c,1056 :: 		}
L_timer1_isr406:
;botrungtam.c,1058 :: 		}
L_timer1_isr282:
;botrungtam.c,1059 :: 		}
L_end_timer1_isr:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _timer1_isr
_uart4_rx:
;botrungtam.c,1069 :: 		void uart4_rx() iv IVT_INT_UART4 ics ICS_AUTO {
;botrungtam.c,1072 :: 		if(UART4_SRbits.RXNE){   // RXNE: Read data register not empty
MOVW	R1, #lo_addr(UART4_SRbits+0)
MOVT	R1, #hi_addr(UART4_SRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_uart4_rx407
;botrungtam.c,1073 :: 		UART4_SRbits.RXNE=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(UART4_SRbits+0)
MOVT	R0, #hi_addr(UART4_SRbits+0)
STR	R1, [R0, #0]
;botrungtam.c,1074 :: 		data_rc=UART4_DRbits.DR;
MOVW	R0, #lo_addr(UART4_DRbits+0)
MOVT	R0, #hi_addr(UART4_DRbits+0)
LDRH	R0, [R0, #0]
UBFX	R0, R0, #0, #9
; data_rc start address is: 12 (R3)
UXTB	R3, R0
;botrungtam.c,1078 :: 		if(DATA_TRUE){
MOVW	R0, #lo_addr(_DATA_TRUE+0)
MOVT	R0, #hi_addr(_DATA_TRUE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_uart4_rx408
;botrungtam.c,1079 :: 		buf_rc_u4[count_buf_rc_4++]=data_rc;
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
;botrungtam.c,1080 :: 		}
L_uart4_rx408:
;botrungtam.c,1081 :: 		if(count_buf_rc_4==0){    // received header
MOVW	R0, #lo_addr(_count_buf_rc_4+0)
MOVT	R0, #hi_addr(_count_buf_rc_4+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_uart4_rx409
;botrungtam.c,1082 :: 		if(data_rc==0x4B){    // header is "K"
CMP	R3, #75
IT	NE
BNE	L_uart4_rx410
;botrungtam.c,1084 :: 		DATA_TRUE=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_DATA_TRUE+0)
MOVT	R0, #hi_addr(_DATA_TRUE+0)
STRB	R1, [R0, #0]
;botrungtam.c,1086 :: 		}
L_uart4_rx410:
;botrungtam.c,1087 :: 		}
L_uart4_rx409:
;botrungtam.c,1089 :: 		if(count_buf_rc_4>=6){
MOVW	R0, #lo_addr(_count_buf_rc_4+0)
MOVT	R0, #hi_addr(_count_buf_rc_4+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	CC
BCC	L_uart4_rx411
;botrungtam.c,1091 :: 		DATA_TRUE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_DATA_TRUE+0)
MOVT	R0, #hi_addr(_DATA_TRUE+0)
STRB	R1, [R0, #0]
;botrungtam.c,1092 :: 		if(data_rc==0x4D){    // "M"
CMP	R3, #77
IT	NE
BNE	L_uart4_rx412
; data_rc end address is: 12 (R3)
;botrungtam.c,1093 :: 		PROCESSING_RS485=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_PROCESSING_RS485+0)
MOVT	R0, #hi_addr(_PROCESSING_RS485+0)
STRB	R1, [R0, #0]
;botrungtam.c,1094 :: 		count_buf_rc_4=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_count_buf_rc_4+0)
MOVT	R0, #hi_addr(_count_buf_rc_4+0)
STRB	R1, [R0, #0]
;botrungtam.c,1099 :: 		}
L_uart4_rx412:
;botrungtam.c,1100 :: 		}
L_uart4_rx411:
;botrungtam.c,1106 :: 		}
L_uart4_rx407:
;botrungtam.c,1108 :: 		}
L_end_uart4_rx:
BX	LR
; end of _uart4_rx
_main:
;botrungtam.c,1119 :: 		void main() {
SUB	SP, SP, #12
;botrungtam.c,1127 :: 		gpio_init();
BL	_gpio_init+0
;botrungtam.c,1130 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_14);   // KICK MOSFET IRF9530 FOR RELAY 12V
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1131 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_15);
MOVW	R1, #32768
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1132 :: 		duphong8_C14=0;      // KICK MOSFET IRF9530 FOR RELAY 12V
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R0, [SP, #8]
STR	R1, [R0, #0]
;botrungtam.c,1133 :: 		duphong9_C15=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R0, [SP, #4]
STR	R1, [R0, #0]
;botrungtam.c,1140 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_12);   // den bao mau xanh da troi Port A12
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1141 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_8);   //
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1142 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_9);   // KICK MOSFET IRF9530 FOR RELAY 12V
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1144 :: 		GPIO_Digital_Input (&GPIOD_BASE, _GPIO_PINMASK_6 );    //chuyen thanh INPUT
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
;botrungtam.c,1146 :: 		GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_7);   // ke ben pinD6- kick 74hc595
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1147 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_3);   //
MOVW	R1, #8
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1148 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_4);   //
MOVW	R1, #16
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;botrungtam.c,1149 :: 		STAT=0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1150 :: 		duphong66_C9=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1151 :: 		duphong67_A8=1;
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1153 :: 		duphong88_D7=0;      // ke ben pinD6- kick 74hc595
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1154 :: 		duphong89_B3=1;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1155 :: 		duphong90_B4=1;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1156 :: 		buf_rc_u4[0]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+0)
MOVT	R0, #hi_addr(_buf_rc_u4+0)
STRB	R1, [R0, #0]
;botrungtam.c,1157 :: 		buf_rc_u4[1]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+1)
MOVT	R0, #hi_addr(_buf_rc_u4+1)
STRB	R1, [R0, #0]
;botrungtam.c,1158 :: 		buf_rc_u4[2]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+2)
MOVT	R0, #hi_addr(_buf_rc_u4+2)
STRB	R1, [R0, #0]
;botrungtam.c,1159 :: 		buf_rc_u4[3]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+3)
MOVT	R0, #hi_addr(_buf_rc_u4+3)
STRB	R1, [R0, #0]
;botrungtam.c,1160 :: 		buf_rc_u4[4]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+4)
MOVT	R0, #hi_addr(_buf_rc_u4+4)
STRB	R1, [R0, #0]
;botrungtam.c,1161 :: 		buf_rc_u4[5]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+5)
MOVT	R0, #hi_addr(_buf_rc_u4+5)
STRB	R1, [R0, #0]
;botrungtam.c,1162 :: 		buf_rc_u4[6]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+6)
MOVT	R0, #hi_addr(_buf_rc_u4+6)
STRB	R1, [R0, #0]
;botrungtam.c,1164 :: 		usart2_init();
BL	_usart2_init+0
;botrungtam.c,1165 :: 		uart4__init();   //baud=9600 rs485 uart 4
BL	_uart4__init+0
;botrungtam.c,1166 :: 		DATA_TRUE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_DATA_TRUE+0)
MOVT	R0, #hi_addr(_DATA_TRUE+0)
STRB	R1, [R0, #0]
;botrungtam.c,1167 :: 		PROCESSING_RS485=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_PROCESSING_RS485+0)
MOVT	R0, #hi_addr(_PROCESSING_RS485+0)
STRB	R1, [R0, #0]
;botrungtam.c,1169 :: 		count_buf_rc_4=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_count_buf_rc_4+0)
MOVT	R0, #hi_addr(_count_buf_rc_4+0)
STRB	R1, [R0, #0]
;botrungtam.c,1170 :: 		TRAN_4    //   rs485 uart 4
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1171 :: 		uart4_string("ok");
MOVW	R0, #lo_addr(?lstr33_botrungtam+0)
MOVT	R0, #hi_addr(?lstr33_botrungtam+0)
BL	_uart4_string+0
;botrungtam.c,1172 :: 		uart4_chr(0x0D);
MOVS	R0, #13
BL	_uart4_chr+0
;botrungtam.c,1173 :: 		uart4_chr(0x0A);
MOVS	R0, #10
BL	_uart4_chr+0
;botrungtam.c,1174 :: 		REC_4
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1176 :: 		out_relay=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
STR	R0, [SP, #0]
STR	R1, [R0, #0]
;botrungtam.c,1177 :: 		xuat_32bit(out_relay);
MOV	R0, #0
BL	_xuat_32bit+0
;botrungtam.c,1179 :: 		delay_ms(1500);
MOVW	R7, #43135
MOVT	R7, #274
NOP
NOP
L_main413:
SUBS	R7, R7, #1
BNE	L_main413
NOP
NOP
NOP
;botrungtam.c,1180 :: 		duphong88_D7=1;      // ke ben pinD6- kick 74hc595
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1181 :: 		out_relay=0;
MOVS	R1, #0
LDR	R0, [SP, #0]
STR	R1, [R0, #0]
;botrungtam.c,1182 :: 		xuat_32bit(out_relay);
MOV	R0, #0
BL	_xuat_32bit+0
;botrungtam.c,1183 :: 		memset(but_state,0,25);
MOVS	R2, #25
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
BL	_memset+0
;botrungtam.c,1184 :: 		timer1_init();
BL	_timer1_init+0
;botrungtam.c,1185 :: 		KEYCARD_ENABLE=0;       // disable xuat_32bit(out_relay)
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_ENABLE+0)
MOVT	R0, #hi_addr(_KEYCARD_ENABLE+0)
STRB	R1, [R0, #0]
;botrungtam.c,1190 :: 		duphong8_C14=1; // KICK MOSFET IRF9530 FOR RELAY 12V
MOVS	R1, #1
SXTB	R1, R1
LDR	R0, [SP, #8]
STR	R1, [R0, #0]
;botrungtam.c,1191 :: 		duphong9_C15=1;
LDR	R0, [SP, #4]
STR	R1, [R0, #0]
;botrungtam.c,1192 :: 		RCC_APB1ENR.B11 = 1;            // Enable clock gating for Watchdog Timer 0 module
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;botrungtam.c,1199 :: 		WWDG_CFR = 1;                   // Write window value to be compared to the downcounter
MOVS	R1, #1
MOVW	R0, #lo_addr(WWDG_CFR+0)
MOVT	R0, #hi_addr(WWDG_CFR+0)
STR	R1, [R0, #0]
;botrungtam.c,1200 :: 		while(1){
L_main415:
;botrungtam.c,1203 :: 		if(BELL_ENABLE){
MOVW	R0, #lo_addr(_BELL_ENABLE+0)
MOVT	R0, #hi_addr(_BELL_ENABLE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main417
;botrungtam.c,1204 :: 		BELL_COUNTER++;
MOVW	R2, #lo_addr(_BELL_COUNTER+0)
MOVT	R2, #hi_addr(_BELL_COUNTER+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #1
STR	R1, [R2, #0]
;botrungtam.c,1205 :: 		if(BELL_COUNTER>=0x05ffff){
MOVW	R0, #65535
MOVT	R0, #5
CMP	R1, R0
IT	CC
BCC	L_main418
;botrungtam.c,1206 :: 		out_relay&=~RELAY_13;  // TURN OFF BELL
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #4096
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1207 :: 		BELL_COUNTER=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BELL_COUNTER+0)
MOVT	R0, #hi_addr(_BELL_COUNTER+0)
STR	R1, [R0, #0]
;botrungtam.c,1208 :: 		BELL_ENABLE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BELL_ENABLE+0)
MOVT	R0, #hi_addr(_BELL_ENABLE+0)
STRB	R1, [R0, #0]
;botrungtam.c,1210 :: 		}
L_main418:
;botrungtam.c,1211 :: 		}
L_main417:
;botrungtam.c,1213 :: 		if(CURTAIN_1_STATUS==1)    // FORWARD
MOVW	R0, #lo_addr(_CURTAIN_1_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_1_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main419
;botrungtam.c,1215 :: 		if(CURTAIN_1_FORWARD){
MOVW	R0, #lo_addr(_CURTAIN_1_FORWARD+0)
MOVT	R0, #hi_addr(_CURTAIN_1_FORWARD+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main420
;botrungtam.c,1216 :: 		CURTAIN_1_OFFRELAY++;
MOVW	R1, #lo_addr(_CURTAIN_1_OFFRELAY+0)
MOVT	R1, #hi_addr(_CURTAIN_1_OFFRELAY+0)
LDRB	R0, [R1, #0]
ADDS	R3, R0, #1
UXTB	R3, R3
STRB	R3, [R1, #0]
;botrungtam.c,1217 :: 		out_relay&=~RELAY_11;
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #1024
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1218 :: 		out_relay&=~RELAY_12;
MVN	R0, #2048
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1219 :: 		if(CURTAIN_1_OFFRELAY>=0xFE)
CMP	R3, #254
IT	CC
BCC	L_main421
;botrungtam.c,1221 :: 		out_relay|=RELAY_12;       //C21=1
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R0, [R2, #0]
ORR	R1, R0, #2048
STR	R1, [R2, #0]
;botrungtam.c,1222 :: 		out_relay&=~RELAY_11;      //C22=0
MVN	R0, #1024
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1223 :: 		LED_3_2=0;     // LED BACKWARD OFF
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1224 :: 		CURTAIN_1_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_1_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_1_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1225 :: 		CURTAIN_1_OFFRELAY=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_1_OFFRELAY+0)
MOVT	R0, #hi_addr(_CURTAIN_1_OFFRELAY+0)
STRB	R1, [R0, #0]
;botrungtam.c,1226 :: 		}
L_main421:
;botrungtam.c,1227 :: 		}
L_main420:
;botrungtam.c,1228 :: 		if(!CURTAIN_1_FORWARD){     //STOP
MOVW	R0, #lo_addr(_CURTAIN_1_FORWARD+0)
MOVT	R0, #hi_addr(_CURTAIN_1_FORWARD+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main422
;botrungtam.c,1229 :: 		out_relay|=RELAY_12;       //C21=1
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #2048
STR	R0, [R1, #0]
;botrungtam.c,1230 :: 		out_relay|=RELAY_11;      //C22=1
ORR	R0, R0, #1024
STR	R0, [R1, #0]
;botrungtam.c,1231 :: 		LED_3_0=0;    //STOP
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1232 :: 		LED_3_2=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1233 :: 		CURTAIN_1_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_1_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_1_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1234 :: 		}
L_main422:
;botrungtam.c,1235 :: 		}
L_main419:
;botrungtam.c,1237 :: 		if(CURTAIN_1_STATUS==2)    // BACKWARD
MOVW	R0, #lo_addr(_CURTAIN_1_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_1_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main423
;botrungtam.c,1239 :: 		if(CURTAIN_1_BACKWARD){
MOVW	R0, #lo_addr(_CURTAIN_1_BACKWARD+0)
MOVT	R0, #hi_addr(_CURTAIN_1_BACKWARD+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main424
;botrungtam.c,1240 :: 		CURTAIN_1_OFFRELAY++;
MOVW	R1, #lo_addr(_CURTAIN_1_OFFRELAY+0)
MOVT	R1, #hi_addr(_CURTAIN_1_OFFRELAY+0)
LDRB	R0, [R1, #0]
ADDS	R3, R0, #1
UXTB	R3, R3
STRB	R3, [R1, #0]
;botrungtam.c,1241 :: 		out_relay&=~RELAY_11;
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #1024
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1242 :: 		out_relay&=~RELAY_12;
MVN	R0, #2048
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1243 :: 		if(CURTAIN_1_OFFRELAY>=0xFE)
CMP	R3, #254
IT	CC
BCC	L_main425
;botrungtam.c,1245 :: 		out_relay&=~RELAY_12;       //C21=0
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #2048
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1246 :: 		out_relay|=RELAY_11;        //C22=1
ORR	R0, R0, #1024
STR	R0, [R2, #0]
;botrungtam.c,1247 :: 		LED_3_0=0;     // LED FORWARD OFF
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1248 :: 		CURTAIN_1_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_1_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_1_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1249 :: 		CURTAIN_1_OFFRELAY=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_1_OFFRELAY+0)
MOVT	R0, #hi_addr(_CURTAIN_1_OFFRELAY+0)
STRB	R1, [R0, #0]
;botrungtam.c,1250 :: 		}
L_main425:
;botrungtam.c,1251 :: 		}
L_main424:
;botrungtam.c,1252 :: 		if(!CURTAIN_1_BACKWARD){     //STOP
MOVW	R0, #lo_addr(_CURTAIN_1_BACKWARD+0)
MOVT	R0, #hi_addr(_CURTAIN_1_BACKWARD+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main426
;botrungtam.c,1253 :: 		out_relay|=RELAY_12;       //C21=1
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #2048
STR	R0, [R1, #0]
;botrungtam.c,1254 :: 		out_relay|=RELAY_11;      //C22=1
ORR	R0, R0, #1024
STR	R0, [R1, #0]
;botrungtam.c,1255 :: 		LED_3_2=0;    //STOP
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1256 :: 		LED_3_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1257 :: 		CURTAIN_1_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_1_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_1_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1258 :: 		}
L_main426:
;botrungtam.c,1260 :: 		}
L_main423:
;botrungtam.c,1263 :: 		if(CURTAIN_1_TIMEOUT)
MOVW	R0, #lo_addr(_CURTAIN_1_TIMEOUT+0)
MOVT	R0, #hi_addr(_CURTAIN_1_TIMEOUT+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main427
;botrungtam.c,1265 :: 		CURTAIN_1_COUNTER_CLOSE++;
MOVW	R2, #lo_addr(_CURTAIN_1_COUNTER_CLOSE+0)
MOVT	R2, #hi_addr(_CURTAIN_1_COUNTER_CLOSE+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #1
STR	R1, [R2, #0]
;botrungtam.c,1266 :: 		if(CURTAIN_1_COUNTER_CLOSE>=0x000fffff)
MOVW	R0, #65535
MOVT	R0, #15
CMP	R1, R0
IT	CC
BCC	L_main428
;botrungtam.c,1268 :: 		out_relay&=~RELAY_12;  // TURN OFF CURTAIN_1 C21
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #2048
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1269 :: 		out_relay&=~RELAY_11;  // TURN OFF CURTAIN_1 C22
MVN	R0, #1024
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1270 :: 		CURTAIN_1_COUNTER_CLOSE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_1_COUNTER_CLOSE+0)
MOVT	R0, #hi_addr(_CURTAIN_1_COUNTER_CLOSE+0)
STR	R1, [R0, #0]
;botrungtam.c,1271 :: 		CURTAIN_1_TIMEOUT=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_1_TIMEOUT+0)
MOVT	R0, #hi_addr(_CURTAIN_1_TIMEOUT+0)
STRB	R1, [R0, #0]
;botrungtam.c,1272 :: 		LED_3_0=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1273 :: 		LED_3_2=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1274 :: 		CURTAIN_1_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_1_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_1_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1275 :: 		}
L_main428:
;botrungtam.c,1276 :: 		}
L_main427:
;botrungtam.c,1278 :: 		if(CURTAIN_2_STATUS==1)    // FORWARD
MOVW	R0, #lo_addr(_CURTAIN_2_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_2_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main429
;botrungtam.c,1280 :: 		if(CURTAIN_2_FORWARD){
MOVW	R0, #lo_addr(_CURTAIN_2_FORWARD+0)
MOVT	R0, #hi_addr(_CURTAIN_2_FORWARD+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main430
;botrungtam.c,1281 :: 		out_relay|=RELAY_10;       //C23=1
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R0, [R2, #0]
ORR	R1, R0, #512
STR	R1, [R2, #0]
;botrungtam.c,1282 :: 		out_relay&=~RELAY_9;      //C24=0
MVN	R0, #256
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1283 :: 		LED_4_1=0;     // LED BACKWARD OFF
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1284 :: 		}
L_main430:
;botrungtam.c,1285 :: 		if(!CURTAIN_2_FORWARD){
MOVW	R0, #lo_addr(_CURTAIN_2_FORWARD+0)
MOVT	R0, #hi_addr(_CURTAIN_2_FORWARD+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main431
;botrungtam.c,1286 :: 		out_relay|=RELAY_10;       //C23=1
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #512
STR	R0, [R1, #0]
;botrungtam.c,1287 :: 		out_relay|=RELAY_9;      //C24=1
ORR	R0, R0, #256
STR	R0, [R1, #0]
;botrungtam.c,1288 :: 		LED_4_0=0;    //STOP
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1289 :: 		LED_4_1=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1290 :: 		}
L_main431:
;botrungtam.c,1291 :: 		CURTAIN_2_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_2_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_2_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1292 :: 		}
L_main429:
;botrungtam.c,1294 :: 		if(CURTAIN_2_STATUS==2)    // BACKWARD
MOVW	R0, #lo_addr(_CURTAIN_2_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_2_STATUS+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main432
;botrungtam.c,1296 :: 		if(CURTAIN_2_BACKWARD){
MOVW	R0, #lo_addr(_CURTAIN_2_BACKWARD+0)
MOVT	R0, #hi_addr(_CURTAIN_2_BACKWARD+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main433
;botrungtam.c,1297 :: 		out_relay&=~RELAY_10;       //C23=0
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #512
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1298 :: 		out_relay|=RELAY_9;        //C24=1
ORR	R0, R0, #256
STR	R0, [R2, #0]
;botrungtam.c,1299 :: 		LED_4_0=0;     // LED FORWARD OFF
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1300 :: 		}
L_main433:
;botrungtam.c,1301 :: 		if(!CURTAIN_2_BACKWARD){
MOVW	R0, #lo_addr(_CURTAIN_2_BACKWARD+0)
MOVT	R0, #hi_addr(_CURTAIN_2_BACKWARD+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main434
;botrungtam.c,1302 :: 		out_relay|=RELAY_10;       //C23=1
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #512
STR	R0, [R1, #0]
;botrungtam.c,1303 :: 		out_relay|=RELAY_9;      //C24=1
ORR	R0, R0, #256
STR	R0, [R1, #0]
;botrungtam.c,1304 :: 		LED_4_1=0;    //STOP
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1305 :: 		LED_4_0=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1306 :: 		}
L_main434:
;botrungtam.c,1307 :: 		CURTAIN_2_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_2_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_2_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1308 :: 		}
L_main432:
;botrungtam.c,1310 :: 		if(CURTAIN_2_TIMEOUT)
MOVW	R0, #lo_addr(_CURTAIN_2_TIMEOUT+0)
MOVT	R0, #hi_addr(_CURTAIN_2_TIMEOUT+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main435
;botrungtam.c,1312 :: 		CURTAIN_2_COUNTER_CLOSE++;
MOVW	R2, #lo_addr(_CURTAIN_2_COUNTER_CLOSE+0)
MOVT	R2, #hi_addr(_CURTAIN_2_COUNTER_CLOSE+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #1
STR	R1, [R2, #0]
;botrungtam.c,1313 :: 		if(CURTAIN_2_COUNTER_CLOSE>=0x000fffff)
MOVW	R0, #65535
MOVT	R0, #15
CMP	R1, R0
IT	CC
BCC	L_main436
;botrungtam.c,1315 :: 		out_relay&=~RELAY_10;  // TURN OFF CURTAIN1 C23
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #512
ANDS	R1, R0
STR	R1, [R2, #0]
;botrungtam.c,1316 :: 		out_relay&=~RELAY_9;  // TURN OFF CURTAIN1 C24
MVN	R0, #256
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1317 :: 		CURTAIN_2_COUNTER_CLOSE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_2_COUNTER_CLOSE+0)
MOVT	R0, #hi_addr(_CURTAIN_2_COUNTER_CLOSE+0)
STR	R1, [R0, #0]
;botrungtam.c,1318 :: 		CURTAIN_2_TIMEOUT=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_2_TIMEOUT+0)
MOVT	R0, #hi_addr(_CURTAIN_2_TIMEOUT+0)
STRB	R1, [R0, #0]
;botrungtam.c,1319 :: 		LED_4_0=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1320 :: 		LED_4_1=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1321 :: 		CURTAIN_2_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_2_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_2_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1322 :: 		}
L_main436:
;botrungtam.c,1323 :: 		}
L_main435:
;botrungtam.c,1325 :: 		if(KEYCARD_INSERT==1){
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main437
;botrungtam.c,1327 :: 		KEYCARD_COUNTER_CLOSE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_COUNTER_CLOSE+0)
MOVT	R0, #hi_addr(_KEYCARD_COUNTER_CLOSE+0)
STR	R1, [R0, #0]
;botrungtam.c,1333 :: 		if(!KEYCARD_STARTUP){
MOVW	R0, #lo_addr(_KEYCARD_STARTUP+0)
MOVT	R0, #hi_addr(_KEYCARD_STARTUP+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main438
;botrungtam.c,1338 :: 		out_relay|=SOCKET;    //SOCKET=RELAY_14
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #8192
STR	R0, [R1, #0]
;botrungtam.c,1339 :: 		out_relay|=AIRCON;    //AIRCON==RELAY_15
ORR	R0, R0, #16384
STR	R0, [R1, #0]
;botrungtam.c,1342 :: 		CURTAIN_1_STATUS=1;   // curtain_1=forward
MOVS	R1, #1
MOVW	R0, #lo_addr(_CURTAIN_1_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_1_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1343 :: 		CURTAIN_1_FORWARD=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_CURTAIN_1_FORWARD+0)
MOVT	R0, #hi_addr(_CURTAIN_1_FORWARD+0)
STRB	R1, [R0, #0]
;botrungtam.c,1344 :: 		CURTAIN_2_STATUS=1;   // curtain_2=forward
MOVS	R1, #1
MOVW	R0, #lo_addr(_CURTAIN_2_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_2_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1345 :: 		CURTAIN_2_FORWARD=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_CURTAIN_2_FORWARD+0)
MOVT	R0, #hi_addr(_CURTAIN_2_FORWARD+0)
STRB	R1, [R0, #0]
;botrungtam.c,1346 :: 		CURTAIN_1_TIMEOUT=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_CURTAIN_1_TIMEOUT+0)
MOVT	R0, #hi_addr(_CURTAIN_1_TIMEOUT+0)
STRB	R1, [R0, #0]
;botrungtam.c,1347 :: 		CURTAIN_2_TIMEOUT=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_CURTAIN_2_TIMEOUT+0)
MOVT	R0, #hi_addr(_CURTAIN_2_TIMEOUT+0)
STRB	R1, [R0, #0]
;botrungtam.c,1351 :: 		KEYCARD_STARTUP=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_KEYCARD_STARTUP+0)
MOVT	R0, #hi_addr(_KEYCARD_STARTUP+0)
STRB	R1, [R0, #0]
;botrungtam.c,1352 :: 		}
L_main438:
;botrungtam.c,1353 :: 		}
L_main437:
;botrungtam.c,1355 :: 		if(KEYCARD_INSERT==0){
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main439
;botrungtam.c,1356 :: 		KEYCARD_COUNTER_CLOSE++;
MOVW	R1, #lo_addr(_KEYCARD_COUNTER_CLOSE+0)
MOVT	R1, #hi_addr(_KEYCARD_COUNTER_CLOSE+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,1357 :: 		if(KEYCARD_COUNTER_CLOSE>=0x00100000) {
CMP	R0, #1048576
IT	CC
BCC	L_main440
;botrungtam.c,1358 :: 		KEYCARD_COUNTER_CLOSE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_COUNTER_CLOSE+0)
MOVT	R0, #hi_addr(_KEYCARD_COUNTER_CLOSE+0)
STR	R1, [R0, #0]
;botrungtam.c,1359 :: 		KEYCARD_ENABLE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_ENABLE+0)
MOVT	R0, #hi_addr(_KEYCARD_ENABLE+0)
STRB	R1, [R0, #0]
;botrungtam.c,1360 :: 		KEYCARD_STARTUP=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_STARTUP+0)
MOVT	R0, #hi_addr(_KEYCARD_STARTUP+0)
STRB	R1, [R0, #0]
;botrungtam.c,1362 :: 		out_relay=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
STR	R1, [R0, #0]
;botrungtam.c,1363 :: 		STAT=0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1369 :: 		AMBIENT_BATH_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_AMBIENT_BATH_STATUS+0)
MOVT	R0, #hi_addr(_AMBIENT_BATH_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1370 :: 		MASTER_LIV_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_MASTER_LIV_STATUS+0)
MOVT	R0, #hi_addr(_MASTER_LIV_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1371 :: 		AMBIENT_LIV_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_AMBIENT_LIV_STATUS+0)
MOVT	R0, #hi_addr(_AMBIENT_LIV_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1372 :: 		CURTAIN_1_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_1_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_1_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1373 :: 		CURTAIN_2_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CURTAIN_2_STATUS+0)
MOVT	R0, #hi_addr(_CURTAIN_2_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1375 :: 		LED_11_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1376 :: 		LED_11_1=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1377 :: 		LED_9_0=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1378 :: 		LED_9_1=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1380 :: 		LED_10_0=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1381 :: 		LED_10_1=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1383 :: 		LED_8_0=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1384 :: 		LED_8_1=0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1386 :: 		LED_6_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1388 :: 		LED_5_0=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1389 :: 		LED_5_1=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1391 :: 		LED_4_0=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1392 :: 		LED_4_1=0;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1394 :: 		LED_3_0=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1395 :: 		LED_3_2=0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1397 :: 		LED_2_0=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1398 :: 		LED_2_1=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1399 :: 		LED_2_2=0;
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1400 :: 		DO_NOT_DISTURB=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_DO_NOT_DISTURB+0)
MOVT	R0, #hi_addr(_DO_NOT_DISTURB+0)
STRB	R1, [R0, #0]
;botrungtam.c,1402 :: 		LED_1_0=0;     // MUR LED
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1403 :: 		LED_1_1=0;     // DND LED
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R2, [R0, #0]
;botrungtam.c,1404 :: 		}
L_main440:
;botrungtam.c,1405 :: 		}
L_main439:
;botrungtam.c,1410 :: 		if(PROCESSING_RS485){
MOVW	R0, #lo_addr(_PROCESSING_RS485+0)
MOVT	R0, #hi_addr(_PROCESSING_RS485+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main441
;botrungtam.c,1419 :: 		PROCESSING_RS485=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_PROCESSING_RS485+0)
MOVT	R0, #hi_addr(_PROCESSING_RS485+0)
STRB	R1, [R0, #0]
;botrungtam.c,1423 :: 		if(buf_rc_u4[4]==0x33){ // 0x33= "3"
MOVW	R0, #lo_addr(_buf_rc_u4+4)
MOVT	R0, #hi_addr(_buf_rc_u4+4)
LDRB	R0, [R0, #0]
CMP	R0, #51
IT	NE
BNE	L_main442
;botrungtam.c,1424 :: 		STAT = ~STAT;
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,1425 :: 		if(buf_rc_u4[3]==0x42)
MOVW	R0, #lo_addr(_buf_rc_u4+3)
MOVT	R0, #hi_addr(_buf_rc_u4+3)
LDRB	R0, [R0, #0]
CMP	R0, #66
IT	NE
BNE	L_main443
;botrungtam.c,1427 :: 		AMBIENT_BATH=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_AMBIENT_BATH+0)
MOVT	R0, #hi_addr(_AMBIENT_BATH+0)
STRB	R1, [R0, #0]
;botrungtam.c,1428 :: 		AMBIENT_BATH_STATUS=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_AMBIENT_BATH_STATUS+0)
MOVT	R0, #hi_addr(_AMBIENT_BATH_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1429 :: 		}
L_main443:
;botrungtam.c,1430 :: 		if(buf_rc_u4[3]==0x54)
MOVW	R0, #lo_addr(_buf_rc_u4+3)
MOVT	R0, #hi_addr(_buf_rc_u4+3)
LDRB	R0, [R0, #0]
CMP	R0, #84
IT	NE
BNE	L_main444
;botrungtam.c,1432 :: 		AMBIENT_BATH=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_AMBIENT_BATH+0)
MOVT	R0, #hi_addr(_AMBIENT_BATH+0)
STRB	R1, [R0, #0]
;botrungtam.c,1433 :: 		AMBIENT_BATH_STATUS=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_AMBIENT_BATH_STATUS+0)
MOVT	R0, #hi_addr(_AMBIENT_BATH_STATUS+0)
STRB	R1, [R0, #0]
;botrungtam.c,1434 :: 		}
L_main444:
;botrungtam.c,1435 :: 		}
L_main442:
;botrungtam.c,1438 :: 		if(buf_rc_u4[4]==0x32){ // 0x32= "2"
MOVW	R0, #lo_addr(_buf_rc_u4+4)
MOVT	R0, #hi_addr(_buf_rc_u4+4)
LDRB	R0, [R0, #0]
CMP	R0, #50
IT	NE
BNE	L_main445
;botrungtam.c,1439 :: 		if(buf_rc_u4[3]==0x42)
MOVW	R0, #lo_addr(_buf_rc_u4+3)
MOVT	R0, #hi_addr(_buf_rc_u4+3)
LDRB	R0, [R0, #0]
CMP	R0, #66
IT	NE
BNE	L_main446
;botrungtam.c,1441 :: 		out_relay|=S9;   // S9 = RELAY-2
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #2
STR	R0, [R1, #0]
;botrungtam.c,1442 :: 		}
L_main446:
;botrungtam.c,1443 :: 		if(buf_rc_u4[3]==0x54)
MOVW	R0, #lo_addr(_buf_rc_u4+3)
MOVT	R0, #hi_addr(_buf_rc_u4+3)
LDRB	R0, [R0, #0]
CMP	R0, #84
IT	NE
BNE	L_main447
;botrungtam.c,1445 :: 		out_relay&=~S9;   // S9 = RELAY-2
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #2
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1446 :: 		}
L_main447:
;botrungtam.c,1447 :: 		STAT = ~STAT;
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,1448 :: 		}
L_main445:
;botrungtam.c,1451 :: 		if(buf_rc_u4[4]==0x31){ // 0x31="1"
MOVW	R0, #lo_addr(_buf_rc_u4+4)
MOVT	R0, #hi_addr(_buf_rc_u4+4)
LDRB	R0, [R0, #0]
CMP	R0, #49
IT	NE
BNE	L_main448
;botrungtam.c,1452 :: 		if(buf_rc_u4[3]==0x42)
MOVW	R0, #lo_addr(_buf_rc_u4+3)
MOVT	R0, #hi_addr(_buf_rc_u4+3)
LDRB	R0, [R0, #0]
CMP	R0, #66
IT	NE
BNE	L_main449
;botrungtam.c,1454 :: 		out_relay|=S10;   // S9 = RELAY-2
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #32768
STR	R0, [R1, #0]
;botrungtam.c,1455 :: 		}
L_main449:
;botrungtam.c,1456 :: 		if(buf_rc_u4[3]==0x54)
MOVW	R0, #lo_addr(_buf_rc_u4+3)
MOVT	R0, #hi_addr(_buf_rc_u4+3)
LDRB	R0, [R0, #0]
CMP	R0, #84
IT	NE
BNE	L_main450
;botrungtam.c,1458 :: 		out_relay&=~S10;   // S9 = RELAY-2
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MOVW	R0, #32767
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;botrungtam.c,1459 :: 		}
L_main450:
;botrungtam.c,1460 :: 		STAT = ~STAT;
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;botrungtam.c,1461 :: 		}
L_main448:
;botrungtam.c,1498 :: 		}
L_main441:
;botrungtam.c,1500 :: 		if(KEYCARD_SEND_RS485>=200){
MOVW	R0, #lo_addr(_KEYCARD_SEND_RS485+0)
MOVT	R0, #hi_addr(_KEYCARD_SEND_RS485+0)
LDRB	R0, [R0, #0]
CMP	R0, #200
IT	CC
BCC	L_main451
;botrungtam.c,1501 :: 		KEYCARD_SEND_RS485=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_SEND_RS485+0)
MOVT	R0, #hi_addr(_KEYCARD_SEND_RS485+0)
STRB	R1, [R0, #0]
;botrungtam.c,1502 :: 		if(SEND_RS485_KEY==1){
MOVW	R0, #lo_addr(_SEND_RS485_KEY+0)
MOVT	R0, #hi_addr(_SEND_RS485_KEY+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main452
;botrungtam.c,1503 :: 		TRAN_4
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1505 :: 		uart4_chr(0x4B);    //"K"
MOVS	R0, #75
BL	_uart4_chr+0
;botrungtam.c,1506 :: 		uart4_chr(0x30);    //1
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,1507 :: 		uart4_chr(0x30);    //2
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,1508 :: 		uart4_chr(0x30);    //3
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,1509 :: 		uart4_chr(0x30);    //4
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,1510 :: 		uart4_chr(0x45);    //E
MOVS	R0, #69
BL	_uart4_chr+0
;botrungtam.c,1511 :: 		uart4_chr(0x4D);    //"M"
MOVS	R0, #77
BL	_uart4_chr+0
;botrungtam.c,1512 :: 		uart4_chr(0x0D);
MOVS	R0, #13
BL	_uart4_chr+0
;botrungtam.c,1513 :: 		uart4_chr(0x0A);
MOVS	R0, #10
BL	_uart4_chr+0
;botrungtam.c,1514 :: 		REC_4
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1515 :: 		SEND_RS485_KEY=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_SEND_RS485_KEY+0)
MOVT	R0, #hi_addr(_SEND_RS485_KEY+0)
STRB	R1, [R0, #0]
;botrungtam.c,1516 :: 		}
L_main452:
;botrungtam.c,1517 :: 		if(SEND_RS485_KEY==2){
MOVW	R0, #lo_addr(_SEND_RS485_KEY+0)
MOVT	R0, #hi_addr(_SEND_RS485_KEY+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main453
;botrungtam.c,1518 :: 		TRAN_4
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1520 :: 		uart4_chr(0x4B);    //"K"
MOVS	R0, #75
BL	_uart4_chr+0
;botrungtam.c,1521 :: 		uart4_chr(0x30);    //1
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,1522 :: 		uart4_chr(0x30);    //2
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,1523 :: 		uart4_chr(0x30);    //3
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,1524 :: 		uart4_chr(0x30);    //4
MOVS	R0, #48
BL	_uart4_chr+0
;botrungtam.c,1525 :: 		uart4_chr(0x48);    //"H"
MOVS	R0, #72
BL	_uart4_chr+0
;botrungtam.c,1526 :: 		uart4_chr(0x4D);    //"M"
MOVS	R0, #77
BL	_uart4_chr+0
;botrungtam.c,1527 :: 		uart4_chr(0x0D);
MOVS	R0, #13
BL	_uart4_chr+0
;botrungtam.c,1528 :: 		uart4_chr(0x0A);
MOVS	R0, #10
BL	_uart4_chr+0
;botrungtam.c,1529 :: 		REC_4
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;botrungtam.c,1530 :: 		SEND_RS485_KEY=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_SEND_RS485_KEY+0)
MOVT	R0, #hi_addr(_SEND_RS485_KEY+0)
STRB	R1, [R0, #0]
;botrungtam.c,1531 :: 		}
L_main453:
;botrungtam.c,1532 :: 		}
L_main451:
;botrungtam.c,1535 :: 		}
IT	AL
BAL	L_main415
;botrungtam.c,1536 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
