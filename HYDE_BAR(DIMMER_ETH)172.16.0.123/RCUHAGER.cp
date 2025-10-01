#line 1 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
#line 1 "c:/users/lenovo/desktop/thang8-dimmer ethenet/hyde_bar(dimmer_eth)172.16.0.123/main.h"
#line 1 "c:/users/lenovo/desktop/thang8-dimmer ethenet/hyde_bar(dimmer_eth)172.16.0.123/init.c"
#line 1 "c:/users/lenovo/desktop/thang8-dimmer ethenet/hyde_bar(dimmer_eth)172.16.0.123/init.h"
#line 19 "c:/users/lenovo/desktop/thang8-dimmer ethenet/hyde_bar(dimmer_eth)172.16.0.123/init.h"
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
#line 2 "c:/users/lenovo/desktop/thang8-dimmer ethenet/hyde_bar(dimmer_eth)172.16.0.123/init.c"
void xuat_32bit(unsigned long data_dich){
 unsigned char vt_dich=32;
 unsigned long shift_data=data_dich;
  GPIOD_ODR.B1 =1;
 do{
 vt_dich--;
  GPIOD_ODR.B2 =(shift_data>>vt_dich);
  GPIOC_ODR.B12 =0; GPIOC_ODR.B12 =1; 
 delay_us(2);
 }while(vt_dich>0);
  GPIOD_ODR.B1 =0;
  GPIOD_ODR.B0 =0; GPIOD_ODR.B0 =1; 
}

void timer1_init(){
 TIM1_CR1bits.DIR_=0;
 TIM1_CR1bits.ARPE=0;
 TIM1_CR1bits.OPM=0;
 TIM1_PSC=10000;
 TIM1_ARR=320;


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


 UART4_BRR=0X0271;
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
#line 1 "c:/users/lenovo/desktop/thang8-dimmer ethenet/hyde_bar(dimmer_eth)172.16.0.123/__ethenc28j60.h"
#line 119 "c:/users/lenovo/desktop/thang8-dimmer ethenet/hyde_bar(dimmer_eth)172.16.0.123/__ethenc28j60.h"
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
#line 146 "c:/users/lenovo/desktop/thang8-dimmer ethenet/hyde_bar(dimmer_eth)172.16.0.123/__ethenc28j60.h"
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
#line 90 "c:/users/lenovo/desktop/thang8-dimmer ethenet/hyde_bar(dimmer_eth)172.16.0.123/main.h"
unsigned char but_sample[24][ 2 ];
unsigned char but_state[24];
unsigned char but_status[24];
unsigned char but_sum_sample[24];








unsigned int count_time_but2=0;
unsigned char flag_enable_but2=0;
unsigned int flag_but_master= 2 ;
#line 186 "c:/users/lenovo/desktop/thang8-dimmer ethenet/hyde_bar(dimmer_eth)172.16.0.123/main.h"
unsigned long out_relay=0;

unsigned char buf_rc_u4[6],count_buf_rc_4=0,status_but_touch=0xff,channel_touch=0xff,touch_but=0xff;
unsigned int status_led_touch=0,status_led_touch_save=0;
#line 203 "c:/users/lenovo/desktop/thang8-dimmer ethenet/hyde_bar(dimmer_eth)172.16.0.123/main.h"
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
#line 7 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
sfr sbit SPI_Ethernet_Rst at GPIOC_ODR.B4;
sfr sbit SPI_Ethernet_CS at GPIOA_ODR.B4;
sfr sbit STAT at GPIOA_ODR.B12;
sfr sbit duphong8_C14 at GPIOC_ODR.B14;
sfr sbit duphong9_C15 at GPIOC_ODR.B15;
sfr sbit duphong66_C9 at GPIOC_ODR.B9;
sfr sbit duphong67_A8 at GPIOA_ODR.B8;
sfr sbit duphong87_D6 at GPIOD_ODR.B6;
sfr sbit duphong88_D7 at GPIOD_ODR.B7;
sfr sbit duphong89_B3 at GPIOB_ODR.B3;
sfr sbit duphong90_B4 at GPIOB_ODR.B4;

const code unsigned char httpHeader[] = "HTTP/1.1 200 OK\nContent-type: ";
const code unsigned char httpMimeTypeHTML[] = "text/html\n\n";
const code unsigned char httpMimeTypeScript[] = "text/plain\n\n";
unsigned char httpMethod[] = "GET /";

const code char *LoginPage =
#line 30 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
"<html><head></head><title>Login Page</title><h1>VALI TEST HAGER -<br>IP default:192.168.1.123 -<br>MAC:00-14-A5-76-18-23</h1></body></html>";

const code char *indexPage =
#line 91 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
"<html><head><title>Room</title><script>var t_r;function _http(dt){var t=dt+Math.random();var ht=new XMLHttpRequest();ht.onreadystatechange=rec;function rec(){if(ht.responseText!=null){var st=ht.responseText;t_r=parseInt(st.substr(1,st.length),10);}}ht.open(\"GET\",t,false);ht.send(null);_ch();}function _ch(){for(var l=0;l<32;l++){var _id=\"t\"+l+\"$\";if((t_r>>l)&1){document.getElementById(_id).value=\"On\";document.getElementById(_id).style.background=\"#20FF00\";}else{document.getElementById(_id).value=\"Off\";document.getElementById(_id).style.background=\"#FF4000\";}}}function _init(f){var str,i;str=\"\";for(i=0;i<f;i++){str+=\"<tr><td>\"+ar[i]+\"</td>\";str+=\"</td><td><input style='height:30px;width:100px' type='button' id='t\"+i+\"$'onMouseDown=\"+\"_http('o\"+i+\"$') onMouseUp=\"+\"_http('f\"+i+\"$')\"+\"></td></tr>\";}document.write(str);}</script></head><center><body onload=\"setInterval(function(){_http('s')},3000);_http('s');\"><table cellpadding=\"4\"><tr bgcolor=\"#F4A460\"><script>var h;var s=\"\";var ar_t=[\"L\",\"Service\",\"Lighting\",\"Curtain\",\"Scenes\",\"Fan Speed\",\"Dimer Extant\",\"Device Extant\",\"Setting\",\"Home\"];for(h=1;h<10;h++){s+=\"<td><a href=/t\"+h+\"><b>\"+ar_t[h]+\"</b></a></td>\";}document.write(s)</script></tr></table><br><br><table border=1>";

const code char *HomePage =
#line 116 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
"<head><title>Room</title></head><center><body><table cellpadding=\"4\"><tr bgcolor=\"#F4A460\"><script>var h;var s=\"\";var ar_t=[\"L\",\"Service\",\"Lighting\",\"Curtain\",\"Scenes\",\"Fan Speed\",\"Dimer Extant\",\"Device Extant\",\"Setting\",\"Home\"];for(h=1;h<10;h++){s+=\"<td><a href=/t\"+h+\"><b>\"+ar_t[h]+\"</b></a></td>\";}document.write(s)</script></tr></table><br><br><span style=\"color:#881111\"><h1>Intelligent Electric JSC</h1></span></body></html>" ;

const code char *ServicePage =
#line 148 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
"<head><title>Room</title></head><center><body><table cellpadding=\"4\"><tr bgcolor=\"#F4A460\"><script>var h;var s=\"\";var ar_t=[\"L\",\"Service\",\"Lighting\",\"Curtain\",\"Scenes\",\"Fan Speed\",\"Dimer Extant\",\"Device Extant\",\"Setting\",\"Home\"];for(h=1;h<10;h++){s+=\"<td><a href=/t\"+h+\"><b>\"+ar_t[h]+\"</b></a></td>\";}document.write(s)</script></tr></table><br><br><form><span style=\"color:#881111\"><h1>SET VALUE FOR DIMMER-MASTER</h1></span><span style=\"color:#ff4000\"><h3>VALUE DATA FORM 0-TO-100.</h3></span><table border=\"3\" bgcolor=\"#ffffff\"><td><input type=\"integer-allowed\" size=\"15\" name=\"ip1\" ip1=\"\" /></td><td><input type=\"submit\" style='height:30px;width:100px;background:#F4A460' value=\"SAVE\" / ></table></form></body></html>";

const code char *LightingPage =
#line 157 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
"<tr><th colspan=3>Light</th></tr><script>var ar=[\"Entrance\",\"Master\",\"Bath\",\"Reading\",\"Bedside\"];_init(5);</script></html>" ;

const code char *CurtainPage =
#line 168 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
"<tr><th colspan=3>Curtain</th></tr><script>var ar=[\"Open 1 then close\",\"Open 1 then stop\",\"Open 2 then close\",\"Open 2 then stop\"];_init(4);</script></td></tr></table></body></html>" ;

const code char *ScenesPage =
#line 179 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
"<tr><th colspan=6>Scenes</th></tr><script>var ar=[\"Relax\",\"Night\",\"Party\",\"Morning\",\"Afternoon\",\"Watch TV\"];_init(6);</script></td></tr></table></body></html>" ;

const code char *Fan_SpeedPage =
#line 190 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
"<tr><th colspan=3>Fan Speed</th></tr><script>var ar=[\"Off\",\"Low\",\"Medium\",\"Hight\"];_init(4);</script></td></tr></table></body></html>" ;

const code char *Dimer_ExtantPage =
#line 200 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
"<tr><th colspan=4>Dimer</th></tr><script>var ar=[\"Up 1&2\",\"Down 1&2\",\"Up 3&4\",\"Down 3&4\"];_init(4);</script></td></tr></table></html>" ;

const code char *Device_ExtantPage =
#line 268 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
"<head><title>Room</title><script>var t_r;function _http(dt){var t=dt+Math.random();var ht=new XMLHttpRequest();ht.onreadystatechange=rec;function rec(){if(ht.responseText!=null){var st=ht.responseText;t_r=parseInt(st.substr(1,st.length),10);}}ht.open(\"GET\",t,false);ht.send(null);_ch();}function _ch(){for(var l=0;l<32;l++){var _id=\"t\"+l+\"$\";if((t_r>>l)&1){document.getElementById(_id).value=\"On \"+l;document.getElementById(_id).style.background=\"#20FF00\";}else{document.getElementById(_id).value=\"Off \"+l;document.getElementById(_id).style.background=\"#FF4000\";}}}function _init(f){var str,i;str=\"\";str+=\"<tr><th colspan=3>Thiet bi</th></tr>\";for(i=0;i<32;i++){str+=\"<tr><td>Thiet bi \"+i+\"</td>\";str+=\"</td><td><input style='height:30px;width:100px' type='button' id='t\"+i+\"$'onclick=\"+\"_http('d\"+i+\"$')\"+\"></td></tr>\";}document.write(str);}</script></head><center><body onload=\"setInterval(function(){_http('s')},3000);_http('s');\"><table cellpadding=\"4\"><tr bgcolor=\"#F4A460\"><script>var h;var s=\"\";var ar_t=[\"L\",\"Service\",\"Lighting\",\"Curtain\",\"Scenes\",\"Fan Speed\",\"Dimer Extant\",\"Device Extant\",\"Setting\",\"Home\"];for(h=1;h<10;h++){s+=\"<td><a href=/t\"+h+\"><b>\"+ar_t[h]+\"</b></a></td>\";}document.write(s)</script></tr></table><br><br><table border=1><script>_init(20);</script></td></tr></table></body></html>" ;


const code char *SettingPage =
#line 301 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
"<head><title>Room</title></head><center><body><table cellpadding=\"4\"><tr bgcolor=\"#F4A460\"><script>var h;var s=\"\";var ar_t=[\"L\",\"Service\",\"Lighting\",\"Curtain\",\"Scenes\",\"Fan Speed\",\"Dimer Extant\",\"Device Extant\",\"Setting\",\"Home\"];for(h=1;h<10;h++){s+=\"<td><a href=/t\"+h+\"><b>\"+ar_t[h]+\"</b></a></td>\";}document.write(s)</script></tr></table><br><br><form><span style=\"color:#881111\"><h1>Setting IP</h1></span><span style=\"color:#ff4000\"><h3>Note :Format IP address is xxx.xxx.xxx.xxx, with x is integer number.</h3></span><table border=\"3\" bgcolor=\"#ffffff\"><td><input type=\"integer-allowed\" size=\"15\" name=\"ip1\" ip1=\"\" /></td><td><input type=\"submit\" style='height:30px;width:100px;background:#F4A460' value=\"Enter\" / ></table></form></body></html>";

unsigned char myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x18, 0x23};
unsigned char myIpAddr[4] = {192,168,1,123};


unsigned char gwIpAddr[4];
unsigned char ipMask[4] = {255, 255, 255, 0 };
unsigned char dnsIpAddr[4] = {192, 168, 1, 1 };
unsigned char getRequest[100];
unsigned char dyna[40] ;
unsigned char buf[40];
unsigned char DIM_VAR[16];
unsigned long AddressDIMVALUE = 0x08007F90;
unsigned long SAVE_VALUE_DIM=0;
unsigned int index_page=7;
unsigned char ipAddress[4];
unsigned long Address = 0x08008000,i,temp,checkConnect=0;
unsigned long* ptr;
unsigned char curtain;
unsigned char flag_all_dimer_percent=0;
unsigned char DELAY_SEND_DIMMER=0;
unsigned char PERCENT_DIMMER=0;
unsigned char DATA_TRUE,PROCESSING_RS485,RESPOND_PROCESSING_RS485;
unsigned char MASTER_SWITCH=0;
unsigned char DO_NOT_DISTURB=0;
unsigned char KEYCARD_ENABLE=0;
unsigned char KEYCARD_INSERT=0;
unsigned long KEYCARD_COUNTER=0;
unsigned long KEYCARD_COUNTER_CLOSE=0;
unsigned long BELL_COUNTER=0;
unsigned char BELL_ENABLE=0;
unsigned char DIM4_EVERGREEN=0;
unsigned char DIM2_EVERGREEN=0;

unsigned long status_out_relay=0;
unsigned char DIMMER_ALL_20PERCENT=0;
unsigned char running_right_curtain=0;
unsigned char running_left_curtain=0;
unsigned char running_hold_curtain=1;
unsigned char flag_right_curtain=0;
unsigned char flag_left_curtain=0;
unsigned char flag_hold_curtain=0;
unsigned char flag_running_right_done=0;
unsigned char flag_running_left_done=1;
unsigned long counter_running_right=0;
unsigned long counter_running_left=0;
unsigned long counter_button_curtain=0;
unsigned char MASTER_SWITCH_ALL=0;
unsigned char MASTER_SWITCH_TOGGLE=0;
unsigned char flag_button_dim1=0;
unsigned char flag_button_dim2=0;
unsigned char flag_button_dim3=0;
unsigned char flag_button_dim4=0;
unsigned char flag_button_dimmaster=0;
unsigned char flag_setdimmer1=0;
unsigned char flag_setdimmer2=0;
unsigned char flag_setdimmer3=0;
unsigned char flag_setdimmer4=0;
unsigned char flag_setdimmaster=0;
unsigned char BUTTON_DIM_CHANNEL1=0;
unsigned char BUTTON_DIM_CHANNEL2=0;
unsigned char BUTTON_DIM_CHANNEL3=0;
unsigned char BUTTON_DIM_CHANNEL4=0;
unsigned char BUTTON_DIM_MASTER=0;
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
unsigned char ETHERNET_BUTTON_DEVICE_0=0;
unsigned char ETHERNET_BUTTON_DEVICE_1=0;
unsigned char ETHERNET_BUTTON_DEVICE_2=0;
unsigned char ETHERNET_BUTTON_DEVICE_3=0;
unsigned char ETHERNET_BUTTON_DEVICE_4=0;
unsigned char ETHERNET_BUTTON_DIM0=0;
unsigned char ETHERNET_BUTTON_DIM1=0;
unsigned char ETHERNET_BUTTON_DIM2=0;
unsigned char ETHERNET_BUTTON_DIM3=0;
unsigned char ETHERNET_BUTTON_DIM4=0;
unsigned char VALUE4CHANNEL=35;
unsigned long IP_NULL=0;
void settingEthenet(void){
 ptr = (unsigned long*)Address;
 i=*ptr;
 if(i==0xffffffff){
 FLASH_ErasePage(Address);





 FLASH_Write_Word(Address,0xC0A8017B);
 }
 myIpAddr[0]=i>>24;
 myIpAddr[1]=i>>16;
 myIpAddr[2]=i>>8;
 myIpAddr[3]=i;
 gwIpAddr[0]=myIpAddr[0];
 gwIpAddr[1]=myIpAddr[1];
 gwIpAddr[2]=myIpAddr[2];
 gwIpAddr[3]=1;
 SPI_Ethernet_Init(myMacAddr, myIpAddr,  1 );
 SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr);
}
void putChar(unsigned char c){
 while(UART4_SRbits.TC==0);
 UART4_DRbits.DR = c;
}
void saveDIMVALUE(){
 unsigned char i=11;
#line 443 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
 DIM_VAR[0]=getRequest[i] ;
 DIM_VAR[1]=getRequest[i+1];
 DIM_VAR[2]=getRequest[i+2];
 DIM_VAR[3]=getRequest[i+3];
 DIM_VAR[4]=getRequest[i+4];
 DIM_VAR[5]=getRequest[i+5];
 DIM_VAR[6]=getRequest[i+6];
 DIM_VAR[7]=getRequest[i+7];
 DIM_VAR[8]=getRequest[i+8];
 DIM_VAR[9]=getRequest[i+9];
 DIM_VAR[10]=getRequest[i+10];
 DIM_VAR[11]=getRequest[i+11];
 DIM_VAR[12]=getRequest[i+12];
 DIM_VAR[13]=getRequest[i+13];
 DIM_VAR[14]=getRequest[i+14];
 DIM_VAR[15]=getRequest[i+15];
SAVE_VALUE_DIM=(((unsigned long)DIM_VAR[3])<<24)|(((unsigned long)DIM_VAR[2])<<16)|(((unsigned long)DIM_VAR[1])<<8)|(((unsigned long)DIM_VAR[0]));
FLASH_Write_Word(0x08007F80,SAVE_VALUE_DIM);
SAVE_VALUE_DIM=(((unsigned long)DIM_VAR[7])<<24)|(((unsigned long)DIM_VAR[6])<<16)|(((unsigned long)DIM_VAR[5])<<8)|(((unsigned long)DIM_VAR[4]));
FLASH_Write_Word(0x08007F90,SAVE_VALUE_DIM);
SAVE_VALUE_DIM=(((unsigned long)DIM_VAR[11])<<24)|(((unsigned long)DIM_VAR[10])<<16)|(((unsigned long)DIM_VAR[9])<<8)|(((unsigned long)DIM_VAR[8]));
FLASH_Write_Word(0x08007FA0,SAVE_VALUE_DIM);
SAVE_VALUE_DIM=(((unsigned long)DIM_VAR[15])<<24)|(((unsigned long)DIM_VAR[14])<<16)|(((unsigned long)DIM_VAR[13])<<8)|(((unsigned long)DIM_VAR[12]));
FLASH_Write_Word(0x08007FB0,SAVE_VALUE_DIM);
}
void saveIP(unsigned char buf[]){
 unsigned long ipWord;
 unsigned char i=0,j,pos=0;
 while(i<39){
 if(buf[i]=='i'&&buf[i+1]=='p'){
 for(j=0;j<4;j++){
 if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]<48||buf[i+5]>57)){
 ipAddress[j]=buf[i+4]-48;
 i+=2;
 }
 else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]<48||buf[i+6]>57)){
 ipAddress[j]=10*(buf[i+4]-48)+(buf[i+5]-48);
 i+=3;
 }
 else if(buf[i+4]>=48&&buf[i+4]<=57&&(buf[i+5]>=48||buf[i+5]<=57)&&(buf[i+6]>=48||buf[i+6]<=57)){
 ipAddress[j]=100*(buf[i+4]-48)+10*(buf[i+5]-48)+(buf[i+6]-48);
 i+=4;
 }
 }
 FLASH_ErasePage(Address);
 ipword=(((unsigned long)ipAddress[0])<<24)|(((unsigned long)ipAddress[1])<<16)|(((unsigned long)ipAddress[2])<<8)|(((unsigned long)ipAddress[3]));
 FLASH_Write_Word(Address,ipWord);
 settingEthenet();
 }
 i++;
 }
}
void copyBuf(unsigned char a[],unsigned char b[],unsigned char size){
 unsigned char index;
 for(index=0;index<size;index++){
 b[index]=a[index];
 }
}
unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags){
 unsigned int len=0;
 unsigned char vt_button=0;
 unsigned long shift=1;

 unsigned char locate=0,_locate=0,h=0;
 unsigned int _myip[4];
 if(localPort != 80)
 {
 return(0);
 }
 for(len = 0;len <40;len++){
 getRequest[len] = SPI_Ethernet_getByte();
 }
 getRequest[len] = 0;
 len = 0;
 if(memcmp(getRequest, httpMethod, 5))
 {
 return(0);
 }

 if(getRequest[5]=='t'){
 if(isdigit(getRequest[6])){
 index_page=getRequest[6]-'0';
 if(index_page==Page_Setting){
 _locate=10;
 for(h=0;h<4;h++){
 locate=get_point(getRequest,_locate,25);
 _myip[h]=chuoi_so(getRequest,_locate,(locate-1));
 _locate=locate+1;
 }
 if((_myip[0]<=255)&&(_myip[1]<=255)&&(_myip[2]<=255)&&(_myip[3]<=255)) {
 for(h=0;h<4;h++){
 myIpAddr[h]=_myip[h];
 }
 flag_reset_ip=1;
 }
 }
 if(index_page==Page_Service){
 saveDIMVALUE();
 }
 }
 }
 else if(getRequest[5] == 's'){
 STAT = ~STAT;
 len =  SPI_Ethernet_putConstString (httpHeader);
 len +=  SPI_Ethernet_putConstString (httpMimeTypeHTML);
 switch (index_page) {





 break;
 case Page_Lighting:
 len +=  SPI_Ethernet_putConstString ("r");
 LongWordToStr(status_wed_light, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 break;
 case Page_Curtain:
 len +=  SPI_Ethernet_putConstString ("r");
 LongWordToStr(status_wed_curtain, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 break;
 case Page_Scenes:
 len +=  SPI_Ethernet_putConstString ("r");
 LongWordToStr(status_wed_scenes, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 break;
 case Page_Fan_Speed:
 len +=  SPI_Ethernet_putConstString ("r");
 LongWordToStr(status_wed_fan, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 break;
 case Page_Dimer_Extant:
 len +=  SPI_Ethernet_putConstString ("r");
 LongWordToStr(status_wed_dimer, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 break;
 case Page_Device_Extant:
 len +=  SPI_Ethernet_putConstString ("r");
 LongWordToStr(wed_status_button, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 break;
 default:
 break;
 }
 }
 switch (index_page) {
 case Page_Service:



 if(getRequest[5] == 'f'){
 len +=  SPI_Ethernet_putConstString ("r");
 len +=  SPI_Ethernet_putString (dyna);
 }
 break;
 case Page_Lighting:
 if(getRequest[5] == 'o'){
 if(isdigit(getRequest[6])){
 if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
 switch (vt_button) {
 case 0:
 break;
 case 1:
 break;
 case 2:
 break;
 case 3:
 break;
 case 4:
 break;
 default:
 break;
 }
 }
 len +=  SPI_Ethernet_putConstString ("r");
 status_wed_light|=(shift<<vt_button);
 LongWordToStr(status_wed_light, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 xuat_32bit(out_relay);
 }
 else if(getRequest[5] == 'f'){
 if(isdigit(getRequest[6])){
 if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
 switch (vt_button) {
 case 0:
 break;
 case 1:
 break;
 case 2:
 break;
 case 3:
 break;
 case 4:
 break;
 default:
 break;
 }
 }
 flag_but_dimer=0;
 len +=  SPI_Ethernet_putConstString ("r");
 status_wed_light|=(shift<<vt_button);
 LongWordToStr(status_wed_light, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 }
 break;
 case Page_Curtain:
 if(getRequest[5] == 'o'){
 if(isdigit(getRequest[6])){
 if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
 switch (vt_button) {
 case 0:
 break;
 case 1:
 break;
 case 2:
 break;
 case 3:
 break;

 default:
 break;
 }
 }
 len +=  SPI_Ethernet_putConstString ("r");
 status_wed_curtain|=(shift<<vt_button);
 LongWordToStr(status_wed_curtain, dyna);
 len +=  SPI_Ethernet_putString (dyna);

 }
 else if(getRequest[5] == 'f'){
 if(isdigit(getRequest[6])){
 if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
 switch (vt_button) {
 case 0:
 break;
 case 1:
 break;
 case 2:
 break;
 case 3:
 break;
 default:
 break;
 }
 }
 len +=  SPI_Ethernet_putConstString ("r");
 status_wed_curtain&=~(shift<<vt_button);
 LongWordToStr(status_wed_curtain, dyna);
 len +=  SPI_Ethernet_putString (dyna);

 }
 break;
 case Page_Scenes:
 if(getRequest[5] == 'o'){
 if(isdigit(getRequest[6])){
 if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
 switch (vt_button) {
 case 0:
 break;
 case 1:
 break;
 case 2:
 break;
 default:
 break;
 }
 }
 len +=  SPI_Ethernet_putConstString ("r");
 status_wed_scenes|=(shift<<vt_button);
 LongWordToStr(status_wed_scenes, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 xuat_32bit(out_relay);
 }
 else if(getRequest[5] == 'f'){
 if(isdigit(getRequest[6])){
 if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
 switch (vt_button) {
 case 0:
 break;
 case 1:
 break;
 case 2:
 break;
 default:
 break;
 }
 }
 len +=  SPI_Ethernet_putConstString ("r");
 status_wed_scenes|=(shift<<vt_button);
 LongWordToStr(status_wed_scenes, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 }
 break;
 case Page_Fan_Speed:
 if(getRequest[5] == 'o'){
 if(isdigit(getRequest[6])){
 if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
 switch (vt_button) {
 case 0:
 break;
 case 1:
 break;
 case 2:
 break;
 case 3:
 break;
 default:
 break;
 }
 }
 len +=  SPI_Ethernet_putConstString ("r");
 if((out_relay& 0b00000000000000000000001000000000 )?1:0)status_wed_fan|=(shift<<1);
 else status_wed_fan&=~(shift<<1);
 if((out_relay& 0b00000000000000000000010000000000 )?1:0)status_wed_fan|=(shift<<2);
 else status_wed_fan&=~(shift<<2);
 if((out_relay& 0b00000000000000000000100000000000 )?1:0)status_wed_fan|=(shift<<3);
 else status_wed_fan&=~(shift<<3);
 LongWordToStr(status_wed_fan, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 }
 else if(getRequest[5] == 'f'){
 if(isdigit(getRequest[6])){
 if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
 switch (vt_button) {
 case 0:
 break;
 case 1:
 break;
 case 2:
 break;
 case 3:
 break;
 default:
 break;
 }
 }
 len +=  SPI_Ethernet_putConstString ("r");
 if((out_relay& 0b00000000000000000000001000000000 )?1:0)status_wed_fan|=(shift<<1);
 else status_wed_fan&=~(shift<<1);
 if((out_relay& 0b00000000000000000000010000000000 )?1:0)status_wed_fan|=(shift<<2);
 else status_wed_fan&=~(shift<<2);
 if((out_relay& 0b00000000000000000000100000000000 )?1:0)status_wed_fan|=(shift<<3);
 else status_wed_fan&=~(shift<<3);
 LongWordToStr(status_wed_fan, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 }
 break;
 case Page_Dimer_Extant:
 if(getRequest[5] == 'o'){
 if(isdigit(getRequest[6])){
 if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
 switch (vt_button) {
 case 0:
 break;
 case 1:
 break;
 case 2:
 break;
 case 3:
 break;
 case 4:
 break;
 case 5:
 break;
 default:
 break;
 }
 }
 len +=  SPI_Ethernet_putConstString ("r");
 status_wed_dimer|=(shift<<vt_button);
 LongWordToStr(status_wed_dimer, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 }
 else if(getRequest[5] == 'f'){
 if(isdigit(getRequest[6])){
 if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
 switch (vt_button) {
 case 0:
 flag_dimer_ex[1]=0;
 count_time_dimer_ex[1]=0;
 DIM2_EVERGREEN = 0;
 break;
 case 1:
 flag_dimer_ex[1]=0;
 count_time_dimer_ex[1]=0;
 DIM2_EVERGREEN = 0;
 break;
 case 2:



 flag_dimer_ex[2]=0;
 count_time_dimer_ex[2]=0;
 DIM4_EVERGREEN = 0;
 break;
 case 3:


 flag_dimer_ex[2]=0;
 count_time_dimer_ex[2]=0;
 DIM4_EVERGREEN = 0;
 break;
 case 4:


 break;
 case 5:


 default:
 break;
 }
 }
 len +=  SPI_Ethernet_putConstString ("r");
 status_wed_dimer&=~(shift<<vt_button);
 LongWordToStr(status_wed_dimer, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 }
 break;
 case Page_Device_Extant:
 if(getRequest[5] == 'd'){
 if(isdigit(getRequest[6])){
 if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
 else if(getRequest[8]=='$')vt_button=chuoi_so(getRequest,6,7);




 if(getRequest[6]=='0'){
 ETHERNET_BUTTON_DEVICE_0=1;
 ETHERNET_BUTTON_DIM0++;
 }
 if(getRequest[6]=='1'){
 ETHERNET_BUTTON_DEVICE_1=1;
 ETHERNET_BUTTON_DIM1^=1;
 }
 if(getRequest[6]=='2'){
 ETHERNET_BUTTON_DEVICE_2=1;
 ETHERNET_BUTTON_DIM2^=1;
 }
 if(getRequest[6]=='3'){
 ETHERNET_BUTTON_DEVICE_3=1;
 ETHERNET_BUTTON_DIM3^=1;
 }
 if(getRequest[6]=='4'){
 ETHERNET_BUTTON_DEVICE_4=1;
 ETHERNET_BUTTON_DIM4^=1;
 }
 }


 len +=  SPI_Ethernet_putConstString ("r");





 }
 break;
 case Page_Setting:

 copyBuf(getRequest,buf,40);
#line 918 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
 saveIP(buf);
 if(getRequest[5] == 'f'){
 len +=  SPI_Ethernet_putConstString ("r");
 len +=  SPI_Ethernet_putString (dyna);
 }
 break;
 default:
 break;
 }
 if(len == 0){
 len =  SPI_Ethernet_putConstString (httpHeader);
 len +=  SPI_Ethernet_putConstString (httpMimeTypeHTML);
 switch (index_page) {
 case Page_Login:
 len +=  SPI_Ethernet_putConstString (LoginPage);
 break;
 case Page_Service:

 len +=  SPI_Ethernet_putConstString (ServicePage);
 break;
 case Page_Lighting:
 len +=  SPI_Ethernet_putConstString (indexPage);
 len +=  SPI_Ethernet_putConstString (LightingPage);
 break;
 case Page_Curtain:
 len +=  SPI_Ethernet_putConstString (indexPage);
 len +=  SPI_Ethernet_putConstString (CurtainPage);
 break;
 case Page_Scenes:
 len +=  SPI_Ethernet_putConstString (indexPage);
 len +=  SPI_Ethernet_putConstString (ScenesPage);
 break;
 case Page_Fan_Speed:
 len +=  SPI_Ethernet_putConstString (indexPage);
 len +=  SPI_Ethernet_putConstString (Fan_SpeedPage);
 break;
 case Page_Dimer_Extant:
 len +=  SPI_Ethernet_putConstString (indexPage);
 len +=  SPI_Ethernet_putConstString (Dimer_ExtantPage);
 break;
 case Page_Device_Extant:
 len +=  SPI_Ethernet_putConstString (Device_ExtantPage);
 break;
 case Page_Setting:
 len +=  SPI_Ethernet_putConstString (SettingPage);
 break;
 case Page_Home:
 len +=  SPI_Ethernet_putConstString (HomePage);
 break;
 default:
 len +=  SPI_Ethernet_putConstString (indexPage);
 len +=  SPI_Ethernet_putConstString (Device_ExtantPage);
 break;
 }
 }
 return(len);
}
unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags){
 return(0);
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

 for(but_isr=0;but_isr< 24 ;but_isr++){
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
#line 1073 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
 duphong67_A8=~duphong67_A8;



 if(but_status[0]== 5 ){
  GPIOE_ODR.B3 ^=1;
 }
 else if(but_status[0]== 4 ){

 }


 if(but_status[1]== 5 ){
  GPIOE_ODR.B5 =1;
 if(!flag_button_dim1){
 flag_button_dim1=1;
 if(BUTTON_DIM_CHANNEL1<=4){BUTTON_DIM_CHANNEL1++;}
 if(BUTTON_DIM_CHANNEL1>=5){BUTTON_DIM_CHANNEL1=0;}
 flag_setdimmer1=1;
 }
 }
 else if(but_status[1]== 4 ){
  GPIOE_ODR.B5 =0;
 flag_button_dim1=0;
 }

 if(but_status[2]== 5 ){
  GPIOC_ODR.B13 =1;
 if(!flag_button_dim2){
 flag_button_dim2=1;
 if(BUTTON_DIM_CHANNEL2<=4){BUTTON_DIM_CHANNEL2++;}
 if(BUTTON_DIM_CHANNEL2>=5){BUTTON_DIM_CHANNEL2=0;}
 flag_setdimmer2=1;
 }
 }
 else if(but_status[2]== 4 ){
  GPIOC_ODR.B13 =0;
 flag_button_dim2=0;
 }


 if(but_status[3]== 5 ){
  GPIOC_ODR.B1 ^=1;
 }
 else if(but_status[3]== 4 ){

 }


 if(but_status[4]== 5 ){
  GPIOC_ODR.B3 =1;
 if(!flag_button_dim2){
 flag_button_dim3=1;
 if(BUTTON_DIM_CHANNEL3<=4){BUTTON_DIM_CHANNEL3++;}
 if(BUTTON_DIM_CHANNEL3>=5){BUTTON_DIM_CHANNEL3=0;}
 flag_setdimmer3=1;
 }
 }
 else if(but_status[4]== 4 ){
  GPIOC_ODR.B3 =0;
 flag_button_dim3=0;
 }


 if(but_status[5]== 5 ){
  GPIOA_ODR.B1 =1;
 if(!flag_button_dim4){
 flag_button_dim4=1;
 if(BUTTON_DIM_CHANNEL4<=4){BUTTON_DIM_CHANNEL4++;}
 if(BUTTON_DIM_CHANNEL4>=5){BUTTON_DIM_CHANNEL4=0;}
 flag_setdimmer4=1;
 }
 }
 else if(but_status[5]== 4 ){
  GPIOA_ODR.B1 =0;
 flag_button_dim4=0;
 }



 if(but_status[6]== 5 ){
  GPIOB_ODR.B0 =1;
 if(!flag_button_dimmaster){
 flag_button_dimmaster=1;
 if(BUTTON_DIM_MASTER<=4){BUTTON_DIM_MASTER++;}
 if(BUTTON_DIM_MASTER>=5){BUTTON_DIM_MASTER=0;}
 flag_setdimmaster=1;
 }
 }
 else if(but_status[6]== 4 ){
  GPIOB_ODR.B0 =0;
 flag_button_dimmaster=0;
 }

 if(but_status[7]== 5 ){
  GPIOB_ODR.B0 =1;
 if(!flag_button_dimmaster){
 flag_button_dimmaster=1;
 if(BUTTON_DIM_MASTER<=4){BUTTON_DIM_MASTER++;}
 if(BUTTON_DIM_MASTER>=5){BUTTON_DIM_MASTER=0;}
 flag_setdimmaster=1;
 }
 }
 else if(but_status[7]== 4 ){
  GPIOB_ODR.B0 =0;
 flag_button_dimmaster=0;
 }

 if(but_status[8]== 5 ){
  GPIOB_ODR.B2 =1;
 if(!flag_button_dimmaster){
 flag_button_dimmaster=1;
 if(BUTTON_DIM_MASTER<=4){BUTTON_DIM_MASTER++;}
 if(BUTTON_DIM_MASTER>=5){BUTTON_DIM_MASTER=0;}
 flag_setdimmaster=1;
 }
 }
 else if(but_status[8]== 4 ){
  GPIOB_ODR.B2 =0;
 flag_button_dimmaster=0;
 }


 if(but_status[9]== 5 ){
  GPIOE_ODR.B8 =1;
 out_relay^= 0b00000000000000000000000000000001 ;
 }
 else if(but_status[9]== 4 ){
  GPIOE_ODR.B8 =(out_relay& 0b00000000000000000000000000000001 )?1:0;
 }

 if(but_status[10]== 5 ){
  GPIOE_ODR.B10 =1;
 out_relay^= 0b00000000000000001000000000000000 ;
 }
 else if(but_status[10]== 4 ){
  GPIOE_ODR.B10 =(out_relay& 0b00000000000000001000000000000000 )?1:0;
 }



 if(but_status[11]== 5 ){
  GPIOE_ODR.B14 =1;
 out_relay^= 0b00000000000000000000000000100000 ;
 }
 else if(but_status[11]== 4 ){
  GPIOE_ODR.B14 =(out_relay& 0b00000000000000000000000000100000 )?1:0;

 }

 if(but_status[12]== 5 ){
  GPIOB_ODR.B10 =1;
 out_relay^= 0b00000000000000000010000000000000 ;


 }
 else if(but_status[12]== 4 ){
  GPIOB_ODR.B10 =(out_relay& 0b00000000000000000010000000000000 )?1:0;
 }



 if(but_status[13]== 5 ){
  GPIOB_ODR.B12 =1;
 out_relay^= 0b00000000000000000000000010000000 ;
 }
 else if(but_status[13]== 4 ){
  GPIOB_ODR.B12 =(out_relay& 0b00000000000000000000000010000000 )?1:0;
 }


 if(but_status[14]== 5 ){
  GPIOB_ODR.B14 =1;
 MASTER_SWITCH_ALL=1;
 MASTER_SWITCH_TOGGLE^=1;
 }
 else if(but_status[14]== 4 ){
  GPIOB_ODR.B14 =MASTER_SWITCH_TOGGLE;
 MASTER_SWITCH_ALL=0;
 }


 if(but_status[15]== 5 ){
  GPIOD_ODR.B8 =1;
 out_relay^= 0b00000000000000000000000000010000 ;
 }
 else if(but_status[15]== 4 ){
  GPIOD_ODR.B8 =(out_relay& 0b00000000000000000000000000010000 )?1:0;
 }


 if(but_status[16]== 5 ){
  GPIOD_ODR.B10 =1;
 out_relay^= 0b00000000000000000000000000001000 ;
 }
 else if(but_status[16]== 4 ){
  GPIOD_ODR.B10 =(out_relay& 0b00000000000000000000000000001000 )?1:0;
 }


 if(but_status[17]== 5 ){
  GPIOD_ODR.B12 =1;
 }
 else if(but_status[17]== 4 ){
  GPIOD_ODR.B12 =0;
 }

 if(but_status[18]== 5 ){
  GPIOD_ODR.B14 ^=1;
 }
 else if(but_status[18]== 4 ){

 }


 if(but_status[19]== 5 ){
 if(!DO_NOT_DISTURB) {
  GPIOC_ODR.B6 ^=1;
  GPIOB_ODR.B7 ^=1;
 }
 }
 else if(but_status[19]== 4 ){

 }

 if(but_status[20]== 5 ){
  GPIOC_ODR.B8 ^=1;
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

 KEYCARD_COUNTER_CLOSE=0;
 KEYCARD_INSERT=1;
 }
 else if(but_status[23]== 4 ){

 KEYCARD_INSERT=0;
 }


 if(MASTER_SWITCH){
 }


 xuat_32bit(out_relay);






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

 PROCESSING_RS485=1;




 }






 }

}
#line 1388 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
void IP_FIRST_TIME() org 0x00007FC0
{
IP_NULL=0xCACBEDAC;
IP_NULL=0xC0A80178;
IP_NULL=0xC0A80179;
IP_NULL=0xC0A8017A;
IP_NULL=0xC0A8017B;
IP_NULL=0xAC10007B;
IP_NULL=0xC0A8017D;
IP_NULL=0xC0A8017E;
IP_NULL=0xC0A8017F;
asm nop;
asm nop;
}
void main() {
#line 1410 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
 gpio_init();
 GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_14);
 GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_15);
 duphong8_C14=0;
 duphong9_C15=0;
 out_relay=0;
 if(out_relay==0x01){IP_FIRST_TIME();}
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
 GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_6);
 GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_7);
 GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_3);
 GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_4);
 STAT=1;
 duphong66_C9=1;
 duphong67_A8=1;
 duphong87_D6=1;
 duphong88_D7=1;
 duphong89_B3=1;
 duphong90_B4=1;

 usart2_init();
 uart4__init();


 flag_setdimmer1=0;
 flag_setdimmer2=0;
 flag_button_dim1=0;
 flag_button_dim2=0;
 BUTTON_DIM_CHANNEL1=0;
 BUTTON_DIM_CHANNEL2=0;
 DIMMER_ALL_20PERCENT=0;
 status_out_relay=0;

 running_right_curtain=0;
 running_left_curtain=0;
 running_hold_curtain=0;
 flag_right_curtain=0;
 flag_left_curtain=0;
 flag_hold_curtain=1;
 flag_running_right_done=0;
 flag_running_left_done=1;
 counter_running_right=0;
 counter_running_left=0;
 counter_button_curtain=0;
#line 1481 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
 timer1_init();
 memset(but_state,0,24);
#line 1500 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
 SPI1_Init_Advanced(_SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PA567);
 settingEthenet();

 delay_ms(1000);
 duphong8_C14=1;

 RCC_APB1ENR.B11 = 1;
 WWDG_CFR = 1;






 while(1){



 if(flag_setdimmer4){
 if(BUTTON_DIM_CHANNEL4==0){set_value_dim(0,4);}
 if(BUTTON_DIM_CHANNEL4==1){set_value_dim(93,4);}
 if(BUTTON_DIM_CHANNEL4==2){set_value_dim(60,4);}
 if(BUTTON_DIM_CHANNEL4==3){set_value_dim(49,4);}
 if(BUTTON_DIM_CHANNEL4==4){set_value_dim(40,4);}
 flag_setdimmer4=0;
 }

 if(flag_setdimmer3){
 if(BUTTON_DIM_CHANNEL3==0){set_value_dim(0,3);}
 if(BUTTON_DIM_CHANNEL3==1){set_value_dim(93,3);}
 if(BUTTON_DIM_CHANNEL3==2){set_value_dim(60,3);}
 if(BUTTON_DIM_CHANNEL3==3){set_value_dim(49,3);}
 if(BUTTON_DIM_CHANNEL3==4){set_value_dim(40,3);}
 flag_setdimmer3=0;
 }

 if(flag_setdimmer2){
 if(BUTTON_DIM_CHANNEL2==0){set_value_dim(0,2);}
 if(BUTTON_DIM_CHANNEL2==1){set_value_dim(93,2);}
 if(BUTTON_DIM_CHANNEL2==2){set_value_dim(60,2);}
 if(BUTTON_DIM_CHANNEL2==3){set_value_dim(49,2);}
 if(BUTTON_DIM_CHANNEL2==4){set_value_dim(40,2);}
 flag_setdimmer2=0;
 }

 if(flag_setdimmer1){
 if(BUTTON_DIM_CHANNEL1==0){set_value_dim(0,1);}
 if(BUTTON_DIM_CHANNEL1==1){set_value_dim(93,1);}
 if(BUTTON_DIM_CHANNEL1==2){set_value_dim(60,1);}
 if(BUTTON_DIM_CHANNEL1==3){set_value_dim(49,1);}
 if(BUTTON_DIM_CHANNEL1==4){set_value_dim(40,1);}
 flag_setdimmer1=0;
 }

 if(flag_setdimmaster){
 if(BUTTON_DIM_MASTER==0)
 {
 set_value_dim(0,1);
 set_value_dim(0,2);
 set_value_dim(0,3);
 set_value_dim(0,4);
 }
 if(BUTTON_DIM_MASTER==1)
 {
 set_value_dim(93,1);
 set_value_dim(93,2);
 set_value_dim(93,3);
 set_value_dim(93,4);
 }
 if(BUTTON_DIM_MASTER==2)
 {
 set_value_dim(60,1);
 set_value_dim(60,2);
 set_value_dim(60,3);
 set_value_dim(60,4);
 }
 if(BUTTON_DIM_MASTER==3)
 {
 set_value_dim(49,1);
 set_value_dim(49,2);
 set_value_dim(49,3);
 set_value_dim(49,4);
 }
 if(BUTTON_DIM_MASTER==4)
 {
 set_value_dim(40,1);
 set_value_dim(40,2);
 set_value_dim(40,3);
 set_value_dim(40,4);
 }
 flag_setdimmaster=0;
 }


 if(BELL_ENABLE){
 }



 if(DIMMER_ALL_20PERCENT){
 DIMMER_ALL_20PERCENT=0;
 set_value_dim(20,2);
 set_value_dim(20,1);
 BUTTON_DIM_CHANNEL2=3;
 BUTTON_DIM_CHANNEL1=3;
 }


 if(ETHERNET_BUTTON_DEVICE_0==1){
 ETHERNET_BUTTON_DEVICE_0=0;
 if(ETHERNET_BUTTON_DIM0==1){VALUE4CHANNEL=40;}
 if(ETHERNET_BUTTON_DIM0==2){VALUE4CHANNEL=49;}
 if(ETHERNET_BUTTON_DIM0==3){VALUE4CHANNEL=60;}
 if(ETHERNET_BUTTON_DIM0==4){VALUE4CHANNEL=93;}
 if(ETHERNET_BUTTON_DIM0>=5){
 ETHERNET_BUTTON_DIM0=0;
 VALUE4CHANNEL=25;}

 ETHERNET_BUTTON_DEVICE_1=1;
 ETHERNET_BUTTON_DEVICE_2=1;
 ETHERNET_BUTTON_DEVICE_3=1;
 ETHERNET_BUTTON_DEVICE_4=1;
 out_relay^= 0b00000000000000001000000000000000 ;
 }
 if(ETHERNET_BUTTON_DEVICE_1==1){
 ETHERNET_BUTTON_DEVICE_1=0;
 if(ETHERNET_BUTTON_DIM1)
 {
 out_relay|= 0b00000000000000000000000000000001 ;
 set_value_dim(VALUE4CHANNEL,1);
 }
 if(!ETHERNET_BUTTON_DIM1)
 {
 out_relay&=~ 0b00000000000000000000000000000001 ;
 set_value_dim(0,1);
 }
 }
 if(ETHERNET_BUTTON_DEVICE_2==1){
 ETHERNET_BUTTON_DEVICE_2=0;
 if(ETHERNET_BUTTON_DIM2)
 {
 out_relay|= 0b00000000000000000000000000000010 ;
 set_value_dim(VALUE4CHANNEL,2);
 }
 if(!ETHERNET_BUTTON_DIM2)
 {
 out_relay&=~ 0b00000000000000000000000000000010 ;
 set_value_dim(0,2);
 }
 }
 if(ETHERNET_BUTTON_DEVICE_3==1){
 ETHERNET_BUTTON_DEVICE_3=0;
 if(ETHERNET_BUTTON_DIM3)
 {
 out_relay|= 0b00000000000000000000000000000100 ;
 set_value_dim(VALUE4CHANNEL,3);
 }
 if(!ETHERNET_BUTTON_DIM3)
 {
 out_relay&=~ 0b00000000000000000000000000000100 ;
 set_value_dim(0,3);
 }
 }
 if(ETHERNET_BUTTON_DEVICE_4==1){
 ETHERNET_BUTTON_DEVICE_4=0;
 if(ETHERNET_BUTTON_DIM4)
 {
 out_relay|= 0b00000000000000000100000000000000 ;
 set_value_dim(VALUE4CHANNEL,4);
 }
 if(!ETHERNET_BUTTON_DIM4)
 {
 out_relay&=~ 0b00000000000000000100000000000000 ;
 set_value_dim(0,4);
 }
 }
#line 1891 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
 SPI_Ethernet_doPacket();

 if(flag_reset_ip==1){
 flag_reset_ip=0;
 goto RESET;
 }
#line 1915 "C:/Users/Lenovo/Desktop/THANG8-DIMMER ETHENET/HYDE_BAR(DIMMER_ETH)172.16.0.123/RCUHAGER.c"
 }
}
