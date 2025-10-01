#line 1 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
#line 1 "c:/users/lenovo/desktop/t9-euro nhatrang/v9-eurowd-rcu2(sla)(9600-20ms)-keyacin/main.h"
#line 1 "c:/users/lenovo/desktop/t9-euro nhatrang/v9-eurowd-rcu2(sla)(9600-20ms)-keyacin/init.c"
#line 1 "c:/users/lenovo/desktop/t9-euro nhatrang/v9-eurowd-rcu2(sla)(9600-20ms)-keyacin/init.h"
#line 19 "c:/users/lenovo/desktop/t9-euro nhatrang/v9-eurowd-rcu2(sla)(9600-20ms)-keyacin/init.h"
void xuat_32bit(unsigned long data_dich);
void usart1_init();
void uart1_chr(unsigned char data_usart1_tx);
void uart1_string(unsigned char *s);
void usart2_init();
void uart2_chr(unsigned char data_usart2_tx);
void uart2_string(unsigned char *s);
void uart4__init();
void uart4_chr(unsigned char data_usart4_tx);
void uart4_string(unsigned char *s);
void timer1_init();
void gpio_init();
void rs485_u4(unsigned char buf_rs4[],unsigned int count_buf);
void set_value_dim(unsigned char value_dim,unsigned char channel);
unsigned long chuoi_so(unsigned char *so,unsigned char vt_bd,unsigned char vt_kt);
unsigned int get_point(unsigned char *s,unsigned int start,unsigned int end);
#line 2 "c:/users/lenovo/desktop/t9-euro nhatrang/v9-eurowd-rcu2(sla)(9600-20ms)-keyacin/init.c"
void xuat_32bit(unsigned long data_dich){
 unsigned char vt_dich=32;
 unsigned long shift_data=data_dich;
  GPIOD_ODR.B1 =1;
 do{
 vt_dich--;
  GPIOD_ODR.B2 =(shift_data>>vt_dich);
  GPIOC_ODR.B12 =0; GPIOC_ODR.B12 =1; 
 Delay_us(10);
 }while(vt_dich>0);
  GPIOD_ODR.B1 =0;
  GPIOD_ODR.B0 =0; GPIOD_ODR.B0 =1; 
 Delay_us(10);
}

void timer1_init(){
 TIM1_CR1bits.DIR_=0;
 TIM1_CR1bits.ARPE=0;
 TIM1_CR1bits.OPM=0;
 TIM1_PSC=10000;
 TIM1_ARR=144;


 TIM1_CNT=0;
 TIM1_DIERbits.UIE=1;
 NVIC_SETENA0bits.SETENA25=1;
 NVIC_IP6bits.PRI_25=0x00;
 TIM1_CR1bits.CEN=1;
 NVIC_IP8bits.PRI_32=0xf0;
}

void usart1_init(){
 USART1_CR1bits.UE=1;
 USART1_CR1bits.M=0;
 USART1_CR1bits.PCE=0;
 USART1_CR1bits.RXNEIE=1;
 USART1_CR1bits.RE=1;
 USART1_CR1bits.TE=1;
 USART1_BRR=0X1D4C;
 USART1_CR2=0;
 USART1_CR3=0;

 NVIC_SETENA1bits.SETENA37=1;
 NVIC_IP11bits.PRI_44=0x10;
}

void uart1_chr(unsigned char data_usart1_tx){
 while(USART1_SRbits.TC==0);
 USART1_DRbits.DR=data_usart1_tx;
}
void uart1_string(unsigned char *s){
 while(*s){
 uart1_chr(*s++);
 }
}

void uart4__init(){

 UART4_CR1bits.UE=1;
 UART4_CR1bits.M=0;
 UART4_CR1bits.PCE=0;
 UART4_CR1bits.RXNEIE=1;
 UART4_CR1bits.RE=1;
 UART4_CR1bits.TE=1;
 UART4_BRR=0X1D4C;


 UART4_CR2=0;
 UART4_CR3=0;

 NVIC_SETENA1bits.SETENA52=1;
 NVIC_IP14bits.PRI_59=0x00;
}

void uart4_chr(unsigned char data_usart4_tx){
 while(UART4_SRbits.TC==0);
 UART4_DRbits.DR=data_usart4_tx;
}

void rs485_u4(unsigned char buf_rs4[],unsigned int count_buf){
 unsigned char i = 0;
 UART4_CR1bits.RE=0;
  GPIOA_ODR.B15 =1; 
 for (i = 0; i < count_buf; i++) {
 while(UART4_SRbits.TC==0);
 UART4_DRbits.DR = buf_rs4[i];

 }
 while(UART4_SRbits.TC==0);
  GPIOA_ODR.B15 =0; 
 UART4_CR1bits.RE=1;
}

void uart4_string(unsigned char *s){
 while(*s){
 uart4_chr(*s++);
 }
}

void usart2_init(){
 USART2_CR1bits.UE=1;
 USART2_BRR=0X1D4C;
 USART2_CR1bits.M=0;
 USART2_CR1bits.PCE=0;
 USART2_CR1bits.RXNEIE=1;
 USART2_CR1bits.RE=1;
 USART2_CR1bits.TE=1;
 USART2_CR2=0;
 USART2_CR3=0;



}

void uart2_chr(unsigned char data_usart2_tx){
 while(USART2_SRbits.TC==0);
 USART2_DR=data_usart2_tx;
}
void uart2_string(unsigned char *s){
 while(*s){
 uart2_chr(*s++);
 }
}

void set_value_dim(unsigned char value_dim,unsigned char channel){
 unsigned char data_dim[3]={0xfa,0x00,0x00},k;
 data_dim[1]=channel;
 data_dim[2]=value_dim;
 for(k=0;k<3;k++){
 uart2_chr(data_dim[k]);
 }
}

void gpio_init(){
 RCC_APB2ENR=(1<<AFIOEN)|(1<<IOPAEN)|(1<<IOPBEN)|(1<<IOPCEN)|(1<<IOPDEN)|(1<<IOPEEN)|(1<<TIM1EN)|(1<<SPI1EN)|(1<<USART1EN);
 RCC_APB1ENR=(1<<UART4EN)|(1<<USART2EN);

 AFIO_MAPR|=0x02000000;

 GPIOA_CRL&=0xffff0000;
 GPIOA_CRL|=0x00004938;
 GPIOA_CRH&=0x0ff00000;
 GPIOA_CRH|=0x30003490;
 GPIOA_ODR=0;
 GPIOA_ODR|=0B0000000000000001;

 GPIOB_CRL&=0x00fff000;
 GPIOB_CRL|=0x38000383;
 GPIOB_CRH=0;
 GPIOB_CRH|=0x83838338;
 GPIOB_ODR=0;
 GPIOB_ODR|=0B1010100101000010;

 GPIOC_CRL&=0x000f0000;
 GPIOC_CRL|=0x83803838;
 GPIOC_CRH&=0xff0000f0;
 GPIOC_CRH|=0x00234903;
 GPIOC_ODR=0;
 GPIOC_ODR|=0B0000000010100101;

 GPIOD_CRL&=0xff000000;
 GPIOD_CRL|=0x00833333;
 GPIOD_CRH=0;
 GPIOD_CRH|=0x83838383;
 GPIOD_ODR=0;
 GPIOD_ODR|=0B1010101000100000;

 GPIOE_CRL=0;
 GPIOE_CRL|=0x88383838;
 GPIOE_CRH=0;
 GPIOE_CRH|=0x83838383;
 GPIOE_ODR=0;
 GPIOE_ODR|=0B1010101011010101;
 GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_7);
}
unsigned long chuoi_so(unsigned char *so,unsigned char vt_bd,unsigned char vt_kt){
 unsigned char sb;
 unsigned long gt_so;
 gt_so=0;
 for(sb=vt_bd;sb<=vt_kt;sb++){
 gt_so*=10;
 gt_so+=(*(so+sb)-0x30);
 }
 return gt_so;
}
unsigned char get_point(unsigned char *s,unsigned char start,unsigned char end){
 unsigned char locate_point=0;
 for(locate_point=start;locate_point<end;locate_point++){
 if((*(s+start)=='.')||(*(s+start)==' ')){
 break;
 }
 s++;
 }
 return locate_point;
}
#line 1 "c:/users/lenovo/desktop/t9-euro nhatrang/v9-eurowd-rcu2(sla)(9600-20ms)-keyacin/__ethenc28j60.h"
#line 119 "c:/users/lenovo/desktop/t9-euro nhatrang/v9-eurowd-rcu2(sla)(9600-20ms)-keyacin/__ethenc28j60.h"
typedef struct
 {
 unsigned char valid;
 unsigned long tmr;
 unsigned char ip[4];
 unsigned char mac[6];
 } SPI_Ethernet_arpCacheStruct;

extern SPI_Ethernet_arpCacheStruct SPI_Ethernet_arpCache[];

extern unsigned char SPI_Ethernet_macAddr[6];
extern unsigned char SPI_Ethernet_ipAddr[4];
extern unsigned char SPI_Ethernet_gwIpAddr[4];
extern unsigned char SPI_Ethernet_ipMask[4];
extern unsigned char SPI_Ethernet_dnsIpAddr[4];
extern unsigned char SPI_Ethernet_rmtIpAddr[4];

extern unsigned long SPI_Ethernet_userTimerSec;

typedef struct {
 unsigned canCloseTCP: 1;
 unsigned isBroadcast: 1;
} TEthPktFlags;
#line 146 "c:/users/lenovo/desktop/t9-euro nhatrang/v9-eurowd-rcu2(sla)(9600-20ms)-keyacin/__ethenc28j60.h"
extern void SPI_Ethernet_Init(unsigned char *resetPort, unsigned char resetBit, unsigned char *CSport, unsigned char CSbit, unsigned char *mac, unsigned char *ip, unsigned char fullDuplex);
extern unsigned char SPI_Ethernet_doPacket();
extern void SPI_Ethernet_putByte(unsigned char b);
extern void SPI_Ethernet_putBytes(unsigned char *ptr, unsigned int n);
extern void SPI_Ethernet_putConstBytes(const unsigned char *ptr, unsigned int n);
extern unsigned char SPI_Ethernet_getByte();
extern void SPI_Ethernet_getBytes(unsigned char *ptr, unsigned int addr, unsigned int n);
extern unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags * flags);
extern unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags * flags);
extern void SPI_Ethernet_confNetwork(char *ipMask, char *gwIpAddr, char *dnsIpAddr);
#line 89 "c:/users/lenovo/desktop/t9-euro nhatrang/v9-eurowd-rcu2(sla)(9600-20ms)-keyacin/main.h"
unsigned char but_sample[25][ 2 ];
unsigned char but_state[25];
unsigned char but_status[25];
unsigned char but_sum_sample[25];








unsigned int count_time_but2=0;
unsigned char flag_enable_but2=0;
unsigned int flag_but_master= 2 ;
#line 199 "c:/users/lenovo/desktop/t9-euro nhatrang/v9-eurowd-rcu2(sla)(9600-20ms)-keyacin/main.h"
unsigned char buf_rc_u4[6],count_buf_rc_4=0,status_but_touch=0xff,channel_touch=0xff,touch_but=0xff;
unsigned int status_led_touch=0,status_led_touch_save=0;
#line 214 "c:/users/lenovo/desktop/t9-euro nhatrang/v9-eurowd-rcu2(sla)(9600-20ms)-keyacin/main.h"
unsigned char value_dimer=0,count_but_dimer=0,flag_but_dimer=0,value_dimer_save=100,flag_dimer_up_down= 0 ;



unsigned long value_count_time_curtain=0;
unsigned char flag_count_curtain=0,flag_curtain_direction=0;





unsigned long count_time_fan=0,flag_count_time_fan=0;
unsigned char flag_fan_speed=0;




unsigned long wed_status_button=0;
unsigned char flag_reset_ip=0,flag_new_rec=0,flag_response_wed=0;
unsigned long status_wed_service=0,status_wed_light=0,status_wed_curtain=0,status_wed_scenes=0;
unsigned long status_wed_fan=0,status_wed_dimer=0;
enum page{
 Page_Login=0,
 Page_Service,
 Page_Lighting,
 Page_Curtain,
 Page_Scenes,
 Page_Fan_Speed,
 Page_Dimer_Extant,
 Page_Device_Extant,
 Page_Setting,
 Page_Home,
 Page_Info,
 Page_Erro
};

void response_touch(unsigned int status_response);
void process_touch();






unsigned char flag_dimer_ex[4]={0,0,0,0};
unsigned char flag_dimer_ex_up_down[4]={ 1 , 1 , 1 , 1 };
unsigned long count_time_dimer_ex[4]={0,0,0,0};
unsigned char value_dimer_ex[4]={0,0,0,0};
#line 5 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
sfr sbit SPI_Ethernet_Rst at GPIOC_ODR.B4;
sfr sbit SPI_Ethernet_CS at GPIOA_ODR.B4;
sfr sbit STAT at GPIOA_ODR.B12;
sfr sbit duphong8_C14 at GPIOC_ODR.B14;
sfr sbit duphong9_C15 at GPIOC_ODR.B15;
sfr sbit duphong66_C9 at GPIOC_ODR.B9;
sfr sbit duphong67_A8 at GPIOA_ODR.B8;

sfr sbit duphong88_D7 at GPIOD_ODR.B7;
sfr sbit duphong89_B3 at GPIOB_ODR.B3;
sfr sbit duphong90_B4 at GPIOB_ODR.B4;

const code unsigned char httpHeader[] = "HTTP/1.1 200 OK\nContent-type: ";
const code unsigned char httpMimeTypeHTML[] = "text/html\n\n";
const code unsigned char httpMimeTypeScript[] = "text/plain\n\n";
unsigned char httpMethod[] = "GET /";

const code char *LoginPage =
#line 28 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
"<html><head></head><title>Login Page</title><h1>NHATRANG EUROWINDOW-<br>IP: -<br>MAC:-</h1></body></html>";

const code char *indexPage =
#line 32 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
"</html>" ;
const code char *HomePage =
#line 35 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
"</html>" ;
const code char *ServicePage =
#line 38 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
"</html>" ;

const code char *LightingPage =
#line 42 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
"</html>" ;
const code char *CurtainPage =
#line 45 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
"</html>" ;
const code char *ScenesPage =
#line 48 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
"</html>" ;
const code char *Fan_SpeedPage =
#line 51 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
"</html>" ;

const code char *Dimer_ExtantPage =
#line 55 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
"</html>" ;

const code char *Device_ExtantPage =
#line 59 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
"</html>" ;

const code char *SettingPage =
#line 63 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
"</html>";


unsigned char myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x18, 0x00};
unsigned char myIpAddr[4] = {192,168,1,120};


unsigned char gwIpAddr[4];
unsigned char ipMask[4] = {255, 255, 255, 0 };
unsigned char dnsIpAddr[4] = {192, 168, 1, 1 };
unsigned char getRequest[100];
unsigned char dyna[40] ;
unsigned char buf[40];
unsigned char HOPTEST[16];
unsigned int index_page=7;
unsigned char ipAddress[4];
unsigned long Address = 0x08008000,i,temp,checkConnect=0;
unsigned long* ptr;
unsigned long out_relay=0;
unsigned char curtain;
unsigned char flag_all_dimer_percent=0;
unsigned char DELAY_SEND_DIMMER=0;
unsigned char PERCENT_DIMMER=0;
unsigned char DATA_TRUE,PROCESSING_RS485,RESPOND_PROCESSING_RS485;
unsigned char MASTER_SWITCH=0;
unsigned char MASTER_BEDROOM=0;
unsigned char MASTER_BEDROOM_STATUS=0;
unsigned char AMBIENT_BEDROOM=0;
unsigned char AMBIENT_STATUS=0;
unsigned char ACCENT_BEDROOM=0;
unsigned char ACCENT_STATUS=0;
unsigned char RS485_CONTROL_S9_S11=0;
unsigned char RS485_CONTROL_S9=0;
unsigned char RS485_CONTROL_S10=0;
unsigned char RS485_STATUS_S9_S11=0;
unsigned char RS485_STATUS_S9=0;
unsigned char RS485_STATUS_S10=0;

unsigned char DO_NOT_DISTURB=0;
unsigned char KEYCARD_ENABLE=0;
unsigned char KEYCARD_INSERT=0;
unsigned long KEYCARD_COUNTER=0;
unsigned long KEYCARD_COUNTER_CLOSE=0;
unsigned long BELL_COUNTER=0;
unsigned char BELL_ENABLE=0;
unsigned char DIM4_EVERGREEN=0;
unsigned char DIM2_EVERGREEN=0;
unsigned char FLAG_CURTAIN_STOP=0;
unsigned long sameold_out_relay=0;
unsigned long TIME_OUT=0;
unsigned char TIMEOUT_RELAY_1=0;
unsigned char TIMEOUT_RELAY_2=0;
unsigned char TIMEOUT_RELAY_3=0;
unsigned char TIMEOUT_RELAY_4=0;
unsigned char TIMEOUT_RELAY_5=0;
unsigned char TIMEOUT_RELAY_6=0;
unsigned char TIMEOUT_RELAY_7=0;
unsigned char TIMEOUT_RELAY_8=0;
unsigned char TIMEOUT_RELAY_16=0;
unsigned char TIMEOUT_RELAY_15=0;
unsigned char TIMEOUT_RELAY_14=0;
unsigned char TIMEOUT_RELAY_13=0;
unsigned char TIMEOUT_RELAY_12=0;
unsigned char TIMEOUT_RELAY_11=0;
unsigned char TIMEOUT_RELAY_10=0;
unsigned char TIMEOUT_RELAY_9=0;

void putChar(unsigned char c){
 while(UART4_SRbits.TC==0);
 UART4_DRbits.DR = c;
}

void timer1_isr() iv IVT_INT_TIM1_UP ics ICS_AUTO {
 unsigned char i_isr=0,but_isr=0;


 unsigned long shift=1;

 if(TIM1_SRbits.UIF==1)
 {
 TIM1_SRbits.UIF=0;


 but_sample[0][ 2 -1]=! GPIOE_IDR.B2 ;
 but_sample[1][ 2 -1]=! GPIOE_IDR.B4 ;
 but_sample[2][ 2 -1]=! GPIOE_IDR.B6 ;

 but_sample[3][ 2 -1]=! GPIOC_IDR.B0 ;
 but_sample[4][ 2 -1]=! GPIOC_IDR.B2 ;
 but_sample[5][ 2 -1]=! GPIOA_IDR.B0 ;

 but_sample[6][ 2 -1]=! GPIOC_IDR.B5 ;
 but_sample[7][ 2 -1]=! GPIOB_IDR.B1 ;
 but_sample[8][ 2 -1]=! GPIOE_IDR.B7 ;

 but_sample[9][ 2 -1]=! GPIOE_IDR.B9 ;
 but_sample[10][ 2 -1]=! GPIOE_IDR.B11 ;

 but_sample[11][ 2 -1]=! GPIOE_IDR.B13 ;
 but_sample[12][ 2 -1]=! GPIOE_IDR.B15 ;

 but_sample[13][ 2 -1]=! GPIOB_IDR.B11 ;

 but_sample[14][ 2 -1]=! GPIOB_IDR.B13 ;

 but_sample[15][ 2 -1]=! GPIOB_IDR.B15 ;
 but_sample[16][ 2 -1]=! GPIOD_IDR.B9 ;

 but_sample[17][ 2 -1]=! GPIOD_IDR.B11 ;
 but_sample[18][ 2 -1]=! GPIOD_IDR.B13 ;

 but_sample[19][ 2 -1]=! GPIOD_IDR.B15 ;
 but_sample[20][ 2 -1]=! GPIOC_IDR.B7 ;

 but_sample[21][ 2 -1]=! GPIOB_IDR.B6 ;
 but_sample[22][ 2 -1]=! GPIOB_IDR.B8 ;

 but_sample[23][ 2 -1]=! GPIOE_IDR.B0 ;

 but_sample[24][ 2 -1]=! GPIOD_IDR.B6 ;

 for(but_isr=0;but_isr< 25 ;but_isr++){
 for(i_isr=0;i_isr< 2 -1;i_isr++){
 but_sample[but_isr][i_isr]=but_sample[but_isr][i_isr+1];
 }
 but_sum_sample[but_isr]=0;
 for(i_isr=0;i_isr< 2 ;i_isr++){
 but_sum_sample[but_isr]+=but_sample[but_isr][i_isr];
 }
 if(but_sum_sample[but_isr]>= 2 ){
 but_state[but_isr]= 2 ;
 }
 else if(but_sum_sample[but_isr]== 0 ){
 but_state[but_isr]= 0 ;
 }
 if(but_state[but_isr]== 2 ){
 if(but_status[but_isr]== 0 ){
 but_status[but_isr]= 5 ;
 }
 else if(but_status[but_isr]== 5 ){
 but_status[but_isr]= 6 ;
 }
 else if(but_status[but_isr]== 6 ){
 but_status[but_isr]= 6 ;
 }
 }
 else if(but_state[but_isr]== 0 ){
 if ((but_status[but_isr]== 6 )||(but_status[but_isr]== 5 )){
 but_status[but_isr]= 4 ;
 }
 else if(but_status[but_isr]== 4 ){
 but_status[but_isr]= 0 ;
 }
 else if(but_status[but_isr]== 0 ){
 but_status[but_isr]= 0 ;
 }
 }
 }
#line 250 "C:/Users/Lenovo/Desktop/T9-EURO NHATRANG/V9-EUROWD-RCU2(SLA)(9600-20MS)-KeyACin/botrungtam.c"
 duphong67_A8=~duphong67_A8;



 if(but_status[0]== 5 ){

 }
 else if(but_status[0]== 4 ){

 }

 if(but_status[1]== 5 ){


 RS485_CONTROL_S9_S11=1;
 RS485_STATUS_S9_S11^=1;
 }
 else if(but_status[1]== 4 ){

 }

 if(but_status[2]== 5 ){

 RS485_CONTROL_S10=1;
 RS485_STATUS_S10^=1;
 }
 else if(but_status[2]== 4 ){

 }


 if(but_status[3]== 5 ){

 }
 else if(but_status[3]== 4 ){

 }

 if(but_status[4]== 5 ){



 AMBIENT_BEDROOM=1;
 AMBIENT_STATUS^=1;
 }
 else if(but_status[4]== 4 ){

 }

 if(but_status[5]== 5 ){

 ACCENT_BEDROOM=1;
 ACCENT_STATUS^=1;
 }
 else if(but_status[5]== 4 ){

 }



 if(but_status[6]== 5 ){

 }
 else if(but_status[6]== 4 ){

 }

 if(but_status[7]== 5 ){


 RS485_CONTROL_S9=1;
 RS485_STATUS_S9^=1;

 }
 else if(but_status[7]== 4 ){


 }

 if(but_status[8]== 5 ){
  GPIOB_ODR.B2 =1;
 out_relay^= 0b00000000000000000000000000000010 ;
 }
 else if(but_status[8]== 4 ){
  GPIOB_ODR.B2 =(out_relay& 0b00000000000000000000000000000010 )?1:0;
 }


 if(but_status[9]== 5 ){

 AMBIENT_BEDROOM=1;
 AMBIENT_STATUS^=1;
 }
 else if(but_status[9]== 4 ){



 }

 if(but_status[10]== 5 ){


 ACCENT_BEDROOM=1;
 ACCENT_STATUS^=1;
 }
 else if(but_status[10]== 4 ){


 }




 if(but_status[11]== 5 ){
  GPIOE_ODR.B14 =1;

 RS485_CONTROL_S9=1;
 RS485_STATUS_S9^=1;
 }
 else if(but_status[11]== 4 ){


 }

 if(but_status[12]== 5 ){
  GPIOB_ODR.B10 =1;
 out_relay^= 0b00000000000000000000000000000001 ;
 }
 else if(but_status[12]== 4 ){
  GPIOB_ODR.B10 =(out_relay& 0b00000000000000000000000000000001 )?1:0;
 }



 if(but_status[13]== 5 ){
  GPIOB_ODR.B12 =1;
 out_relay^= 0b00000000000000001000000000000000 ;
 }
 else if(but_status[13]== 4 ){
  GPIOB_ODR.B12 =(out_relay& 0b00000000000000001000000000000000 )?1:0;
 }


 if(but_status[14]== 5 ){

 MASTER_BEDROOM=1;
 MASTER_BEDROOM_STATUS^=1;

 }
 else if(but_status[14]== 4 ){

 }


 if(but_status[15]== 5 ){

 AMBIENT_BEDROOM=1;
 AMBIENT_STATUS^=1;
 }
 else if(but_status[15]== 4 ){

 }


 if(but_status[16]== 5 ){

 ACCENT_BEDROOM=1;
 ACCENT_STATUS^=1;
 }
 else if(but_status[16]== 4 ){


 }


 if(but_status[17]== 5 ){

 }
 else if(but_status[17]== 4 ){

 }


 if(but_status[18]== 5 ){

 }
 else if(but_status[18]== 4 ){

 }


 if(but_status[19]== 5 ){

 }
 else if(but_status[19]== 4 ){

 }

 if(but_status[20]== 5 ){

 }
 else if(but_status[20]== 4 ){

 }


 if(but_status[21]== 5 ){

 }
 else if(but_status[21]== 4 ){

 }

 if(but_status[22]== 5 ){

 }
 else if(but_status[22]== 4 ){

 }


 if(but_status[23]== 5 ){

 MASTER_BEDROOM=1;
 MASTER_BEDROOM_STATUS^=1;
 }
 else if(but_status[23]== 4 ){


 }


 if(but_status[24]== 5 ){
 STAT = 1;
 KEYCARD_INSERT=1;
 KEYCARD_ENABLE=1;
 }
 else if(but_status[24]== 4 ){
 STAT = 0;
 KEYCARD_INSERT=0;
 }

 if(KEYCARD_ENABLE==1){

 if(MASTER_BEDROOM==1){
 if( MASTER_BEDROOM_STATUS!=0){

 out_relay|= 0b00000000000000000000000001000000 ;
 out_relay|= 0b00000000000000000000000000100000 ;
 out_relay|= 0b00000000000000000000000000000100 ;
  GPIOE_ODR.B1 =1;
  GPIOB_ODR.B14 =1;
  GPIOC_ODR.B3 =1;
  GPIOE_ODR.B8 =1;
  GPIOD_ODR.B8 =1;
  GPIOA_ODR.B1 =1;
  GPIOE_ODR.B10 =1;
  GPIOD_ODR.B10 =1;
 }
 if( MASTER_BEDROOM_STATUS==0){

 out_relay&=~ 0b00000000000000000000000001000000 ;
 out_relay&=~ 0b00000000000000000000000000100000 ;
 out_relay&=~ 0b00000000000000000000000000000100 ;
  GPIOE_ODR.B1 =0;
  GPIOB_ODR.B14 =0;
  GPIOC_ODR.B3 =0;
  GPIOE_ODR.B8 =0;
  GPIOD_ODR.B8 =0;
  GPIOA_ODR.B1 =0;
  GPIOE_ODR.B10 =0;
  GPIOD_ODR.B10 =0;
 }
 MASTER_BEDROOM=0;
 }

 if(AMBIENT_BEDROOM==1){
 if( AMBIENT_STATUS!=0){

 out_relay|= 0b00000000000000000000000001000000 ;
 out_relay|= 0b00000000000000000000000000100000 ;
  GPIOC_ODR.B3 =1;
  GPIOE_ODR.B8 =1;
  GPIOD_ODR.B8 =1;
 }
 if(AMBIENT_STATUS==0){

 out_relay&=~ 0b00000000000000000000000001000000 ;
 out_relay&=~ 0b00000000000000000000000000100000 ;
  GPIOC_ODR.B3 =0;
  GPIOE_ODR.B8 =0;
  GPIOD_ODR.B8 =0;
 }
 AMBIENT_BEDROOM=0;
 }

 if(ACCENT_BEDROOM==1){
 if( ACCENT_STATUS!=0){

 out_relay|= 0b00000000000000000000000000000100 ;
  GPIOA_ODR.B1 =1;
  GPIOE_ODR.B10 =1;
  GPIOD_ODR.B10 =1;
 }
 if(ACCENT_STATUS==0){

 out_relay&=~ 0b00000000000000000000000000000100 ;
  GPIOA_ODR.B1 =0;
  GPIOE_ODR.B10 =0;
  GPIOD_ODR.B10 =0;
 }
 ACCENT_BEDROOM=0;
 }
 xuat_32bit(out_relay);
 }

 if(KEYCARD_ENABLE==0)
 {out_relay=0;
 ACCENT_STATUS=0;
 AMBIENT_STATUS=0;
 MASTER_BEDROOM_STATUS=0;
 RS485_CONTROL_S9=0;
 RS485_CONTROL_S10=0;
 RS485_CONTROL_S9_S11=0;
 RS485_STATUS_S9=0;
 RS485_STATUS_S10=0;
 RS485_STATUS_S9_S11=0;
 xuat_32bit(out_relay);
 }
 }
}

void uart4_rx() iv IVT_INT_UART4 ics ICS_AUTO {
 unsigned char data_rc;

 if(UART4_SRbits.RXNE){
 UART4_SRbits.RXNE=0;
 data_rc=UART4_DRbits.DR;



 if(DATA_TRUE){
 buf_rc_u4[count_buf_rc_4++]=data_rc;
 }
 if(count_buf_rc_4==0){
 if(data_rc==0x4B){

 DATA_TRUE=1;

 }
 }

 if(count_buf_rc_4>=6){

 DATA_TRUE=0;
 if(data_rc==0x4D){
 PROCESSING_RS485=1;
 count_buf_rc_4=0;

 }
 }

 }
}

void main() {
 gpio_init();
 GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_14);
 GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_15);
 duphong8_C14=0;
 duphong9_C15=0;
 out_relay=0;
 xuat_32bit(out_relay);
 delay_ms(1500);
RESET:
 buf_rc_u4[0]=0;
 buf_rc_u4[1]=0;
 buf_rc_u4[2]=0;
 buf_rc_u4[3]=0;
 buf_rc_u4[4]=0;
 buf_rc_u4[5]=0;
 buf_rc_u4[6]=0;
 GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_12);
 GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_8);
 GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_9);


 GPIO_Digital_Input (&GPIOD_BASE, _GPIO_PINMASK_6 );

 GPIO_Config(&GPIOD_BASE,_GPIO_PINMASK_6,_GPIO_CFG_MODE_INPUT | _GPIO_CFG_PULL_UP);


 GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_7);
 GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_3);
 GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_4);
 STAT=0;
 duphong66_C9=1;
 duphong67_A8=1;
 duphong88_D7=1;
 duphong89_B3=1;
 duphong90_B4=1;

 usart2_init();
 uart4__init();










 timer1_init();
 memset(but_state,0,24);
 delay_ms(1000);

 RCC_APB1ENR.B11 = 1;
 WWDG_CFR = 1;
 while(1){




 if(KEYCARD_INSERT){KEYCARD_COUNTER_CLOSE=0;}

 if(!KEYCARD_INSERT){
 KEYCARD_COUNTER_CLOSE++;
 if(KEYCARD_COUNTER_CLOSE>=0x001fffff) {
 KEYCARD_COUNTER_CLOSE=0;
 KEYCARD_ENABLE=0;

 out_relay=0;

 STAT=0;
 MASTER_BEDROOM_STATUS=0;
 AMBIENT_STATUS=0;
 ACCENT_STATUS=0;
 RS485_CONTROL_S9=0;
 RS485_CONTROL_S10=0;
 RS485_CONTROL_S9_S11=0;
 RS485_STATUS_S9=0;
 RS485_STATUS_S10=0;
 RS485_STATUS_S9_S11=0;


  GPIOB_ODR.B7 =0;
  GPIOB_ODR.B9 =0;
  GPIOD_ODR.B12 =0;
  GPIOD_ODR.B14 =0;
  GPIOB_ODR.B14 =0;

  GPIOC_ODR.B6 =0;
  GPIOC_ODR.B8 =0;

  GPIOD_ODR.B8 =0;
  GPIOD_ODR.B10 =0;

  GPIOB_ODR.B12 =0;

  GPIOE_ODR.B14 =0;
  GPIOB_ODR.B10 =0;

  GPIOE_ODR.B8 =0;
  GPIOE_ODR.B10 =0;

  GPIOB_ODR.B0 =0;

  GPIOB_ODR.B2 =0;

  GPIOC_ODR.B1 =0;
  GPIOC_ODR.B3 =0;
  GPIOA_ODR.B1 =0;

  GPIOE_ODR.B3 =0;
  GPIOE_ODR.B5 =0;
  GPIOC_ODR.B13 =0;
 }
 }

 if(PROCESSING_RS485){








 PROCESSING_RS485=0;
 if(buf_rc_u4[4]==0x45){
 KEYCARD_INSERT=1;
 buf_rc_u4[5]=0;
 STAT = ~STAT;
 }

 if(buf_rc_u4[4]==0x48){
 KEYCARD_INSERT=0;
 KEYCARD_ENABLE=0;

 out_relay=0;

 STAT=0;
 MASTER_BEDROOM_STATUS=0;
 AMBIENT_STATUS=0;
 ACCENT_STATUS=0;
 RS485_CONTROL_S9=0;
 RS485_CONTROL_S10=0;
 RS485_CONTROL_S9_S11=0;
 RS485_STATUS_S9=0;
 RS485_STATUS_S10=0;
 RS485_STATUS_S9_S11=0;

  GPIOB_ODR.B7 =0;
  GPIOB_ODR.B9 =0;
  GPIOD_ODR.B12 =0;
  GPIOD_ODR.B14 =0;
  GPIOB_ODR.B14 =0;

  GPIOC_ODR.B6 =0;
  GPIOC_ODR.B8 =0;

  GPIOD_ODR.B8 =0;
  GPIOD_ODR.B10 =0;

  GPIOB_ODR.B12 =0;

  GPIOE_ODR.B14 =0;
  GPIOB_ODR.B10 =0;

  GPIOE_ODR.B8 =0;
  GPIOE_ODR.B10 =0;

  GPIOB_ODR.B0 =0;

  GPIOB_ODR.B2 =0;

  GPIOC_ODR.B1 =0;
  GPIOC_ODR.B3 =0;
  GPIOA_ODR.B1 =0;

  GPIOE_ODR.B3 =0;
  GPIOE_ODR.B5 =0;
  GPIOC_ODR.B13 =0;
 }
 }

 if(RS485_CONTROL_S9_S11){
 RS485_CONTROL_S9_S11=0;
 STAT=~STAT;
 if(RS485_STATUS_S9_S11==1)
 {
 out_relay|= 0b00000000000000000000000010000000 ;
  GPIOE_ODR.B5 =1;
  GPIOA_ODR.B15 =1; 

 uart4_chr(0x4B);
 uart4_chr(0x30);
 uart4_chr(0x30);
 uart4_chr(0x30);
 uart4_chr(0x42);
 uart4_chr(0x33);
 uart4_chr(0x4D);
 uart4_chr(0x0D);
 uart4_chr(0x0A);
  GPIOA_ODR.B15 =0; 
 }
 if(RS485_STATUS_S9_S11==0)
 {
 out_relay&=~ 0b00000000000000000000000010000000 ;
  GPIOE_ODR.B5 =0;
  GPIOA_ODR.B15 =1; 
 uart4_chr(0x4B);
 uart4_chr(0x30);
 uart4_chr(0x30);
 uart4_chr(0x30);
 uart4_chr(0x54);
 uart4_chr(0x33);
 uart4_chr(0x4D);
 uart4_chr(0x0D);
 uart4_chr(0x0A);
  GPIOA_ODR.B15 =0; 
 }
 }

 if(RS485_CONTROL_S9==1){
 RS485_CONTROL_S9=0;
 STAT=~STAT;
 if(RS485_STATUS_S9)
 {
  GPIOB_ODR.B0 =1;
  GPIOE_ODR.B14 =1;
 out_relay|= 0b00000000000000000000000001000000 ;
  GPIOA_ODR.B15 =1; 
 uart4_chr(0x4B);
 uart4_chr(0x30);
 uart4_chr(0x30);
 uart4_chr(0x30);
 uart4_chr(0x42);
 uart4_chr(0x32);
 uart4_chr(0x4D);
 uart4_chr(0x0D);
 uart4_chr(0x0A);
  GPIOA_ODR.B15 =0; 
 }
 if(!RS485_STATUS_S9)
 {
  GPIOB_ODR.B0 =0;
  GPIOE_ODR.B14 =0;
 out_relay&=~ 0b00000000000000000000000001000000 ;
  GPIOA_ODR.B15 =1; 
 uart4_chr(0x4B);
 uart4_chr(0x30);
 uart4_chr(0x30);
 uart4_chr(0x30);
 uart4_chr(0x54);
 uart4_chr(0x32);
 uart4_chr(0x4D);
 uart4_chr(0x0D);
 uart4_chr(0x0A);
  GPIOA_ODR.B15 =0; 
 }
 }
 if(RS485_CONTROL_S10==1){
 RS485_CONTROL_S10=0;
 STAT=~STAT;
 if(RS485_STATUS_S10)
 { GPIOC_ODR.B13 =1;
  GPIOA_ODR.B15 =1; 
 uart4_chr(0x4B);
 uart4_chr(0x30);
 uart4_chr(0x30);
 uart4_chr(0x30);
 uart4_chr(0x42);
 uart4_chr(0x31);
 uart4_chr(0x4D);
 uart4_chr(0x0D);
 uart4_chr(0x0A);
  GPIOA_ODR.B15 =0; 
 }
 if(!RS485_STATUS_S10)
 { GPIOC_ODR.B13 =0;
  GPIOA_ODR.B15 =1; 
 uart4_chr(0x4B);
 uart4_chr(0x30);
 uart4_chr(0x30);
 uart4_chr(0x30);
 uart4_chr(0x54);
 uart4_chr(0x31);
 uart4_chr(0x4D);
 uart4_chr(0x0D);
 uart4_chr(0x0A);
  GPIOA_ODR.B15 =0; 
 }
 }




 }
}
