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
L__xuat_32bit481:
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
;init.c,10 :: 		delay_us(2);
MOVW	R7, #23
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
BHI	L__xuat_32bit481
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
;init.c,14 :: 		}
L_end_xuat_32bit:
BX	LR
; end of _xuat_32bit
_timer1_init:
;init.c,16 :: 		void timer1_init(){ //20 ms
;init.c,17 :: 		TIM1_CR1bits.DIR_=0;  // directon 0:upcounter, 1: down
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_CR1bits+0)
MOVT	R0, #hi_addr(TIM1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,18 :: 		TIM1_CR1bits.ARPE=0; // auto-reload Preload Enable
MOVW	R0, #lo_addr(TIM1_CR1bits+0)
MOVT	R0, #hi_addr(TIM1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,19 :: 		TIM1_CR1bits.OPM=0;     // one pulse mode / 0: counter non-stop; 1: stop when CEN bit clear
MOVW	R0, #lo_addr(TIM1_CR1bits+0)
MOVT	R0, #hi_addr(TIM1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,20 :: 		TIM1_PSC=10000;  // PRESCALE VALUE(16bit)  frequency = Fclk/(PSC+1)
MOVW	R1, #10000
MOVW	R0, #lo_addr(TIM1_PSC+0)
MOVT	R0, #hi_addr(TIM1_PSC+0)
STR	R1, [R0, #0]
;init.c,21 :: 		TIM1_ARR=144;    // AUTO-RELOAD VALUE
MOVS	R1, #144
MOVW	R0, #lo_addr(TIM1_ARR+0)
MOVT	R0, #hi_addr(TIM1_ARR+0)
STR	R1, [R0, #0]
;init.c,24 :: 		TIM1_CNT=0;      // counter value
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM1_CNT+0)
MOVT	R0, #hi_addr(TIM1_CNT+0)
STR	R1, [R0, #0]
;init.c,25 :: 		TIM1_DIERbits.UIE=1;  // DMA interrup enable Register  - UIE: update interrup enable
MOVS	R3, #1
SXTB	R3, R3
MOVW	R0, #lo_addr(TIM1_DIERbits+0)
MOVT	R0, #hi_addr(TIM1_DIERbits+0)
STR	R3, [R0, #0]
;init.c,26 :: 		NVIC_SETENA0bits.SETENA25=1;
MOVW	R1, #lo_addr(NVIC_SETENA0bits+0)
MOVT	R1, #hi_addr(NVIC_SETENA0bits+0)
LDR	R0, [R1, #0]
BFI	R0, R3, #25, #1
STR	R0, [R1, #0]
;init.c,27 :: 		NVIC_IP6bits.PRI_25=0x00;
MOVS	R2, #0
MOVW	R1, #lo_addr(NVIC_IP6bits+0)
MOVT	R1, #hi_addr(NVIC_IP6bits+0)
LDRH	R0, [R1, #0]
BFI	R0, R2, #8, #8
STRH	R0, [R1, #0]
;init.c,28 :: 		TIM1_CR1bits.CEN=1;    //1 enable counter
MOVW	R0, #lo_addr(TIM1_CR1bits+0)
MOVT	R0, #hi_addr(TIM1_CR1bits+0)
STR	R3, [R0, #0]
;init.c,29 :: 		NVIC_IP8bits.PRI_32=0xf0; // priority
MOVS	R2, #240
MOVW	R1, #lo_addr(NVIC_IP8bits+0)
MOVT	R1, #hi_addr(NVIC_IP8bits+0)
LDRB	R0, [R1, #0]
BFI	R0, R2, #0, #8
STRB	R0, [R1, #0]
;init.c,30 :: 		}
L_end_timer1_init:
BX	LR
; end of _timer1_init
_usart1_init:
;init.c,32 :: 		void usart1_init(){
;init.c,33 :: 		USART1_CR1bits.UE=1; // enable uart1
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R2, [R0, #0]
;init.c,34 :: 		USART1_CR1bits.M=0;  // 8bit data
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,35 :: 		USART1_CR1bits.PCE=0; // no parity
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R1, [R0, #0]
;init.c,36 :: 		USART1_CR1bits.RXNEIE=1;// enable interrupt receiver
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R2, [R0, #0]
;init.c,37 :: 		USART1_CR1bits.RE=1; // enable receiver
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R2, [R0, #0]
;init.c,38 :: 		USART1_CR1bits.TE=1;  //enable transmitter
MOVW	R0, #lo_addr(USART1_CR1bits+0)
MOVT	R0, #hi_addr(USART1_CR1bits+0)
STR	R2, [R0, #0]
;init.c,39 :: 		USART1_BRR=0X1D4C;    // bauld=9600;
MOVW	R1, #7500
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;init.c,40 :: 		USART1_CR2=0;   // 1 stop bit
MOVS	R1, #0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;init.c,41 :: 		USART1_CR3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;init.c,43 :: 		NVIC_SETENA1bits.SETENA37=1; //enable interrupt usart
MOVW	R1, #lo_addr(NVIC_SETENA1bits+0)
MOVT	R1, #hi_addr(NVIC_SETENA1bits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #5, #1
STR	R0, [R1, #0]
;init.c,44 :: 		NVIC_IP11bits.PRI_44=0x10; // priority
MOVS	R2, #16
MOVW	R1, #lo_addr(NVIC_IP11bits+0)
MOVT	R1, #hi_addr(NVIC_IP11bits+0)
LDRB	R0, [R1, #0]
BFI	R0, R2, #0, #8
STRB	R0, [R1, #0]
;init.c,45 :: 		}
L_end_usart1_init:
BX	LR
; end of _usart1_init
_uart1_chr:
;init.c,47 :: 		void uart1_chr(unsigned char data_usart1_tx){
;init.c,48 :: 		while(USART1_SRbits.TC==0);
L_uart1_chr5:
MOVW	R2, #lo_addr(USART1_SRbits+0)
MOVT	R2, #hi_addr(USART1_SRbits+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_uart1_chr6
IT	AL
BAL	L_uart1_chr5
L_uart1_chr6:
;init.c,49 :: 		USART1_DRbits.DR=data_usart1_tx;
UXTB	R3, R0
MOVW	R2, #lo_addr(USART1_DRbits+0)
MOVT	R2, #hi_addr(USART1_DRbits+0)
LDRH	R1, [R2, #0]
BFI	R1, R3, #0, #9
STRH	R1, [R2, #0]
;init.c,50 :: 		}
L_end_uart1_chr:
BX	LR
; end of _uart1_chr
_uart1_string:
;init.c,51 :: 		void uart1_string(unsigned char *s){
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R4, R0
;init.c,52 :: 		while(*s){
L_uart1_string7:
; s start address is: 16 (R4)
LDRB	R1, [R4, #0]
CMP	R1, #0
IT	EQ
BEQ	L_uart1_string8
;init.c,53 :: 		uart1_chr(*s++);
LDRB	R1, [R4, #0]
UXTB	R0, R1
BL	_uart1_chr+0
ADDS	R4, R4, #1
;init.c,54 :: 		}
; s end address is: 16 (R4)
IT	AL
BAL	L_uart1_string7
L_uart1_string8:
;init.c,55 :: 		}
L_end_uart1_string:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _uart1_string
_uart4__init:
;init.c,57 :: 		void uart4__init(){
;init.c,59 :: 		UART4_CR1bits.UE=1; // enable uart1
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R2, [R0, #0]
;init.c,60 :: 		UART4_CR1bits.M=0;  // 8bit data
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R1, [R0, #0]
;init.c,61 :: 		UART4_CR1bits.PCE=0; // no parity
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R1, [R0, #0]
;init.c,62 :: 		UART4_CR1bits.RXNEIE=1;// enable interrupt receiver
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R2, [R0, #0]
;init.c,63 :: 		UART4_CR1bits.RE=1; // enable receiver
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R2, [R0, #0]
;init.c,64 :: 		UART4_CR1bits.TE=1;  //enable transmitter
MOVW	R0, #lo_addr(UART4_CR1bits+0)
MOVT	R0, #hi_addr(UART4_CR1bits+0)
STR	R2, [R0, #0]
;init.c,67 :: 		UART4_BRR=0X0271;   // bauld=115200
MOVW	R1, #625
MOVW	R0, #lo_addr(UART4_BRR+0)
MOVT	R0, #hi_addr(UART4_BRR+0)
STR	R1, [R0, #0]
;init.c,68 :: 		UART4_CR2=0;   // 1 stop bit
MOVS	R1, #0
MOVW	R0, #lo_addr(UART4_CR2+0)
MOVT	R0, #hi_addr(UART4_CR2+0)
STR	R1, [R0, #0]
;init.c,69 :: 		UART4_CR3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(UART4_CR3+0)
MOVT	R0, #hi_addr(UART4_CR3+0)
STR	R1, [R0, #0]
;init.c,71 :: 		NVIC_SETENA1bits.SETENA52=1; //enable interrupt usart
MOVW	R1, #lo_addr(NVIC_SETENA1bits+0)
MOVT	R1, #hi_addr(NVIC_SETENA1bits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #20, #1
STR	R0, [R1, #0]
;init.c,72 :: 		NVIC_IP14bits.PRI_59=0x00; // priority
MOVS	R2, #0
MOVW	R1, #lo_addr(NVIC_IP14bits+0)
MOVT	R1, #hi_addr(NVIC_IP14bits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #24, #8
STR	R0, [R1, #0]
;init.c,73 :: 		}
L_end_uart4__init:
BX	LR
; end of _uart4__init
_uart4_chr:
;init.c,75 :: 		void uart4_chr(unsigned char data_usart4_tx){
;init.c,76 :: 		while(UART4_SRbits.TC==0);
L_uart4_chr9:
MOVW	R2, #lo_addr(UART4_SRbits+0)
MOVT	R2, #hi_addr(UART4_SRbits+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_uart4_chr10
IT	AL
BAL	L_uart4_chr9
L_uart4_chr10:
;init.c,77 :: 		UART4_DRbits.DR=data_usart4_tx;
UXTB	R3, R0
MOVW	R2, #lo_addr(UART4_DRbits+0)
MOVT	R2, #hi_addr(UART4_DRbits+0)
LDRH	R1, [R2, #0]
BFI	R1, R3, #0, #9
STRH	R1, [R2, #0]
;init.c,78 :: 		}
L_end_uart4_chr:
BX	LR
; end of _uart4_chr
_rs485_u4:
;init.c,80 :: 		void rs485_u4(unsigned char buf_rs4[],unsigned int count_buf){
; count_buf start address is: 4 (R1)
; count_buf end address is: 4 (R1)
; count_buf start address is: 4 (R1)
;init.c,81 :: 		unsigned char i = 0;
;init.c,82 :: 		UART4_CR1bits.RE=0;
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(UART4_CR1bits+0)
MOVT	R2, #hi_addr(UART4_CR1bits+0)
STR	R3, [R2, #0]
;init.c,83 :: 		TRAN_4
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
STR	R3, [R2, #0]
;init.c,84 :: 		for (i = 0; i < count_buf; i++) {
; i start address is: 20 (R5)
MOVS	R5, #0
; count_buf end address is: 4 (R1)
; i end address is: 20 (R5)
L_rs485_u411:
; i start address is: 20 (R5)
; count_buf start address is: 4 (R1)
CMP	R5, R1
IT	CS
BCS	L_rs485_u412
; count_buf end address is: 4 (R1)
; i end address is: 20 (R5)
;init.c,85 :: 		while(UART4_SRbits.TC==0);
L_rs485_u414:
; count_buf start address is: 4 (R1)
; i start address is: 20 (R5)
MOVW	R3, #lo_addr(UART4_SRbits+0)
MOVT	R3, #hi_addr(UART4_SRbits+0)
LDR	R2, [R3, #0]
CMP	R2, #0
IT	NE
BNE	L_rs485_u415
IT	AL
BAL	L_rs485_u414
L_rs485_u415:
;init.c,86 :: 		UART4_DRbits.DR = buf_rs4[i];
ADDS	R2, R0, R5
LDRB	R2, [R2, #0]
UXTB	R4, R2
MOVW	R3, #lo_addr(UART4_DRbits+0)
MOVT	R3, #hi_addr(UART4_DRbits+0)
LDRH	R2, [R3, #0]
BFI	R2, R4, #0, #9
STRH	R2, [R3, #0]
;init.c,84 :: 		for (i = 0; i < count_buf; i++) {
ADDS	R5, R5, #1
UXTB	R5, R5
;init.c,88 :: 		}
; count_buf end address is: 4 (R1)
; i end address is: 20 (R5)
IT	AL
BAL	L_rs485_u411
L_rs485_u412:
;init.c,89 :: 		while(UART4_SRbits.TC==0);
L_rs485_u416:
MOVW	R3, #lo_addr(UART4_SRbits+0)
MOVT	R3, #hi_addr(UART4_SRbits+0)
LDR	R2, [R3, #0]
CMP	R2, #0
IT	NE
BNE	L_rs485_u417
IT	AL
BAL	L_rs485_u416
L_rs485_u417:
;init.c,90 :: 		REC_4
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIOA_ODR+0)
MOVT	R2, #hi_addr(GPIOA_ODR+0)
STR	R3, [R2, #0]
;init.c,91 :: 		UART4_CR1bits.RE=1;
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(UART4_CR1bits+0)
MOVT	R2, #hi_addr(UART4_CR1bits+0)
STR	R3, [R2, #0]
;init.c,92 :: 		}
L_end_rs485_u4:
BX	LR
; end of _rs485_u4
_uart4_string:
;init.c,94 :: 		void uart4_string(unsigned char *s){
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R4, R0
;init.c,95 :: 		while(*s){
L_uart4_string18:
; s start address is: 16 (R4)
LDRB	R1, [R4, #0]
CMP	R1, #0
IT	EQ
BEQ	L_uart4_string19
;init.c,96 :: 		uart4_chr(*s++);
LDRB	R1, [R4, #0]
UXTB	R0, R1
BL	_uart4_chr+0
ADDS	R4, R4, #1
;init.c,97 :: 		}
; s end address is: 16 (R4)
IT	AL
BAL	L_uart4_string18
L_uart4_string19:
;init.c,98 :: 		}
L_end_uart4_string:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _uart4_string
_usart2_init:
;init.c,100 :: 		void usart2_init(){
;init.c,101 :: 		USART2_CR1bits.UE=1; // enable uart1
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R2, [R0, #0]
;init.c,102 :: 		USART2_BRR=0X1D4C;    // bauld=9600;
MOVW	R1, #7500
MOVW	R0, #lo_addr(USART2_BRR+0)
MOVT	R0, #hi_addr(USART2_BRR+0)
STR	R1, [R0, #0]
;init.c,103 :: 		USART2_CR1bits.M=0;  // 8bit data
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R1, [R0, #0]
;init.c,104 :: 		USART2_CR1bits.PCE=0; // no parity
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R1, [R0, #0]
;init.c,105 :: 		USART2_CR1bits.RXNEIE=1;// enable interrupt receiver
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R2, [R0, #0]
;init.c,106 :: 		USART2_CR1bits.RE=1; // enable receiver
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R2, [R0, #0]
;init.c,107 :: 		USART2_CR1bits.TE=1;  //enable transmitter
MOVW	R0, #lo_addr(USART2_CR1bits+0)
MOVT	R0, #hi_addr(USART2_CR1bits+0)
STR	R2, [R0, #0]
;init.c,108 :: 		USART2_CR2=0;   // 1 stop bit
MOVS	R1, #0
MOVW	R0, #lo_addr(USART2_CR2+0)
MOVT	R0, #hi_addr(USART2_CR2+0)
STR	R1, [R0, #0]
;init.c,109 :: 		USART2_CR3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(USART2_CR3+0)
MOVT	R0, #hi_addr(USART2_CR3+0)
STR	R1, [R0, #0]
;init.c,113 :: 		}
L_end_usart2_init:
BX	LR
; end of _usart2_init
_uart2_chr:
;init.c,115 :: 		void uart2_chr(unsigned char data_usart2_tx){
;init.c,116 :: 		while(USART2_SRbits.TC==0);
L_uart2_chr20:
MOVW	R2, #lo_addr(USART2_SRbits+0)
MOVT	R2, #hi_addr(USART2_SRbits+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_uart2_chr21
IT	AL
BAL	L_uart2_chr20
L_uart2_chr21:
;init.c,117 :: 		USART2_DR=data_usart2_tx;
MOVW	R1, #lo_addr(USART2_DR+0)
MOVT	R1, #hi_addr(USART2_DR+0)
STR	R0, [R1, #0]
;init.c,118 :: 		}
L_end_uart2_chr:
BX	LR
; end of _uart2_chr
_uart2_string:
;init.c,119 :: 		void uart2_string(unsigned char *s){
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R3, R0
;init.c,120 :: 		while(*s){
L_uart2_string22:
; s start address is: 12 (R3)
LDRB	R1, [R3, #0]
CMP	R1, #0
IT	EQ
BEQ	L_uart2_string23
;init.c,121 :: 		uart2_chr(*s++);
LDRB	R1, [R3, #0]
UXTB	R0, R1
BL	_uart2_chr+0
ADDS	R3, R3, #1
;init.c,122 :: 		}
; s end address is: 12 (R3)
IT	AL
BAL	L_uart2_string22
L_uart2_string23:
;init.c,123 :: 		}
L_end_uart2_string:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _uart2_string
_set_value_dim:
;init.c,125 :: 		void set_value_dim(unsigned char value_dim,unsigned char channel){
; channel start address is: 4 (R1)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; channel end address is: 4 (R1)
; channel start address is: 4 (R1)
;init.c,126 :: 		unsigned char data_dim[3]={0xfa,0x00,0x00},k;
MOVS	R2, #250
STRB	R2, [SP, #4]
MOVS	R2, #0
STRB	R2, [SP, #5]
MOVS	R2, #0
STRB	R2, [SP, #6]
;init.c,127 :: 		data_dim[1]=channel;
ADD	R3, SP, #4
ADDS	R2, R3, #1
STRB	R1, [R2, #0]
; channel end address is: 4 (R1)
;init.c,128 :: 		data_dim[2]=value_dim;
ADDS	R2, R3, #2
STRB	R0, [R2, #0]
;init.c,129 :: 		for(k=0;k<3;k++){
; k start address is: 12 (R3)
MOVS	R3, #0
; k end address is: 12 (R3)
L_set_value_dim24:
; k start address is: 12 (R3)
CMP	R3, #3
IT	CS
BCS	L_set_value_dim25
;init.c,130 :: 		uart2_chr(data_dim[k]);
ADD	R2, SP, #4
ADDS	R2, R2, R3
LDRB	R2, [R2, #0]
UXTB	R0, R2
BL	_uart2_chr+0
;init.c,129 :: 		for(k=0;k<3;k++){
ADDS	R3, R3, #1
UXTB	R3, R3
;init.c,131 :: 		}
; k end address is: 12 (R3)
IT	AL
BAL	L_set_value_dim24
L_set_value_dim25:
;init.c,132 :: 		}
L_end_set_value_dim:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _set_value_dim
_gpio_init:
;init.c,134 :: 		void gpio_init(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;init.c,135 :: 		RCC_APB2ENR=(1<<AFIOEN)|(1<<IOPAEN)|(1<<IOPBEN)|(1<<IOPCEN)|(1<<IOPDEN)|(1<<IOPEEN)|(1<<TIM1EN)|(1<<SPI1EN)|(1<<USART1EN);
MOVW	R1, #22653
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;init.c,136 :: 		RCC_APB1ENR=(1<<UART4EN)|(1<<USART2EN);
MOV	R1, #655360
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;init.c,138 :: 		AFIO_MAPR|=0x02000000;
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #33554432
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;init.c,140 :: 		GPIOA_CRL&=0xffff0000;
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #65535
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;init.c,141 :: 		GPIOA_CRL|=0x00004938;
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #18744
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;init.c,142 :: 		GPIOA_CRH&=0x0ff00000;
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
AND	R1, R0, #267386880
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;init.c,143 :: 		GPIOA_CRH|=0x30003490;
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #13456
MOVT	R0, #12288
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;init.c,144 :: 		GPIOA_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;init.c,145 :: 		GPIOA_ODR|=0B0000000000000001;
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;init.c,147 :: 		GPIOB_CRL&=0x00fff000;
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #61440
MOVT	R0, #255
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;init.c,148 :: 		GPIOB_CRL|=0x38000383;
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #899
MOVT	R0, #14336
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;init.c,149 :: 		GPIOB_CRH=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOB_CRH+0)
MOVT	R0, #hi_addr(GPIOB_CRH+0)
STR	R1, [R0, #0]
;init.c,150 :: 		GPIOB_CRH|=0x83838338;
MOVW	R0, #lo_addr(GPIOB_CRH+0)
MOVT	R0, #hi_addr(GPIOB_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #33592
MOVT	R0, #33667
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOB_CRH+0)
MOVT	R0, #hi_addr(GPIOB_CRH+0)
STR	R1, [R0, #0]
;init.c,151 :: 		GPIOB_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;init.c,152 :: 		GPIOB_ODR|=0B1010100101000010;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R1, [R0, #0]
MOVW	R0, #43330
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;init.c,154 :: 		GPIOC_CRL&=0x000f0000;
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
LDR	R0, [R0, #0]
AND	R1, R0, #983040
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;init.c,155 :: 		GPIOC_CRL|=0x83803838;
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #14392
MOVT	R0, #33664
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;init.c,156 :: 		GPIOC_CRH&=0xff0000f0;
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #240
MOVT	R0, #65280
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;init.c,157 :: 		GPIOC_CRH|=0x00234903;
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #18691
MOVT	R0, #35
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;init.c,158 :: 		GPIOC_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;init.c,159 :: 		GPIOC_ODR|=0B0000000010100101;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #165
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;init.c,161 :: 		GPIOD_CRL&=0xff000000;
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
AND	R1, R0, #-16777216
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;init.c,162 :: 		GPIOD_CRL|=0x00833333;
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #13107
MOVT	R0, #131
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;init.c,163 :: 		GPIOD_CRH=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;init.c,164 :: 		GPIOD_CRH|=0x83838383;
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #-2088533117
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;init.c,165 :: 		GPIOD_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;init.c,166 :: 		GPIOD_ODR|=0B1010101000100000;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R1, [R0, #0]
MOVW	R0, #43552
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;init.c,168 :: 		GPIOE_CRL=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;init.c,169 :: 		GPIOE_CRL|=0x88383838;
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #14392
MOVT	R0, #34872
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;init.c,170 :: 		GPIOE_CRH=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;init.c,171 :: 		GPIOE_CRH|=0x83838383;
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #-2088533117
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;init.c,172 :: 		GPIOE_ODR=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;init.c,173 :: 		GPIOE_ODR|=0B1010101011010101;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
LDR	R1, [R0, #0]
MOVW	R0, #43733
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;init.c,174 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_7);
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;init.c,175 :: 		}
L_end_gpio_init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _gpio_init
_chuoi_so:
;init.c,176 :: 		unsigned long chuoi_so(unsigned char *so,unsigned char vt_bd,unsigned char vt_kt){
; vt_kt start address is: 8 (R2)
; vt_bd start address is: 4 (R1)
UXTB	R3, R2
; vt_kt end address is: 8 (R2)
; vt_bd end address is: 4 (R1)
; vt_bd start address is: 4 (R1)
; vt_kt start address is: 12 (R3)
;init.c,179 :: 		gt_so=0;
; gt_so start address is: 20 (R5)
MOVS	R5, #0
;init.c,180 :: 		for(sb=vt_bd;sb<=vt_kt;sb++){
; sb start address is: 8 (R2)
UXTB	R2, R1
; vt_bd end address is: 4 (R1)
; vt_kt end address is: 12 (R3)
; gt_so end address is: 20 (R5)
; sb end address is: 8 (R2)
MOV	R1, R0
UXTB	R0, R3
L_chuoi_so27:
; sb start address is: 8 (R2)
; so start address is: 4 (R1)
; gt_so start address is: 20 (R5)
; so start address is: 4 (R1)
; so end address is: 4 (R1)
CMP	R2, R0
IT	HI
BHI	L_chuoi_so28
; so end address is: 4 (R1)
;init.c,181 :: 		gt_so*=10;
; so start address is: 4 (R1)
MOVS	R3, #10
MUL	R4, R5, R3
; gt_so end address is: 20 (R5)
;init.c,182 :: 		gt_so+=(*(so+sb)-0x30);
ADDS	R3, R1, R2
LDRB	R3, [R3, #0]
SUBS	R3, #48
SXTH	R3, R3
ADDS	R3, R4, R3
; gt_so start address is: 20 (R5)
MOV	R5, R3
;init.c,180 :: 		for(sb=vt_bd;sb<=vt_kt;sb++){
ADDS	R2, R2, #1
UXTB	R2, R2
;init.c,183 :: 		}
; so end address is: 4 (R1)
; sb end address is: 8 (R2)
IT	AL
BAL	L_chuoi_so27
L_chuoi_so28:
;init.c,184 :: 		return gt_so;
MOV	R0, R5
; gt_so end address is: 20 (R5)
;init.c,185 :: 		}
L_end_chuoi_so:
BX	LR
; end of _chuoi_so
_get_point:
;init.c,186 :: 		unsigned char get_point(unsigned char *s,unsigned char start,unsigned char end){
; end start address is: 8 (R2)
; start start address is: 4 (R1)
UXTB	R3, R2
UXTB	R2, R1
; end end address is: 8 (R2)
; start end address is: 4 (R1)
; start start address is: 8 (R2)
; end start address is: 12 (R3)
;init.c,187 :: 		unsigned char locate_point=0;
;init.c,188 :: 		for(locate_point=start;locate_point<end;locate_point++){
; locate_point start address is: 4 (R1)
UXTB	R1, R2
; end end address is: 12 (R3)
; locate_point end address is: 4 (R1)
MOV	R4, R0
UXTB	R0, R3
L_get_point30:
; locate_point start address is: 4 (R1)
; start start address is: 8 (R2)
; start end address is: 8 (R2)
; s start address is: 16 (R4)
CMP	R1, R0
IT	CS
BCS	L_get_point31
; start end address is: 8 (R2)
;init.c,189 :: 		if((*(s+start)=='.')||(*(s+start)==' ')){
; start start address is: 8 (R2)
ADDS	R3, R4, R2
LDRB	R3, [R3, #0]
CMP	R3, #46
IT	EQ
BEQ	L__get_point484
ADDS	R3, R4, R2
LDRB	R3, [R3, #0]
CMP	R3, #32
IT	EQ
BEQ	L__get_point483
IT	AL
BAL	L_get_point35
; start end address is: 8 (R2)
; s end address is: 16 (R4)
L__get_point484:
L__get_point483:
;init.c,190 :: 		break;
IT	AL
BAL	L_get_point31
;init.c,191 :: 		}
L_get_point35:
;init.c,192 :: 		s++;
; s start address is: 16 (R4)
; start start address is: 8 (R2)
ADDS	R4, R4, #1
;init.c,188 :: 		for(locate_point=start;locate_point<end;locate_point++){
ADDS	R1, R1, #1
UXTB	R1, R1
;init.c,193 :: 		}
; start end address is: 8 (R2)
; s end address is: 16 (R4)
IT	AL
BAL	L_get_point30
L_get_point31:
;init.c,194 :: 		return locate_point;
UXTB	R0, R1
; locate_point end address is: 4 (R1)
;init.c,195 :: 		}
L_end_get_point:
BX	LR
; end of _get_point
_settingEthenet:
;RCUHAGER.c,375 :: 		void settingEthenet(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;RCUHAGER.c,376 :: 		ptr = (unsigned long*)Address;
MOVW	R2, #lo_addr(_Address+0)
MOVT	R2, #hi_addr(_Address+0)
LDR	R1, [R2, #0]
MOVW	R0, #lo_addr(_ptr+0)
MOVT	R0, #hi_addr(_ptr+0)
STR	R1, [R0, #0]
;RCUHAGER.c,377 :: 		i=*ptr;
MOV	R0, R2
LDR	R0, [R0, #0]
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STR	R1, [R0, #0]
;RCUHAGER.c,378 :: 		if(i==0xffffffff){    // khi moi nap frimware thi dia chi ip se la fffffff
CMP	R1, #-1
IT	NE
BNE	L_settingEthenet36
;RCUHAGER.c,379 :: 		FLASH_ErasePage(Address);
MOVW	R0, #lo_addr(_Address+0)
MOVT	R0, #hi_addr(_Address+0)
LDR	R0, [R0, #0]
BL	_FLASH_ErasePage+0
;RCUHAGER.c,385 :: 		FLASH_Write_Word(Address,0xC0A8017B);     // c0:a8:01:7c  = 192.168.1.123
MOVW	R0, #lo_addr(_Address+0)
MOVT	R0, #hi_addr(_Address+0)
LDR	R0, [R0, #0]
MOVW	R1, #379
MOVT	R1, #49320
BL	_FLASH_Write_Word+0
;RCUHAGER.c,386 :: 		}
L_settingEthenet36:
;RCUHAGER.c,387 :: 		myIpAddr[0]=i>>24;
MOVW	R1, #lo_addr(_i+0)
MOVT	R1, #hi_addr(_i+0)
LDR	R0, [R1, #0]
LSRS	R0, R0, #24
MOVW	R4, #lo_addr(_myIpAddr+0)
MOVT	R4, #hi_addr(_myIpAddr+0)
STRB	R0, [R4, #0]
;RCUHAGER.c,388 :: 		myIpAddr[1]=i>>16;
MOV	R0, R1
LDR	R0, [R0, #0]
LSRS	R0, R0, #16
MOVW	R3, #lo_addr(_myIpAddr+1)
MOVT	R3, #hi_addr(_myIpAddr+1)
STRB	R0, [R3, #0]
;RCUHAGER.c,389 :: 		myIpAddr[2]=i>>8;
MOV	R0, R1
LDR	R0, [R0, #0]
LSRS	R0, R0, #8
MOVW	R2, #lo_addr(_myIpAddr+2)
MOVT	R2, #hi_addr(_myIpAddr+2)
STRB	R0, [R2, #0]
;RCUHAGER.c,390 :: 		myIpAddr[3]=i;
MOV	R0, R1
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_myIpAddr+3)
MOVT	R0, #hi_addr(_myIpAddr+3)
STRB	R1, [R0, #0]
;RCUHAGER.c,391 :: 		gwIpAddr[0]=myIpAddr[0];
MOV	R0, R4
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_gwIpAddr+0)
MOVT	R0, #hi_addr(_gwIpAddr+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,392 :: 		gwIpAddr[1]=myIpAddr[1];
MOV	R0, R3
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_gwIpAddr+1)
MOVT	R0, #hi_addr(_gwIpAddr+1)
STRB	R1, [R0, #0]
;RCUHAGER.c,393 :: 		gwIpAddr[2]=myIpAddr[2];
MOV	R0, R2
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_gwIpAddr+2)
MOVT	R0, #hi_addr(_gwIpAddr+2)
STRB	R1, [R0, #0]
;RCUHAGER.c,394 :: 		gwIpAddr[3]=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_gwIpAddr+3)
MOVT	R0, #hi_addr(_gwIpAddr+3)
STRB	R1, [R0, #0]
;RCUHAGER.c,395 :: 		SPI_Ethernet_Init(myMacAddr, myIpAddr, SPI_Ethernet_FULLDUPLEX);
MOVS	R2, #1
MOVW	R1, #lo_addr(_myIpAddr+0)
MOVT	R1, #hi_addr(_myIpAddr+0)
MOVW	R0, #lo_addr(_myMacAddr+0)
MOVT	R0, #hi_addr(_myMacAddr+0)
BL	_SPI_Ethernet_Init+0
;RCUHAGER.c,396 :: 		SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr);
MOVW	R2, #lo_addr(_dnsIpAddr+0)
MOVT	R2, #hi_addr(_dnsIpAddr+0)
MOVW	R1, #lo_addr(_gwIpAddr+0)
MOVT	R1, #hi_addr(_gwIpAddr+0)
MOVW	R0, #lo_addr(_ipMask+0)
MOVT	R0, #hi_addr(_ipMask+0)
BL	_SPI_Ethernet_confNetwork+0
;RCUHAGER.c,397 :: 		}
L_end_settingEthenet:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _settingEthenet
_putChar:
;RCUHAGER.c,398 :: 		void putChar(unsigned char c){
;RCUHAGER.c,399 :: 		while(UART4_SRbits.TC==0);
L_putChar37:
MOVW	R2, #lo_addr(UART4_SRbits+0)
MOVT	R2, #hi_addr(UART4_SRbits+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_putChar38
IT	AL
BAL	L_putChar37
L_putChar38:
;RCUHAGER.c,400 :: 		UART4_DRbits.DR = c;
UXTB	R3, R0
MOVW	R2, #lo_addr(UART4_DRbits+0)
MOVT	R2, #hi_addr(UART4_DRbits+0)
LDRH	R1, [R2, #0]
BFI	R1, R3, #0, #9
STRH	R1, [R2, #0]
;RCUHAGER.c,401 :: 		}
L_end_putChar:
BX	LR
; end of _putChar
_saveIP:
;RCUHAGER.c,402 :: 		void saveIP(unsigned char buf[]){
SUB	SP, SP, #16
STR	LR, [SP, #0]
;RCUHAGER.c,404 :: 		unsigned char i=0,j,pos=0;
; i start address is: 8 (R2)
MOVS	R2, #0
; i end address is: 8 (R2)
;RCUHAGER.c,405 :: 		while(i<39){
L_saveIP39:
; i start address is: 8 (R2)
CMP	R2, #39
IT	CS
BCS	L_saveIP40
;RCUHAGER.c,406 :: 		if(buf[i]=='i'&&buf[i+1]=='p'){
ADDS	R1, R0, R2
LDRB	R1, [R1, #0]
CMP	R1, #105
IT	NE
BNE	L__saveIP514
ADDS	R1, R2, #1
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #112
IT	NE
BNE	L__saveIP515
L__saveIP493:
;RCUHAGER.c,407 :: 		for(j=0;j<4;j++){
MOVS	R1, #0
STRB	R1, [SP, #12]
; i end address is: 8 (R2)
UXTB	R5, R2
L_saveIP44:
; i start address is: 20 (R5)
LDRB	R1, [SP, #12]
CMP	R1, #4
IT	CS
BCS	L_saveIP45
;RCUHAGER.c,408 :: 		if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]<48||buf[i+5]>57)){
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP497
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP496
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP495
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP494
IT	AL
BAL	L_saveIP51
L__saveIP495:
L__saveIP494:
L__saveIP491:
;RCUHAGER.c,409 :: 		ipAddress[j]=buf[i+4]-48;
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
;RCUHAGER.c,410 :: 		i+=2;
ADDS	R1, R5, #2
UXTB	R5, R1
;RCUHAGER.c,411 :: 		}
IT	AL
BAL	L_saveIP52
L_saveIP51:
;RCUHAGER.c,408 :: 		if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]<48||buf[i+5]>57)){
L__saveIP497:
L__saveIP496:
;RCUHAGER.c,412 :: 		else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]<48||buf[i+6]>57)){
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP503
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP502
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CS
BCS	L__saveIP499
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	LS
BLS	L__saveIP498
IT	AL
BAL	L_saveIP59
L__saveIP499:
L__saveIP498:
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP501
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP500
IT	AL
BAL	L_saveIP59
L__saveIP501:
L__saveIP500:
L__saveIP488:
;RCUHAGER.c,413 :: 		ipAddress[j]=10*(buf[i+4]-48)+(buf[i+5]-48);
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
;RCUHAGER.c,414 :: 		i+=3;
ADDS	R1, R5, #3
; i end address is: 20 (R5)
; i start address is: 4 (R1)
UXTB	R1, R1
;RCUHAGER.c,415 :: 		}
UXTB	R5, R1
; i end address is: 4 (R1)
IT	AL
BAL	L_saveIP60
L_saveIP59:
;RCUHAGER.c,412 :: 		else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]<48||buf[i+6]>57)){
; i start address is: 20 (R5)
L__saveIP503:
L__saveIP502:
;RCUHAGER.c,416 :: 		else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]>=48||buf[i+6]<=57)){
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CC
BCC	L__saveIP512
ADDS	R1, R5, #4
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__saveIP513
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CS
BCS	L__saveIP505
ADDS	R1, R5, #5
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	LS
BLS	L__saveIP504
UXTB	R1, R5
IT	AL
BAL	L_saveIP67
L__saveIP505:
L__saveIP504:
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #48
IT	CS
BCS	L__saveIP507
ADDS	R1, R5, #6
SXTH	R1, R1
ADDS	R1, R0, R1
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	LS
BLS	L__saveIP506
UXTB	R1, R5
IT	AL
BAL	L_saveIP67
L__saveIP507:
L__saveIP506:
L__saveIP485:
;RCUHAGER.c,417 :: 		ipAddress[j]=100*(buf[i+4]-48)+10*(buf[i+5]-48)+(buf[i+6]-48);
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
;RCUHAGER.c,418 :: 		i+=4;
ADDS	R1, R5, #4
; i end address is: 20 (R5)
; i start address is: 8 (R2)
UXTB	R2, R1
; i end address is: 8 (R2)
UXTB	R1, R2
;RCUHAGER.c,419 :: 		}
L_saveIP67:
;RCUHAGER.c,416 :: 		else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]>=48||buf[i+6]<=57)){
; i start address is: 4 (R1)
; i end address is: 4 (R1)
IT	AL
BAL	L__saveIP509
L__saveIP512:
UXTB	R1, R5
L__saveIP509:
; i start address is: 4 (R1)
; i end address is: 4 (R1)
IT	AL
BAL	L__saveIP508
L__saveIP513:
UXTB	R1, R5
L__saveIP508:
;RCUHAGER.c,419 :: 		}
; i start address is: 4 (R1)
UXTB	R5, R1
; i end address is: 4 (R1)
L_saveIP60:
; i start address is: 20 (R5)
; i end address is: 20 (R5)
L_saveIP52:
;RCUHAGER.c,407 :: 		for(j=0;j<4;j++){
; i start address is: 20 (R5)
LDRB	R1, [SP, #12]
ADDS	R1, R1, #1
STRB	R1, [SP, #12]
;RCUHAGER.c,420 :: 		}
IT	AL
BAL	L_saveIP44
L_saveIP45:
;RCUHAGER.c,421 :: 		FLASH_ErasePage(Address);
MOVW	R1, #lo_addr(_Address+0)
MOVT	R1, #hi_addr(_Address+0)
LDR	R1, [R1, #0]
STR	R0, [SP, #4]
MOV	R0, R1
BL	_FLASH_ErasePage+0
;RCUHAGER.c,422 :: 		ipword=(((unsigned long)ipAddress[0])<<24)|(((unsigned long)ipAddress[1])<<16)|(((unsigned long)ipAddress[2])<<8)|(((unsigned long)ipAddress[3]));
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
;RCUHAGER.c,423 :: 		FLASH_Write_Word(Address,ipWord);
MOVW	R1, #lo_addr(_Address+0)
MOVT	R1, #hi_addr(_Address+0)
LDR	R1, [R1, #0]
MOV	R0, R1
MOV	R1, R2
BL	_FLASH_Write_Word+0
LDR	R0, [SP, #4]
;RCUHAGER.c,424 :: 		settingEthenet();
STRB	R5, [SP, #4]
; i end address is: 20 (R5)
STR	R0, [SP, #8]
BL	_settingEthenet+0
LDR	R0, [SP, #8]
LDRB	R5, [SP, #4]
MOV	R1, R0
UXTB	R0, R5
;RCUHAGER.c,406 :: 		if(buf[i]=='i'&&buf[i+1]=='p'){
IT	AL
BAL	L__saveIP511
L__saveIP514:
MOV	R1, R0
UXTB	R0, R2
L__saveIP511:
; buf start address is: 4 (R1)
UXTB	R2, R0
; buf end address is: 4 (R1)
MOV	R0, R1
IT	AL
BAL	L__saveIP510
L__saveIP515:
L__saveIP510:
;RCUHAGER.c,426 :: 		i++;
; i start address is: 8 (R2)
ADDS	R2, R2, #1
UXTB	R2, R2
;RCUHAGER.c,427 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_saveIP39
L_saveIP40:
;RCUHAGER.c,428 :: 		}
L_end_saveIP:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _saveIP
_copyBuf:
;RCUHAGER.c,429 :: 		void copyBuf(unsigned char a[],unsigned char b[],unsigned char size){
; size start address is: 8 (R2)
; b start address is: 4 (R1)
SUB	SP, SP, #4
; size end address is: 8 (R2)
; b end address is: 4 (R1)
; b start address is: 4 (R1)
; size start address is: 8 (R2)
;RCUHAGER.c,431 :: 		for(index=0;index<size;index++){
; index start address is: 20 (R5)
MOVS	R5, #0
; size end address is: 8 (R2)
; index end address is: 20 (R5)
STRB	R2, [SP, #0]
MOV	R2, R0
LDRB	R0, [SP, #0]
L_copyBuf68:
; index start address is: 20 (R5)
; a start address is: 8 (R2)
; b start address is: 4 (R1)
; b end address is: 4 (R1)
; a start address is: 8 (R2)
; a end address is: 8 (R2)
CMP	R5, R0
IT	CS
BCS	L_copyBuf69
; b end address is: 4 (R1)
; a end address is: 8 (R2)
;RCUHAGER.c,432 :: 		b[index]=a[index];
; a start address is: 8 (R2)
; b start address is: 4 (R1)
ADDS	R4, R1, R5
ADDS	R3, R2, R5
LDRB	R3, [R3, #0]
STRB	R3, [R4, #0]
;RCUHAGER.c,431 :: 		for(index=0;index<size;index++){
ADDS	R5, R5, #1
UXTB	R5, R5
;RCUHAGER.c,433 :: 		}
; b end address is: 4 (R1)
; a end address is: 8 (R2)
; index end address is: 20 (R5)
IT	AL
BAL	L_copyBuf68
L_copyBuf69:
;RCUHAGER.c,434 :: 		}
L_end_copyBuf:
ADD	SP, SP, #4
BX	LR
; end of _copyBuf
_SPI_Ethernet_UserTCP:
;RCUHAGER.c,435 :: 		unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags){
; localPort start address is: 8 (R2)
SUB	SP, SP, #40
STR	LR, [SP, #0]
; localPort end address is: 8 (R2)
; localPort start address is: 8 (R2)
; flags start address is: 16 (R4)
LDR	R4, [SP, #40]
; flags end address is: 16 (R4)
;RCUHAGER.c,436 :: 		unsigned int len=0;
;RCUHAGER.c,437 :: 		unsigned char vt_button=0;
MOVS	R4, #0
STRB	R4, [SP, #14]
;RCUHAGER.c,438 :: 		unsigned long shift=1;
MOV	R4, #1
STR	R4, [SP, #16]
;RCUHAGER.c,440 :: 		unsigned char locate=0,_locate=0,h=0;
;RCUHAGER.c,442 :: 		if(localPort != 80)
CMP	R2, #80
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP71
; localPort end address is: 8 (R2)
;RCUHAGER.c,444 :: 		return(0);
MOVS	R0, #0
IT	AL
BAL	L_end_SPI_Ethernet_UserTCP
;RCUHAGER.c,445 :: 		}
L_SPI_Ethernet_UserTCP71:
;RCUHAGER.c,446 :: 		for(len = 0;len < 30;len++){
MOVS	R4, #0
STRH	R4, [SP, #12]
L_SPI_Ethernet_UserTCP72:
LDRH	R4, [SP, #12]
CMP	R4, #30
IT	CS
BCS	L_SPI_Ethernet_UserTCP73
;RCUHAGER.c,447 :: 		getRequest[len] = SPI_Ethernet_getByte();
LDRH	R5, [SP, #12]
MOVW	R4, #lo_addr(_getRequest+0)
MOVT	R4, #hi_addr(_getRequest+0)
ADDS	R4, R4, R5
STR	R4, [SP, #36]
BL	_SPI_Ethernet_getByte+0
LDR	R4, [SP, #36]
STRB	R0, [R4, #0]
;RCUHAGER.c,446 :: 		for(len = 0;len < 30;len++){
LDRH	R4, [SP, #12]
ADDS	R4, R4, #1
STRH	R4, [SP, #12]
;RCUHAGER.c,448 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP72
L_SPI_Ethernet_UserTCP73:
;RCUHAGER.c,449 :: 		getRequest[len] = 0;
LDRH	R5, [SP, #12]
MOVW	R4, #lo_addr(_getRequest+0)
MOVT	R4, #hi_addr(_getRequest+0)
ADDS	R5, R4, R5
MOVS	R4, #0
STRB	R4, [R5, #0]
;RCUHAGER.c,450 :: 		len = 0;
MOVS	R4, #0
STRH	R4, [SP, #12]
;RCUHAGER.c,451 :: 		if(memcmp(getRequest, httpMethod, 5))
MOVS	R2, #5
SXTH	R2, R2
MOVW	R1, #lo_addr(_httpMethod+0)
MOVT	R1, #hi_addr(_httpMethod+0)
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_memcmp+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP75
;RCUHAGER.c,453 :: 		return(0);
MOVS	R0, #0
IT	AL
BAL	L_end_SPI_Ethernet_UserTCP
;RCUHAGER.c,454 :: 		}
L_SPI_Ethernet_UserTCP75:
;RCUHAGER.c,456 :: 		if(getRequest[5]=='t'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #116
IT	NE
BNE	L_SPI_Ethernet_UserTCP76
;RCUHAGER.c,457 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP77
;RCUHAGER.c,458 :: 		index_page=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBW	R5, R4, #48
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
STRH	R5, [R4, #0]
;RCUHAGER.c,459 :: 		if(index_page==Page_Setting){
UXTH	R4, R5
CMP	R4, #8
IT	NE
BNE	L_SPI_Ethernet_UserTCP78
;RCUHAGER.c,460 :: 		_locate=10;
; _locate start address is: 36 (R9)
MOVW	R9, #10
;RCUHAGER.c,461 :: 		for(h=0;h<4;h++){
; h start address is: 32 (R8)
MOVW	R8, #0
; h end address is: 32 (R8)
; _locate end address is: 36 (R9)
UXTB	R6, R8
UXTB	R8, R9
L_SPI_Ethernet_UserTCP79:
; h start address is: 24 (R6)
; _locate start address is: 32 (R8)
CMP	R6, #4
IT	CS
BCS	L_SPI_Ethernet_UserTCP80
;RCUHAGER.c,462 :: 		locate=get_point(getRequest,_locate,25);
MOVS	R2, #25
UXTB	R1, R8
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_get_point+0
; locate start address is: 28 (R7)
UXTB	R7, R0
;RCUHAGER.c,463 :: 		_myip[h]=chuoi_so(getRequest,_locate,(locate-1));
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
;RCUHAGER.c,464 :: 		_locate=locate+1;
ADDS	R4, R7, #1
; locate end address is: 28 (R7)
; _locate start address is: 36 (R9)
UXTB	R9, R4
;RCUHAGER.c,461 :: 		for(h=0;h<4;h++){
ADDS	R0, R6, #1
UXTB	R0, R0
; h end address is: 24 (R6)
;RCUHAGER.c,465 :: 		}
UXTB	R8, R9
; _locate end address is: 36 (R9)
UXTB	R6, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP79
L_SPI_Ethernet_UserTCP80:
;RCUHAGER.c,466 :: 		if((_myip[0]<=255)&&(_myip[1]<=255)&&(_myip[2]<=255)&&(_myip[3]<=255)) {
ADD	R4, SP, #4
LDRH	R4, [R4, #0]
CMP	R4, #255
IT	HI
BHI	L__SPI_Ethernet_UserTCP520
ADD	R4, SP, #4
ADDS	R4, R4, #2
LDRH	R4, [R4, #0]
CMP	R4, #255
IT	HI
BHI	L__SPI_Ethernet_UserTCP519
ADD	R4, SP, #4
ADDS	R4, R4, #4
LDRH	R4, [R4, #0]
CMP	R4, #255
IT	HI
BHI	L__SPI_Ethernet_UserTCP518
ADD	R4, SP, #4
ADDS	R4, R4, #6
LDRH	R4, [R4, #0]
CMP	R4, #255
IT	HI
BHI	L__SPI_Ethernet_UserTCP517
L__SPI_Ethernet_UserTCP516:
;RCUHAGER.c,467 :: 		for(h=0;h<4;h++){
MOVS	R0, #0
L_SPI_Ethernet_UserTCP85:
CMP	R0, #4
IT	CS
BCS	L_SPI_Ethernet_UserTCP86
;RCUHAGER.c,468 :: 		myIpAddr[h]=_myip[h];
MOVW	R4, #lo_addr(_myIpAddr+0)
MOVT	R4, #hi_addr(_myIpAddr+0)
ADDS	R6, R4, R0
ADD	R5, SP, #4
LSLS	R4, R0, #1
ADDS	R4, R5, R4
LDRH	R4, [R4, #0]
STRB	R4, [R6, #0]
;RCUHAGER.c,467 :: 		for(h=0;h<4;h++){
ADDS	R4, R0, #1
; h start address is: 4 (R1)
UXTB	R1, R4
;RCUHAGER.c,469 :: 		}
UXTB	R0, R1
; h end address is: 4 (R1)
IT	AL
BAL	L_SPI_Ethernet_UserTCP85
L_SPI_Ethernet_UserTCP86:
;RCUHAGER.c,470 :: 		flag_reset_ip=1;
MOVS	R5, #1
MOVW	R4, #lo_addr(_flag_reset_ip+0)
MOVT	R4, #hi_addr(_flag_reset_ip+0)
STRB	R5, [R4, #0]
;RCUHAGER.c,466 :: 		if((_myip[0]<=255)&&(_myip[1]<=255)&&(_myip[2]<=255)&&(_myip[3]<=255)) {
L__SPI_Ethernet_UserTCP520:
L__SPI_Ethernet_UserTCP519:
L__SPI_Ethernet_UserTCP518:
L__SPI_Ethernet_UserTCP517:
;RCUHAGER.c,472 :: 		}
L_SPI_Ethernet_UserTCP78:
;RCUHAGER.c,473 :: 		}
L_SPI_Ethernet_UserTCP77:
;RCUHAGER.c,474 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP88
L_SPI_Ethernet_UserTCP76:
;RCUHAGER.c,475 :: 		else if(getRequest[5] == 's'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #115
IT	NE
BNE	L_SPI_Ethernet_UserTCP89
;RCUHAGER.c,476 :: 		STAT = ~STAT;         // LED INDICATOR HOPTEST
MOVW	R5, #lo_addr(GPIOA_ODR+0)
MOVT	R5, #hi_addr(GPIOA_ODR+0)
LDR	R4, [R5, #0]
EOR	R4, R4, #1
STR	R4, [R5, #0]
;RCUHAGER.c,477 :: 		len =  putConstString(httpHeader);
MOVW	R0, #lo_addr(_httpHeader+0)
MOVT	R0, #hi_addr(_httpHeader+0)
BL	_SPI_Ethernet_putConstString+0
STRH	R0, [SP, #12]
;RCUHAGER.c,478 :: 		len += putConstString(httpMimeTypeHTML);
MOVW	R0, #lo_addr(_httpMimeTypeHTML+0)
MOVT	R0, #hi_addr(_httpMimeTypeHTML+0)
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,479 :: 		switch (index_page) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP90
;RCUHAGER.c,480 :: 		case Page_Service:
L_SPI_Ethernet_UserTCP92:
;RCUHAGER.c,481 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_12_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_12_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,482 :: 		LongWordToStr(status_wed_service, dyna);
MOVW	R4, #lo_addr(_status_wed_service+0)
MOVT	R4, #hi_addr(_status_wed_service+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,483 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,484 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP91
;RCUHAGER.c,485 :: 		case Page_Lighting:
L_SPI_Ethernet_UserTCP93:
;RCUHAGER.c,486 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_13_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_13_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,487 :: 		LongWordToStr(status_wed_light, dyna);
MOVW	R4, #lo_addr(_status_wed_light+0)
MOVT	R4, #hi_addr(_status_wed_light+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,488 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,489 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP91
;RCUHAGER.c,490 :: 		case Page_Curtain:
L_SPI_Ethernet_UserTCP94:
;RCUHAGER.c,491 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_14_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_14_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,492 :: 		LongWordToStr(status_wed_curtain, dyna);
MOVW	R4, #lo_addr(_status_wed_curtain+0)
MOVT	R4, #hi_addr(_status_wed_curtain+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,493 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,494 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP91
;RCUHAGER.c,495 :: 		case Page_Scenes:
L_SPI_Ethernet_UserTCP95:
;RCUHAGER.c,496 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_15_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_15_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,497 :: 		LongWordToStr(status_wed_scenes, dyna);
MOVW	R4, #lo_addr(_status_wed_scenes+0)
MOVT	R4, #hi_addr(_status_wed_scenes+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,498 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,499 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP91
;RCUHAGER.c,500 :: 		case Page_Fan_Speed:
L_SPI_Ethernet_UserTCP96:
;RCUHAGER.c,501 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_16_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_16_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,502 :: 		LongWordToStr(status_wed_fan, dyna);
MOVW	R4, #lo_addr(_status_wed_fan+0)
MOVT	R4, #hi_addr(_status_wed_fan+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,503 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,504 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP91
;RCUHAGER.c,505 :: 		case Page_Dimer_Extant:
L_SPI_Ethernet_UserTCP97:
;RCUHAGER.c,506 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_17_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_17_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,507 :: 		LongWordToStr(status_wed_dimer, dyna);
MOVW	R4, #lo_addr(_status_wed_dimer+0)
MOVT	R4, #hi_addr(_status_wed_dimer+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,508 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,509 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP91
;RCUHAGER.c,510 :: 		case Page_Device_Extant:
L_SPI_Ethernet_UserTCP98:
;RCUHAGER.c,511 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_18_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_18_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,512 :: 		LongWordToStr(wed_status_button, dyna);
MOVW	R4, #lo_addr(_wed_status_button+0)
MOVT	R4, #hi_addr(_wed_status_button+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,513 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,514 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP91
;RCUHAGER.c,515 :: 		default:
L_SPI_Ethernet_UserTCP99:
;RCUHAGER.c,516 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP91
;RCUHAGER.c,517 :: 		}
L_SPI_Ethernet_UserTCP90:
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP92
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP93
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP94
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP95
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP96
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #6
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP97
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #7
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP98
IT	AL
BAL	L_SPI_Ethernet_UserTCP99
L_SPI_Ethernet_UserTCP91:
;RCUHAGER.c,518 :: 		}
L_SPI_Ethernet_UserTCP89:
L_SPI_Ethernet_UserTCP88:
;RCUHAGER.c,519 :: 		switch (index_page) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP100
;RCUHAGER.c,520 :: 		case Page_Service:
L_SPI_Ethernet_UserTCP102:
;RCUHAGER.c,521 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP103
;RCUHAGER.c,522 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP104
;RCUHAGER.c,523 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP105
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP105:
;RCUHAGER.c,524 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP106
;RCUHAGER.c,525 :: 		case 0://SERVICE_1
L_SPI_Ethernet_UserTCP108:
;RCUHAGER.c,528 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP107
;RCUHAGER.c,529 :: 		case 1://SERVICE_2
L_SPI_Ethernet_UserTCP109:
;RCUHAGER.c,532 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP107
;RCUHAGER.c,533 :: 		default:
L_SPI_Ethernet_UserTCP110:
;RCUHAGER.c,534 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP107
;RCUHAGER.c,535 :: 		}
L_SPI_Ethernet_UserTCP106:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP108
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP109
IT	AL
BAL	L_SPI_Ethernet_UserTCP110
L_SPI_Ethernet_UserTCP107:
;RCUHAGER.c,536 :: 		}
L_SPI_Ethernet_UserTCP104:
;RCUHAGER.c,537 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_19_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_19_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,538 :: 		status_wed_service|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_service+0)
MOVT	R5, #hi_addr(_status_wed_service+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;RCUHAGER.c,539 :: 		LongWordToStr(status_wed_service, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,540 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,541 :: 		xuat_32bit(out_relay);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_xuat_32bit+0
;RCUHAGER.c,542 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP111
L_SPI_Ethernet_UserTCP103:
;RCUHAGER.c,543 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP112
;RCUHAGER.c,544 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP113
;RCUHAGER.c,545 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP114
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP114:
;RCUHAGER.c,546 :: 		}
L_SPI_Ethernet_UserTCP113:
;RCUHAGER.c,547 :: 		status_wed_service|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_service+0)
MOVT	R5, #hi_addr(_status_wed_service+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;RCUHAGER.c,548 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_20_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_20_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,549 :: 		LongWordToStr(status_wed_service, dyna);
MOVW	R4, #lo_addr(_status_wed_service+0)
MOVT	R4, #hi_addr(_status_wed_service+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,550 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,551 :: 		}
L_SPI_Ethernet_UserTCP112:
L_SPI_Ethernet_UserTCP111:
;RCUHAGER.c,552 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP101
;RCUHAGER.c,553 :: 		case Page_Lighting:
L_SPI_Ethernet_UserTCP115:
;RCUHAGER.c,554 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP116
;RCUHAGER.c,555 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP117
;RCUHAGER.c,556 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP118
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP118:
;RCUHAGER.c,557 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP119
;RCUHAGER.c,558 :: 		case 0://ENTRANCE
L_SPI_Ethernet_UserTCP121:
;RCUHAGER.c,559 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP120
;RCUHAGER.c,560 :: 		case 1://MASTER
L_SPI_Ethernet_UserTCP122:
;RCUHAGER.c,561 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP120
;RCUHAGER.c,562 :: 		case 2://LIGHT_BATH
L_SPI_Ethernet_UserTCP123:
;RCUHAGER.c,563 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP120
;RCUHAGER.c,564 :: 		case 3://LIGHT_READING
L_SPI_Ethernet_UserTCP124:
;RCUHAGER.c,565 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP120
;RCUHAGER.c,566 :: 		case 4://LIGHT_BEDSIDE
L_SPI_Ethernet_UserTCP125:
;RCUHAGER.c,567 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP120
;RCUHAGER.c,568 :: 		default:
L_SPI_Ethernet_UserTCP126:
;RCUHAGER.c,569 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP120
;RCUHAGER.c,570 :: 		}
L_SPI_Ethernet_UserTCP119:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP121
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP122
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP123
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP124
LDRB	R4, [SP, #14]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP125
IT	AL
BAL	L_SPI_Ethernet_UserTCP126
L_SPI_Ethernet_UserTCP120:
;RCUHAGER.c,571 :: 		}
L_SPI_Ethernet_UserTCP117:
;RCUHAGER.c,572 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_21_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_21_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,573 :: 		status_wed_light|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_light+0)
MOVT	R5, #hi_addr(_status_wed_light+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;RCUHAGER.c,574 :: 		LongWordToStr(status_wed_light, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,575 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,576 :: 		xuat_32bit(out_relay);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_xuat_32bit+0
;RCUHAGER.c,577 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP127
L_SPI_Ethernet_UserTCP116:
;RCUHAGER.c,578 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP128
;RCUHAGER.c,579 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP129
;RCUHAGER.c,580 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP130
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP130:
;RCUHAGER.c,581 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP131
;RCUHAGER.c,582 :: 		case 0://ENTRANCE
L_SPI_Ethernet_UserTCP133:
;RCUHAGER.c,583 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP132
;RCUHAGER.c,584 :: 		case 1://MASTER
L_SPI_Ethernet_UserTCP134:
;RCUHAGER.c,585 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP132
;RCUHAGER.c,586 :: 		case 2://LIGHT_BATH
L_SPI_Ethernet_UserTCP135:
;RCUHAGER.c,587 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP132
;RCUHAGER.c,588 :: 		case 3://LIGHT_READING
L_SPI_Ethernet_UserTCP136:
;RCUHAGER.c,589 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP132
;RCUHAGER.c,590 :: 		case 4://LIGHT_BEDSIDE
L_SPI_Ethernet_UserTCP137:
;RCUHAGER.c,591 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP132
;RCUHAGER.c,592 :: 		default:
L_SPI_Ethernet_UserTCP138:
;RCUHAGER.c,593 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP132
;RCUHAGER.c,594 :: 		}
L_SPI_Ethernet_UserTCP131:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP133
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP134
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP135
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP136
LDRB	R4, [SP, #14]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP137
IT	AL
BAL	L_SPI_Ethernet_UserTCP138
L_SPI_Ethernet_UserTCP132:
;RCUHAGER.c,595 :: 		}
L_SPI_Ethernet_UserTCP129:
;RCUHAGER.c,596 :: 		flag_but_dimer=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_flag_but_dimer+0)
MOVT	R4, #hi_addr(_flag_but_dimer+0)
STRB	R5, [R4, #0]
;RCUHAGER.c,597 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_22_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_22_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,598 :: 		status_wed_light|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_light+0)
MOVT	R5, #hi_addr(_status_wed_light+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;RCUHAGER.c,599 :: 		LongWordToStr(status_wed_light, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,600 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,601 :: 		}
L_SPI_Ethernet_UserTCP128:
L_SPI_Ethernet_UserTCP127:
;RCUHAGER.c,602 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP101
;RCUHAGER.c,603 :: 		case Page_Curtain:
L_SPI_Ethernet_UserTCP139:
;RCUHAGER.c,604 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP140
;RCUHAGER.c,605 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP141
;RCUHAGER.c,606 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP142
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP142:
;RCUHAGER.c,607 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP143
;RCUHAGER.c,608 :: 		case 0://CURTAIN_O 1   OPEN THEN CLOSE
L_SPI_Ethernet_UserTCP145:
;RCUHAGER.c,609 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP144
;RCUHAGER.c,610 :: 		case 1://CURTAIN_C 1   OPEN THEN STOP
L_SPI_Ethernet_UserTCP146:
;RCUHAGER.c,611 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP144
;RCUHAGER.c,612 :: 		case 2://CURTAIN_O 2
L_SPI_Ethernet_UserTCP147:
;RCUHAGER.c,613 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP144
;RCUHAGER.c,614 :: 		case 3://CURTAIN_C 2
L_SPI_Ethernet_UserTCP148:
;RCUHAGER.c,615 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP144
;RCUHAGER.c,617 :: 		default:
L_SPI_Ethernet_UserTCP149:
;RCUHAGER.c,618 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP144
;RCUHAGER.c,619 :: 		}
L_SPI_Ethernet_UserTCP143:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP145
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP146
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP147
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP148
IT	AL
BAL	L_SPI_Ethernet_UserTCP149
L_SPI_Ethernet_UserTCP144:
;RCUHAGER.c,620 :: 		}
L_SPI_Ethernet_UserTCP141:
;RCUHAGER.c,621 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_23_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_23_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,622 :: 		status_wed_curtain|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_curtain+0)
MOVT	R5, #hi_addr(_status_wed_curtain+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;RCUHAGER.c,623 :: 		LongWordToStr(status_wed_curtain, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,624 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,626 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP150
L_SPI_Ethernet_UserTCP140:
;RCUHAGER.c,627 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP151
;RCUHAGER.c,628 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP152
;RCUHAGER.c,629 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP153
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP153:
;RCUHAGER.c,630 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP154
;RCUHAGER.c,631 :: 		case 0://CURTAIN_O 1
L_SPI_Ethernet_UserTCP156:
;RCUHAGER.c,632 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP155
;RCUHAGER.c,633 :: 		case 1://CURTAIN_C 1  OPEN THEN STOP ( TURN ON 8&9)
L_SPI_Ethernet_UserTCP157:
;RCUHAGER.c,634 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP155
;RCUHAGER.c,635 :: 		case 2://CURTAIN_O 2
L_SPI_Ethernet_UserTCP158:
;RCUHAGER.c,636 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP155
;RCUHAGER.c,637 :: 		case 3://CURTAIN_C 2
L_SPI_Ethernet_UserTCP159:
;RCUHAGER.c,638 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP155
;RCUHAGER.c,639 :: 		default:
L_SPI_Ethernet_UserTCP160:
;RCUHAGER.c,640 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP155
;RCUHAGER.c,641 :: 		}
L_SPI_Ethernet_UserTCP154:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP156
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP157
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP158
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP159
IT	AL
BAL	L_SPI_Ethernet_UserTCP160
L_SPI_Ethernet_UserTCP155:
;RCUHAGER.c,642 :: 		}
L_SPI_Ethernet_UserTCP152:
;RCUHAGER.c,643 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_24_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_24_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,644 :: 		status_wed_curtain&=~(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSLS	R4, R5
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_curtain+0)
MOVT	R5, #hi_addr(_status_wed_curtain+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
;RCUHAGER.c,645 :: 		LongWordToStr(status_wed_curtain, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,646 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,648 :: 		}
L_SPI_Ethernet_UserTCP151:
L_SPI_Ethernet_UserTCP150:
;RCUHAGER.c,649 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP101
;RCUHAGER.c,650 :: 		case Page_Scenes:
L_SPI_Ethernet_UserTCP161:
;RCUHAGER.c,651 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP162
;RCUHAGER.c,652 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP163
;RCUHAGER.c,653 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP164
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP164:
;RCUHAGER.c,654 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP165
;RCUHAGER.c,655 :: 		case 0://S_RELAX
L_SPI_Ethernet_UserTCP167:
;RCUHAGER.c,656 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP166
;RCUHAGER.c,657 :: 		case 1://S_NIGHT
L_SPI_Ethernet_UserTCP168:
;RCUHAGER.c,658 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP166
;RCUHAGER.c,659 :: 		case 2://S_PARTY
L_SPI_Ethernet_UserTCP169:
;RCUHAGER.c,660 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP166
;RCUHAGER.c,661 :: 		default:
L_SPI_Ethernet_UserTCP170:
;RCUHAGER.c,662 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP166
;RCUHAGER.c,663 :: 		}
L_SPI_Ethernet_UserTCP165:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP167
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP168
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP169
IT	AL
BAL	L_SPI_Ethernet_UserTCP170
L_SPI_Ethernet_UserTCP166:
;RCUHAGER.c,664 :: 		}
L_SPI_Ethernet_UserTCP163:
;RCUHAGER.c,665 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_25_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_25_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,666 :: 		status_wed_scenes|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_scenes+0)
MOVT	R5, #hi_addr(_status_wed_scenes+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;RCUHAGER.c,667 :: 		LongWordToStr(status_wed_scenes, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,668 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,669 :: 		xuat_32bit(out_relay);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_xuat_32bit+0
;RCUHAGER.c,670 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP171
L_SPI_Ethernet_UserTCP162:
;RCUHAGER.c,671 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP172
;RCUHAGER.c,672 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP173
;RCUHAGER.c,673 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP174
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP174:
;RCUHAGER.c,674 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP175
;RCUHAGER.c,675 :: 		case 0://S_RELAX
L_SPI_Ethernet_UserTCP177:
;RCUHAGER.c,676 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP176
;RCUHAGER.c,677 :: 		case 1://S_NIGHT
L_SPI_Ethernet_UserTCP178:
;RCUHAGER.c,678 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP176
;RCUHAGER.c,679 :: 		case 2://S_PARTY
L_SPI_Ethernet_UserTCP179:
;RCUHAGER.c,680 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP176
;RCUHAGER.c,681 :: 		default:
L_SPI_Ethernet_UserTCP180:
;RCUHAGER.c,682 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP176
;RCUHAGER.c,683 :: 		}
L_SPI_Ethernet_UserTCP175:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP177
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP178
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP179
IT	AL
BAL	L_SPI_Ethernet_UserTCP180
L_SPI_Ethernet_UserTCP176:
;RCUHAGER.c,684 :: 		}
L_SPI_Ethernet_UserTCP173:
;RCUHAGER.c,685 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_26_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_26_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,686 :: 		status_wed_scenes|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_scenes+0)
MOVT	R5, #hi_addr(_status_wed_scenes+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;RCUHAGER.c,687 :: 		LongWordToStr(status_wed_scenes, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,688 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,689 :: 		}
L_SPI_Ethernet_UserTCP172:
L_SPI_Ethernet_UserTCP171:
;RCUHAGER.c,690 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP101
;RCUHAGER.c,691 :: 		case Page_Fan_Speed:
L_SPI_Ethernet_UserTCP181:
;RCUHAGER.c,692 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP182
;RCUHAGER.c,693 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP183
;RCUHAGER.c,694 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP184
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP184:
;RCUHAGER.c,695 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP185
;RCUHAGER.c,696 :: 		case 0://FAN_ON_OFF
L_SPI_Ethernet_UserTCP187:
;RCUHAGER.c,697 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP186
;RCUHAGER.c,698 :: 		case 1://FAN_LOW
L_SPI_Ethernet_UserTCP188:
;RCUHAGER.c,699 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP186
;RCUHAGER.c,700 :: 		case 2://FAN_MEDIUM
L_SPI_Ethernet_UserTCP189:
;RCUHAGER.c,701 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP186
;RCUHAGER.c,702 :: 		case 3://FAN_HIGHT
L_SPI_Ethernet_UserTCP190:
;RCUHAGER.c,703 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP186
;RCUHAGER.c,704 :: 		default:
L_SPI_Ethernet_UserTCP191:
;RCUHAGER.c,705 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP186
;RCUHAGER.c,706 :: 		}
L_SPI_Ethernet_UserTCP185:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP187
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP188
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP189
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP190
IT	AL
BAL	L_SPI_Ethernet_UserTCP191
L_SPI_Ethernet_UserTCP186:
;RCUHAGER.c,707 :: 		}
L_SPI_Ethernet_UserTCP183:
;RCUHAGER.c,708 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_27_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_27_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,709 :: 		if((out_relay&FAN_L)?1:0)status_wed_fan|=(shift<<1);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #512
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP192
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP193
L_SPI_Ethernet_UserTCP192:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP193:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP194
LDR	R4, [SP, #16]
LSLS	R6, R4, #1
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP195
L_SPI_Ethernet_UserTCP194:
;RCUHAGER.c,710 :: 		else status_wed_fan&=~(shift<<1);
LDR	R4, [SP, #16]
LSLS	R4, R4, #1
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP195:
;RCUHAGER.c,711 :: 		if((out_relay&FAN_M)?1:0)status_wed_fan|=(shift<<2);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #1024
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP196
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP197
L_SPI_Ethernet_UserTCP196:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP197:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP198
LDR	R4, [SP, #16]
LSLS	R6, R4, #2
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP199
L_SPI_Ethernet_UserTCP198:
;RCUHAGER.c,712 :: 		else status_wed_fan&=~(shift<<2);
LDR	R4, [SP, #16]
LSLS	R4, R4, #2
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP199:
;RCUHAGER.c,713 :: 		if((out_relay&FAN_H)?1:0)status_wed_fan|=(shift<<3);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #2048
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP200
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP201
L_SPI_Ethernet_UserTCP200:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP201:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP202
LDR	R4, [SP, #16]
LSLS	R6, R4, #3
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP203
L_SPI_Ethernet_UserTCP202:
;RCUHAGER.c,714 :: 		else status_wed_fan&=~(shift<<3);
LDR	R4, [SP, #16]
LSLS	R4, R4, #3
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP203:
;RCUHAGER.c,715 :: 		LongWordToStr(status_wed_fan, dyna);
MOVW	R4, #lo_addr(_status_wed_fan+0)
MOVT	R4, #hi_addr(_status_wed_fan+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,716 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,717 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP204
L_SPI_Ethernet_UserTCP182:
;RCUHAGER.c,718 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP205
;RCUHAGER.c,719 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP206
;RCUHAGER.c,720 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP207
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP207:
;RCUHAGER.c,721 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP208
;RCUHAGER.c,722 :: 		case 0://FAN_ON_OFF
L_SPI_Ethernet_UserTCP210:
;RCUHAGER.c,723 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP209
;RCUHAGER.c,724 :: 		case 1://FAN_LOW
L_SPI_Ethernet_UserTCP211:
;RCUHAGER.c,725 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP209
;RCUHAGER.c,726 :: 		case 2://FAN_MEDIUM
L_SPI_Ethernet_UserTCP212:
;RCUHAGER.c,727 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP209
;RCUHAGER.c,728 :: 		case 3://FAN_HIGHT
L_SPI_Ethernet_UserTCP213:
;RCUHAGER.c,729 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP209
;RCUHAGER.c,730 :: 		default:
L_SPI_Ethernet_UserTCP214:
;RCUHAGER.c,731 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP209
;RCUHAGER.c,732 :: 		}
L_SPI_Ethernet_UserTCP208:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP210
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP211
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP212
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP213
IT	AL
BAL	L_SPI_Ethernet_UserTCP214
L_SPI_Ethernet_UserTCP209:
;RCUHAGER.c,733 :: 		}
L_SPI_Ethernet_UserTCP206:
;RCUHAGER.c,734 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_28_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_28_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,735 :: 		if((out_relay&FAN_L)?1:0)status_wed_fan|=(shift<<1);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #512
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP215
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP216
L_SPI_Ethernet_UserTCP215:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP216:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP217
LDR	R4, [SP, #16]
LSLS	R6, R4, #1
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP218
L_SPI_Ethernet_UserTCP217:
;RCUHAGER.c,736 :: 		else status_wed_fan&=~(shift<<1);
LDR	R4, [SP, #16]
LSLS	R4, R4, #1
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP218:
;RCUHAGER.c,737 :: 		if((out_relay&FAN_M)?1:0)status_wed_fan|=(shift<<2);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #1024
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP219
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP220
L_SPI_Ethernet_UserTCP219:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP220:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP221
LDR	R4, [SP, #16]
LSLS	R6, R4, #2
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP222
L_SPI_Ethernet_UserTCP221:
;RCUHAGER.c,738 :: 		else status_wed_fan&=~(shift<<2);
LDR	R4, [SP, #16]
LSLS	R4, R4, #2
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP222:
;RCUHAGER.c,739 :: 		if((out_relay&FAN_H)?1:0)status_wed_fan|=(shift<<3);
MOVW	R4, #lo_addr(_out_relay+0)
MOVT	R4, #hi_addr(_out_relay+0)
LDR	R4, [R4, #0]
AND	R4, R4, #2048
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP223
MOVS	R0, #1
SXTB	R0, R0
IT	AL
BAL	L_SPI_Ethernet_UserTCP224
L_SPI_Ethernet_UserTCP223:
MOVS	R0, #0
SXTB	R0, R0
L_SPI_Ethernet_UserTCP224:
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP225
LDR	R4, [SP, #16]
LSLS	R6, R4, #3
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
IT	AL
BAL	L_SPI_Ethernet_UserTCP226
L_SPI_Ethernet_UserTCP225:
;RCUHAGER.c,740 :: 		else status_wed_fan&=~(shift<<3);
LDR	R4, [SP, #16]
LSLS	R4, R4, #3
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_fan+0)
MOVT	R5, #hi_addr(_status_wed_fan+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
L_SPI_Ethernet_UserTCP226:
;RCUHAGER.c,741 :: 		LongWordToStr(status_wed_fan, dyna);
MOVW	R4, #lo_addr(_status_wed_fan+0)
MOVT	R4, #hi_addr(_status_wed_fan+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,742 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,743 :: 		}
L_SPI_Ethernet_UserTCP205:
L_SPI_Ethernet_UserTCP204:
;RCUHAGER.c,744 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP101
;RCUHAGER.c,745 :: 		case Page_Dimer_Extant:
L_SPI_Ethernet_UserTCP227:
;RCUHAGER.c,746 :: 		if(getRequest[5] == 'o'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #111
IT	NE
BNE	L_SPI_Ethernet_UserTCP228
;RCUHAGER.c,747 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP229
;RCUHAGER.c,748 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP230
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP230:
;RCUHAGER.c,749 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP231
;RCUHAGER.c,750 :: 		case 0:
L_SPI_Ethernet_UserTCP233:
;RCUHAGER.c,751 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP232
;RCUHAGER.c,752 :: 		case 1:
L_SPI_Ethernet_UserTCP234:
;RCUHAGER.c,753 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP232
;RCUHAGER.c,754 :: 		case 2:
L_SPI_Ethernet_UserTCP235:
;RCUHAGER.c,755 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP232
;RCUHAGER.c,756 :: 		case 3:
L_SPI_Ethernet_UserTCP236:
;RCUHAGER.c,757 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP232
;RCUHAGER.c,758 :: 		case 4:
L_SPI_Ethernet_UserTCP237:
;RCUHAGER.c,759 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP232
;RCUHAGER.c,760 :: 		case 5:
L_SPI_Ethernet_UserTCP238:
;RCUHAGER.c,761 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP232
;RCUHAGER.c,762 :: 		default:
L_SPI_Ethernet_UserTCP239:
;RCUHAGER.c,763 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP232
;RCUHAGER.c,764 :: 		}
L_SPI_Ethernet_UserTCP231:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP233
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP234
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP235
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP236
LDRB	R4, [SP, #14]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP237
LDRB	R4, [SP, #14]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP238
IT	AL
BAL	L_SPI_Ethernet_UserTCP239
L_SPI_Ethernet_UserTCP232:
;RCUHAGER.c,765 :: 		}
L_SPI_Ethernet_UserTCP229:
;RCUHAGER.c,766 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_29_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_29_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,767 :: 		status_wed_dimer|=(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSL	R6, R4, R5
MOVW	R5, #lo_addr(_status_wed_dimer+0)
MOVT	R5, #hi_addr(_status_wed_dimer+0)
LDR	R4, [R5, #0]
ORRS	R4, R6
STR	R4, [R5, #0]
;RCUHAGER.c,768 :: 		LongWordToStr(status_wed_dimer, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,769 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,770 :: 		}
IT	AL
BAL	L_SPI_Ethernet_UserTCP240
L_SPI_Ethernet_UserTCP228:
;RCUHAGER.c,771 :: 		else if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP241
;RCUHAGER.c,772 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP242
;RCUHAGER.c,773 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP243
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
SUBS	R4, #48
STRB	R4, [SP, #14]
L_SPI_Ethernet_UserTCP243:
;RCUHAGER.c,774 :: 		switch (vt_button) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP244
;RCUHAGER.c,775 :: 		case 0://up1
L_SPI_Ethernet_UserTCP246:
;RCUHAGER.c,776 :: 		flag_dimer_ex[1]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_flag_dimer_ex+1)
MOVT	R4, #hi_addr(_flag_dimer_ex+1)
STRB	R5, [R4, #0]
;RCUHAGER.c,777 :: 		count_time_dimer_ex[1]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_count_time_dimer_ex+4)
MOVT	R4, #hi_addr(_count_time_dimer_ex+4)
STR	R5, [R4, #0]
;RCUHAGER.c,778 :: 		DIM2_EVERGREEN = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_DIM2_EVERGREEN+0)
MOVT	R4, #hi_addr(_DIM2_EVERGREEN+0)
STRB	R5, [R4, #0]
;RCUHAGER.c,779 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP245
;RCUHAGER.c,780 :: 		case 1://dow1
L_SPI_Ethernet_UserTCP247:
;RCUHAGER.c,781 :: 		flag_dimer_ex[1]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_flag_dimer_ex+1)
MOVT	R4, #hi_addr(_flag_dimer_ex+1)
STRB	R5, [R4, #0]
;RCUHAGER.c,782 :: 		count_time_dimer_ex[1]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_count_time_dimer_ex+4)
MOVT	R4, #hi_addr(_count_time_dimer_ex+4)
STR	R5, [R4, #0]
;RCUHAGER.c,783 :: 		DIM2_EVERGREEN = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_DIM2_EVERGREEN+0)
MOVT	R4, #hi_addr(_DIM2_EVERGREEN+0)
STRB	R5, [R4, #0]
;RCUHAGER.c,784 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP245
;RCUHAGER.c,785 :: 		case 2://up34
L_SPI_Ethernet_UserTCP248:
;RCUHAGER.c,789 :: 		flag_dimer_ex[2]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_flag_dimer_ex+2)
MOVT	R4, #hi_addr(_flag_dimer_ex+2)
STRB	R5, [R4, #0]
;RCUHAGER.c,790 :: 		count_time_dimer_ex[2]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_count_time_dimer_ex+8)
MOVT	R4, #hi_addr(_count_time_dimer_ex+8)
STR	R5, [R4, #0]
;RCUHAGER.c,791 :: 		DIM4_EVERGREEN = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_DIM4_EVERGREEN+0)
MOVT	R4, #hi_addr(_DIM4_EVERGREEN+0)
STRB	R5, [R4, #0]
;RCUHAGER.c,792 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP245
;RCUHAGER.c,793 :: 		case 3://down34
L_SPI_Ethernet_UserTCP249:
;RCUHAGER.c,796 :: 		flag_dimer_ex[2]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_flag_dimer_ex+2)
MOVT	R4, #hi_addr(_flag_dimer_ex+2)
STRB	R5, [R4, #0]
;RCUHAGER.c,797 :: 		count_time_dimer_ex[2]=0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_count_time_dimer_ex+8)
MOVT	R4, #hi_addr(_count_time_dimer_ex+8)
STR	R5, [R4, #0]
;RCUHAGER.c,798 :: 		DIM4_EVERGREEN = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_DIM4_EVERGREEN+0)
MOVT	R4, #hi_addr(_DIM4_EVERGREEN+0)
STRB	R5, [R4, #0]
;RCUHAGER.c,799 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP245
;RCUHAGER.c,800 :: 		case 4://up3
L_SPI_Ethernet_UserTCP250:
;RCUHAGER.c,803 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP245
;RCUHAGER.c,804 :: 		case 5://down3
L_SPI_Ethernet_UserTCP251:
;RCUHAGER.c,807 :: 		default:
L_SPI_Ethernet_UserTCP252:
;RCUHAGER.c,808 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP245
;RCUHAGER.c,809 :: 		}
L_SPI_Ethernet_UserTCP244:
LDRB	R4, [SP, #14]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP246
LDRB	R4, [SP, #14]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP247
LDRB	R4, [SP, #14]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP248
LDRB	R4, [SP, #14]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP249
LDRB	R4, [SP, #14]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP250
LDRB	R4, [SP, #14]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP251
IT	AL
BAL	L_SPI_Ethernet_UserTCP252
L_SPI_Ethernet_UserTCP245:
;RCUHAGER.c,810 :: 		}
L_SPI_Ethernet_UserTCP242:
;RCUHAGER.c,811 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_30_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_30_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,812 :: 		status_wed_dimer&=~(shift<<vt_button);
LDRB	R5, [SP, #14]
LDR	R4, [SP, #16]
LSLS	R4, R5
MVN	R6, R4
MOVW	R5, #lo_addr(_status_wed_dimer+0)
MOVT	R5, #hi_addr(_status_wed_dimer+0)
LDR	R4, [R5, #0]
ANDS	R4, R6
STR	R4, [R5, #0]
;RCUHAGER.c,813 :: 		LongWordToStr(status_wed_dimer, dyna);
MOVW	R1, #lo_addr(_dyna+0)
MOVT	R1, #hi_addr(_dyna+0)
MOV	R0, R4
BL	_LongWordToStr+0
;RCUHAGER.c,814 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,815 :: 		}
L_SPI_Ethernet_UserTCP241:
L_SPI_Ethernet_UserTCP240:
;RCUHAGER.c,816 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP101
;RCUHAGER.c,817 :: 		case Page_Device_Extant:
L_SPI_Ethernet_UserTCP253:
;RCUHAGER.c,818 :: 		if(getRequest[5] == 'd'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #100
IT	NE
BNE	L_SPI_Ethernet_UserTCP254
;RCUHAGER.c,819 :: 		if(isdigit(getRequest[6])){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
UXTB	R0, R4
BL	_isdigit+0
CMP	R0, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP255
;RCUHAGER.c,820 :: 		if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
MOVW	R4, #lo_addr(_getRequest+7)
MOVT	R4, #hi_addr(_getRequest+7)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP256
IT	AL
BAL	L_SPI_Ethernet_UserTCP257
L_SPI_Ethernet_UserTCP256:
;RCUHAGER.c,821 :: 		else if(getRequest[8]=='$')vt_button=chuoi_so(getRequest,6,7);
MOVW	R4, #lo_addr(_getRequest+8)
MOVT	R4, #hi_addr(_getRequest+8)
LDRB	R4, [R4, #0]
CMP	R4, #36
IT	NE
BNE	L_SPI_Ethernet_UserTCP258
MOVS	R2, #7
MOVS	R1, #6
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_chuoi_so+0
L_SPI_Ethernet_UserTCP258:
L_SPI_Ethernet_UserTCP257:
;RCUHAGER.c,826 :: 		if(getRequest[6]=='0'){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
CMP	R4, #48
IT	NE
BNE	L_SPI_Ethernet_UserTCP259
;RCUHAGER.c,827 :: 		ETHERNET_BUTTON_DEVICE_0=1;
MOVS	R5, #1
MOVW	R4, #lo_addr(_ETHERNET_BUTTON_DEVICE_0+0)
MOVT	R4, #hi_addr(_ETHERNET_BUTTON_DEVICE_0+0)
STRB	R5, [R4, #0]
;RCUHAGER.c,828 :: 		ETHERNET_BUTTON_DIM0++;   // ADD PLUS VALUE4CHANNEL
MOVW	R5, #lo_addr(_ETHERNET_BUTTON_DIM0+0)
MOVT	R5, #hi_addr(_ETHERNET_BUTTON_DIM0+0)
LDRB	R4, [R5, #0]
ADDS	R4, R4, #1
STRB	R4, [R5, #0]
;RCUHAGER.c,829 :: 		}
L_SPI_Ethernet_UserTCP259:
;RCUHAGER.c,830 :: 		if(getRequest[6]=='1'){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
CMP	R4, #49
IT	NE
BNE	L_SPI_Ethernet_UserTCP260
;RCUHAGER.c,831 :: 		ETHERNET_BUTTON_DEVICE_1=1;
MOVS	R5, #1
MOVW	R4, #lo_addr(_ETHERNET_BUTTON_DEVICE_1+0)
MOVT	R4, #hi_addr(_ETHERNET_BUTTON_DEVICE_1+0)
STRB	R5, [R4, #0]
;RCUHAGER.c,832 :: 		ETHERNET_BUTTON_DIM1^=1;
MOVW	R5, #lo_addr(_ETHERNET_BUTTON_DIM1+0)
MOVT	R5, #hi_addr(_ETHERNET_BUTTON_DIM1+0)
LDRB	R4, [R5, #0]
EOR	R4, R4, #1
STRB	R4, [R5, #0]
;RCUHAGER.c,833 :: 		}
L_SPI_Ethernet_UserTCP260:
;RCUHAGER.c,834 :: 		if(getRequest[6]=='2'){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
CMP	R4, #50
IT	NE
BNE	L_SPI_Ethernet_UserTCP261
;RCUHAGER.c,835 :: 		ETHERNET_BUTTON_DEVICE_2=1;
MOVS	R5, #1
MOVW	R4, #lo_addr(_ETHERNET_BUTTON_DEVICE_2+0)
MOVT	R4, #hi_addr(_ETHERNET_BUTTON_DEVICE_2+0)
STRB	R5, [R4, #0]
;RCUHAGER.c,836 :: 		ETHERNET_BUTTON_DIM2^=1;
MOVW	R5, #lo_addr(_ETHERNET_BUTTON_DIM2+0)
MOVT	R5, #hi_addr(_ETHERNET_BUTTON_DIM2+0)
LDRB	R4, [R5, #0]
EOR	R4, R4, #1
STRB	R4, [R5, #0]
;RCUHAGER.c,837 :: 		}
L_SPI_Ethernet_UserTCP261:
;RCUHAGER.c,838 :: 		if(getRequest[6]=='3'){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
CMP	R4, #51
IT	NE
BNE	L_SPI_Ethernet_UserTCP262
;RCUHAGER.c,839 :: 		ETHERNET_BUTTON_DEVICE_3=1;
MOVS	R5, #1
MOVW	R4, #lo_addr(_ETHERNET_BUTTON_DEVICE_3+0)
MOVT	R4, #hi_addr(_ETHERNET_BUTTON_DEVICE_3+0)
STRB	R5, [R4, #0]
;RCUHAGER.c,840 :: 		ETHERNET_BUTTON_DIM3^=1;
MOVW	R5, #lo_addr(_ETHERNET_BUTTON_DIM3+0)
MOVT	R5, #hi_addr(_ETHERNET_BUTTON_DIM3+0)
LDRB	R4, [R5, #0]
EOR	R4, R4, #1
STRB	R4, [R5, #0]
;RCUHAGER.c,841 :: 		}
L_SPI_Ethernet_UserTCP262:
;RCUHAGER.c,842 :: 		if(getRequest[6]=='4'){
MOVW	R4, #lo_addr(_getRequest+6)
MOVT	R4, #hi_addr(_getRequest+6)
LDRB	R4, [R4, #0]
CMP	R4, #52
IT	NE
BNE	L_SPI_Ethernet_UserTCP263
;RCUHAGER.c,843 :: 		ETHERNET_BUTTON_DEVICE_4=1;
MOVS	R5, #1
MOVW	R4, #lo_addr(_ETHERNET_BUTTON_DEVICE_4+0)
MOVT	R4, #hi_addr(_ETHERNET_BUTTON_DEVICE_4+0)
STRB	R5, [R4, #0]
;RCUHAGER.c,844 :: 		ETHERNET_BUTTON_DIM4^=1;
MOVW	R5, #lo_addr(_ETHERNET_BUTTON_DIM4+0)
MOVT	R5, #hi_addr(_ETHERNET_BUTTON_DIM4+0)
LDRB	R4, [R5, #0]
EOR	R4, R4, #1
STRB	R4, [R5, #0]
;RCUHAGER.c,845 :: 		}
L_SPI_Ethernet_UserTCP263:
;RCUHAGER.c,846 :: 		}
L_SPI_Ethernet_UserTCP255:
;RCUHAGER.c,849 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_31_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_31_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,855 :: 		}
L_SPI_Ethernet_UserTCP254:
;RCUHAGER.c,856 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP101
;RCUHAGER.c,857 :: 		case Page_Setting:
L_SPI_Ethernet_UserTCP264:
;RCUHAGER.c,858 :: 		copyBuf(getRequest,buf,40);
MOVS	R2, #40
MOVW	R1, #lo_addr(_buf+0)
MOVT	R1, #hi_addr(_buf+0)
MOVW	R0, #lo_addr(_getRequest+0)
MOVT	R0, #hi_addr(_getRequest+0)
BL	_copyBuf+0
;RCUHAGER.c,859 :: 		saveIP(buf);
MOVW	R0, #lo_addr(_buf+0)
MOVT	R0, #hi_addr(_buf+0)
BL	_saveIP+0
;RCUHAGER.c,860 :: 		if(getRequest[5] == 'f'){
MOVW	R4, #lo_addr(_getRequest+5)
MOVT	R4, #hi_addr(_getRequest+5)
LDRB	R4, [R4, #0]
CMP	R4, #102
IT	NE
BNE	L_SPI_Ethernet_UserTCP265
;RCUHAGER.c,861 :: 		len += putConstString("r");
MOVW	R4, #lo_addr(?lstr_32_RCUHAGER+0)
MOVT	R4, #hi_addr(?lstr_32_RCUHAGER+0)
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,862 :: 		len += putString(dyna);
MOVW	R0, #lo_addr(_dyna+0)
MOVT	R0, #hi_addr(_dyna+0)
BL	_SPI_Ethernet_putString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,863 :: 		}
L_SPI_Ethernet_UserTCP265:
;RCUHAGER.c,864 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP101
;RCUHAGER.c,865 :: 		default:
L_SPI_Ethernet_UserTCP266:
;RCUHAGER.c,866 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP101
;RCUHAGER.c,867 :: 		}
L_SPI_Ethernet_UserTCP100:
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP102
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP115
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP139
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP161
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP181
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #6
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP227
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #7
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP253
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #8
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP264
IT	AL
BAL	L_SPI_Ethernet_UserTCP266
L_SPI_Ethernet_UserTCP101:
;RCUHAGER.c,868 :: 		if(len == 0){
LDRH	R4, [SP, #12]
CMP	R4, #0
IT	NE
BNE	L_SPI_Ethernet_UserTCP267
;RCUHAGER.c,869 :: 		len =  putConstString(httpHeader);
MOVW	R0, #lo_addr(_httpHeader+0)
MOVT	R0, #hi_addr(_httpHeader+0)
BL	_SPI_Ethernet_putConstString+0
STRH	R0, [SP, #12]
;RCUHAGER.c,870 :: 		len += putConstString(httpMimeTypeHTML);
MOVW	R0, #lo_addr(_httpMimeTypeHTML+0)
MOVT	R0, #hi_addr(_httpMimeTypeHTML+0)
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,871 :: 		switch (index_page) {
IT	AL
BAL	L_SPI_Ethernet_UserTCP268
;RCUHAGER.c,872 :: 		case Page_Login:
L_SPI_Ethernet_UserTCP270:
;RCUHAGER.c,873 :: 		len += putConstString(LoginPage);
MOVW	R4, #lo_addr(_LoginPage+0)
MOVT	R4, #hi_addr(_LoginPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,874 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP269
;RCUHAGER.c,875 :: 		case Page_Service:
L_SPI_Ethernet_UserTCP271:
;RCUHAGER.c,876 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,877 :: 		len += putConstString(ServicePage);
MOVW	R4, #lo_addr(_ServicePage+0)
MOVT	R4, #hi_addr(_ServicePage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,878 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP269
;RCUHAGER.c,879 :: 		case Page_Lighting:
L_SPI_Ethernet_UserTCP272:
;RCUHAGER.c,880 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,881 :: 		len += putConstString(LightingPage);
MOVW	R4, #lo_addr(_LightingPage+0)
MOVT	R4, #hi_addr(_LightingPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,882 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP269
;RCUHAGER.c,883 :: 		case Page_Curtain:
L_SPI_Ethernet_UserTCP273:
;RCUHAGER.c,884 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,885 :: 		len += putConstString(CurtainPage);
MOVW	R4, #lo_addr(_CurtainPage+0)
MOVT	R4, #hi_addr(_CurtainPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,886 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP269
;RCUHAGER.c,887 :: 		case Page_Scenes:
L_SPI_Ethernet_UserTCP274:
;RCUHAGER.c,888 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,889 :: 		len += putConstString(ScenesPage);
MOVW	R4, #lo_addr(_ScenesPage+0)
MOVT	R4, #hi_addr(_ScenesPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,890 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP269
;RCUHAGER.c,891 :: 		case Page_Fan_Speed:
L_SPI_Ethernet_UserTCP275:
;RCUHAGER.c,892 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,893 :: 		len += putConstString(Fan_SpeedPage);
MOVW	R4, #lo_addr(_Fan_SpeedPage+0)
MOVT	R4, #hi_addr(_Fan_SpeedPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,894 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP269
;RCUHAGER.c,895 :: 		case Page_Dimer_Extant:
L_SPI_Ethernet_UserTCP276:
;RCUHAGER.c,896 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,897 :: 		len += putConstString(Dimer_ExtantPage);
MOVW	R4, #lo_addr(_Dimer_ExtantPage+0)
MOVT	R4, #hi_addr(_Dimer_ExtantPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,898 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP269
;RCUHAGER.c,899 :: 		case Page_Device_Extant:
L_SPI_Ethernet_UserTCP277:
;RCUHAGER.c,900 :: 		len += putConstString(Device_ExtantPage);
MOVW	R4, #lo_addr(_Device_ExtantPage+0)
MOVT	R4, #hi_addr(_Device_ExtantPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,901 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP269
;RCUHAGER.c,902 :: 		case Page_Setting:
L_SPI_Ethernet_UserTCP278:
;RCUHAGER.c,903 :: 		len += putConstString(SettingPage);
MOVW	R4, #lo_addr(_SettingPage+0)
MOVT	R4, #hi_addr(_SettingPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,904 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP269
;RCUHAGER.c,905 :: 		case Page_Home:
L_SPI_Ethernet_UserTCP279:
;RCUHAGER.c,906 :: 		len += putConstString(HomePage);
MOVW	R4, #lo_addr(_HomePage+0)
MOVT	R4, #hi_addr(_HomePage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,907 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP269
;RCUHAGER.c,908 :: 		default:
L_SPI_Ethernet_UserTCP280:
;RCUHAGER.c,909 :: 		len += putConstString(indexPage);
MOVW	R4, #lo_addr(_indexPage+0)
MOVT	R4, #hi_addr(_indexPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,910 :: 		len += putConstString(Device_ExtantPage);
MOVW	R4, #lo_addr(_Device_ExtantPage+0)
MOVT	R4, #hi_addr(_Device_ExtantPage+0)
LDR	R4, [R4, #0]
MOV	R0, R4
BL	_SPI_Ethernet_putConstString+0
LDRH	R4, [SP, #12]
ADDS	R4, R4, R0
STRH	R4, [SP, #12]
;RCUHAGER.c,911 :: 		break;
IT	AL
BAL	L_SPI_Ethernet_UserTCP269
;RCUHAGER.c,912 :: 		}
L_SPI_Ethernet_UserTCP268:
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #0
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP270
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #1
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP271
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #2
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP272
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #3
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP273
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #4
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP274
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #5
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP275
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #6
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP276
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #7
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP277
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #8
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP278
MOVW	R4, #lo_addr(_index_page+0)
MOVT	R4, #hi_addr(_index_page+0)
LDRH	R4, [R4, #0]
CMP	R4, #9
IT	EQ
BEQ	L_SPI_Ethernet_UserTCP279
IT	AL
BAL	L_SPI_Ethernet_UserTCP280
L_SPI_Ethernet_UserTCP269:
;RCUHAGER.c,913 :: 		}
L_SPI_Ethernet_UserTCP267:
;RCUHAGER.c,914 :: 		return(len);
LDRH	R0, [SP, #12]
;RCUHAGER.c,915 :: 		}
L_end_SPI_Ethernet_UserTCP:
LDR	LR, [SP, #0]
ADD	SP, SP, #40
BX	LR
; end of _SPI_Ethernet_UserTCP
_SPI_Ethernet_UserUDP:
;RCUHAGER.c,916 :: 		unsigned int    SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags){
; flags start address is: 16 (R4)
SUB	SP, SP, #16
LDR	R4, [SP, #16]
; flags end address is: 16 (R4)
;RCUHAGER.c,917 :: 		return(0);
MOVS	R0, #0
;RCUHAGER.c,918 :: 		}
L_end_SPI_Ethernet_UserUDP:
ADD	SP, SP, #16
BX	LR
; end of _SPI_Ethernet_UserUDP
_timer1_isr:
;RCUHAGER.c,920 :: 		void timer1_isr() iv IVT_INT_TIM1_UP ics ICS_AUTO { //20 ms
SUB	SP, SP, #4
STR	LR, [SP, #0]
;RCUHAGER.c,921 :: 		unsigned char i_isr=0,but_isr=0;
;RCUHAGER.c,922 :: 		unsigned long shift=1;
;RCUHAGER.c,924 :: 		if(TIM1_SRbits.UIF==1)
MOVW	R1, #lo_addr(TIM1_SRbits+0)
MOVT	R1, #hi_addr(TIM1_SRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr281
;RCUHAGER.c,926 :: 		TIM1_SRbits.UIF=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_SRbits+0)
MOVT	R0, #hi_addr(TIM1_SRbits+0)
STR	R1, [R0, #0]
;RCUHAGER.c,929 :: 		but_sample[0][SAMPLE-1]=!BUT1_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+1)
MOVT	R0, #hi_addr(_but_sample+1)
STRB	R1, [R0, #0]
;RCUHAGER.c,930 :: 		but_sample[1][SAMPLE-1]=!BUT1_1;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+3)
MOVT	R0, #hi_addr(_but_sample+3)
STRB	R1, [R0, #0]
;RCUHAGER.c,931 :: 		but_sample[2][SAMPLE-1]=!BUT1_2;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+5)
MOVT	R0, #hi_addr(_but_sample+5)
STRB	R1, [R0, #0]
;RCUHAGER.c,933 :: 		but_sample[3][SAMPLE-1]=!BUT2_0;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+7)
MOVT	R0, #hi_addr(_but_sample+7)
STRB	R1, [R0, #0]
;RCUHAGER.c,934 :: 		but_sample[4][SAMPLE-1]=!BUT2_1;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+9)
MOVT	R0, #hi_addr(_but_sample+9)
STRB	R1, [R0, #0]
;RCUHAGER.c,935 :: 		but_sample[5][SAMPLE-1]=!BUT2_2;
MOVW	R1, #lo_addr(GPIOA_IDR+0)
MOVT	R1, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+11)
MOVT	R0, #hi_addr(_but_sample+11)
STRB	R1, [R0, #0]
;RCUHAGER.c,937 :: 		but_sample[6][SAMPLE-1]=!BUT3_0;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+13)
MOVT	R0, #hi_addr(_but_sample+13)
STRB	R1, [R0, #0]
;RCUHAGER.c,938 :: 		but_sample[7][SAMPLE-1]=!BUT3_1;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+15)
MOVT	R0, #hi_addr(_but_sample+15)
STRB	R1, [R0, #0]
;RCUHAGER.c,939 :: 		but_sample[8][SAMPLE-1]=!BUT3_2;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+17)
MOVT	R0, #hi_addr(_but_sample+17)
STRB	R1, [R0, #0]
;RCUHAGER.c,941 :: 		but_sample[9][SAMPLE-1]=!BUT4_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+19)
MOVT	R0, #hi_addr(_but_sample+19)
STRB	R1, [R0, #0]
;RCUHAGER.c,942 :: 		but_sample[10][SAMPLE-1]=!BUT4_1;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+21)
MOVT	R0, #hi_addr(_but_sample+21)
STRB	R1, [R0, #0]
;RCUHAGER.c,944 :: 		but_sample[11][SAMPLE-1]=!BUT5_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+23)
MOVT	R0, #hi_addr(_but_sample+23)
STRB	R1, [R0, #0]
;RCUHAGER.c,945 :: 		but_sample[12][SAMPLE-1]=!BUT5_1;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+25)
MOVT	R0, #hi_addr(_but_sample+25)
STRB	R1, [R0, #0]
;RCUHAGER.c,947 :: 		but_sample[13][SAMPLE-1]=!BUT6_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+27)
MOVT	R0, #hi_addr(_but_sample+27)
STRB	R1, [R0, #0]
;RCUHAGER.c,949 :: 		but_sample[14][SAMPLE-1]=!BUT7_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+29)
MOVT	R0, #hi_addr(_but_sample+29)
STRB	R1, [R0, #0]
;RCUHAGER.c,951 :: 		but_sample[15][SAMPLE-1]=!BUT8_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+31)
MOVT	R0, #hi_addr(_but_sample+31)
STRB	R1, [R0, #0]
;RCUHAGER.c,952 :: 		but_sample[16][SAMPLE-1]=!BUT8_1;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+33)
MOVT	R0, #hi_addr(_but_sample+33)
STRB	R1, [R0, #0]
;RCUHAGER.c,954 :: 		but_sample[17][SAMPLE-1]=!BUT9_0;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+35)
MOVT	R0, #hi_addr(_but_sample+35)
STRB	R1, [R0, #0]
;RCUHAGER.c,955 :: 		but_sample[18][SAMPLE-1]=!BUT9_1;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+37)
MOVT	R0, #hi_addr(_but_sample+37)
STRB	R1, [R0, #0]
;RCUHAGER.c,957 :: 		but_sample[19][SAMPLE-1]=!BUT10_0;
MOVW	R1, #lo_addr(GPIOD_IDR+0)
MOVT	R1, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+39)
MOVT	R0, #hi_addr(_but_sample+39)
STRB	R1, [R0, #0]
;RCUHAGER.c,958 :: 		but_sample[20][SAMPLE-1]=!BUT10_1;
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+41)
MOVT	R0, #hi_addr(_but_sample+41)
STRB	R1, [R0, #0]
;RCUHAGER.c,960 :: 		but_sample[21][SAMPLE-1]=!BUT11_0;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+43)
MOVT	R0, #hi_addr(_but_sample+43)
STRB	R1, [R0, #0]
;RCUHAGER.c,961 :: 		but_sample[22][SAMPLE-1]=!BUT11_1;
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+45)
MOVT	R0, #hi_addr(_but_sample+45)
STRB	R1, [R0, #0]
;RCUHAGER.c,963 :: 		but_sample[23][SAMPLE-1]=!BUT12_0;
MOVW	R1, #lo_addr(GPIOE_IDR+0)
MOVT	R1, #hi_addr(GPIOE_IDR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_but_sample+47)
MOVT	R0, #hi_addr(_but_sample+47)
STRB	R1, [R0, #0]
;RCUHAGER.c,965 :: 		for(but_isr=0;but_isr<SUM_BUT;but_isr++){
; but_isr start address is: 12 (R3)
MOVS	R3, #0
; but_isr end address is: 12 (R3)
L_timer1_isr282:
; but_isr start address is: 12 (R3)
CMP	R3, #24
IT	CS
BCS	L_timer1_isr283
;RCUHAGER.c,966 :: 		for(i_isr=0;i_isr<SAMPLE-1;i_isr++){
; i_isr start address is: 16 (R4)
MOVS	R4, #0
; i_isr end address is: 16 (R4)
; but_isr end address is: 12 (R3)
L_timer1_isr285:
; i_isr start address is: 16 (R4)
; but_isr start address is: 12 (R3)
CMP	R4, #1
IT	CS
BCS	L_timer1_isr286
;RCUHAGER.c,967 :: 		but_sample[but_isr][i_isr]=but_sample[but_isr][i_isr+1];
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
;RCUHAGER.c,966 :: 		for(i_isr=0;i_isr<SAMPLE-1;i_isr++){
ADDS	R4, R4, #1
UXTB	R4, R4
;RCUHAGER.c,968 :: 		}
; i_isr end address is: 16 (R4)
IT	AL
BAL	L_timer1_isr285
L_timer1_isr286:
;RCUHAGER.c,969 :: 		but_sum_sample[but_isr]=0;
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RCUHAGER.c,970 :: 		for(i_isr=0;i_isr<SAMPLE;i_isr++){
; i_isr start address is: 16 (R4)
MOVS	R4, #0
; i_isr end address is: 16 (R4)
; but_isr end address is: 12 (R3)
L_timer1_isr288:
; i_isr start address is: 16 (R4)
; but_isr start address is: 12 (R3)
CMP	R4, #2
IT	CS
BCS	L_timer1_isr289
;RCUHAGER.c,971 :: 		but_sum_sample[but_isr]+=but_sample[but_isr][i_isr];
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
;RCUHAGER.c,970 :: 		for(i_isr=0;i_isr<SAMPLE;i_isr++){
ADDS	R4, R4, #1
UXTB	R4, R4
;RCUHAGER.c,972 :: 		}
; i_isr end address is: 16 (R4)
IT	AL
BAL	L_timer1_isr288
L_timer1_isr289:
;RCUHAGER.c,973 :: 		if(but_sum_sample[but_isr]>=PRESS){
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	CC
BCC	L_timer1_isr291
;RCUHAGER.c,974 :: 		but_state[but_isr]=PRESS;
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R1, R0, R3
MOVS	R0, #2
STRB	R0, [R1, #0]
;RCUHAGER.c,975 :: 		}
IT	AL
BAL	L_timer1_isr292
L_timer1_isr291:
;RCUHAGER.c,976 :: 		else if(but_sum_sample[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_sum_sample+0)
MOVT	R0, #hi_addr(_but_sum_sample+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr293
;RCUHAGER.c,977 :: 		but_state[but_isr]=UNPRESS;
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RCUHAGER.c,978 :: 		}
L_timer1_isr293:
L_timer1_isr292:
;RCUHAGER.c,979 :: 		if(but_state[but_isr]==PRESS){
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_timer1_isr294
;RCUHAGER.c,980 :: 		if(but_status[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr295
;RCUHAGER.c,981 :: 		but_status[but_isr]=PRES_DOW;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #5
STRB	R0, [R1, #0]
;RCUHAGER.c,982 :: 		}
IT	AL
BAL	L_timer1_isr296
L_timer1_isr295:
;RCUHAGER.c,983 :: 		else if(but_status[but_isr]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr297
;RCUHAGER.c,984 :: 		but_status[but_isr]=PRESSING;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #6
STRB	R0, [R1, #0]
;RCUHAGER.c,985 :: 		}
IT	AL
BAL	L_timer1_isr298
L_timer1_isr297:
;RCUHAGER.c,986 :: 		else if(but_status[but_isr]==PRESSING){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	NE
BNE	L_timer1_isr299
;RCUHAGER.c,987 :: 		but_status[but_isr]=PRESSING;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #6
STRB	R0, [R1, #0]
;RCUHAGER.c,988 :: 		}
L_timer1_isr299:
L_timer1_isr298:
L_timer1_isr296:
;RCUHAGER.c,989 :: 		}
IT	AL
BAL	L_timer1_isr300
L_timer1_isr294:
;RCUHAGER.c,990 :: 		else if(but_state[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr301
;RCUHAGER.c,991 :: 		if ((but_status[but_isr]==PRESSING)||(but_status[but_isr]==PRES_DOW)){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	EQ
BEQ	L__timer1_isr523
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L__timer1_isr522
IT	AL
BAL	L_timer1_isr304
L__timer1_isr523:
L__timer1_isr522:
;RCUHAGER.c,992 :: 		but_status[but_isr]=PRES_UP;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #4
STRB	R0, [R1, #0]
;RCUHAGER.c,993 :: 		}
IT	AL
BAL	L_timer1_isr305
L_timer1_isr304:
;RCUHAGER.c,994 :: 		else if(but_status[but_isr]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr306
;RCUHAGER.c,995 :: 		but_status[but_isr]=UNPRESS;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RCUHAGER.c,996 :: 		}
IT	AL
BAL	L_timer1_isr307
L_timer1_isr306:
;RCUHAGER.c,997 :: 		else if(but_status[but_isr]==UNPRESS){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R0, R0, R3
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr308
;RCUHAGER.c,998 :: 		but_status[but_isr]=UNPRESS;
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
ADDS	R1, R0, R3
MOVS	R0, #0
STRB	R0, [R1, #0]
;RCUHAGER.c,999 :: 		}
L_timer1_isr308:
L_timer1_isr307:
L_timer1_isr305:
;RCUHAGER.c,1000 :: 		}
L_timer1_isr301:
L_timer1_isr300:
;RCUHAGER.c,965 :: 		for(but_isr=0;but_isr<SUM_BUT;but_isr++){
ADDS	R3, R3, #1
UXTB	R3, R3
;RCUHAGER.c,1001 :: 		}
; but_isr end address is: 12 (R3)
IT	AL
BAL	L_timer1_isr282
L_timer1_isr283:
;RCUHAGER.c,1014 :: 		duphong67_A8=~duphong67_A8;             // LED INDICAROR QUET BAN PHIM
MOVW	R1, #lo_addr(GPIOA_ODR+0)
MOVT	R1, #hi_addr(GPIOA_ODR+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;RCUHAGER.c,1018 :: 		if(but_status[0]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr309
;RCUHAGER.c,1019 :: 		LED_1_0^=1;
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1020 :: 		}
IT	AL
BAL	L_timer1_isr310
L_timer1_isr309:
;RCUHAGER.c,1021 :: 		else if(but_status[0]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+0)
MOVT	R0, #hi_addr(_but_status+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr311
;RCUHAGER.c,1023 :: 		}
L_timer1_isr311:
L_timer1_isr310:
;RCUHAGER.c,1026 :: 		if(but_status[1]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+1)
MOVT	R0, #hi_addr(_but_status+1)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr312
;RCUHAGER.c,1027 :: 		LED_1_1=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1028 :: 		if(!flag_button_dim1){
MOVW	R0, #lo_addr(_flag_button_dim1+0)
MOVT	R0, #hi_addr(_flag_button_dim1+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr313
;RCUHAGER.c,1029 :: 		flag_button_dim1=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_button_dim1+0)
MOVT	R0, #hi_addr(_flag_button_dim1+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1030 :: 		if(BUTTON_DIM_CHANNEL1<=4){BUTTON_DIM_CHANNEL1++;}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL1+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL1+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	HI
BHI	L_timer1_isr314
MOVW	R1, #lo_addr(_BUTTON_DIM_CHANNEL1+0)
MOVT	R1, #hi_addr(_BUTTON_DIM_CHANNEL1+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
L_timer1_isr314:
;RCUHAGER.c,1031 :: 		if(BUTTON_DIM_CHANNEL1>=5){BUTTON_DIM_CHANNEL1=0;}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL1+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL1+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	CC
BCC	L_timer1_isr315
MOVS	R1, #0
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL1+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL1+0)
STRB	R1, [R0, #0]
L_timer1_isr315:
;RCUHAGER.c,1032 :: 		flag_setdimmer1=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_setdimmer1+0)
MOVT	R0, #hi_addr(_flag_setdimmer1+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1033 :: 		}
L_timer1_isr313:
;RCUHAGER.c,1034 :: 		}
IT	AL
BAL	L_timer1_isr316
L_timer1_isr312:
;RCUHAGER.c,1035 :: 		else if(but_status[1]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+1)
MOVT	R0, #hi_addr(_but_status+1)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr317
;RCUHAGER.c,1036 :: 		LED_1_1=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1037 :: 		flag_button_dim1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_button_dim1+0)
MOVT	R0, #hi_addr(_flag_button_dim1+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1038 :: 		}
L_timer1_isr317:
L_timer1_isr316:
;RCUHAGER.c,1040 :: 		if(but_status[2]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+2)
MOVT	R0, #hi_addr(_but_status+2)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr318
;RCUHAGER.c,1041 :: 		LED_1_2=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1042 :: 		if(!flag_button_dim2){
MOVW	R0, #lo_addr(_flag_button_dim2+0)
MOVT	R0, #hi_addr(_flag_button_dim2+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr319
;RCUHAGER.c,1043 :: 		flag_button_dim2=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_button_dim2+0)
MOVT	R0, #hi_addr(_flag_button_dim2+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1044 :: 		if(BUTTON_DIM_CHANNEL2<=4){BUTTON_DIM_CHANNEL2++;}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL2+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL2+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	HI
BHI	L_timer1_isr320
MOVW	R1, #lo_addr(_BUTTON_DIM_CHANNEL2+0)
MOVT	R1, #hi_addr(_BUTTON_DIM_CHANNEL2+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
L_timer1_isr320:
;RCUHAGER.c,1045 :: 		if(BUTTON_DIM_CHANNEL2>=5){BUTTON_DIM_CHANNEL2=0;}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL2+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL2+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	CC
BCC	L_timer1_isr321
MOVS	R1, #0
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL2+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL2+0)
STRB	R1, [R0, #0]
L_timer1_isr321:
;RCUHAGER.c,1046 :: 		flag_setdimmer2=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_setdimmer2+0)
MOVT	R0, #hi_addr(_flag_setdimmer2+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1047 :: 		}
L_timer1_isr319:
;RCUHAGER.c,1048 :: 		}
IT	AL
BAL	L_timer1_isr322
L_timer1_isr318:
;RCUHAGER.c,1049 :: 		else if(but_status[2]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+2)
MOVT	R0, #hi_addr(_but_status+2)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr323
;RCUHAGER.c,1050 :: 		LED_1_2=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1051 :: 		flag_button_dim2=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_button_dim2+0)
MOVT	R0, #hi_addr(_flag_button_dim2+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1052 :: 		}
L_timer1_isr323:
L_timer1_isr322:
;RCUHAGER.c,1055 :: 		if(but_status[3]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+3)
MOVT	R0, #hi_addr(_but_status+3)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr324
;RCUHAGER.c,1056 :: 		LED_2_0^=1;
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1057 :: 		}
IT	AL
BAL	L_timer1_isr325
L_timer1_isr324:
;RCUHAGER.c,1058 :: 		else if(but_status[3]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+3)
MOVT	R0, #hi_addr(_but_status+3)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr326
;RCUHAGER.c,1060 :: 		}
L_timer1_isr326:
L_timer1_isr325:
;RCUHAGER.c,1063 :: 		if(but_status[4]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+4)
MOVT	R0, #hi_addr(_but_status+4)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr327
;RCUHAGER.c,1064 :: 		LED_2_1=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1065 :: 		if(!flag_button_dim2){
MOVW	R0, #lo_addr(_flag_button_dim2+0)
MOVT	R0, #hi_addr(_flag_button_dim2+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr328
;RCUHAGER.c,1066 :: 		flag_button_dim3=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_button_dim3+0)
MOVT	R0, #hi_addr(_flag_button_dim3+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1067 :: 		if(BUTTON_DIM_CHANNEL3<=4){BUTTON_DIM_CHANNEL3++;}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL3+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL3+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	HI
BHI	L_timer1_isr329
MOVW	R1, #lo_addr(_BUTTON_DIM_CHANNEL3+0)
MOVT	R1, #hi_addr(_BUTTON_DIM_CHANNEL3+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
L_timer1_isr329:
;RCUHAGER.c,1068 :: 		if(BUTTON_DIM_CHANNEL3>=5){BUTTON_DIM_CHANNEL3=0;}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL3+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL3+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	CC
BCC	L_timer1_isr330
MOVS	R1, #0
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL3+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL3+0)
STRB	R1, [R0, #0]
L_timer1_isr330:
;RCUHAGER.c,1069 :: 		flag_setdimmer3=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_setdimmer3+0)
MOVT	R0, #hi_addr(_flag_setdimmer3+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1070 :: 		}
L_timer1_isr328:
;RCUHAGER.c,1071 :: 		}
IT	AL
BAL	L_timer1_isr331
L_timer1_isr327:
;RCUHAGER.c,1072 :: 		else if(but_status[4]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+4)
MOVT	R0, #hi_addr(_but_status+4)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr332
;RCUHAGER.c,1073 :: 		LED_2_1=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1074 :: 		flag_button_dim3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_button_dim3+0)
MOVT	R0, #hi_addr(_flag_button_dim3+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1075 :: 		}
L_timer1_isr332:
L_timer1_isr331:
;RCUHAGER.c,1078 :: 		if(but_status[5]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+5)
MOVT	R0, #hi_addr(_but_status+5)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr333
;RCUHAGER.c,1079 :: 		LED_2_2=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1080 :: 		if(!flag_button_dim4){
MOVW	R0, #lo_addr(_flag_button_dim4+0)
MOVT	R0, #hi_addr(_flag_button_dim4+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr334
;RCUHAGER.c,1081 :: 		flag_button_dim4=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_button_dim4+0)
MOVT	R0, #hi_addr(_flag_button_dim4+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1082 :: 		if(BUTTON_DIM_CHANNEL4<=4){BUTTON_DIM_CHANNEL4++;}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL4+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL4+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	HI
BHI	L_timer1_isr335
MOVW	R1, #lo_addr(_BUTTON_DIM_CHANNEL4+0)
MOVT	R1, #hi_addr(_BUTTON_DIM_CHANNEL4+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
L_timer1_isr335:
;RCUHAGER.c,1083 :: 		if(BUTTON_DIM_CHANNEL4>=5){BUTTON_DIM_CHANNEL4=0;}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL4+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL4+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	CC
BCC	L_timer1_isr336
MOVS	R1, #0
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL4+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL4+0)
STRB	R1, [R0, #0]
L_timer1_isr336:
;RCUHAGER.c,1084 :: 		flag_setdimmer4=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_setdimmer4+0)
MOVT	R0, #hi_addr(_flag_setdimmer4+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1085 :: 		}
L_timer1_isr334:
;RCUHAGER.c,1086 :: 		}
IT	AL
BAL	L_timer1_isr337
L_timer1_isr333:
;RCUHAGER.c,1087 :: 		else if(but_status[5]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+5)
MOVT	R0, #hi_addr(_but_status+5)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr338
;RCUHAGER.c,1088 :: 		LED_2_2=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1089 :: 		flag_button_dim4=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_button_dim4+0)
MOVT	R0, #hi_addr(_flag_button_dim4+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1090 :: 		}
L_timer1_isr338:
L_timer1_isr337:
;RCUHAGER.c,1094 :: 		if(but_status[6]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+6)
MOVT	R0, #hi_addr(_but_status+6)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr339
;RCUHAGER.c,1095 :: 		LED_3_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1096 :: 		if(!flag_button_dimmaster){
MOVW	R0, #lo_addr(_flag_button_dimmaster+0)
MOVT	R0, #hi_addr(_flag_button_dimmaster+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr340
;RCUHAGER.c,1097 :: 		flag_button_dimmaster=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_button_dimmaster+0)
MOVT	R0, #hi_addr(_flag_button_dimmaster+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1098 :: 		if(BUTTON_DIM_MASTER<=4){BUTTON_DIM_MASTER++;}
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	HI
BHI	L_timer1_isr341
MOVW	R1, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R1, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
L_timer1_isr341:
;RCUHAGER.c,1099 :: 		if(BUTTON_DIM_MASTER>=5){BUTTON_DIM_MASTER=0;}
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	CC
BCC	L_timer1_isr342
MOVS	R1, #0
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
STRB	R1, [R0, #0]
L_timer1_isr342:
;RCUHAGER.c,1100 :: 		flag_setdimmaster=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_setdimmaster+0)
MOVT	R0, #hi_addr(_flag_setdimmaster+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1101 :: 		}
L_timer1_isr340:
;RCUHAGER.c,1102 :: 		}
IT	AL
BAL	L_timer1_isr343
L_timer1_isr339:
;RCUHAGER.c,1103 :: 		else if(but_status[6]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+6)
MOVT	R0, #hi_addr(_but_status+6)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr344
;RCUHAGER.c,1104 :: 		LED_3_0=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1105 :: 		flag_button_dimmaster=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_button_dimmaster+0)
MOVT	R0, #hi_addr(_flag_button_dimmaster+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1106 :: 		}
L_timer1_isr344:
L_timer1_isr343:
;RCUHAGER.c,1108 :: 		if(but_status[7]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+7)
MOVT	R0, #hi_addr(_but_status+7)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr345
;RCUHAGER.c,1109 :: 		LED_3_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1110 :: 		if(!flag_button_dimmaster){
MOVW	R0, #lo_addr(_flag_button_dimmaster+0)
MOVT	R0, #hi_addr(_flag_button_dimmaster+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr346
;RCUHAGER.c,1111 :: 		flag_button_dimmaster=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_button_dimmaster+0)
MOVT	R0, #hi_addr(_flag_button_dimmaster+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1112 :: 		if(BUTTON_DIM_MASTER<=4){BUTTON_DIM_MASTER++;}
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	HI
BHI	L_timer1_isr347
MOVW	R1, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R1, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
L_timer1_isr347:
;RCUHAGER.c,1113 :: 		if(BUTTON_DIM_MASTER>=5){BUTTON_DIM_MASTER=0;}
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	CC
BCC	L_timer1_isr348
MOVS	R1, #0
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
STRB	R1, [R0, #0]
L_timer1_isr348:
;RCUHAGER.c,1114 :: 		flag_setdimmaster=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_setdimmaster+0)
MOVT	R0, #hi_addr(_flag_setdimmaster+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1115 :: 		}
L_timer1_isr346:
;RCUHAGER.c,1116 :: 		}
IT	AL
BAL	L_timer1_isr349
L_timer1_isr345:
;RCUHAGER.c,1117 :: 		else if(but_status[7]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+7)
MOVT	R0, #hi_addr(_but_status+7)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr350
;RCUHAGER.c,1118 :: 		LED_3_0=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1119 :: 		flag_button_dimmaster=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_button_dimmaster+0)
MOVT	R0, #hi_addr(_flag_button_dimmaster+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1120 :: 		}
L_timer1_isr350:
L_timer1_isr349:
;RCUHAGER.c,1122 :: 		if(but_status[8]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+8)
MOVT	R0, #hi_addr(_but_status+8)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr351
;RCUHAGER.c,1123 :: 		LED_3_2=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1124 :: 		if(!flag_button_dimmaster){
MOVW	R0, #lo_addr(_flag_button_dimmaster+0)
MOVT	R0, #hi_addr(_flag_button_dimmaster+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr352
;RCUHAGER.c,1125 :: 		flag_button_dimmaster=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_button_dimmaster+0)
MOVT	R0, #hi_addr(_flag_button_dimmaster+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1126 :: 		if(BUTTON_DIM_MASTER<=4){BUTTON_DIM_MASTER++;}
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	HI
BHI	L_timer1_isr353
MOVW	R1, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R1, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
L_timer1_isr353:
;RCUHAGER.c,1127 :: 		if(BUTTON_DIM_MASTER>=5){BUTTON_DIM_MASTER=0;}
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	CC
BCC	L_timer1_isr354
MOVS	R1, #0
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
STRB	R1, [R0, #0]
L_timer1_isr354:
;RCUHAGER.c,1128 :: 		flag_setdimmaster=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_setdimmaster+0)
MOVT	R0, #hi_addr(_flag_setdimmaster+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1129 :: 		}
L_timer1_isr352:
;RCUHAGER.c,1130 :: 		}
IT	AL
BAL	L_timer1_isr355
L_timer1_isr351:
;RCUHAGER.c,1131 :: 		else if(but_status[8]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+8)
MOVT	R0, #hi_addr(_but_status+8)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr356
;RCUHAGER.c,1132 :: 		LED_3_2=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1133 :: 		flag_button_dimmaster=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_button_dimmaster+0)
MOVT	R0, #hi_addr(_flag_button_dimmaster+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1134 :: 		}
L_timer1_isr356:
L_timer1_isr355:
;RCUHAGER.c,1137 :: 		if(but_status[9]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+9)
MOVT	R0, #hi_addr(_but_status+9)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr357
;RCUHAGER.c,1138 :: 		LED_4_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1139 :: 		out_relay^=RELAY_1;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;RCUHAGER.c,1140 :: 		}
IT	AL
BAL	L_timer1_isr358
L_timer1_isr357:
;RCUHAGER.c,1141 :: 		else if(but_status[9]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+9)
MOVT	R0, #hi_addr(_but_status+9)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr359
;RCUHAGER.c,1142 :: 		LED_4_0=(out_relay&RELAY_1)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #1
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr360
; ?FLOC___timer1_isr?T1217 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1217 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr361
L_timer1_isr360:
; ?FLOC___timer1_isr?T1217 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1217 end address is: 4 (R1)
L_timer1_isr361:
; ?FLOC___timer1_isr?T1217 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1217 end address is: 4 (R1)
;RCUHAGER.c,1143 :: 		}
L_timer1_isr359:
L_timer1_isr358:
;RCUHAGER.c,1145 :: 		if(but_status[10]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+10)
MOVT	R0, #hi_addr(_but_status+10)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr362
;RCUHAGER.c,1146 :: 		LED_4_1=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1147 :: 		out_relay^=RELAY_16;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #32768
STR	R0, [R1, #0]
;RCUHAGER.c,1148 :: 		}
IT	AL
BAL	L_timer1_isr363
L_timer1_isr362:
;RCUHAGER.c,1149 :: 		else if(but_status[10]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+10)
MOVT	R0, #hi_addr(_but_status+10)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr364
;RCUHAGER.c,1150 :: 		LED_4_1=(out_relay&RELAY_16)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #32768
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr365
; ?FLOC___timer1_isr?T1228 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1228 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr366
L_timer1_isr365:
; ?FLOC___timer1_isr?T1228 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1228 end address is: 4 (R1)
L_timer1_isr366:
; ?FLOC___timer1_isr?T1228 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1228 end address is: 4 (R1)
;RCUHAGER.c,1151 :: 		}
L_timer1_isr364:
L_timer1_isr363:
;RCUHAGER.c,1155 :: 		if(but_status[11]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+11)
MOVT	R0, #hi_addr(_but_status+11)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr367
;RCUHAGER.c,1156 :: 		LED_5_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1157 :: 		out_relay^=RELAY_6;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #32
STR	R0, [R1, #0]
;RCUHAGER.c,1158 :: 		}
IT	AL
BAL	L_timer1_isr368
L_timer1_isr367:
;RCUHAGER.c,1159 :: 		else if(but_status[11]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+11)
MOVT	R0, #hi_addr(_but_status+11)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr369
;RCUHAGER.c,1160 :: 		LED_5_0=(out_relay&RELAY_6)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #32
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr370
; ?FLOC___timer1_isr?T1239 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1239 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr371
L_timer1_isr370:
; ?FLOC___timer1_isr?T1239 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1239 end address is: 4 (R1)
L_timer1_isr371:
; ?FLOC___timer1_isr?T1239 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1239 end address is: 4 (R1)
;RCUHAGER.c,1162 :: 		}
L_timer1_isr369:
L_timer1_isr368:
;RCUHAGER.c,1164 :: 		if(but_status[12]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+12)
MOVT	R0, #hi_addr(_but_status+12)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr372
;RCUHAGER.c,1165 :: 		LED_5_1=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1166 :: 		out_relay^=RELAY_14;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #8192
STR	R0, [R1, #0]
;RCUHAGER.c,1169 :: 		}
IT	AL
BAL	L_timer1_isr373
L_timer1_isr372:
;RCUHAGER.c,1170 :: 		else if(but_status[12]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+12)
MOVT	R0, #hi_addr(_but_status+12)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr374
;RCUHAGER.c,1171 :: 		LED_5_1=(out_relay&RELAY_14)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #8192
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr375
; ?FLOC___timer1_isr?T1250 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1250 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr376
L_timer1_isr375:
; ?FLOC___timer1_isr?T1250 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1250 end address is: 4 (R1)
L_timer1_isr376:
; ?FLOC___timer1_isr?T1250 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1250 end address is: 4 (R1)
;RCUHAGER.c,1172 :: 		}
L_timer1_isr374:
L_timer1_isr373:
;RCUHAGER.c,1176 :: 		if(but_status[13]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+13)
MOVT	R0, #hi_addr(_but_status+13)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr377
;RCUHAGER.c,1177 :: 		LED_6_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1178 :: 		out_relay^=RELAY_8;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #128
STR	R0, [R1, #0]
;RCUHAGER.c,1179 :: 		}
IT	AL
BAL	L_timer1_isr378
L_timer1_isr377:
;RCUHAGER.c,1180 :: 		else if(but_status[13]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+13)
MOVT	R0, #hi_addr(_but_status+13)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr379
;RCUHAGER.c,1181 :: 		LED_6_0=(out_relay&RELAY_8)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #128
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr380
; ?FLOC___timer1_isr?T1261 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1261 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr381
L_timer1_isr380:
; ?FLOC___timer1_isr?T1261 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1261 end address is: 4 (R1)
L_timer1_isr381:
; ?FLOC___timer1_isr?T1261 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1261 end address is: 4 (R1)
;RCUHAGER.c,1182 :: 		}
L_timer1_isr379:
L_timer1_isr378:
;RCUHAGER.c,1185 :: 		if(but_status[14]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+14)
MOVT	R0, #hi_addr(_but_status+14)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr382
;RCUHAGER.c,1186 :: 		LED_7_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1187 :: 		MASTER_SWITCH_ALL=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_MASTER_SWITCH_ALL+0)
MOVT	R0, #hi_addr(_MASTER_SWITCH_ALL+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1188 :: 		MASTER_SWITCH_TOGGLE^=1;
MOVW	R1, #lo_addr(_MASTER_SWITCH_TOGGLE+0)
MOVT	R1, #hi_addr(_MASTER_SWITCH_TOGGLE+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;RCUHAGER.c,1189 :: 		}
IT	AL
BAL	L_timer1_isr383
L_timer1_isr382:
;RCUHAGER.c,1190 :: 		else if(but_status[14]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+14)
MOVT	R0, #hi_addr(_but_status+14)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr384
;RCUHAGER.c,1191 :: 		LED_7_0=MASTER_SWITCH_TOGGLE;
MOVW	R0, #lo_addr(_MASTER_SWITCH_TOGGLE+0)
MOVT	R0, #hi_addr(_MASTER_SWITCH_TOGGLE+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1192 :: 		MASTER_SWITCH_ALL=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_MASTER_SWITCH_ALL+0)
MOVT	R0, #hi_addr(_MASTER_SWITCH_ALL+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1193 :: 		}
L_timer1_isr384:
L_timer1_isr383:
;RCUHAGER.c,1196 :: 		if(but_status[15]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+15)
MOVT	R0, #hi_addr(_but_status+15)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr385
;RCUHAGER.c,1197 :: 		LED_8_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1198 :: 		out_relay^=RELAY_5;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #16
STR	R0, [R1, #0]
;RCUHAGER.c,1199 :: 		}
IT	AL
BAL	L_timer1_isr386
L_timer1_isr385:
;RCUHAGER.c,1200 :: 		else if(but_status[15]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+15)
MOVT	R0, #hi_addr(_but_status+15)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr387
;RCUHAGER.c,1201 :: 		LED_8_0=(out_relay&RELAY_5)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #16
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr388
; ?FLOC___timer1_isr?T1281 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1281 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr389
L_timer1_isr388:
; ?FLOC___timer1_isr?T1281 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1281 end address is: 4 (R1)
L_timer1_isr389:
; ?FLOC___timer1_isr?T1281 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1281 end address is: 4 (R1)
;RCUHAGER.c,1202 :: 		}
L_timer1_isr387:
L_timer1_isr386:
;RCUHAGER.c,1205 :: 		if(but_status[16]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+16)
MOVT	R0, #hi_addr(_but_status+16)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr390
;RCUHAGER.c,1206 :: 		LED_8_1=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1207 :: 		out_relay^=RELAY_4;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #8
STR	R0, [R1, #0]
;RCUHAGER.c,1208 :: 		}
IT	AL
BAL	L_timer1_isr391
L_timer1_isr390:
;RCUHAGER.c,1209 :: 		else if(but_status[16]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+16)
MOVT	R0, #hi_addr(_but_status+16)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr392
;RCUHAGER.c,1210 :: 		LED_8_1=(out_relay&RELAY_4)?1:0;
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
AND	R0, R0, #8
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr393
; ?FLOC___timer1_isr?T1292 start address is: 4 (R1)
MOVS	R1, #1
SXTB	R1, R1
; ?FLOC___timer1_isr?T1292 end address is: 4 (R1)
IT	AL
BAL	L_timer1_isr394
L_timer1_isr393:
; ?FLOC___timer1_isr?T1292 start address is: 4 (R1)
MOVS	R1, #0
SXTB	R1, R1
; ?FLOC___timer1_isr?T1292 end address is: 4 (R1)
L_timer1_isr394:
; ?FLOC___timer1_isr?T1292 start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
; ?FLOC___timer1_isr?T1292 end address is: 4 (R1)
;RCUHAGER.c,1211 :: 		}
L_timer1_isr392:
L_timer1_isr391:
;RCUHAGER.c,1214 :: 		if(but_status[17]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+17)
MOVT	R0, #hi_addr(_but_status+17)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr395
;RCUHAGER.c,1215 :: 		LED_9_0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1216 :: 		}
IT	AL
BAL	L_timer1_isr396
L_timer1_isr395:
;RCUHAGER.c,1217 :: 		else if(but_status[17]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+17)
MOVT	R0, #hi_addr(_but_status+17)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr397
;RCUHAGER.c,1218 :: 		LED_9_0=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1219 :: 		}
L_timer1_isr397:
L_timer1_isr396:
;RCUHAGER.c,1221 :: 		if(but_status[18]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+18)
MOVT	R0, #hi_addr(_but_status+18)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr398
;RCUHAGER.c,1222 :: 		LED_9_1^=1;
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1223 :: 		}
IT	AL
BAL	L_timer1_isr399
L_timer1_isr398:
;RCUHAGER.c,1224 :: 		else if(but_status[18]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+18)
MOVT	R0, #hi_addr(_but_status+18)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr400
;RCUHAGER.c,1226 :: 		}
L_timer1_isr400:
L_timer1_isr399:
;RCUHAGER.c,1229 :: 		if(but_status[19]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+19)
MOVT	R0, #hi_addr(_but_status+19)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr401
;RCUHAGER.c,1230 :: 		if(!DO_NOT_DISTURB)  {
MOVW	R0, #lo_addr(_DO_NOT_DISTURB+0)
MOVT	R0, #hi_addr(_DO_NOT_DISTURB+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_timer1_isr402
;RCUHAGER.c,1231 :: 		LED_10_0^=1; // LED MUR port10
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1232 :: 		LED_11_0^=1;  // LED MUR port11
MOVW	R1, #lo_addr(GPIOB_ODR+0)
MOVT	R1, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1233 :: 		}
L_timer1_isr402:
;RCUHAGER.c,1234 :: 		}
IT	AL
BAL	L_timer1_isr403
L_timer1_isr401:
;RCUHAGER.c,1235 :: 		else if(but_status[19]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+19)
MOVT	R0, #hi_addr(_but_status+19)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr404
;RCUHAGER.c,1237 :: 		}
L_timer1_isr404:
L_timer1_isr403:
;RCUHAGER.c,1239 :: 		if(but_status[20]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+20)
MOVT	R0, #hi_addr(_but_status+20)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr405
;RCUHAGER.c,1240 :: 		LED_10_1^=1; // LED DND port10
MOVW	R1, #lo_addr(GPIOC_ODR+0)
MOVT	R1, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1241 :: 		}
IT	AL
BAL	L_timer1_isr406
L_timer1_isr405:
;RCUHAGER.c,1242 :: 		else if(but_status[20]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+20)
MOVT	R0, #hi_addr(_but_status+20)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr407
;RCUHAGER.c,1243 :: 		}
L_timer1_isr407:
L_timer1_isr406:
;RCUHAGER.c,1246 :: 		if(but_status[21]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+21)
MOVT	R0, #hi_addr(_but_status+21)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr408
;RCUHAGER.c,1247 :: 		}
IT	AL
BAL	L_timer1_isr409
L_timer1_isr408:
;RCUHAGER.c,1248 :: 		else if(but_status[21]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+21)
MOVT	R0, #hi_addr(_but_status+21)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr410
;RCUHAGER.c,1249 :: 		}
L_timer1_isr410:
L_timer1_isr409:
;RCUHAGER.c,1251 :: 		if(but_status[22]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+22)
MOVT	R0, #hi_addr(_but_status+22)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr411
;RCUHAGER.c,1252 :: 		}
IT	AL
BAL	L_timer1_isr412
L_timer1_isr411:
;RCUHAGER.c,1253 :: 		else if(but_status[22]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+22)
MOVT	R0, #hi_addr(_but_status+22)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr413
;RCUHAGER.c,1254 :: 		}
L_timer1_isr413:
L_timer1_isr412:
;RCUHAGER.c,1258 :: 		if(but_status[23]==PRES_DOW){
MOVW	R0, #lo_addr(_but_status+23)
MOVT	R0, #hi_addr(_but_status+23)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_timer1_isr414
;RCUHAGER.c,1260 :: 		KEYCARD_COUNTER_CLOSE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_COUNTER_CLOSE+0)
MOVT	R0, #hi_addr(_KEYCARD_COUNTER_CLOSE+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1261 :: 		KEYCARD_INSERT=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1262 :: 		}
IT	AL
BAL	L_timer1_isr415
L_timer1_isr414:
;RCUHAGER.c,1263 :: 		else if(but_status[23]==PRES_UP){
MOVW	R0, #lo_addr(_but_status+23)
MOVT	R0, #hi_addr(_but_status+23)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_timer1_isr416
;RCUHAGER.c,1265 :: 		KEYCARD_INSERT=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_KEYCARD_INSERT+0)
MOVT	R0, #hi_addr(_KEYCARD_INSERT+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1266 :: 		}
L_timer1_isr416:
L_timer1_isr415:
;RCUHAGER.c,1269 :: 		if(MASTER_SWITCH){
MOVW	R0, #lo_addr(_MASTER_SWITCH+0)
MOVT	R0, #hi_addr(_MASTER_SWITCH+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_timer1_isr417
;RCUHAGER.c,1270 :: 		}
L_timer1_isr417:
;RCUHAGER.c,1273 :: 		xuat_32bit(out_relay);
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
BL	_xuat_32bit+0
;RCUHAGER.c,1280 :: 		}
L_timer1_isr281:
;RCUHAGER.c,1281 :: 		}
L_end_timer1_isr:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _timer1_isr
_uart4_rx:
;RCUHAGER.c,1283 :: 		void uart4_rx() iv IVT_INT_UART4 ics ICS_AUTO {
;RCUHAGER.c,1286 :: 		if(UART4_SRbits.RXNE){   // RXNE: Read data register not empty
MOVW	R1, #lo_addr(UART4_SRbits+0)
MOVT	R1, #hi_addr(UART4_SRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_uart4_rx418
;RCUHAGER.c,1287 :: 		UART4_SRbits.RXNE=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(UART4_SRbits+0)
MOVT	R0, #hi_addr(UART4_SRbits+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1288 :: 		data_rc=UART4_DRbits.DR;
MOVW	R0, #lo_addr(UART4_DRbits+0)
MOVT	R0, #hi_addr(UART4_DRbits+0)
LDRH	R0, [R0, #0]
UBFX	R0, R0, #0, #9
; data_rc start address is: 12 (R3)
UXTB	R3, R0
;RCUHAGER.c,1292 :: 		if(DATA_TRUE){
MOVW	R0, #lo_addr(_DATA_TRUE+0)
MOVT	R0, #hi_addr(_DATA_TRUE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_uart4_rx419
;RCUHAGER.c,1293 :: 		buf_rc_u4[count_buf_rc_4++]=data_rc;
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
;RCUHAGER.c,1294 :: 		}
L_uart4_rx419:
;RCUHAGER.c,1295 :: 		if(count_buf_rc_4==0){    // received header
MOVW	R0, #lo_addr(_count_buf_rc_4+0)
MOVT	R0, #hi_addr(_count_buf_rc_4+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_uart4_rx420
;RCUHAGER.c,1296 :: 		if(data_rc==0x4B){    // header is "K"
CMP	R3, #75
IT	NE
BNE	L_uart4_rx421
; data_rc end address is: 12 (R3)
;RCUHAGER.c,1298 :: 		DATA_TRUE=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_DATA_TRUE+0)
MOVT	R0, #hi_addr(_DATA_TRUE+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1300 :: 		}
L_uart4_rx421:
;RCUHAGER.c,1301 :: 		}
L_uart4_rx420:
;RCUHAGER.c,1303 :: 		if(count_buf_rc_4>=6){
MOVW	R0, #lo_addr(_count_buf_rc_4+0)
MOVT	R0, #hi_addr(_count_buf_rc_4+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	CC
BCC	L_uart4_rx422
;RCUHAGER.c,1305 :: 		DATA_TRUE=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_DATA_TRUE+0)
MOVT	R0, #hi_addr(_DATA_TRUE+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1307 :: 		PROCESSING_RS485=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_PROCESSING_RS485+0)
MOVT	R0, #hi_addr(_PROCESSING_RS485+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1312 :: 		}
L_uart4_rx422:
;RCUHAGER.c,1319 :: 		}
L_uart4_rx418:
;RCUHAGER.c,1321 :: 		}
L_end_uart4_rx:
BX	LR
; end of _uart4_rx
_IP_FIRST_TIME:
;RCUHAGER.c,1329 :: 		void IP_FIRST_TIME() org 0x00007FC0
;RCUHAGER.c,1331 :: 		IP_NULL=0xCACBEDAC;
MOVW	R0, #60844
MOVT	R0, #51915
MOVW	R1, #lo_addr(_IP_NULL+0)
MOVT	R1, #hi_addr(_IP_NULL+0)
STR	R0, [R1, #0]
;RCUHAGER.c,1332 :: 		IP_NULL=0xC0A80178;
MOVW	R0, #376
MOVT	R0, #49320
STR	R0, [R1, #0]
;RCUHAGER.c,1333 :: 		IP_NULL=0xC0A80179;
MOVW	R0, #377
MOVT	R0, #49320
STR	R0, [R1, #0]
;RCUHAGER.c,1334 :: 		IP_NULL=0xC0A8017A;
MOVW	R0, #378
MOVT	R0, #49320
STR	R0, [R1, #0]
;RCUHAGER.c,1335 :: 		IP_NULL=0xC0A8017B;
MOVW	R0, #379
MOVT	R0, #49320
STR	R0, [R1, #0]
;RCUHAGER.c,1336 :: 		IP_NULL=0xC0A8017C;
MOVW	R0, #380
MOVT	R0, #49320
STR	R0, [R1, #0]
;RCUHAGER.c,1337 :: 		IP_NULL=0xC0A8017D;
MOVW	R0, #381
MOVT	R0, #49320
STR	R0, [R1, #0]
;RCUHAGER.c,1338 :: 		IP_NULL=0xC0A8017E;
MOVW	R0, #382
MOVT	R0, #49320
STR	R0, [R1, #0]
;RCUHAGER.c,1339 :: 		IP_NULL=0xC0A8017F;
MOVW	R0, #383
MOVT	R0, #49320
STR	R0, [R1, #0]
;RCUHAGER.c,1340 :: 		asm nop;
NOP
;RCUHAGER.c,1341 :: 		asm nop;
NOP
;RCUHAGER.c,1342 :: 		}
L_end_IP_FIRST_TIME:
BX	LR
; end of _IP_FIRST_TIME
_main:
;RCUHAGER.c,1343 :: 		void main() {
;RCUHAGER.c,1351 :: 		gpio_init();
BL	_gpio_init+0
;RCUHAGER.c,1352 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_14);   // KICK MOSFET IRF9530 FOR RELAY 12V
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;RCUHAGER.c,1353 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_15);
MOVW	R1, #32768
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;RCUHAGER.c,1354 :: 		duphong8_C14=0;      // KICK MOSFET IRF9530 FOR RELAY 12V
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1355 :: 		duphong9_C15=0;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1356 :: 		out_relay=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1357 :: 		if(out_relay==0x01){IP_FIRST_TIME();}
L_main423:
;RCUHAGER.c,1358 :: 		xuat_32bit(out_relay);
MOVW	R0, #lo_addr(_out_relay+0)
MOVT	R0, #hi_addr(_out_relay+0)
LDR	R0, [R0, #0]
BL	_xuat_32bit+0
;RCUHAGER.c,1361 :: 		delay_ms(1500);
MOVW	R7, #43135
MOVT	R7, #274
NOP
NOP
L_main424:
SUBS	R7, R7, #1
BNE	L_main424
NOP
NOP
NOP
;RCUHAGER.c,1364 :: 		RESET:
___main_RESET:
;RCUHAGER.c,1365 :: 		buf_rc_u4[0]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+0)
MOVT	R0, #hi_addr(_buf_rc_u4+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1366 :: 		buf_rc_u4[1]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+1)
MOVT	R0, #hi_addr(_buf_rc_u4+1)
STRB	R1, [R0, #0]
;RCUHAGER.c,1367 :: 		buf_rc_u4[2]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+2)
MOVT	R0, #hi_addr(_buf_rc_u4+2)
STRB	R1, [R0, #0]
;RCUHAGER.c,1368 :: 		buf_rc_u4[3]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+3)
MOVT	R0, #hi_addr(_buf_rc_u4+3)
STRB	R1, [R0, #0]
;RCUHAGER.c,1369 :: 		buf_rc_u4[4]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+4)
MOVT	R0, #hi_addr(_buf_rc_u4+4)
STRB	R1, [R0, #0]
;RCUHAGER.c,1370 :: 		buf_rc_u4[5]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+5)
MOVT	R0, #hi_addr(_buf_rc_u4+5)
STRB	R1, [R0, #0]
;RCUHAGER.c,1371 :: 		buf_rc_u4[6]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_buf_rc_u4+6)
MOVT	R0, #hi_addr(_buf_rc_u4+6)
STRB	R1, [R0, #0]
;RCUHAGER.c,1372 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_12);   // den bao mau xanh da troi Port A12
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;RCUHAGER.c,1373 :: 		GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_8);   //
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;RCUHAGER.c,1374 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_9);   // KICK MOSFET IRF9530 FOR RELAY 12V
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;RCUHAGER.c,1377 :: 		GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_7);   //
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;RCUHAGER.c,1378 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_3);   //
MOVW	R1, #8
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;RCUHAGER.c,1379 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_4);   //
MOVW	R1, #16
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;RCUHAGER.c,1380 :: 		STAT=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1381 :: 		duphong66_C9=1;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1382 :: 		duphong67_A8=1;
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1384 :: 		duphong88_D7=1;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1385 :: 		duphong89_B3=1;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1386 :: 		duphong90_B4=1;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1388 :: 		usart2_init();
BL	_usart2_init+0
;RCUHAGER.c,1389 :: 		uart4__init();   //baud=57600 rs485 uart 4
BL	_uart4__init+0
;RCUHAGER.c,1392 :: 		flag_setdimmer1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_setdimmer1+0)
MOVT	R0, #hi_addr(_flag_setdimmer1+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1393 :: 		flag_setdimmer2=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_setdimmer2+0)
MOVT	R0, #hi_addr(_flag_setdimmer2+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1394 :: 		flag_button_dim1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_button_dim1+0)
MOVT	R0, #hi_addr(_flag_button_dim1+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1395 :: 		flag_button_dim2=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_button_dim2+0)
MOVT	R0, #hi_addr(_flag_button_dim2+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1396 :: 		BUTTON_DIM_CHANNEL1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL1+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL1+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1397 :: 		BUTTON_DIM_CHANNEL2=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL2+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL2+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1398 :: 		DIMMER_ALL_20PERCENT=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_DIMMER_ALL_20PERCENT+0)
MOVT	R0, #hi_addr(_DIMMER_ALL_20PERCENT+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1399 :: 		status_out_relay=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_status_out_relay+0)
MOVT	R0, #hi_addr(_status_out_relay+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1401 :: 		running_right_curtain=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_running_right_curtain+0)
MOVT	R0, #hi_addr(_running_right_curtain+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1402 :: 		running_left_curtain=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_running_left_curtain+0)
MOVT	R0, #hi_addr(_running_left_curtain+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1403 :: 		running_hold_curtain=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_running_hold_curtain+0)
MOVT	R0, #hi_addr(_running_hold_curtain+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1404 :: 		flag_right_curtain=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_right_curtain+0)
MOVT	R0, #hi_addr(_flag_right_curtain+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1405 :: 		flag_left_curtain=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_left_curtain+0)
MOVT	R0, #hi_addr(_flag_left_curtain+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1406 :: 		flag_hold_curtain=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_hold_curtain+0)
MOVT	R0, #hi_addr(_flag_hold_curtain+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1407 :: 		flag_running_right_done=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_running_right_done+0)
MOVT	R0, #hi_addr(_flag_running_right_done+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1408 :: 		flag_running_left_done=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_running_left_done+0)
MOVT	R0, #hi_addr(_flag_running_left_done+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1409 :: 		counter_running_right=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_counter_running_right+0)
MOVT	R0, #hi_addr(_counter_running_right+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1410 :: 		counter_running_left=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_counter_running_left+0)
MOVT	R0, #hi_addr(_counter_running_left+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1411 :: 		counter_button_curtain=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_counter_button_curtain+0)
MOVT	R0, #hi_addr(_counter_button_curtain+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1423 :: 		timer1_init();
BL	_timer1_init+0
;RCUHAGER.c,1424 :: 		memset(but_state,0,24);
MOVS	R2, #24
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(_but_state+0)
MOVT	R0, #hi_addr(_but_state+0)
BL	_memset+0
;RCUHAGER.c,1442 :: 		SPI1_Init_Advanced(_SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PA567);
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI1_PA567+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI1_PA567+0)
MOVW	R1, #772
MOVS	R0, #2
BL	_SPI1_Init_Advanced+0
;RCUHAGER.c,1443 :: 		settingEthenet();
BL	_settingEthenet+0
;RCUHAGER.c,1445 :: 		delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main426:
SUBS	R7, R7, #1
BNE	L_main426
NOP
NOP
NOP
;RCUHAGER.c,1446 :: 		duphong8_C14=1; // KICK MOSFET IRF9530 FOR RELAY 12
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1448 :: 		RCC_APB1ENR.B11 = 1;            // Enable clock gating for Watchdog Timer 0 module
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1449 :: 		WWDG_CFR = 1;                   // Write window value to be compared to the downcounter
MOVS	R1, #1
MOVW	R0, #lo_addr(WWDG_CFR+0)
MOVT	R0, #hi_addr(WWDG_CFR+0)
STR	R1, [R0, #0]
;RCUHAGER.c,1456 :: 		while(1){
L_main428:
;RCUHAGER.c,1460 :: 		if(flag_setdimmer4){
MOVW	R0, #lo_addr(_flag_setdimmer4+0)
MOVT	R0, #hi_addr(_flag_setdimmer4+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main430
;RCUHAGER.c,1461 :: 		if(BUTTON_DIM_CHANNEL4==0){set_value_dim(0,4);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL4+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL4+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main431
MOVS	R1, #4
MOVS	R0, #0
BL	_set_value_dim+0
L_main431:
;RCUHAGER.c,1462 :: 		if(BUTTON_DIM_CHANNEL4==1){set_value_dim(93,4);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL4+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL4+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main432
MOVS	R1, #4
MOVS	R0, #93
BL	_set_value_dim+0
L_main432:
;RCUHAGER.c,1463 :: 		if(BUTTON_DIM_CHANNEL4==2){set_value_dim(60,4);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL4+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL4+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main433
MOVS	R1, #4
MOVS	R0, #60
BL	_set_value_dim+0
L_main433:
;RCUHAGER.c,1464 :: 		if(BUTTON_DIM_CHANNEL4==3){set_value_dim(45,4);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL4+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL4+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_main434
MOVS	R1, #4
MOVS	R0, #45
BL	_set_value_dim+0
L_main434:
;RCUHAGER.c,1465 :: 		if(BUTTON_DIM_CHANNEL4==4){set_value_dim(35,4);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL4+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL4+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_main435
MOVS	R1, #4
MOVS	R0, #35
BL	_set_value_dim+0
L_main435:
;RCUHAGER.c,1466 :: 		flag_setdimmer4=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_setdimmer4+0)
MOVT	R0, #hi_addr(_flag_setdimmer4+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1467 :: 		}
L_main430:
;RCUHAGER.c,1469 :: 		if(flag_setdimmer3){
MOVW	R0, #lo_addr(_flag_setdimmer3+0)
MOVT	R0, #hi_addr(_flag_setdimmer3+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main436
;RCUHAGER.c,1470 :: 		if(BUTTON_DIM_CHANNEL3==0){set_value_dim(0,3);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL3+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL3+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main437
MOVS	R1, #3
MOVS	R0, #0
BL	_set_value_dim+0
L_main437:
;RCUHAGER.c,1471 :: 		if(BUTTON_DIM_CHANNEL3==1){set_value_dim(93,3);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL3+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL3+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main438
MOVS	R1, #3
MOVS	R0, #93
BL	_set_value_dim+0
L_main438:
;RCUHAGER.c,1472 :: 		if(BUTTON_DIM_CHANNEL3==2){set_value_dim(60,3);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL3+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL3+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main439
MOVS	R1, #3
MOVS	R0, #60
BL	_set_value_dim+0
L_main439:
;RCUHAGER.c,1473 :: 		if(BUTTON_DIM_CHANNEL3==3){set_value_dim(45,3);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL3+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL3+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_main440
MOVS	R1, #3
MOVS	R0, #45
BL	_set_value_dim+0
L_main440:
;RCUHAGER.c,1474 :: 		if(BUTTON_DIM_CHANNEL3==4){set_value_dim(35,3);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL3+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL3+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_main441
MOVS	R1, #3
MOVS	R0, #35
BL	_set_value_dim+0
L_main441:
;RCUHAGER.c,1475 :: 		flag_setdimmer3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_setdimmer3+0)
MOVT	R0, #hi_addr(_flag_setdimmer3+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1476 :: 		}
L_main436:
;RCUHAGER.c,1478 :: 		if(flag_setdimmer2){
MOVW	R0, #lo_addr(_flag_setdimmer2+0)
MOVT	R0, #hi_addr(_flag_setdimmer2+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main442
;RCUHAGER.c,1479 :: 		if(BUTTON_DIM_CHANNEL2==0){set_value_dim(0,2);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL2+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL2+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main443
MOVS	R1, #2
MOVS	R0, #0
BL	_set_value_dim+0
L_main443:
;RCUHAGER.c,1480 :: 		if(BUTTON_DIM_CHANNEL2==1){set_value_dim(93,2);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL2+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL2+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main444
MOVS	R1, #2
MOVS	R0, #93
BL	_set_value_dim+0
L_main444:
;RCUHAGER.c,1481 :: 		if(BUTTON_DIM_CHANNEL2==2){set_value_dim(60,2);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL2+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL2+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main445
MOVS	R1, #2
MOVS	R0, #60
BL	_set_value_dim+0
L_main445:
;RCUHAGER.c,1482 :: 		if(BUTTON_DIM_CHANNEL2==3){set_value_dim(45,2);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL2+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL2+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_main446
MOVS	R1, #2
MOVS	R0, #45
BL	_set_value_dim+0
L_main446:
;RCUHAGER.c,1483 :: 		if(BUTTON_DIM_CHANNEL2==4){set_value_dim(35,2);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL2+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL2+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_main447
MOVS	R1, #2
MOVS	R0, #35
BL	_set_value_dim+0
L_main447:
;RCUHAGER.c,1484 :: 		flag_setdimmer2=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_setdimmer2+0)
MOVT	R0, #hi_addr(_flag_setdimmer2+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1485 :: 		}
L_main442:
;RCUHAGER.c,1487 :: 		if(flag_setdimmer1){
MOVW	R0, #lo_addr(_flag_setdimmer1+0)
MOVT	R0, #hi_addr(_flag_setdimmer1+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main448
;RCUHAGER.c,1488 :: 		if(BUTTON_DIM_CHANNEL1==0){set_value_dim(0,1);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL1+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL1+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main449
MOVS	R1, #1
MOVS	R0, #0
BL	_set_value_dim+0
L_main449:
;RCUHAGER.c,1489 :: 		if(BUTTON_DIM_CHANNEL1==1){set_value_dim(93,1);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL1+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL1+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main450
MOVS	R1, #1
MOVS	R0, #93
BL	_set_value_dim+0
L_main450:
;RCUHAGER.c,1490 :: 		if(BUTTON_DIM_CHANNEL1==2){set_value_dim(60,1);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL1+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL1+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main451
MOVS	R1, #1
MOVS	R0, #60
BL	_set_value_dim+0
L_main451:
;RCUHAGER.c,1491 :: 		if(BUTTON_DIM_CHANNEL1==3){set_value_dim(45,1);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL1+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL1+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_main452
MOVS	R1, #1
MOVS	R0, #45
BL	_set_value_dim+0
L_main452:
;RCUHAGER.c,1492 :: 		if(BUTTON_DIM_CHANNEL1==4){set_value_dim(35,1);}
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL1+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL1+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_main453
MOVS	R1, #1
MOVS	R0, #35
BL	_set_value_dim+0
L_main453:
;RCUHAGER.c,1493 :: 		flag_setdimmer1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_setdimmer1+0)
MOVT	R0, #hi_addr(_flag_setdimmer1+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1494 :: 		}
L_main448:
;RCUHAGER.c,1496 :: 		if(flag_setdimmaster){
MOVW	R0, #lo_addr(_flag_setdimmaster+0)
MOVT	R0, #hi_addr(_flag_setdimmaster+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main454
;RCUHAGER.c,1497 :: 		if(BUTTON_DIM_MASTER==0)
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main455
;RCUHAGER.c,1499 :: 		set_value_dim(0,1);
MOVS	R1, #1
MOVS	R0, #0
BL	_set_value_dim+0
;RCUHAGER.c,1500 :: 		set_value_dim(0,2);
MOVS	R1, #2
MOVS	R0, #0
BL	_set_value_dim+0
;RCUHAGER.c,1501 :: 		set_value_dim(0,3);
MOVS	R1, #3
MOVS	R0, #0
BL	_set_value_dim+0
;RCUHAGER.c,1502 :: 		set_value_dim(0,4);
MOVS	R1, #4
MOVS	R0, #0
BL	_set_value_dim+0
;RCUHAGER.c,1503 :: 		}
L_main455:
;RCUHAGER.c,1504 :: 		if(BUTTON_DIM_MASTER==1)
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main456
;RCUHAGER.c,1506 :: 		set_value_dim(93,1);
MOVS	R1, #1
MOVS	R0, #93
BL	_set_value_dim+0
;RCUHAGER.c,1507 :: 		set_value_dim(93,2);
MOVS	R1, #2
MOVS	R0, #93
BL	_set_value_dim+0
;RCUHAGER.c,1508 :: 		set_value_dim(93,3);
MOVS	R1, #3
MOVS	R0, #93
BL	_set_value_dim+0
;RCUHAGER.c,1509 :: 		set_value_dim(93,4);
MOVS	R1, #4
MOVS	R0, #93
BL	_set_value_dim+0
;RCUHAGER.c,1510 :: 		}
L_main456:
;RCUHAGER.c,1511 :: 		if(BUTTON_DIM_MASTER==2)
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main457
;RCUHAGER.c,1513 :: 		set_value_dim(60,1);
MOVS	R1, #1
MOVS	R0, #60
BL	_set_value_dim+0
;RCUHAGER.c,1514 :: 		set_value_dim(60,2);
MOVS	R1, #2
MOVS	R0, #60
BL	_set_value_dim+0
;RCUHAGER.c,1515 :: 		set_value_dim(60,3);
MOVS	R1, #3
MOVS	R0, #60
BL	_set_value_dim+0
;RCUHAGER.c,1516 :: 		set_value_dim(60,4);
MOVS	R1, #4
MOVS	R0, #60
BL	_set_value_dim+0
;RCUHAGER.c,1517 :: 		}
L_main457:
;RCUHAGER.c,1518 :: 		if(BUTTON_DIM_MASTER==3)
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_main458
;RCUHAGER.c,1520 :: 		set_value_dim(45,1);
MOVS	R1, #1
MOVS	R0, #45
BL	_set_value_dim+0
;RCUHAGER.c,1521 :: 		set_value_dim(45,2);
MOVS	R1, #2
MOVS	R0, #45
BL	_set_value_dim+0
;RCUHAGER.c,1522 :: 		set_value_dim(45,3);
MOVS	R1, #3
MOVS	R0, #45
BL	_set_value_dim+0
;RCUHAGER.c,1523 :: 		set_value_dim(45,4);
MOVS	R1, #4
MOVS	R0, #45
BL	_set_value_dim+0
;RCUHAGER.c,1524 :: 		}
L_main458:
;RCUHAGER.c,1525 :: 		if(BUTTON_DIM_MASTER==4)
MOVW	R0, #lo_addr(_BUTTON_DIM_MASTER+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_MASTER+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_main459
;RCUHAGER.c,1527 :: 		set_value_dim(35,1);
MOVS	R1, #1
MOVS	R0, #35
BL	_set_value_dim+0
;RCUHAGER.c,1528 :: 		set_value_dim(35,2);
MOVS	R1, #2
MOVS	R0, #35
BL	_set_value_dim+0
;RCUHAGER.c,1529 :: 		set_value_dim(35,3);
MOVS	R1, #3
MOVS	R0, #35
BL	_set_value_dim+0
;RCUHAGER.c,1530 :: 		set_value_dim(35,4);
MOVS	R1, #4
MOVS	R0, #35
BL	_set_value_dim+0
;RCUHAGER.c,1531 :: 		}
L_main459:
;RCUHAGER.c,1532 :: 		flag_setdimmaster=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_setdimmaster+0)
MOVT	R0, #hi_addr(_flag_setdimmaster+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1533 :: 		}
L_main454:
;RCUHAGER.c,1536 :: 		if(BELL_ENABLE){
MOVW	R0, #lo_addr(_BELL_ENABLE+0)
MOVT	R0, #hi_addr(_BELL_ENABLE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main460
;RCUHAGER.c,1537 :: 		}
L_main460:
;RCUHAGER.c,1541 :: 		if(DIMMER_ALL_20PERCENT){
MOVW	R0, #lo_addr(_DIMMER_ALL_20PERCENT+0)
MOVT	R0, #hi_addr(_DIMMER_ALL_20PERCENT+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main461
;RCUHAGER.c,1542 :: 		DIMMER_ALL_20PERCENT=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_DIMMER_ALL_20PERCENT+0)
MOVT	R0, #hi_addr(_DIMMER_ALL_20PERCENT+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1543 :: 		set_value_dim(20,2);
MOVS	R1, #2
MOVS	R0, #20
BL	_set_value_dim+0
;RCUHAGER.c,1544 :: 		set_value_dim(20,1);
MOVS	R1, #1
MOVS	R0, #20
BL	_set_value_dim+0
;RCUHAGER.c,1545 :: 		BUTTON_DIM_CHANNEL2=3;  // dang o muc 20%
MOVS	R1, #3
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL2+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL2+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1546 :: 		BUTTON_DIM_CHANNEL1=3;  // dang o muc 20%
MOVS	R1, #3
MOVW	R0, #lo_addr(_BUTTON_DIM_CHANNEL1+0)
MOVT	R0, #hi_addr(_BUTTON_DIM_CHANNEL1+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1547 :: 		}
L_main461:
;RCUHAGER.c,1550 :: 		if(ETHERNET_BUTTON_DEVICE_0==1){
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_0+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_0+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main462
;RCUHAGER.c,1551 :: 		ETHERNET_BUTTON_DEVICE_0=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_0+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_0+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1552 :: 		if(ETHERNET_BUTTON_DIM0==1){VALUE4CHANNEL=35;} //  ASCII "1"
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM0+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM0+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main463
MOVS	R1, #35
MOVW	R0, #lo_addr(_VALUE4CHANNEL+0)
MOVT	R0, #hi_addr(_VALUE4CHANNEL+0)
STRB	R1, [R0, #0]
L_main463:
;RCUHAGER.c,1553 :: 		if(ETHERNET_BUTTON_DIM0==2){VALUE4CHANNEL=45;} //  ASCII "9"
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM0+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM0+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main464
MOVS	R1, #45
MOVW	R0, #lo_addr(_VALUE4CHANNEL+0)
MOVT	R0, #hi_addr(_VALUE4CHANNEL+0)
STRB	R1, [R0, #0]
L_main464:
;RCUHAGER.c,1554 :: 		if(ETHERNET_BUTTON_DIM0==3){VALUE4CHANNEL=60;} //  ASCII "K"
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM0+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM0+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_main465
MOVS	R1, #60
MOVW	R0, #lo_addr(_VALUE4CHANNEL+0)
MOVT	R0, #hi_addr(_VALUE4CHANNEL+0)
STRB	R1, [R0, #0]
L_main465:
;RCUHAGER.c,1555 :: 		if(ETHERNET_BUTTON_DIM0==4){VALUE4CHANNEL=93;} //  ASCII "Z"
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM0+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM0+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_main466
MOVS	R1, #93
MOVW	R0, #lo_addr(_VALUE4CHANNEL+0)
MOVT	R0, #hi_addr(_VALUE4CHANNEL+0)
STRB	R1, [R0, #0]
L_main466:
;RCUHAGER.c,1556 :: 		if(ETHERNET_BUTTON_DIM0>=5){
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM0+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM0+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	CC
BCC	L_main467
;RCUHAGER.c,1557 :: 		ETHERNET_BUTTON_DIM0=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM0+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM0+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1558 :: 		VALUE4CHANNEL=25;}                             //  ASCII "#"
MOVS	R1, #25
MOVW	R0, #lo_addr(_VALUE4CHANNEL+0)
MOVT	R0, #hi_addr(_VALUE4CHANNEL+0)
STRB	R1, [R0, #0]
L_main467:
;RCUHAGER.c,1560 :: 		ETHERNET_BUTTON_DEVICE_1=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_1+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_1+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1561 :: 		ETHERNET_BUTTON_DEVICE_2=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_2+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_2+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1562 :: 		ETHERNET_BUTTON_DEVICE_3=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_3+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_3+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1563 :: 		ETHERNET_BUTTON_DEVICE_4=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_4+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_4+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1564 :: 		out_relay^=RELAY_16;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #32768
STR	R0, [R1, #0]
;RCUHAGER.c,1565 :: 		}
L_main462:
;RCUHAGER.c,1566 :: 		if(ETHERNET_BUTTON_DEVICE_1==1){
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_1+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_1+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main468
;RCUHAGER.c,1567 :: 		ETHERNET_BUTTON_DEVICE_1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_1+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_1+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1568 :: 		if(ETHERNET_BUTTON_DIM1)
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM1+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM1+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main469
;RCUHAGER.c,1570 :: 		out_relay|=RELAY_1;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #1
STR	R0, [R1, #0]
;RCUHAGER.c,1571 :: 		set_value_dim(VALUE4CHANNEL,1);
MOVW	R0, #lo_addr(_VALUE4CHANNEL+0)
MOVT	R0, #hi_addr(_VALUE4CHANNEL+0)
LDRB	R0, [R0, #0]
MOVS	R1, #1
BL	_set_value_dim+0
;RCUHAGER.c,1572 :: 		}
L_main469:
;RCUHAGER.c,1573 :: 		if(!ETHERNET_BUTTON_DIM1)
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM1+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM1+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main470
;RCUHAGER.c,1575 :: 		out_relay&=~RELAY_1;
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #1
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;RCUHAGER.c,1576 :: 		set_value_dim(0,1);
MOVS	R1, #1
MOVS	R0, #0
BL	_set_value_dim+0
;RCUHAGER.c,1577 :: 		}
L_main470:
;RCUHAGER.c,1578 :: 		}
L_main468:
;RCUHAGER.c,1579 :: 		if(ETHERNET_BUTTON_DEVICE_2==1){
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_2+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_2+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main471
;RCUHAGER.c,1580 :: 		ETHERNET_BUTTON_DEVICE_2=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_2+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_2+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1581 :: 		if(ETHERNET_BUTTON_DIM2)
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM2+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM2+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main472
;RCUHAGER.c,1583 :: 		out_relay|=RELAY_2;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #2
STR	R0, [R1, #0]
;RCUHAGER.c,1584 :: 		set_value_dim(VALUE4CHANNEL,2);
MOVW	R0, #lo_addr(_VALUE4CHANNEL+0)
MOVT	R0, #hi_addr(_VALUE4CHANNEL+0)
LDRB	R0, [R0, #0]
MOVS	R1, #2
BL	_set_value_dim+0
;RCUHAGER.c,1585 :: 		}
L_main472:
;RCUHAGER.c,1586 :: 		if(!ETHERNET_BUTTON_DIM2)
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM2+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM2+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main473
;RCUHAGER.c,1588 :: 		out_relay&=~RELAY_2;
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #2
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;RCUHAGER.c,1589 :: 		set_value_dim(0,2);
MOVS	R1, #2
MOVS	R0, #0
BL	_set_value_dim+0
;RCUHAGER.c,1590 :: 		}
L_main473:
;RCUHAGER.c,1591 :: 		}
L_main471:
;RCUHAGER.c,1592 :: 		if(ETHERNET_BUTTON_DEVICE_3==1){
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_3+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_3+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main474
;RCUHAGER.c,1593 :: 		ETHERNET_BUTTON_DEVICE_3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_3+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_3+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1594 :: 		if(ETHERNET_BUTTON_DIM3)
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM3+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM3+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main475
;RCUHAGER.c,1596 :: 		out_relay|=RELAY_3;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #4
STR	R0, [R1, #0]
;RCUHAGER.c,1597 :: 		set_value_dim(VALUE4CHANNEL,3);
MOVW	R0, #lo_addr(_VALUE4CHANNEL+0)
MOVT	R0, #hi_addr(_VALUE4CHANNEL+0)
LDRB	R0, [R0, #0]
MOVS	R1, #3
BL	_set_value_dim+0
;RCUHAGER.c,1598 :: 		}
L_main475:
;RCUHAGER.c,1599 :: 		if(!ETHERNET_BUTTON_DIM3)
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM3+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM3+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main476
;RCUHAGER.c,1601 :: 		out_relay&=~RELAY_3;
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #4
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;RCUHAGER.c,1602 :: 		set_value_dim(0,3);
MOVS	R1, #3
MOVS	R0, #0
BL	_set_value_dim+0
;RCUHAGER.c,1603 :: 		}
L_main476:
;RCUHAGER.c,1604 :: 		}
L_main474:
;RCUHAGER.c,1605 :: 		if(ETHERNET_BUTTON_DEVICE_4==1){
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_4+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_4+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main477
;RCUHAGER.c,1606 :: 		ETHERNET_BUTTON_DEVICE_4=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DEVICE_4+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DEVICE_4+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1607 :: 		if(ETHERNET_BUTTON_DIM4)
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM4+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM4+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main478
;RCUHAGER.c,1609 :: 		out_relay|=RELAY_15;
MOVW	R1, #lo_addr(_out_relay+0)
MOVT	R1, #hi_addr(_out_relay+0)
LDR	R0, [R1, #0]
ORR	R0, R0, #16384
STR	R0, [R1, #0]
;RCUHAGER.c,1610 :: 		set_value_dim(VALUE4CHANNEL,4);
MOVW	R0, #lo_addr(_VALUE4CHANNEL+0)
MOVT	R0, #hi_addr(_VALUE4CHANNEL+0)
LDRB	R0, [R0, #0]
MOVS	R1, #4
BL	_set_value_dim+0
;RCUHAGER.c,1611 :: 		}
L_main478:
;RCUHAGER.c,1612 :: 		if(!ETHERNET_BUTTON_DIM4)
MOVW	R0, #lo_addr(_ETHERNET_BUTTON_DIM4+0)
MOVT	R0, #hi_addr(_ETHERNET_BUTTON_DIM4+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main479
;RCUHAGER.c,1614 :: 		out_relay&=~RELAY_15;
MOVW	R2, #lo_addr(_out_relay+0)
MOVT	R2, #hi_addr(_out_relay+0)
LDR	R1, [R2, #0]
MVN	R0, #16384
AND	R0, R1, R0, LSL #0
STR	R0, [R2, #0]
;RCUHAGER.c,1615 :: 		set_value_dim(0,4);
MOVS	R1, #4
MOVS	R0, #0
BL	_set_value_dim+0
;RCUHAGER.c,1616 :: 		}
L_main479:
;RCUHAGER.c,1617 :: 		}
L_main477:
;RCUHAGER.c,1833 :: 		SPI_Ethernet_doPacket();
BL	_SPI_Ethernet_doPacket+0
;RCUHAGER.c,1835 :: 		if(flag_reset_ip==1){
MOVW	R0, #lo_addr(_flag_reset_ip+0)
MOVT	R0, #hi_addr(_flag_reset_ip+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main480
;RCUHAGER.c,1836 :: 		flag_reset_ip=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_reset_ip+0)
MOVT	R0, #hi_addr(_flag_reset_ip+0)
STRB	R1, [R0, #0]
;RCUHAGER.c,1837 :: 		goto RESET;
IT	AL
BAL	___main_RESET
;RCUHAGER.c,1838 :: 		}
L_main480:
;RCUHAGER.c,1857 :: 		}
IT	AL
BAL	L_main428
;RCUHAGER.c,1858 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
