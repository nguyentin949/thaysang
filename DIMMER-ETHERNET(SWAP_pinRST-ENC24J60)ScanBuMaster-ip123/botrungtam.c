#include "main.h"
#include "RCUHAGER.c"
                  // TEST PORT - RS485-KEYCARD- DIM AC (VALUE CHANGE TO 93 ) HONGKONG - HANOI - 17/12/2017
                  // flash IP enable
                   // R DETECTZERO = 150K, R OPTO = 10K, LED DETECT STM8 -PORTC C5
                   // luu y port 3 co 3 input 2 output
                   //       port 4 co 2 input 3 output -> led on/off khac port nhau
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

const code   char    *LoginPage =
"<html><head></head><title>Login Page</title>\
<h1>VALI TEST HAGER -\
<br>IP default:192.168.1.123 -\
<br>MAC:00-14-A5-76-18-23</h1>\
</body></html>\
";

const code   char    *indexPage =
"</html>\
" ;
const code   char    *HomePage =
"</html>\
" ;
const code char    *ServicePage =
"</html>\
" ;

const code char    *LightingPage =
"</html>\
" ;
const code char    *CurtainPage =
"</html>\
" ;
const code char    *ScenesPage =
"</html>\
" ;
const code char    *Fan_SpeedPage =
"</html>\
" ;

const code char    *Dimer_ExtantPage =
"</html>\
" ;

const code char    *Device_ExtantPage =
"</html>\
" ;
             //phien ban hotel
const code char    *SettingPage =
"</html>\
";


unsigned char   myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x18, 0x23};   // my MAC address
unsigned char   myIpAddr[4] = {192,168,1,123};                   // my IP Address CHO LAN CHAY DAU TIEN
 // unsigned char   myIpAddr[4];                   // my IP Address

unsigned char   gwIpAddr[4];                    // gateway (router) IP address
unsigned char   ipMask[4]    = {255, 255, 255, 0 };                   // network mask (for example : 255.255.255.0)
unsigned char   dnsIpAddr[4] = {192, 168,  1,  1 };                   // DNS server IP address
unsigned char   getRequest[100];
unsigned char   dyna[40] ;
unsigned char   buf[40];
unsigned char   HOPTEST[16];
unsigned int    index_page=7;   // Page_Device_Extant  _ HOTEL PROJECT
unsigned char   ipAddress[4];
unsigned long Address = 0x08008000,i,temp,checkConnect=0;
unsigned long* ptr;
unsigned char  curtain;
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
unsigned char flag_button_dim2=0;
unsigned char flag_button_dim1=0;
unsigned char flag_setdimmer1=0;
unsigned char flag_setdimmer2=0;
unsigned char BUTTON_DIM_CHANNEL1=0;
unsigned char BUTTON_DIM_CHANNEL2=0;
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
void settingEthenet(void){
    ptr = (unsigned long*)Address;
    i=*ptr;
    if(i==0xffffffff){    // khi moi nap frimware thi dia chi ip se la fffffff
        FLASH_ErasePage(Address);
        // start Address Flash : 0x08000000  - bo nho chuong trinh
        // stm32f103vct6 co 256 kb flash -> 0x08000000->0x08040000
        // add=0800.8000 -> 32kb dau tien cua chuong
        //Used ROM (bytes): 29581 (11%)  Free ROM (bytes): 232563 (89%)
        //Static RAM (bytes): 641   Dynamic RAM (bytes): 48507
        FLASH_Write_Word(Address,0xC0A80178);     // c0:a8:01:7c  = 192.168.1.124
    }
    //i=0xC0A8017A ;       // hop sua lai i= ma ko can flash address
    myIpAddr[0]=i>>24;
    myIpAddr[1]=i>>16;
    myIpAddr[2]=i>>8;
    myIpAddr[3]=i;
    gwIpAddr[0]=myIpAddr[0];
    gwIpAddr[1]=myIpAddr[1];
    gwIpAddr[2]=myIpAddr[2];
    gwIpAddr[3]=1;
    SPI_Ethernet_Init(myMacAddr, myIpAddr, SPI_Ethernet_FULLDUPLEX);
    SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr);
}
void putChar(unsigned char c){
    while(UART4_SRbits.TC==0);
    UART4_DRbits.DR = c;
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
    for(len = 0;len < 30;len++){
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
        }
    }
    else if(getRequest[5] == 's'){
        STAT = ~STAT;         // LED INDICATOR HOPTEST
        len =  putConstString(httpHeader);
        len += putConstString(httpMimeTypeHTML);
        switch (index_page) {
        case Page_Service:
            len += putConstString("r");
            LongWordToStr(status_wed_service, dyna);
            len += putString(dyna);
            break;
        case Page_Lighting:
            len += putConstString("r");
            LongWordToStr(status_wed_light, dyna);
            len += putString(dyna);
            break;
        case Page_Curtain:
            len += putConstString("r");
            LongWordToStr(status_wed_curtain, dyna);
            len += putString(dyna);
            break;
        case Page_Scenes:
            len += putConstString("r");
            LongWordToStr(status_wed_scenes, dyna);
            len += putString(dyna);
            break;
        case Page_Fan_Speed:
            len += putConstString("r");
            LongWordToStr(status_wed_fan, dyna);
            len += putString(dyna);
            break;
        case Page_Dimer_Extant:
            len += putConstString("r");
            LongWordToStr(status_wed_dimer, dyna);
            len += putString(dyna);
            break;
        case Page_Device_Extant:
            len += putConstString("r");
            LongWordToStr(wed_status_button, dyna);
            len += putString(dyna);
            break;
        default:
            break;
        }
    }
    switch (index_page) {
    case Page_Service:
        if(getRequest[5] == 'o'){
            if(isdigit(getRequest[6])){
                if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
                switch (vt_button) {
                case 0://SERVICE_1
                //    out_relay^=RELAY_1;
                //    LD1_0=1;
                    break;
                case 1://SERVICE_2
                //    out_relay^=RELAY_2;
                //    LD1_1=1;
                    break;
                default:
                    break;
                }
            }
            len += putConstString("r");
            status_wed_service|=(shift<<vt_button);
            LongWordToStr(status_wed_service, dyna);
            len += putString(dyna);
            xuat_32bit(out_relay);
        }
        else if(getRequest[5] == 'f'){
            if(isdigit(getRequest[6])){
                if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
            }
            status_wed_service|=(shift<<vt_button);
            len += putConstString("r");
            LongWordToStr(status_wed_service, dyna);
            len += putString(dyna);
        }
        break;
    case Page_Lighting:
        if(getRequest[5] == 'o'){
            if(isdigit(getRequest[6])){
                if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
                switch (vt_button) {
                    case 0://ENTRANCE
                        //out_relay|=RELAY_3|RELAY_4|RELAY_5;
                        //LD1_2=1;
                        break;
                    case 1://MASTER
                        //LD2_0=1;
                        //if(flag_but_master==BUT_MASTER_OFF){
                        //    flag_but_master=BUT_MASTER_ON;
                        //    out_relay|=RELAY_3|RELAY_4|RELAY_5|RELAY_6|RELAY_7|RELAY_13|RELAY_14
                        //            |RELAY_15|RELAY_16|RELAY_17|RELAY_18|RELAY_19|RELAY_20|
                        //            RELAY_21|RELAY_22|RELAY_23|RELAY_24|RELAY_25|RELAY_26|
                        //            RELAY_27|RELAY_28|RELAY_29|RELAY_30|RELAY_31|RELAY_32;
                        //}
                        //else if(flag_but_master==BUT_MASTER_ON){
                        //    flag_but_master=BUT_MASTER_OFF;
                        //    out_relay&=~(RELAY_3|RELAY_4|RELAY_5|RELAY_6|RELAY_7|RELAY_13|RELAY_14
                        //                 |RELAY_15|RELAY_16|RELAY_17|RELAY_18|RELAY_19|RELAY_20|
                        //                 RELAY_21|RELAY_22|RELAY_23|RELAY_24|RELAY_25|RELAY_26|
                        //                 RELAY_27|RELAY_28|RELAY_29|RELAY_30|RELAY_31|RELAY_32);
                        //}
                        break;
                    case 2://LIGHT_BATH
                        //out_relay^=RELAY_6;
                        //LD2_1=1;
                        break;
                    case 3://LIGHT_READING
                        //out_relay^=RELAY_7;
                        //LD2_2=1;
                        break;
                    case 4://LIGHT_BEDSIDE
                        //flag_but_dimer=1;
                        //LD3_0=1;
                        break;
                    default:
                        break;
                }
            }
            len += putConstString("r");
            status_wed_light|=(shift<<vt_button);
            LongWordToStr(status_wed_light, dyna);
            len += putString(dyna);
            xuat_32bit(out_relay);
        }
        else if(getRequest[5] == 'f'){
            if(isdigit(getRequest[6])){
                if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
                switch (vt_button) {
                case 0://ENTRANCE
                    break;
                case 1://MASTER
                    break;
                case 2://LIGHT_BATH
                    break;
                case 3://LIGHT_READING
                    break;
                case 4://LIGHT_BEDSIDE
                //    LD3_0=0;
                    //on_off_dimer
                //    if(count_but_dimer<50){//1s
                //        if(value_dimer==0){  //on
                //            flag_but_dimer=0;
                //            count_but_dimer=0;
                //            value_dimer=100;
                //            flag_dimer_up_down=DIM_DOWN;
                //            set_value_dim(value_dimer,1);
                //        }
                //        else{ //off
                //            flag_but_dimer=0;
                //            count_but_dimer=0;
                //            value_dimer_save=value_dimer;
                //            flag_dimer_up_down=DIM_UP;
                //            value_dimer=0;
                //            set_value_dim(value_dimer,1);
                //        }
                //    }
                //    else{
                //        if(flag_dimer_up_down==DIM_UP){
                //            flag_dimer_up_down=DIM_DOWN;
                //        }
                //        else if(flag_dimer_up_down==DIM_DOWN){
                //            flag_dimer_up_down=DIM_UP;
                //        }
                //    }
                    break;
                default:
                    break;
                }
            }
            flag_but_dimer=0;
            len += putConstString("r");
            status_wed_light|=(shift<<vt_button);
            LongWordToStr(status_wed_light, dyna);
            len += putString(dyna);
        }
        break;
    case Page_Curtain:
        if(getRequest[5] == 'o'){
            if(isdigit(getRequest[6])){
                if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
                switch (vt_button) {
                case 0://CURTAIN_O 1   OPEN THEN CLOSE
                      //out_relay^=RELAY_8;     // TUNR ON RL8
                      //out_relay&=~RELAY_9;
                    break;
                case 1://CURTAIN_C 1   OPEN THEN STOP
                      //out_relay^=RELAY_8;
                      //out_relay&=~RELAY_9;
                    break;
                case 2://CURTAIN_O 2
                      //out_relay^=RELAY_9;
                      //out_relay&=~RELAY_8;
                      break;
                case 3://CURTAIN_C 2
                      //out_relay&=~RELAY_8;
                      //out_relay^=RELAY_9;
                    break;

                default:
                    break;
                }
            }
            len += putConstString("r");
            status_wed_curtain|=(shift<<vt_button);
            LongWordToStr(status_wed_curtain, dyna);
            len += putString(dyna);
            //xuat_32bit(out_relay);    //de cho chuong trinh ngat button xuat
        }
        else if(getRequest[5] == 'f'){
            if(isdigit(getRequest[6])){
                if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
                switch (vt_button) {
                case 0://CURTAIN_O 1
                    //out_relay&=~RELAY_8;
                    break;
                case 1://CURTAIN_C 1  OPEN THEN STOP ( TURN ON 8&9)
                    //out_relay^=RELAY_9;
                    //FLAG_CURTAIN_STOP=1;
                    break;
                case 2://CURTAIN_O 2
                    //out_relay&=~RELAY_9;
                    break;
                case 3://CURTAIN_C 2
                     //out_relay^=RELAY_8;
                     //FLAG_CURTAIN_STOP=1;
                    break;
                default:
                    break;
                }
            }
            len += putConstString("r");
            status_wed_curtain&=~(shift<<vt_button);
            LongWordToStr(status_wed_curtain, dyna);
            len += putString(dyna);
            //xuat_32bit(out_relay);   //de cho chuong trinh ngat button xuat ???
        }
        break;
    case Page_Scenes:
        if(getRequest[5] == 'o'){
            if(isdigit(getRequest[6])){
                if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
                switch (vt_button) {
                case 0://S_RELAX
                //    LD4_0=1;
                //    LD4_1=0;
                //    LD4_2=0;
                //    out_relay=0;
                //    out_relay|=RELAY_3|RELAY_4;
                    break;
                case 1://S_NIGHT
                 //   LD4_1=1;
                 //   LD4_0=0;
                 //   LD4_2=0;
                 //   out_relay=0;
                 //   out_relay|=RELAY_1;
                 //   set_value_dim(20,1);
                    break;
                case 2://S_PARTY
                 //   LD4_2=1;
                 //  LD4_0=0;
                 //   LD4_1=0;
                 //   out_relay|=RELAY_1|RELAY_3|RELAY_4|RELAY_5;
                    break;
                default:
                    break;
                }
            }
            len += putConstString("r");
            status_wed_scenes|=(shift<<vt_button);
            LongWordToStr(status_wed_scenes, dyna);
            len += putString(dyna);
            xuat_32bit(out_relay);
        }
        else if(getRequest[5] == 'f'){
            if(isdigit(getRequest[6])){
                if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
                switch (vt_button) {
                case 0://S_RELAX
                    break;
                case 1://S_NIGHT
                    break;
                case 2://S_PARTY
                    break;
                default:
                    break;
                }
            }
            len += putConstString("r");
            status_wed_scenes|=(shift<<vt_button);
            LongWordToStr(status_wed_scenes, dyna);
            len += putString(dyna);
        }
        break;
    case Page_Fan_Speed:
        if(getRequest[5] == 'o'){
            if(isdigit(getRequest[6])){
                if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
                switch (vt_button) {
                case 0://FAN_ON_OFF
                    break;
                case 1://FAN_LOW
                    break;
                case 2://FAN_MEDIUM
                    break;
                case 3://FAN_HIGHT
                    break;
                default:
                    break;
                }
            }
            len += putConstString("r");
            if((out_relay&FAN_L)?1:0)status_wed_fan|=(shift<<1);
            else status_wed_fan&=~(shift<<1);
            if((out_relay&FAN_M)?1:0)status_wed_fan|=(shift<<2);
            else status_wed_fan&=~(shift<<2);
            if((out_relay&FAN_H)?1:0)status_wed_fan|=(shift<<3);
            else status_wed_fan&=~(shift<<3);
            LongWordToStr(status_wed_fan, dyna);
            len += putString(dyna);
        }
        else if(getRequest[5] == 'f'){
            if(isdigit(getRequest[6])){
                if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
                switch (vt_button) {
                case 0://FAN_ON_OFF
                    break;
                case 1://FAN_LOW
                    break;
                case 2://FAN_MEDIUM
                    break;
                case 3://FAN_HIGHT
                    break;
                default:
                    break;
                }
            }
            len += putConstString("r");
            if((out_relay&FAN_L)?1:0)status_wed_fan|=(shift<<1);
            else status_wed_fan&=~(shift<<1);
            if((out_relay&FAN_M)?1:0)status_wed_fan|=(shift<<2);
            else status_wed_fan&=~(shift<<2);
            if((out_relay&FAN_H)?1:0)status_wed_fan|=(shift<<3);
            else status_wed_fan&=~(shift<<3);
            LongWordToStr(status_wed_fan, dyna);
            len += putString(dyna);
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
            len += putConstString("r");
            status_wed_dimer|=(shift<<vt_button);
            LongWordToStr(status_wed_dimer, dyna);
            len += putString(dyna);
        }
        else if(getRequest[5] == 'f'){
            if(isdigit(getRequest[6])){
                if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
                switch (vt_button) {
                case 0://up1
                      flag_dimer_ex[1]=0;
                      count_time_dimer_ex[1]=0;
                      DIM2_EVERGREEN = 0;
                    break;
                case 1://dow1
                      flag_dimer_ex[1]=0;
                      count_time_dimer_ex[1]=0;
                      DIM2_EVERGREEN = 0;
                    break;
                case 2://up34
                    //flag_dimer_ex[1]=DIM_DE_EX;
                    //set_value_dim(50,2);
                    // HOP ADD
                      flag_dimer_ex[2]=0;
                      count_time_dimer_ex[2]=0;
                      DIM4_EVERGREEN = 0;
                    break;
                case 3://down34
                    //flag_dimer_ex[1]=DIM_DE_EX;
                    //set_value_dim(0,2);
                    flag_dimer_ex[2]=0;
                    count_time_dimer_ex[2]=0;
                    DIM4_EVERGREEN = 0;
                    break;
                case 4://up3
                    //flag_dimer_ex[2]=DIM_DE_EX;
                    //set_value_dim(50,3);
                    break;
                case 5://down3
                    //flag_dimer_ex[2]=DIM_DE_EX;
                    //set_value_dim(0,3);
                default:
                    break;
                }
            }
            len += putConstString("r");
            status_wed_dimer&=~(shift<<vt_button);
            LongWordToStr(status_wed_dimer, dyna);
            len += putString(dyna);
        }
        break;
    case Page_Device_Extant:
        if(getRequest[5] == 'd'){
            if(isdigit(getRequest[6])){
                if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
            }
            if(isdigit(getRequest[6])){
                if(getRequest[7]=='$')vt_button=getRequest[6]-'0';
                else if(getRequest[8]=='$')vt_button=chuoi_so(getRequest,6,7);
                else if(getRequest[9]=='$')vt_button=chuoi_so(getRequest,6,8);
            }
            // hop edit chong treo
            //TIM1_CR1bits.CEN=0;   // KO CO TAC DUNG TURN Off TIMER1 de khong bi ngat button
            len += putConstString("r");
            wed_status_button^=(shift<<vt_button);
            out_relay^=(shift<<vt_button);
            LongWordToStr(wed_status_button, dyna);
            len += putString(dyna);
            //TIM1_CR1bits.CEN=1;   //  KO CO TAC DUNG TURN On TIMER1
            //xuat_32bit(out_relay);   //de cho chuong trinh ngat button xuat
        }
        break;
    case Page_Setting:
        copyBuf(getRequest,buf,40);
        saveIP(buf);
        if(getRequest[5] == 'f'){
            len += putConstString("r");
            len += putString(dyna);
        }
        break;
    default:
        break;
    }
    if(len == 0){
        len =  putConstString(httpHeader);
        len += putConstString(httpMimeTypeHTML);
        switch (index_page) {
        case Page_Login:
            len += putConstString(LoginPage);
            break;
        case Page_Service:
            len += putConstString(indexPage);
            len += putConstString(ServicePage);
            break;
        case Page_Lighting:
            len += putConstString(indexPage);
            len += putConstString(LightingPage);
            break;
        case Page_Curtain:
            len += putConstString(indexPage);
            len += putConstString(CurtainPage);
            break;
        case Page_Scenes:
            len += putConstString(indexPage);
            len += putConstString(ScenesPage);
            break;
        case Page_Fan_Speed:
            len += putConstString(indexPage);
            len += putConstString(Fan_SpeedPage);
            break;
        case Page_Dimer_Extant:
            len += putConstString(indexPage);
            len += putConstString(Dimer_ExtantPage);
            break;
        case Page_Device_Extant:
            len += putConstString(Device_ExtantPage);
            break;
        case Page_Setting:
            len += putConstString(SettingPage);
            break;
        case Page_Home:
            len += putConstString(HomePage);
            break;
        default:
        len += putConstString(indexPage);
            len += putConstString(Device_ExtantPage);
            break;
        }
    }
    return(len);
}
unsigned int    SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags){
    return(0);
}

void timer1_isr() iv IVT_INT_TIM1_UP ics ICS_AUTO { //20 ms
    unsigned char i_isr=0,but_isr=0;
    //unsigned long shif_t=1;
    ////// hop them
    //unsigned int len=0;

    //unsigned char vt_button=0;
    unsigned long shift=1;
    // UIF : update interrupt Flag/ set by hardware; clear by software
    if(TIM1_SRbits.UIF==1)
    {
        TIM1_SRbits.UIF=0;
        //scan button
        //PORT 1
        but_sample[0][SAMPLE-1]=!BUT1_0;
        but_sample[1][SAMPLE-1]=!BUT1_1;
        but_sample[2][SAMPLE-1]=!BUT1_2;
        //PORT 2
        but_sample[3][SAMPLE-1]=!BUT2_0;
        but_sample[4][SAMPLE-1]=!BUT2_1;
        but_sample[5][SAMPLE-1]=!BUT2_2;
        //PORT 3
        but_sample[6][SAMPLE-1]=!BUT3_0;
        but_sample[7][SAMPLE-1]=!BUT3_1;
        but_sample[8][SAMPLE-1]=!BUT3_2;
        //PORT 4
        but_sample[9][SAMPLE-1]=!BUT4_0;
        but_sample[10][SAMPLE-1]=!BUT4_1;
        //PORT 5
        but_sample[11][SAMPLE-1]=!BUT5_0;
        but_sample[12][SAMPLE-1]=!BUT5_1;
        //PORT 6
        but_sample[13][SAMPLE-1]=!BUT6_0;
        //PORT 7
        but_sample[14][SAMPLE-1]=!BUT7_0;
        //PORT 8
        but_sample[15][SAMPLE-1]=!BUT8_0;
        but_sample[16][SAMPLE-1]=!BUT8_1;
        //PORT 9
        but_sample[17][SAMPLE-1]=!BUT9_0;
        but_sample[18][SAMPLE-1]=!BUT9_1;
        //PORT 10
        but_sample[19][SAMPLE-1]=!BUT10_0;
        but_sample[20][SAMPLE-1]=!BUT10_1;
        //PORT 11
        but_sample[21][SAMPLE-1]=!BUT11_0;
        but_sample[22][SAMPLE-1]=!BUT11_1;
        //PORT 12
        but_sample[23][SAMPLE-1]=!BUT12_0;

        for(but_isr=0;but_isr<SUM_BUT;but_isr++){
            for(i_isr=0;i_isr<SAMPLE-1;i_isr++){
                but_sample[but_isr][i_isr]=but_sample[but_isr][i_isr+1];
            }
            but_sum_sample[but_isr]=0;
            for(i_isr=0;i_isr<SAMPLE;i_isr++){
                but_sum_sample[but_isr]+=but_sample[but_isr][i_isr];
            }
            if(but_sum_sample[but_isr]>=PRESS){
                but_state[but_isr]=PRESS;
            }
            else if(but_sum_sample[but_isr]==UNPRESS){
                but_state[but_isr]=UNPRESS;
            }
            if(but_state[but_isr]==PRESS){
                if(but_status[but_isr]==UNPRESS){
                    but_status[but_isr]=PRES_DOW;
                }
                else if(but_status[but_isr]==PRES_DOW){
                    but_status[but_isr]=PRESSING;
                }
                else if(but_status[but_isr]==PRESSING){
                    but_status[but_isr]=PRESSING;
                }
            }
            else if(but_state[but_isr]==UNPRESS){
                if ((but_status[but_isr]==PRESSING)||(but_status[but_isr]==PRES_DOW)){
                    but_status[but_isr]=PRES_UP;
                }
                else if(but_status[but_isr]==PRES_UP){
                    but_status[but_isr]=UNPRESS;
                }
                else if(but_status[but_isr]==UNPRESS){
                    but_status[but_isr]=UNPRESS;
                }
            }
        }
/* a=target variable, b=bit number to act upon 0-n
#define BIT_SET(a,b) ((a) |= (1<<(b)))
#define BIT_CLEAR(a,b) ((a) &= ~(1<<(b)))
#define BIT_FLIP(a,b) ((a) ^= (1<<(b)))
#define BIT_CHECK(a,b) ((a) & (1<<(b)))

 x=target variable, y=mask
#define BITMASK_SET(x,y) ((x) |= (y))
#define BITMASK_CLEAR(x,y) ((x) &= (~(y)))
#define BITMASK_FLIP(x,y) ((x) ^= (y))
#define BITMASK_CHECK(x,y) (((x) & (y)) == (y))
*/
        duphong67_A8=~duphong67_A8;             // LED INDICAROR QUET BAN PHIM
    //PORT 1 _ 3INPUT-3LED
    // C6,C7,DIM2 - RELAY3,RELAY2,DIM-CHANNEL2
         // C6-TIVI   RELAY3
        if(but_status[0]==PRES_DOW){
            LED_1_0=1;
            out_relay^=RELAY_3;
        }
        else if(but_status[0]==PRES_UP){
             LED_1_0=(out_relay&RELAY_3)?1:0;
        }
        // C7-READING    RELAY2
        if(but_status[1]==PRES_DOW){
            LED_1_1=1;
            out_relay^=RELAY_2;
        }
        else if(but_status[1]==PRES_UP){
            LED_1_1=(out_relay&RELAY_2)?1:0;
        }
        // DIMMER CHANNEL 2
        if(but_status[2]==PRES_DOW){
            LED_1_2=1;
            if(!flag_button_dim2){
            flag_button_dim2=1;
            if(BUTTON_DIM_CHANNEL2<=3){BUTTON_DIM_CHANNEL2++;}
            if(BUTTON_DIM_CHANNEL2>=4){BUTTON_DIM_CHANNEL2=0;}
            flag_setdimmer2=1;
            }
        }
        else if(but_status[2]==PRES_UP){
            LED_1_2=0;
            flag_button_dim2=0;
        }
        // PORT 2  CHUA SU DUNG
        // CHUA SU DUNG -TEST TOOGLE
        if(but_status[3]==PRES_DOW){
            LED_2_0^=1;
        }
        else if(but_status[3]==PRES_UP){
            //LED_2_0=(out_relay&RELAY_ )?1:0;
        }
        // CHUA SU DUNG -TEST TOOGLE
        if(but_status[4]==PRES_DOW){
            LED_2_1^=1;
        }
        else if(but_status[4]==PRES_UP){
            //LED_2_1=(out_relay&RELAY_ )?1:0;
        }
        
        //  CHUA SU DUNG -TEST TOOGLE
        if(but_status[5]==PRES_DOW){
            LED_2_2^=1;
        }
        else if(but_status[5]==PRES_UP){
            //LED_2_2=(out_relay&RELAY_ )?1:0;
        }

        // PORT3  (3IN-2LED)_KO CO LED BUTTON2 LED_3_1=NULL)
        //  KO SU DUNG
        if(but_status[6]==PRES_DOW){
            //LED_3_0=1;
        }
        else if(but_status[6]==PRES_UP){
             //LED_3_0=0;
        }
        // DIMMER CHANNEL 1
        if(but_status[7]==PRES_DOW){
             LED_3_0=1;
             if(!flag_button_dim1){
            flag_button_dim1=1;
            if(BUTTON_DIM_CHANNEL1<=3){BUTTON_DIM_CHANNEL1++;}
            if(BUTTON_DIM_CHANNEL1>=4){BUTTON_DIM_CHANNEL1=0;}
            flag_setdimmer1=1;
            }
        }
        else if(but_status[7]==PRES_UP){
             LED_3_0=0;
            flag_button_dim1=0;
        }
        // MASTER BEDSIDE
        if(but_status[8]==PRES_DOW){
            LED_3_2=1;
        }
        else if(but_status[8]==PRES_UP){
            LED_3_2=0;
        }
        // PORT4(2IN-3LED)( KO CO BUTTON3)
        //  c8-living room - Relay_1
        if(but_status[9]==PRES_DOW){
            LED_4_0=1;
            out_relay^=RELAY_1;
        }
        else if(but_status[9]==PRES_UP){
             LED_4_0=(out_relay&RELAY_1)?1:0;
        }
        //  c9-balcone - Relay_16
        if(but_status[10]==PRES_DOW){
             LED_4_1=1;
             out_relay^=RELAY_16;
        }
        else if(but_status[10]==PRES_UP){
             LED_4_1=(out_relay&RELAY_16)?1:0;
        }

        // PORT5-(2LED-2IN) c3(table)+c11(kitchen)               r6,r14
        // RELAY6 C3 TABLE
        if(but_status[11]==PRES_DOW){
            LED_5_0=1;
            out_relay^=RELAY_6;
        }
        else if(but_status[11]==PRES_UP){
            LED_5_0=(out_relay&RELAY_6)?1:0;

        }
        // RELAY-14 C11:KITCHEN
        if(but_status[12]==PRES_DOW){
            LED_5_1=1;
            out_relay^=RELAY_14;
            //wed_status_button^=(shift<<13);
            //TIMEOUT_RELAY_14 =0;
        }
        else if(but_status[12]==PRES_UP){
            LED_5_1=(out_relay&RELAY_14)?1:0;
        }
        
        // PORT6(1LED-1IN) ENTRANCE
        //RELAY-8 C1
        if(but_status[13]==PRES_DOW){
            LED_6_0=1;
            out_relay^=RELAY_8;
        }
        else if(but_status[13]==PRES_UP){
            LED_6_0=(out_relay&RELAY_8)?1:0;
        }
        // PORT7-(1LED-1IN)
        // MASTER BEDSIDE RIGHT -TURN OFF ALL -"EXCEPT c1"
        if(but_status[14]==PRES_DOW){
            LED_7_0=1;
            MASTER_SWITCH=1;

        }
        else if(but_status[14]==PRES_UP){
            LED_7_0= 0;
            MASTER_SWITCH=0;
        }
        //PORT8- c4(toilet)+c5(washface)              r5,r4
        // REAY-5 C4:TOILET
        if(but_status[15]==PRES_DOW){
            LED_8_0=1;
            out_relay^=RELAY_5;
        }
        else if(but_status[15]==PRES_UP){
            LED_8_0=(out_relay&RELAY_5)?1:0;
        }

        //  RELAY-4 C5: WASHFACE
        if(but_status[16]==PRES_DOW){
            LED_8_1=1;
            out_relay^=RELAY_4;
            }
        else if(but_status[16]==PRES_UP){
            LED_8_1=(out_relay&RELAY_4)?1:0;
        }
        ////PORT9-0: c14-c15(curtain)                     r11,r10( 1-input)
        //    DIEU KHIEN REM CUA
        if(but_status[17]==PRES_DOW){
        LED_9_0^=1;
        }
        else if(but_status[17]==PRES_UP){
        //LED_9_0=(out_relay&RELAY_9)?1:0;
        }
        // PORT9-1: KO SU DUNG
        if(but_status[18]==PRES_DOW){
            LED_9_1^=1;
        }
        else if(but_status[18]==PRES_UP){
            //LED_9_1=(out_relay&RELAY_10)?1:0;
        }
        //  PORT10 MUR+DND
        // 10-0 MAKE UP ROOM
        if(but_status[19]==PRES_DOW){
            if(!DO_NOT_DISTURB)  {
            LED_10_0^=1; // LED MUR port10
            LED_11_0^=1;  // LED MUR port11
                                 }
        }
        else if(but_status[19]==PRES_UP){

        }
        // PORT10 DND
        if(but_status[20]==PRES_DOW){
            LED_10_1^=1; // LED DND port10
            LED_11_1^=1;  // LED DND port11
              ///// UPDATE WHEN PRESS DND THEN MAKE MUR OFF
            LED_10_0=0; // LED MUR port10 OFF
            LED_11_0=0;  // LED MUR port11  OFF
            DO_NOT_DISTURB=(DO_NOT_DISTURB^0x01);

        }
        else if(but_status[20]==PRES_UP){
        }
        // PORT11
        // 1-input cho BELL OUTSIDE-RELAY-13;
        //LED_11_0=1;  MUR
        //LED_11_1=1;  DND
        if(but_status[21]==PRES_DOW){
             if(!DO_NOT_DISTURB){
             out_relay|=RELAY_13;
             BELL_ENABLE=1;
             }
        }
        else if(but_status[21]==PRES_UP){
        }
        // KO SU DUNG -
        if(but_status[22]==PRES_DOW){
        }
        else if(but_status[22]==PRES_UP){
        }

        // PORT12 (1IN - 1LED) - KEYCARD
        // RELAY-12: SOCKET
        if(but_status[23]==PRES_DOW){
            // LED_12_0=1;  khong co den
            KEYCARD_COUNTER_CLOSE=0;
            KEYCARD_INSERT=1;
        }
        else if(but_status[23]==PRES_UP){
            // LED_12_0=0;
            KEYCARD_INSERT=0;
        }
        
    //XU LY MASTER BEDSIDE LEFT
    if(MASTER_SWITCH==1){
    //PORT1 c6(tivi),c7(reading),dim2            r3,r2,dim2
    //PORT2
    //PORT3
    //PORT4 dim1(90%,60%,20%,0%)+master(dim20%, ON c1)
    //PORT5 c3(table)+c11(kitchen)               r6,r14
    //PORT6 c1                                   r8(entrance)
    //PORT7 MASTER      all OFF
    //PORT8 c4(toilet)+c5(washface)              r5,r4
    //PORT9 c14-c15(curtain)                     r11,r10( 1-input)
    //PORT10   DND-MUR
    //PORT11   BELL-c12+ DND-MUR (OUTSIDE)       R13
    //PORT12 KEYCARD    SOCKET(C13)+             R12
    //                  c1+c5+c7+c10              r8,r4,r2,r15
    // c10- relay-15  -> ko co button dieu khien, qua keycard,master
    //useless        c8,c2,c16,c9        r1,r7,r9,r16
    out_relay&=~RELAY_1;
    out_relay&=~RELAY_2;
    out_relay&=~RELAY_3;
    out_relay&=~RELAY_4;
    out_relay&=~RELAY_5;
    out_relay&=~RELAY_6;
    out_relay&=~RELAY_7;
    out_relay|=RELAY_8; //c1 ON WHEN MASTER_SWITCH - COMMAND CONTROL ABOVE PORT7
    out_relay&=~RELAY_16;
    out_relay&=~RELAY_15;
    out_relay&=~RELAY_14;
    out_relay&=~RELAY_13;
    out_relay&=~RELAY_10;
    out_relay&=~RELAY_9;
    // TURN OFF LED
    //  PORT11;PORT9
    LED_11_0=0;  // MUR outside
    LED_11_1=0;  // DND outside
    LED_9_0=0;
    LED_9_1=0;
    //PORT10
    LED_10_0=0;  // MUR inside
    LED_10_1=0;  // DND inside
    DO_NOT_DISTURB=0;
    //PORT8
    LED_8_0=0;
    LED_8_1=0;
    //PORT6
    LED_6_0=0;
    //PORT5
    LED_5_0=0;
    LED_5_1=0;
    //PORT4
    LED_4_0=0;
    LED_4_1=0;
    //PORT3
    LED_3_0=1; // SL1 ON WHEN MASTER_SWITCH - COMMAND CONTROL ABOVE PORT7
    LED_3_2=0;
    //port2
    LED_2_0=0;    // S1
    LED_2_1=0;    // S2
    LED_2_2=0;    // S5
    //PORT1
    LED_1_0=0;
    LED_1_1=0;
    LED_1_2=0;
    }
    


    // TRONG BO KEYCARD CUA HAGER CO SAN DELAY 30 GIAY
     xuat_32bit(out_relay);
    //if(out_relay!=sameold_out_relay){
    // sameold_out_relay=out_relay;
    // xuat_32bit(out_relay);
    // }

    ///// end scan button
    }
}
/*   HOTEL USELESS
void uart1_rx() iv IVT_INT_USART1 ics ICS_AUTO {
     unsigned char data_rx;
     if(USART1_SRbits.RXNE){
          USART1_SRbits.RXNE=0;
          data_rx=USART1_DRbits.DR;
     }
}
*/

/*   HOTEL USELESS
void response_touch(unsigned int status_response){
     unsigned char buf_response[4];
     buf_response[0]=0xfa;
     buf_response[1]=status_response;
     buf_response[2]=status_response>>8;
     rs485_u4(buf_response,3);
}
*/


void uart4_rx() iv IVT_INT_UART4 ics ICS_AUTO {
    unsigned char data_rc;
    // TIM1_CR1bits.CEN=0;   // KO CO TAC DUNG
    if(UART4_SRbits.RXNE){   // RXNE: Read data register not empty
        UART4_SRbits.RXNE=0;
        data_rc=UART4_DRbits.DR;

        // DR: DATA REGISTER

        if(DATA_TRUE){
                buf_rc_u4[count_buf_rc_4++]=data_rc;
        }
        if(count_buf_rc_4==0){    // received header
            if(data_rc==0x4B){    // header is "K"
                //count_buf_rc_4=1;
                DATA_TRUE=1;
                //buf_rc_u4[0]=data_rc;     // khong su dung header nen khong SAVE
            }
        }

        if(count_buf_rc_4>=6){
                //count_buf_rc_4=0;
                DATA_TRUE=0;
            //if(data_rc==0x48){    // "H"
                PROCESSING_RS485=1;
                //UART4_CR1bits.RE=0; // DISAnable receiver
                //TIM1_CR1bits.CEN=0;   // TURN OFF TIMER1
                //NVIC_SETENA1bits.SETENA52=0;   // DISABLE NestedvectoredInterruptCcontroller (NVIC) usart4 ( positions= 52)
                //buf_rc_u4[1]=data_rc;
            }

        //else{
        //    buf_rc_u4[count_buf_rc_4++]=data_rc;
        //}

        
    }
    //TIM1_CR1bits.CEN=1;   // TURN ON TIMER1
}

 
 /*   HOTEL USELESS
void process_touch(){

}
 */
/*
void IPnull() org 0x00001900
{
asm nop;
asm nop;
asm nop;
asm nop;
asm nop;
asm nop;
asm nop;
asm nop;


}
 */
 
void main() {
/*    union U32_      // place this above "main" somewhere
  {
     unsigned long dblword;   // For accessing the whole 32-bit unsigned long
     unsigned char byte[4];  // For accessing all 32-bits as individual bytes
  };
   union U32_ Bytes2long;  // create an instance of the declared union called 'Bytes2long' in this function
*/
   gpio_init();
   GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_14);   // KICK MOSFET IRF9530 FOR RELAY 12V
   GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_15);
   duphong8_C14=0;      // KICK MOSFET IRF9530 FOR RELAY 12V
   duphong9_C15=0;
   out_relay=0;
   //if(out_relay==0x01){IPnull();}
   xuat_32bit(out_relay);


     delay_ms(1500);
   //wed_status_button= 0b00000000000000000000000000000000;
   //xuat_32bit(out_relay);
RESET:
    //gpio_init();     HOP DELETE AFTER RESET
    ////// HOP HERE ///////////
    //k=0;
    //VALUE_RECEIVED=0;
    buf_rc_u4[0]=0;
    buf_rc_u4[1]=0;
    buf_rc_u4[2]=0;
    buf_rc_u4[3]=0;
    buf_rc_u4[4]=0;
    buf_rc_u4[5]=0;
    buf_rc_u4[6]=0;
    GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_12);   // den bao mau xanh da troi Port A12
    GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_8);   //
    GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_9);   // KICK MOSFET IRF9530 FOR RELAY 12V
    GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_6);   //
    GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_7);   //
    GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_3);   //
    GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_4);   //
    STAT=1;
    duphong66_C9=1;
    duphong67_A8=1;
    duphong87_D6=1;
    duphong88_D7=1;
    duphong89_B3=1;
    duphong90_B4=1;
//    usart1_init();
    usart2_init();
    uart4__init();   //baud=57600 rs485 uart 4
    set_value_dim(0,1);
    set_value_dim(0,2);
    flag_setdimmer1=0;
    flag_setdimmer2=0;
    flag_button_dim1=0;
    flag_button_dim2=0;
    BUTTON_DIM_CHANNEL1=0;
    BUTTON_DIM_CHANNEL2=0;
    //DATA_TRUE=0;
    //PROCESSING_RS485=0;
    //RESPOND_PROCESSING_RS485=0;
    //count_buf_rc_4=0;
    //TRAN_4    //   rs485 uart 4
    //uart4_string("ok");
    //uart4_chr(0x0D);
    //uart4_chr(0x0A);
    //REC_4
    ////////////
    timer1_init();
    memset(but_state,0,24);
  //HOTEL PROJECT USELESS
   // response_touch(status_led_touch);

   //set_value_dim(0,1);
   //set_value_dim(0,2);
   //set_value_dim(0,3);
   //set_value_dim(0,4);
   //count_time_dimer_ex[0]=0;
   //count_time_dimer_ex[1]=0;
   //count_time_dimer_ex[2]=0;
   //count_time_dimer_ex[3]=0;
   //flag_dimer_ex[0]=0;
   //flag_dimer_ex[1]=0;
   //flag_dimer_ex[2]=0;
   //flag_dimer_ex[3]=0;
   //flag_all_dimer_percent=0;
   // REC_1    // rs485 uart 1






    //SPI1_Init_Advanced(_SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PA567);
    //settingEthenet();
    //FLASH_ErasePage(Address);    ADDREESS LA DIA CHI FLASH CHUA IP
    delay_ms(1000);
    duphong8_C14=1; // KICK MOSFET IRF9530 FOR RELAY 12V
    RCC_APB1ENR.B11 = 1;            // Enable clock gating for Watchdog Timer 0 module
    
//Bit 11 WWDGEN: Window watchdog clock enable
//The window watchdog is based on a 7-bit downcounter that can be set as free running.
// It can be used as a watchdog to reset the device when a problem occurs
      // WWDG_CFR:CONFIGURATION REGISTER
      // [W7=0][W6][W5][W4][W3][W2][W1][W0]
    WWDG_CFR = 1;                   // Write window value to be compared to the downcounter

    /*
      SPI_Ethernet_getBytes(HOPTEST, 0x100, 16); // read 16 bytes, starting from address 0x100
        uart2_chr(38);   // 8
        for(k=0;k<16;k++){
        uart2_chr(HOPTEST[k]);
        }
        uart2_chr(13);   // CR
        uart2_chr(10);  // LF
    */
    while(1){
    // xu ly BUTTON DIMMER
    if(flag_setdimmer2){
      if(BUTTON_DIM_CHANNEL2==0){set_value_dim(0,2);}
      if(BUTTON_DIM_CHANNEL2==1){set_value_dim(90,2);}
      if(BUTTON_DIM_CHANNEL2==2){set_value_dim(60,2);}
      if(BUTTON_DIM_CHANNEL2==3){set_value_dim(20,2);}
    flag_setdimmer2=0;
    }

    if(flag_setdimmer1){
      if(BUTTON_DIM_CHANNEL1==0){set_value_dim(0,1);}
      if(BUTTON_DIM_CHANNEL1==1){set_value_dim(90,1);}
      if(BUTTON_DIM_CHANNEL1==2){set_value_dim(60,1);}
      if(BUTTON_DIM_CHANNEL1==3){set_value_dim(20,1);}
      flag_setdimmer1=0;
    }
    //////////////////////////////////
    // xu ly BELL
    if(BELL_ENABLE){
    BELL_COUNTER++;
      if(BELL_COUNTER>=0x1dffff){
      out_relay&=~RELAY_13;  // TURN OFF BELL
      BELL_COUNTER=0;
      BELL_ENABLE=0;
      }
    }
    //
    if(KEYCARD_INSERT){
      KEYCARD_COUNTER++;
      KEYCARD_COUNTER_CLOSE=0;
    if(KEYCARD_COUNTER>=0x0fff){
    KEYCARD_COUNTER=0;
     if(!KEYCARD_ENABLE){
      // duphong8_C14=0; // KICK MOSFET IRF9530 FOR RELAY 12V
    // TURN ON WHEN KEYCARD_INSERT
    //socket+c1+c5+c7+c10              r12,r8,r4,r2,r15
      out_relay|=RELAY_12; // RELAY-12: SOCKET : c13
      out_relay|=RELAY_8;  // c1 entrance  port6.0
      out_relay|=RELAY_4;  // c5 washface  port8.1
      out_relay|=RELAY_2;  // c7 reading   port1.1
      out_relay|=RELAY_15; // c10 entrance2   no-port
      LED_6_0=1;  // c1 entrance  port6.0
      LED_8_1=1;  // c5 washface  port8.1
      LED_1_1=1;  // c7 reading   port1.1
      KEYCARD_ENABLE=1;
    } 
    }
    }
    if(!KEYCARD_INSERT){
       KEYCARD_COUNTER_CLOSE++;
         if(KEYCARD_COUNTER_CLOSE>=0xffffff) {
          KEYCARD_COUNTER_CLOSE=0;
          KEYCARD_ENABLE=0;
    // TURN OFF ALL RELAY WHEN KEYCARD_REMOVED
    out_relay=0;
    //duphong8_C14=0; // KICK OFF MOSFET IRF9530 FOR RELAY 12V
    // TURN OFF ALL LED WHEN KEYCARD_REMOVED
    //  PORT11;PORT9  KO SU DUNG
    LED_11_0=0;
    LED_11_1=0;
    LED_9_0=0;
    LED_9_1=0;
    //PORT10 DND-MUR
    LED_10_0=0;
    LED_10_1=0;
    //PORT8 c4+c5
    LED_8_0=0;
    LED_8_1=0;
    //PORT6   c1
    LED_6_0=0;
    //PORT5  c3+c11
    LED_5_0=0;
    LED_5_1=0;
    //PORT4  c8+c9
    LED_4_0=0;
    LED_4_1=0;
    //PORT3  dim1+masterB
    LED_3_0=0;
    LED_3_2=0;
    //port2   nc
    LED_2_0=0;
    LED_2_1=0;
    LED_2_2=0;
    DO_NOT_DISTURB=0;
    //PORT1    c6,c7,dim2
    LED_1_0=0;
    LED_1_1=0;
    LED_1_2=0;
    }
    }
     /*
     // XU LY TIMEOUT
    TIME_OUT++;
    if(TIME_OUT>=0xfffff)
    {
    TIME_OUT=0;
    TIMEOUT_RELAY_1++;
    TIMEOUT_RELAY_2++;
    TIMEOUT_RELAY_3++;
    TIMEOUT_RELAY_4++;
    TIMEOUT_RELAY_5++;
    TIMEOUT_RELAY_6++;
    TIMEOUT_RELAY_7++;
    TIMEOUT_RELAY_8++;
    TIMEOUT_RELAY_16++;
    TIMEOUT_RELAY_15++;
    TIMEOUT_RELAY_14++;
    TIMEOUT_RELAY_13++;
    TIMEOUT_RELAY_12++;
    TIMEOUT_RELAY_11++;
    TIMEOUT_RELAY_10++;
    TIMEOUT_RELAY_9++;

    /////
    if(TIMEOUT_RELAY_1>=0xfd){
    out_relay&=~RELAY_1;
    //wed_status_button&=~(shift<<0);
    wed_status_button&=~RELAY_1;
    TIMEOUT_RELAY_1=0;
    }
    
    if(TIMEOUT_RELAY_2>=0xfd){
    out_relay&=~RELAY_2;
    wed_status_button&=~RELAY_2;
    TIMEOUT_RELAY_2=0;
    }
    
    if(TIMEOUT_RELAY_3>=0xfd){
    out_relay&=~RELAY_3;
    wed_status_button&=~RELAY_3;
    TIMEOUT_RELAY_3=0;
    }
    
    if(TIMEOUT_RELAY_4>=0xfd){
    out_relay&=~RELAY_4;
    wed_status_button&=~RELAY_4;
    TIMEOUT_RELAY_4=0;
    }
    
    if(TIMEOUT_RELAY_5>=0xfd){
    out_relay&=~RELAY_5;
    wed_status_button&=~RELAY_5;
    TIMEOUT_RELAY_5=0;
    }
    
    if(TIMEOUT_RELAY_6>=0xfd){
    out_relay&=~RELAY_6;
    wed_status_button&=~RELAY_6;
    TIMEOUT_RELAY_6=0;
    }
    
    if(TIMEOUT_RELAY_7>=0xfd){
    out_relay&=~RELAY_7;
    wed_status_button&=~RELAY_7;
    TIMEOUT_RELAY_7=0;
    }
    
    if(TIMEOUT_RELAY_8>=0xfd){
    out_relay&=~RELAY_8;
    wed_status_button&=~RELAY_8;
    TIMEOUT_RELAY_8=0;
    }
    
    if(TIMEOUT_RELAY_16>=0xfd){
    out_relay&=~RELAY_16;
    wed_status_button&=~RELAY_16;
    TIMEOUT_RELAY_16=0;
    }
    
    if(TIMEOUT_RELAY_15>=0xfd){
    out_relay&=~RELAY_15;
    wed_status_button&=~RELAY_15;
    TIMEOUT_RELAY_15=0;
    }
    
    if(TIMEOUT_RELAY_14>=0xfd){
    out_relay&=~RELAY_14;
    wed_status_button&=~RELAY_14;
    TIMEOUT_RELAY_14=0;
    }
    
    if(TIMEOUT_RELAY_13>=0xfd){
    out_relay&=~RELAY_13;
    wed_status_button&=~RELAY_13;
    TIMEOUT_RELAY_13=0;
    }
    
    if(TIMEOUT_RELAY_12>=0xfd){
    out_relay&=~RELAY_12;
    wed_status_button&=~RELAY_12;
    TIMEOUT_RELAY_12=0;
    }
    
    if(TIMEOUT_RELAY_11>=0xfd){
    out_relay&=~RELAY_11;
    wed_status_button&=~RELAY_11;
    TIMEOUT_RELAY_11=0;
    }
    
    if(TIMEOUT_RELAY_10>=0xfd){
    out_relay&=~RELAY_10;
    wed_status_button&=~RELAY_10;
    TIMEOUT_RELAY_10=0;
    }
    
    if(TIMEOUT_RELAY_9>=0xfd){
    out_relay&=~RELAY_9;
    wed_status_button&=~RELAY_9;
    TIMEOUT_RELAY_9=0;
    }
    }
     */
    /*
    // xu ly cac dimmer
    if(flag_all_dimer_percent)
          {
          DELAY_SEND_DIMMER++;

          if(DELAY_SEND_DIMMER=10){ set_value_dim(PERCENT_DIMMER,1);}
          if(DELAY_SEND_DIMMER=40){ set_value_dim(PERCENT_DIMMER,2);}
          if(DELAY_SEND_DIMMER=80){ set_value_dim(PERCENT_DIMMER,3);}
          if(DELAY_SEND_DIMMER=120)
              {value_dimer_ex[1]=PERCENT_DIMMER;
              value_dimer_ex[2]=PERCENT_DIMMER;
              flag_all_dimer_percent=0;
              DELAY_SEND_DIMMER=0;
              set_value_dim(PERCENT_DIMMER,4);
              }
          }
    */
    // xu ly CURTAIN
    /*
    if(FLAG_CURTAIN_STOP)
          {  out_relay&=~RELAY_8;
             out_relay&=~RELAY_9;
             FLAG_CURTAIN_STOP=0;
          }
    */
    
    //  rs485 process
/*
    if(PROCESSING_RS485){
    //Bytes2long.dblword= out_relay;

    Bytes2long.dblword = 0xAAAAAAAA;
    PROCESSING_RS485=0;
    RESPOND_PROCESSING_RS485=1;
    }
    
    //NVIC_SETENA0bits.SETENA25=0;
    //NVIC_SETENA1bits.SETENA52=0;
    
    // send : K123456
    //   RECEIVED :   COUNTER-BUFFER >= 6; not-save "K"
    //buf_rc_u4[0] = 1
    //buf_rc_u4[1] = 2
    //buf_rc_u4[2] = 3
    //buf_rc_u4[3] = 4
    //buf_rc_u4[4] = 5
    //buf_rc_u4[5] = 6
    if(RESPOND_PROCESSING_RS485){
    //TIM1_CR1bits.CEN=0;   // TURN Off TIMER1
    out_relay=0xAAAAAAAA;
    wed_status_button=0xAAAAAAAA;
    LD0_0=0;   //relay 1
    LD0_1=1;   //relay 2
    LD0_2=0;   //relay 3
    LD1_0=1;   //relay 4
    LD1_1=0;   //relay 5
    LD1_2=1;   //relay 6
    LD2_0=0;   //relay 7
    LD2_1=1;   //relay 8
    LD2_2=0;   //relay 9
    LD3_0=1;   //relay 10
    LD3_1=0;   //relay 11
    LD3_2=1;   //relay 12
    LD4_0=0;   //relay 13
    LD4_1=1;   //relay 14
    LD4_2=0;   //relay 15
    LD5_0=1;   //relay 16
    TRAN_4
    //uart4_chr(buf_rc_u4[1]);
    //uart4_chr(buf_rc_u4[2]);
    //uart4_chr(buf_rc_u4[3]);
    //uart4_chr(buf_rc_u4[4]);
    uart4_chr(Bytes2long.byte[0]);
    uart4_chr(Bytes2long.byte[1]);
    uart4_chr(Bytes2long.byte[2]);
    uart4_chr(Bytes2long.byte[3]);
    uart4_chr(buf_rc_u4[5]);
    uart4_chr(0x0D);
    uart4_chr(0x0A);
    REC_4
    count_buf_rc_4=0;
    RESPOND_PROCESSING_RS485=0;
    //k=0;
    //VALUE_RECEIVED=0;
    //UART4_CR1bits.RE=1; // Enable receiver
    //TIM1_CR1bits.CEN=1;   // TURN On TIMER1
    //NVIC_SETENA1bits.SETENA52=1;   // enABLE interupt
    //NVIC_SETENA0bits.SETENA25=1;
     }

*/

    
        if(flag_reset_ip==1){
            flag_reset_ip=0;
            goto RESET;
        }
        //statusConnect=SPI_Ethernet_doPacket();
        // process_touch();

        //if(statusConnect==0){
        //if(SPI_Ethernet_doPacket()==0){
        //    checkConnect=0;
        //}else {
        //    if(checkConnect<1000){
        //        checkConnect++;
        //    }else {
// WWDG_CR:  WINDOW WATCHDOG CONTROL REGISTER
//The watchdog is always disabled after a reset. It is enabled by setting the WDGA bit in the WWDG_CR register
//, then it cannot be disabled again except by a reset
            // 8BIT [WDGA][T6][T5][T4][T3][T2][T1][T0]
        //        WWDG_CR = 0b10000000;
        //    }
        //}

    }
}