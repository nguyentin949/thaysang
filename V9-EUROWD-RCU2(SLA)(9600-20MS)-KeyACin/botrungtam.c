#include "main.h"
#include "__EthEnc28j60.c"

// NHATRANG EUROWINDOW
// RCU 2   -RL5,RL4  USELESS

sfr sbit SPI_Ethernet_Rst at GPIOC_ODR.B4;
sfr sbit SPI_Ethernet_CS at GPIOA_ODR.B4;
sfr sbit STAT at GPIOA_ODR.B12;
sfr sbit duphong8_C14 at GPIOC_ODR.B14;
sfr sbit duphong9_C15 at GPIOC_ODR.B15;
sfr sbit duphong66_C9 at GPIOC_ODR.B9;
sfr sbit duphong67_A8 at GPIOA_ODR.B8;
// sfr sbit duphong87_D6 at GPIOD_ODR.B6;   // chuyen vao SCANBUTTON  port13 - BUT13_0
sfr sbit duphong88_D7 at GPIOD_ODR.B7;
sfr sbit duphong89_B3 at GPIOB_ODR.B3;
sfr sbit duphong90_B4 at GPIOB_ODR.B4;

const code unsigned char httpHeader[] = "HTTP/1.1 200 OK\nContent-type: ";
const code unsigned char httpMimeTypeHTML[] = "text/html\n\n";
const code unsigned char httpMimeTypeScript[] = "text/plain\n\n";
unsigned char httpMethod[] = "GET /";

const code char *LoginPage =
    "<html><head></head><title>Login Page</title>\
<h1>NHATRANG EUROWINDOW-\
<br>IP: -\
<br>MAC:-</h1>\
</body></html>\
";

const code char *indexPage =
    "</html>\
";
const code char *HomePage =
    "</html>\
";
const code char *ServicePage =
    "</html>\
";

const code char *LightingPage =
    "</html>\
";
const code char *CurtainPage =
    "</html>\
";
const code char *ScenesPage =
    "</html>\
";
const code char *Fan_SpeedPage =
    "</html>\
";

const code char *Dimer_ExtantPage =
    "</html>\
";

const code char *Device_ExtantPage =
    "</html>\
";
// phien ban hotel
const code char *SettingPage =
    "</html>\
";

unsigned char myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x18, 0x00}; // my MAC address
unsigned char myIpAddr[4] = {192, 168, 1, 120};                    // my IP Address CHO LAN CHAY DAU TIEN
                                                                   // unsigned char   myIpAddr[4];                   // my IP Address

unsigned char gwIpAddr[4];                     // gateway (router) IP address
unsigned char ipMask[4] = {255, 255, 255, 0};  // network mask (for example : 255.255.255.0)
unsigned char dnsIpAddr[4] = {192, 168, 1, 1}; // DNS server IP address
unsigned char getRequest[100];
unsigned char dyna[40];
unsigned char buf[40];
unsigned char HOPTEST[16];
unsigned int index_page = 7; // Page_Device_Extant  _ HOTEL PROJECT
unsigned char ipAddress[4];
unsigned long Address = 0x08008000, i, temp, checkConnect = 0;
unsigned long *ptr;
unsigned long out_relay = 0;
unsigned char curtain;
unsigned char flag_all_dimer_percent = 0;
unsigned char DELAY_SEND_DIMMER = 0;
unsigned char PERCENT_DIMMER = 0;
unsigned char DATA_TRUE, PROCESSING_RS485, RESPOND_PROCESSING_RS485;
unsigned char MASTER_SWITCH = 0;
unsigned char MASTER_BEDROOM = 0;
unsigned char MASTER_BEDROOM_STATUS = 0;
unsigned char AMBIENT_BEDROOM = 0;
unsigned char AMBIENT_STATUS = 0;
unsigned char ACCENT_BEDROOM = 0;
unsigned char ACCENT_STATUS = 0;
unsigned char RS485_CONTROL_S9_S11 = 0;
unsigned char RS485_CONTROL_S9 = 0;
unsigned char RS485_CONTROL_S10 = 0;
unsigned char RS485_STATUS_S9_S11 = 0;
unsigned char RS485_STATUS_S9 = 0;
unsigned char RS485_STATUS_S10 = 0;
////
unsigned char DO_NOT_DISTURB = 0;
unsigned char KEYCARD_ENABLE = 0;
unsigned char KEYCARD_INSERT = 0;
unsigned long KEYCARD_COUNTER = 0;
unsigned long KEYCARD_COUNTER_CLOSE = 0;
unsigned long BELL_COUNTER = 0;
unsigned char BELL_ENABLE = 0;
unsigned char DIM4_EVERGREEN = 0;
unsigned char DIM2_EVERGREEN = 0;
unsigned char FLAG_CURTAIN_STOP = 0;
unsigned long sameold_out_relay = 0;
unsigned long TIME_OUT = 0;
unsigned char TIMEOUT_RELAY_1 = 0;
unsigned char TIMEOUT_RELAY_2 = 0;
unsigned char TIMEOUT_RELAY_3 = 0;
unsigned char TIMEOUT_RELAY_4 = 0;
unsigned char TIMEOUT_RELAY_5 = 0;
unsigned char TIMEOUT_RELAY_6 = 0;
unsigned char TIMEOUT_RELAY_7 = 0;
unsigned char TIMEOUT_RELAY_8 = 0;
unsigned char TIMEOUT_RELAY_16 = 0;
unsigned char TIMEOUT_RELAY_15 = 0;
unsigned char TIMEOUT_RELAY_14 = 0;
unsigned char TIMEOUT_RELAY_13 = 0;
unsigned char TIMEOUT_RELAY_12 = 0;
unsigned char TIMEOUT_RELAY_11 = 0;
unsigned char TIMEOUT_RELAY_10 = 0;
unsigned char TIMEOUT_RELAY_9 = 0;

void putChar(unsigned char c)
{
    while (UART4_SRbits.TC == 0)
        ;
    UART4_DRbits.DR = c;
}

void timer1_isr() iv IVT_INT_TIM1_UP ics ICS_AUTO
{ // 20 ms
    unsigned char i_isr = 0, but_isr = 0;
    // unsigned int len=0;
    // unsigned char vt_button=0;
    unsigned long shift = 1;
    // UIF : update interrupt Flag/ set by hardware; clear by software
    if (TIM1_SRbits.UIF == 1)
    {
        TIM1_SRbits.UIF = 0;
        // scan button
        // PORT 1
        but_sample[0][SAMPLE - 1] = !BUT1_0;
        but_sample[1][SAMPLE - 1] = !BUT1_1;
        but_sample[2][SAMPLE - 1] = !BUT1_2;
        // PORT 2
        but_sample[3][SAMPLE - 1] = !BUT2_0;
        but_sample[4][SAMPLE - 1] = !BUT2_1;
        but_sample[5][SAMPLE - 1] = !BUT2_2;
        // PORT 3
        but_sample[6][SAMPLE - 1] = !BUT3_0;
        but_sample[7][SAMPLE - 1] = !BUT3_1;
        but_sample[8][SAMPLE - 1] = !BUT3_2;
        // PORT 4
        but_sample[9][SAMPLE - 1] = !BUT4_0;
        but_sample[10][SAMPLE - 1] = !BUT4_1;
        // PORT 5
        but_sample[11][SAMPLE - 1] = !BUT5_0;
        but_sample[12][SAMPLE - 1] = !BUT5_1;
        // PORT 6
        but_sample[13][SAMPLE - 1] = !BUT6_0;
        // PORT 7
        but_sample[14][SAMPLE - 1] = !BUT7_0;
        // PORT 8
        but_sample[15][SAMPLE - 1] = !BUT8_0;
        but_sample[16][SAMPLE - 1] = !BUT8_1;
        // PORT 9
        but_sample[17][SAMPLE - 1] = !BUT9_0;
        but_sample[18][SAMPLE - 1] = !BUT9_1;
        // PORT 10
        but_sample[19][SAMPLE - 1] = !BUT10_0;
        but_sample[20][SAMPLE - 1] = !BUT10_1;
        // PORT 11
        but_sample[21][SAMPLE - 1] = !BUT11_0;
        but_sample[22][SAMPLE - 1] = !BUT11_1;
        // PORT 12
        but_sample[23][SAMPLE - 1] = !BUT12_0;
        // PORT 13
        but_sample[24][SAMPLE - 1] = !BUT13_0;

        for (but_isr = 0; but_isr < SUM_BUT; but_isr++)
        {
            for (i_isr = 0; i_isr < SAMPLE - 1; i_isr++)
            {
                but_sample[but_isr][i_isr] = but_sample[but_isr][i_isr + 1];
            }
            but_sum_sample[but_isr] = 0;
            for (i_isr = 0; i_isr < SAMPLE; i_isr++)
            {
                but_sum_sample[but_isr] += but_sample[but_isr][i_isr];
            }
            if (but_sum_sample[but_isr] >= PRESS)
            {
                but_state[but_isr] = PRESS;
            }
            else if (but_sum_sample[but_isr] == UNPRESS)
            {
                but_state[but_isr] = UNPRESS;
            }
            if (but_state[but_isr] == PRESS)
            {
                if (but_status[but_isr] == UNPRESS)
                {
                    but_status[but_isr] = PRES_DOW;
                }
                else if (but_status[but_isr] == PRES_DOW)
                {
                    but_status[but_isr] = PRESSING;
                }
                else if (but_status[but_isr] == PRESSING)
                {
                    but_status[but_isr] = PRESSING;
                }
            }
            else if (but_state[but_isr] == UNPRESS)
            {
                if ((but_status[but_isr] == PRESSING) || (but_status[but_isr] == PRES_DOW))
                {
                    but_status[but_isr] = PRES_UP;
                }
                else if (but_status[but_isr] == PRES_UP)
                {
                    but_status[but_isr] = UNPRESS;
                }
                else if (but_status[but_isr] == UNPRESS)
                {
                    but_status[but_isr] = UNPRESS;
                }
            }
        }
        /*
        //NHATRANG EUROWINDOW
        //RCU 2   -RL5,RL4  USELESS
            //PORT1 AMBIENT BATH - BEDROOM       S8,S9,S11       RL8,RCU1,RCU1
            //      ACCENT BATH - BEDROOM        S10             RCU1

            //PORT2 AMBIENT BEDROOM       S12,(S13+S16)       RL7,RL6
            //      ACCENT BEDROOM        S17             RL3

            //PORT3 NIGHTL MASTER BEDROOM        S9,S12    RCU1,RL7
            //      READ-L MASTER BEDROOM        S14       RL2

            //PORT4 AMBIENT MASTER BD LEFT       S12,(S13+S16)     RL7,RL6
            //      ACCENT MASTER BD LEFT        S17             RL3  = PORT8_1

            //PORT5 NIGHTR MASTER BEDROOM        S9,S12    RCU1,RL7
            //      READ-R MASTER BEDROOM        S15       RL1

            //PORT6 LIGHT BANCONY                S18           RL16

            //PORT7  MASTER MASTL BEDROOM      S12,(S13+S16),S17       RL7,RL6,  RL3
            //
            //PORT8  AMBIENT MASTER BD LEFT       S12,S13,S16     RL7,RL6
            //      ACCENT MASTER BD LEFT        S17             RL3 = PORT4_1
            //PORT9  nc
            //PORT10 nc
            //PORT11 NC
            //PORT12=port13 MASTER MASTR BEDROOM      S12,S13,S16,S17       RL7,RL6,RL3 ,RL2
        */
        duphong67_A8 = ~duphong67_A8; // LED INDICAROR QUET BAN PHIM
                                      // PORT 1 _ 3INPUT-3LED
        //     NC, AMBIENT B BEDROOM, ACCENT B-BEDROOM
        // pin4-button3 KO SU DUNG;
        if (but_status[0] == PRES_DOW)
        {
            // LED_1_0=1;
        }
        else if (but_status[0] == PRES_UP)
        {
            // LED_1_0=0;
        }
        // pin5-button2 AMBIENT BATHROOM+BEDROOM       S8,S9,S11       RL8,RCU1,RCU1
        if (but_status[1] == PRES_DOW)
        {
            // LED_1_1=1;            // control LED include in RS485_CONTROL_S9_S11
            // out_relay^=RELAY_8;   // control S8 include RS485_CONTROL_S9_S11
            RS485_CONTROL_S9_S11 = 1;
            RS485_STATUS_S9_S11 ^= 1;
        }
        else if (but_status[1] == PRES_UP)
        {
            // LED_1_1=RS485_STATUS_S9_S11;   // control LED include RS485_CONTROL_S9_S11
        }
        // pin6-button1 ACCENT BATH - BEDROOM        S10             RCU1
        if (but_status[2] == PRES_DOW)
        {
            // LED_1_2=1;
            RS485_CONTROL_S10 = 1;
            RS485_STATUS_S10 ^= 1;
        }
        else if (but_status[2] == PRES_UP)
        {
            // LED_1_2=RS485_STATUS_S10;
        }
        // PORT 2  3-INPUT-3LED  : NC,AMBIENT BEDROOM, ACCENT BEDROOM
        // PIN4-BUTTON3  KO SU DUNG
        if (but_status[3] == PRES_DOW)
        {
            // LED_2_0=1;
        }
        else if (but_status[3] == PRES_UP)
        {
            // LED_2_0=0;
        }
        // AMBIENT BEDROOM       S12,(S13+S16)       RL7,RL6
        if (but_status[4] == PRES_DOW)
        {
            // LED_2_1=1;   // XU LY AMBIENT_BEDROOM
            // out_relay^=S12;      //
            // out_relay^=RELAY_6;  // DK THEO RL6(S13+S16)
            AMBIENT_BEDROOM = 1;
            AMBIENT_STATUS ^= 1;
        }
        else if (but_status[4] == PRES_UP)
        {
            // LED_2_1=AMBIENT_STATUS;
        }
        //  ACCENT BEDROOM        S17             RL3
        if (but_status[5] == PRES_DOW)
        {
            // LED_2_2=1;
            ACCENT_BEDROOM = 1;
            ACCENT_STATUS ^= 1;
        }
        else if (but_status[5] == PRES_UP)
        {
            // LED_2_2=ACCENT_STATUS;
        }
        // PORT3  (3IN-2LED)_KO CO LED BUTTON2 LED_3_1=NULL)
        // 1_KO_SU_DUNG;  2_NIGHTL MASTER BEDROOM;   3_READ-L MASTER BEDROOM
        //  KHONG SU DUNG
        if (but_status[6] == PRES_DOW)
        {
            // LED_3_0=1;
        }
        else if (but_status[6] == PRES_UP)
        {
            // LED_3_0=0;
        }
        // NIGHTL MASTER BEDROOM (= PORT5)        S9,S12    RCU1,RL7
        if (but_status[7] == PRES_DOW)
        {
            // LED_3_0=1;
            // out_relay^=S12;      control S8 include RS485_CONTROL_S9
            RS485_CONTROL_S9 = 1;
            RS485_STATUS_S9 ^= 1;
        }
        else if (but_status[7] == PRES_UP)
        {
            // LED_3_0=RS485_STATUS_S9;
            // LED_5_0=LED_3_0;
        }
        //  READ-L MASTER BEDROOM        S14       RL2
        if (but_status[8] == PRES_DOW)
        {
            LED_3_2 = 1;
            out_relay ^= RELAY_2;
        }
        else if (but_status[8] == PRES_UP)
        {
            LED_3_2 = (out_relay & RELAY_2) ? 1 : 0;
        }
        // PORT4(2IN-3LED)( KO CO BUTTON3)
        //   AMBIENT MASTER BD LEFT       S12,(S13+S16)     RL7,RL6
        if (but_status[9] == PRES_DOW)
        {
            // LED_4_0=1;
            AMBIENT_BEDROOM = 1;
            AMBIENT_STATUS ^= 1;
        }
        else if (but_status[9] == PRES_UP)
        {
            // LED_4_0=(out_relay&RELAY_6)?1:0;
            // if(LED_4_0==0){}
            //  PORT8,PORT4,PORT2
        }
        // ACCENT MASTER BD LEFT        S17             RL3
        if (but_status[10] == PRES_DOW)
        {
            // LED_4_1=1;
            // out_relay^=RELAY_3;
            ACCENT_BEDROOM = 1;
            ACCENT_STATUS ^= 1;
        }
        else if (but_status[10] == PRES_UP)
        {
            // LED_4_1=(out_relay&RELAY_3)?1:0;
            // LED_8_1=LED_4_1;
        }

        ////PORT5-(2LED-2IN)
        // NIGHTR MASTER BEDROOM        S9,S12    RCU1,RL7
        //  PORT3=PORT5 NIGHT MAS BEDROOM
        if (but_status[11] == PRES_DOW)
        {
            LED_5_0 = 1;
            // out_relay^=RELAY_7;  // S12
            RS485_CONTROL_S9 = 1;
            RS485_STATUS_S9 ^= 1;
        }
        else if (but_status[11] == PRES_UP)
        {
            // LED_5_0=(out_relay&RELAY_7)?1:0;
            // LED_3_0=LED_5_0;
        }
        // READ-R MASTER BEDROOM        S15       RL1
        if (but_status[12] == PRES_DOW)
        {
            LED_5_1 = 1;
            out_relay ^= RELAY_1;
        }
        else if (but_status[12] == PRES_UP)
        {
            LED_5_1 = (out_relay & RELAY_1) ? 1 : 0;
        }

        // PORT6(1LED-1IN)
        // LIGHT BANCONY                S18           RL16
        if (but_status[13] == PRES_DOW)
        {
            LED_6_0 = 1;
            out_relay ^= RELAY_16;
        }
        else if (but_status[13] == PRES_UP)
        {
            LED_6_0 = (out_relay & RELAY_16) ? 1 : 0;
        }
        // PORT7-(1LED-1IN)
        // MASTER MASTL BEDROOM      S12,(S13+S16),S17       RL7,RL6,  RL3
        if (but_status[14] == PRES_DOW)
        {
            // LED_7_0=1;   // KO DK DEN O DAY
            MASTER_BEDROOM = 1;
            MASTER_BEDROOM_STATUS ^= 1;
        }
        else if (but_status[14] == PRES_UP)
        {
            // LED_7_0= 0;
        }
        // PORT8
        //  AMBIENT MASTER BD LEFT       S12,S13,S16     RL7,RL6
        if (but_status[15] == PRES_DOW)
        {
            // LED_8_0=1;
            AMBIENT_BEDROOM = 1;
            AMBIENT_STATUS ^= 1;
        }
        else if (but_status[15] == PRES_UP)
        {
            // LED_8_0=(out_relay&RELAY_6)?1:0;
        }

        //  ACCENT MASTER BD LEFT        S17             RL3
        if (but_status[16] == PRES_DOW)
        {
            // LED_8_1=1;
            ACCENT_BEDROOM = 1;
            ACCENT_STATUS ^= 1;
        }
        else if (but_status[16] == PRES_UP)
        {
            // LED_8_1=(out_relay&RELAY_3)?1:0;
            // LED_4_1=LED_8_1;
        }
        // PORT9-0:
        // KO SU DUNG
        if (but_status[17] == PRES_DOW)
        {
            // LED_9_0^=1;
        }
        else if (but_status[17] == PRES_UP)
        {
            // LED_9_0^=0;
        }
        // PORT9-1:
        // KO SU DUNG
        if (but_status[18] == PRES_DOW)
        {
            // LED_9_1^=1;
        }
        else if (but_status[18] == PRES_UP)
        {
            // LED_9_1^=0;
        }
        //  PORT10
        // KHONG SU DUNG
        if (but_status[19] == PRES_DOW)
        {
            // LED_10_0=1;
        }
        else if (but_status[19] == PRES_UP)
        {
            // LED_10_0=0;
        }
        // PORT10
        if (but_status[20] == PRES_DOW)
        {
            // LED_10_1=1;
        }
        else if (but_status[20] == PRES_UP)
        {
            // LED_10_1=0;
        }
        // PORT11
        // KO SU DUNG
        if (but_status[21] == PRES_DOW)
        {
            // LED_11_0=1;
        }
        else if (but_status[21] == PRES_UP)
        {
            // LED_11_0=0;
        }
        // KO SU DUNG
        if (but_status[22] == PRES_DOW)
        {
            // LED_11_1=1;
        }
        else if (but_status[22] == PRES_UP)
        {
            // LED_11_1=0;
        }
        // PORT12 (1IN - 1LED)
        // MASTER MASTL BEDROOM      S12,(S13+S16),S17       RL7,RL6,  RL3
        if (but_status[23] == PRES_DOW)
        {
            // LED_12_0=1;  khong dk den o day
            MASTER_BEDROOM = 1;
            MASTER_BEDROOM_STATUS ^= 1;
        }
        else if (but_status[23] == PRES_UP)
        {
            // LED_12_0=0;
            // MASTER_BEDROOM=0;
        }

        // PORT13 (ac input from DIMMER for KEYCARD direct)
        if (but_status[24] == PRES_DOW)
        {
            STAT = 1;
            KEYCARD_INSERT = 1;
            KEYCARD_ENABLE = 1; // enable xuat_32bit(out_relay)
        }
        else if (but_status[24] == PRES_UP)
        {
            STAT = 0;
            KEYCARD_INSERT = 0;
        }
        // end scan button
        if (KEYCARD_ENABLE == 1)
        {
            // XU LY MASTER_BEDROOM
            if (MASTER_BEDROOM == 1)
            {
                if (MASTER_BEDROOM_STATUS != 0)
                {
                    // neu dang OFF thi turn ALL ON
                    out_relay |= S12;  // S12=RELAY_7;
                    out_relay |= S13A; // S13A=RELAY_6;
                    out_relay |= S17;  // S17=RELAY_3;
                    LED_12_0 = 1;      // MASTER_BD BUTTON1-PORT12
                    LED_7_0 = 1;       // MASTER_BD BUTTON1-PORT7
                    LED_2_1 = 1;       // AMBIENT(S12+S13A) BUTTON2-PORT2
                    LED_4_0 = 1;       // AMBIENT(S12+S13A) BUTTON2-PORT4
                    LED_8_0 = 1;       // AMBIENT(S12+S13A) BUTTON2-PORT8
                    LED_2_2 = 1;       // ACCENT(S17) BUTTON1-PORT2
                    LED_4_1 = 1;       // ACCENT(S17) BUTTON1-PORT4
                    LED_8_1 = 1;       // ACCENT(S17) BUTTON1-PORT8
                }
                if (MASTER_BEDROOM_STATUS == 0)
                {
                    // neu dang ON thi turn ALL OFF
                    out_relay &= ~S12;  // S12=RELAY_7;
                    out_relay &= ~S13A; // S13A=RELAY_6;
                    out_relay &= ~S17;  // S17=RELAY_3;
                    LED_12_0 = 0;       // MASTER_BD BUTTON1-PORT12
                    LED_7_0 = 0;        // MASTER_BD BUTTON1-PORT7
                    LED_2_1 = 0;        // AMBIENT(S12+S13A) BUTTON2-PORT2
                    LED_4_0 = 0;        // AMBIENT(S12+S13A) BUTTON2-PORT4
                    LED_8_0 = 0;        // AMBIENT(S12+S13A) BUTTON2-PORT8
                    LED_2_2 = 0;        // ACCENT(S17) BUTTON1-PORT2
                    LED_4_1 = 0;        // ACCENT(S17) BUTTON1-PORT4
                    LED_8_1 = 0;        // ACCENT(S17) BUTTON1-PORT8
                }
                MASTER_BEDROOM = 0;
            }
            // XU LY AMBIENT_BEDROOM
            if (AMBIENT_BEDROOM == 1)
            {
                if (AMBIENT_STATUS != 0)
                {
                    // neu dang OFF thi turn ALL ON
                    out_relay |= S12;  // S12=RELAY_7
                    out_relay |= S13A; // S13A(S13+S16)=RELAY_6
                    LED_2_1 = 1;       // AMBIENT(S12+S13A) BUTTON2-PORT2
                    LED_4_0 = 1;       // AMBIENT(S12+S13A) BUTTON2-PORT4
                    LED_8_0 = 1;       // AMBIENT(S12+S13A) BUTTON2-PORT8
                }
                if (AMBIENT_STATUS == 0)
                {
                    // neu dang ON thi turn ALL OFF
                    out_relay &= ~S12;  // S12=RELAY_7
                    out_relay &= ~S13A; // S13A(S13+S16)=RELAY_6
                    LED_2_1 = 0;        // AMBIENT(S12+S13A) BUTTON2-PORT2
                    LED_4_0 = 0;        // AMBIENT(S12+S13A) BUTTON2-PORT4
                    LED_8_0 = 0;        // AMBIENT(S12+S13A) BUTTON2-PORT8
                }
                AMBIENT_BEDROOM = 0;
            }
            // XU LY ACCENT_BEDROOM
            if (ACCENT_BEDROOM == 1)
            {
                if (ACCENT_STATUS != 0)
                {
                    // neu dang OFF thi turn ALL ON
                    out_relay |= S17; // S17=RELAY_3;
                    LED_2_2 = 1;      // ACCENT(S17) BUTTON1-PORT2
                    LED_4_1 = 1;      // ACCENT(S17) BUTTON1-PORT4
                    LED_8_1 = 1;      // ACCENT(S17) BUTTON1-PORT8
                }
                if (ACCENT_STATUS == 0)
                {
                    // neu dang ON thi turn ALL OFF
                    out_relay &= ~S17; // S17= RELAY_3;
                    LED_2_2 = 0;       // ACCENT(S17) BUTTON1-PORT2
                    LED_4_1 = 0;       // ACCENT(S17) BUTTON1-PORT4
                    LED_8_1 = 0;       // ACCENT(S17) BUTTON1-PORT8
                }
                ACCENT_BEDROOM = 0;
            }
            xuat_32bit(out_relay);
        }
        // CHECK KEYCARD TO ENABLE OUT RELAY
        if (KEYCARD_ENABLE == 0)
        {
            out_relay = 0;
            ACCENT_STATUS = 0;
            AMBIENT_STATUS = 0;
            MASTER_BEDROOM_STATUS = 0;
            RS485_CONTROL_S9 = 0;
            RS485_CONTROL_S10 = 0;
            RS485_CONTROL_S9_S11 = 0;
            RS485_STATUS_S9 = 0;
            RS485_STATUS_S10 = 0;
            RS485_STATUS_S9_S11 = 0;
            xuat_32bit(out_relay);
        }
    }
}

void uart4_rx() iv IVT_INT_UART4 ics ICS_AUTO
{
    unsigned char data_rc;
    // TIM1_CR1bits.CEN=0;   // KO CO TAC DUNG
    if (UART4_SRbits.RXNE)
    { // RXNE: Read data register not empty
        UART4_SRbits.RXNE = 0;
        data_rc = UART4_DRbits.DR;

        // DR: DATA REGISTER

        if (DATA_TRUE)
        {
            buf_rc_u4[count_buf_rc_4++] = data_rc;
        }
        if (count_buf_rc_4 == 0)
        { // received header
            if (data_rc == 0x4B)
            { // header is "K"
                // count_buf_rc_4=1;
                DATA_TRUE = 1;
                // buf_rc_u4[0]=data_rc;     // khong su dung header nen khong SAVE
            }
        }

        if (count_buf_rc_4 >= 6)
        {
            // count_buf_rc_4=0;
            DATA_TRUE = 0;
            if (data_rc == 0x4D)
            { // "M"
                PROCESSING_RS485 = 1;
                count_buf_rc_4 = 0;
                // buf_rc_u4[1]=data_rc;
            }
        }
    }
}

void main()
{
    gpio_init();
    GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_14); // KICK MOSFET IRF9530 FOR RELAY 12V
    GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_15);
    duphong8_C14 = 0; // KICK MOSFET IRF9530 FOR RELAY 12V
    duphong9_C15 = 0;
    out_relay = 0;
    xuat_32bit(out_relay);
    delay_ms(1500);
RESET:
    buf_rc_u4[0] = 0;
    buf_rc_u4[1] = 0;
    buf_rc_u4[2] = 0;
    buf_rc_u4[3] = 0;
    buf_rc_u4[4] = 0;
    buf_rc_u4[5] = 0;
    buf_rc_u4[6] = 0;
    GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_12); // den bao mau xanh da troi Port A12
    GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_8);  //
    GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_9);  // KICK MOSFET IRF9530 FOR RELAY 12V

    // GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_6);   //pin87_ARM chuyen thanh INPUT
    GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_6); // button ACinput here!
                                                      // CONFIG INPUT
    GPIO_Config(&GPIOD_BASE, _GPIO_PINMASK_6, _GPIO_CFG_MODE_INPUT | _GPIO_CFG_PULL_UP);
    // duphong87_D6=1;

    GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_7); //
    GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_3); //
    GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_4); //
    STAT = 0;
    duphong66_C9 = 1;
    duphong67_A8 = 1;
    duphong88_D7 = 1;
    duphong89_B3 = 1;
    duphong90_B4 = 1;
    //    usart1_init();
    usart2_init();
    uart4__init(); // bauld=9600 rs485 uart 4
    // DATA_TRUE=0;
    // PROCESSING_RS485=0;
    // RESPOND_PROCESSING_RS485=0;
    // count_buf_rc_4=0;
    // TRAN_4    //   rs485 uart 4
    // uart4_string("K000003");
    // uart4_chr(0x0D);
    // uart4_chr(0x0A);
    // REC_4
    ////////////
    timer1_init();
    memset(but_state, 0, 24);
    delay_ms(1000);
    // duphong8_C14=1; // KICK MOSFET IRF9530 FOR RELAY 12V
    RCC_APB1ENR.B11 = 1; // Enable clock gating for Watchdog Timer 0 module
    WWDG_CFR = 1;        // Write window value to be compared to the downcounter
    while (1)
    {
        // xu ly BELL
        // xu ly KEYCARD
        // run only RCU2
        //////////////////////////////////////
        if (KEYCARD_INSERT)
        {
            KEYCARD_COUNTER_CLOSE = 0;
        }

        if (!KEYCARD_INSERT)
        {
            KEYCARD_COUNTER_CLOSE++;
            if (KEYCARD_COUNTER_CLOSE >= 0x001fffff)
            {
                KEYCARD_COUNTER_CLOSE = 0;
                KEYCARD_ENABLE = 0;
                // TURN OFF ALL RELAY WHEN KEYCARD_REMOVED
                out_relay = 0;
                // duphong8_C14=0; // KICK OFF MOSFET IRF9530 FOR RELAY 12V
                STAT = 0;
                MASTER_BEDROOM_STATUS = 0;
                AMBIENT_STATUS = 0;
                ACCENT_STATUS = 0;
                RS485_CONTROL_S9 = 0;
                RS485_CONTROL_S10 = 0;
                RS485_CONTROL_S9_S11 = 0;
                RS485_STATUS_S9 = 0;
                RS485_STATUS_S10 = 0;
                RS485_STATUS_S9_S11 = 0;
                // TURN OFF ALL LED WHEN KEYCARD_REMOVED
                //  PORT11;PORT9;PORT7
                LED_11_0 = 0;
                LED_11_1 = 0;
                LED_9_0 = 0;
                LED_9_1 = 0;
                LED_7_0 = 0;
                // PORT10
                LED_10_0 = 0;
                LED_10_1 = 0;
                // PORT8
                LED_8_0 = 0;
                LED_8_1 = 0;
                // PORT6
                LED_6_0 = 0;
                // PORT5
                LED_5_0 = 0;
                LED_5_1 = 0;
                // PORT4
                LED_4_0 = 0;
                LED_4_1 = 0;
                // PORT3
                LED_3_0 = 0;
                // LED_3_1=NULL
                LED_3_2 = 0;
                // PORT2
                LED_2_0 = 0;
                LED_2_1 = 0;
                LED_2_2 = 0;
                // PORT1
                LED_1_0 = 0;
                LED_1_1 = 0;
                LED_1_2 = 0;
            }
        }
        //  rs485 process
        if (PROCESSING_RS485)
        {
            // send : K12345M
            //   RECEIVED :   COUNTER-BUFFER >= 6; not-save "K"
            // buf_rc_u4[0] = 1
            // buf_rc_u4[1] = 2
            // buf_rc_u4[2] = 3
            // buf_rc_u4[3] = 4
            // buf_rc_u4[4] = E
            // buf_rc_u4[5] = M = 0x4D
            PROCESSING_RS485 = 0;
            if (buf_rc_u4[4] == 0x45)
            { // 0x4D= "E"
                KEYCARD_INSERT = 1;
                buf_rc_u4[5] = 0; // CLEAR DATA
                STAT = ~STAT;
            }

            if (buf_rc_u4[4] == 0x48)
            { // 0x4D= "H"
                KEYCARD_INSERT = 0;
                KEYCARD_ENABLE = 0;
                // TURN OFF ALL RELAY WHEN KEYCARD_REMOVED
                out_relay = 0;
                // duphong8_C14=0; // KICK OFF MOSFET IRF9530 FOR RELAY 12V
                STAT = 0;
                MASTER_BEDROOM_STATUS = 0;
                AMBIENT_STATUS = 0;
                ACCENT_STATUS = 0;
                RS485_CONTROL_S9 = 0;
                RS485_CONTROL_S10 = 0;
                RS485_CONTROL_S9_S11 = 0;
                RS485_STATUS_S9 = 0;
                RS485_STATUS_S10 = 0;
                RS485_STATUS_S9_S11 = 0;
                // TURN OFF ALL LED WHEN KEYCARD_REMOVED
                LED_11_0 = 0;
                LED_11_1 = 0;
                LED_9_0 = 0;
                LED_9_1 = 0;
                LED_7_0 = 0;
                // PORT10
                LED_10_0 = 0;
                LED_10_1 = 0;
                // PORT8
                LED_8_0 = 0;
                LED_8_1 = 0;
                // PORT6
                LED_6_0 = 0;
                // PORT5
                LED_5_0 = 0;
                LED_5_1 = 0;
                // PORT4
                LED_4_0 = 0;
                LED_4_1 = 0;
                // PORT3
                LED_3_0 = 0;
                // LED_3_1=NULL
                LED_3_2 = 0;
                // PORT2
                LED_2_0 = 0;
                LED_2_1 = 0;
                LED_2_2 = 0;
                // PORT1
                LED_1_0 = 0;
                LED_1_1 = 0;
                LED_1_2 = 0;
            }
        }
        ////RS485 - SEND COMNAD CONTROL TO RCU1
        if (RS485_CONTROL_S9_S11)
        {
            RS485_CONTROL_S9_S11 = 0;
            STAT = ~STAT;
            if (RS485_STATUS_S9_S11 == 1)
            {                    // TURN ON S8+S9+S11
                out_relay |= S8; // S8=RELAY_8
                LED_1_1 = 1;     // LED BUTTON2-PORT1 ON
                TRAN_4
                // send : K000B3M
                uart4_chr(0x4B); //"K"
                uart4_chr(0x30); // 0
                uart4_chr(0x30); // 0
                uart4_chr(0x30); // 0
                uart4_chr(0x42); //"B"
                uart4_chr(0x33); //"3"
                uart4_chr(0x4D); //"M"
                uart4_chr(0x0D);
                uart4_chr(0x0A);
                REC_4
            }
            if (RS485_STATUS_S9_S11 == 0)
            {                        // TURN OFF S8+S9+S11
                out_relay &= ~S8;    // s8=RELAY_8
                LED_1_1 = 0;         // LED BUTTON2-PORT1 OFF
                TRAN_4               // send : K000T3M
                    uart4_chr(0x4B); //"K"
                uart4_chr(0x30);     // 0
                uart4_chr(0x30);     // 0
                uart4_chr(0x30);     // 0
                uart4_chr(0x54);     //"T"
                uart4_chr(0x33);     //"3'
                uart4_chr(0x4D);     //"M"
                uart4_chr(0x0D);
                uart4_chr(0x0A);
                REC_4
            }
        }
        // RS485_CONTROL_S9+S17  (S9->rcu1; S12-RELAY_7)
        if (RS485_CONTROL_S9 == 1)
        {
            RS485_CONTROL_S9 = 0;
            STAT = ~STAT;
            if (RS485_STATUS_S9)
            {                        // TURN ON S9+S12
                LED_3_0 = 1;         // LED PORT3 ON
                LED_5_0 = 1;         // LED PORT5 ON
                out_relay |= S12;    // S12 - RELAY_7
                TRAN_4               // send : K000B2M
                    uart4_chr(0x4B); //"K"
                uart4_chr(0x30);     // 0
                uart4_chr(0x30);     // 0
                uart4_chr(0x30);     // 0
                uart4_chr(0x42);     //"B"
                uart4_chr(0x32);     //"2"
                uart4_chr(0x4D);     //"M"
                uart4_chr(0x0D);
                uart4_chr(0x0A);
                REC_4
            }
            if (!RS485_STATUS_S9)
            {                        // TURN OFF S9+S12
                LED_3_0 = 0;         // LED PORT3 OFF
                LED_5_0 = 0;         // LED PORT5 OFF
                out_relay &= ~S12;   // S12 - RELAY_7
                TRAN_4               // send : K000T2M
                    uart4_chr(0x4B); //"K"
                uart4_chr(0x30);     // 0
                uart4_chr(0x30);     // 0
                uart4_chr(0x30);     // 0
                uart4_chr(0x54);     //"T"
                uart4_chr(0x32);     //"2"
                uart4_chr(0x4D);     //"M"
                uart4_chr(0x0D);
                uart4_chr(0x0A);
                REC_4
            }
        }
        if (RS485_CONTROL_S10 == 1)
        {
            RS485_CONTROL_S10 = 0;
            STAT = ~STAT;
            if (RS485_STATUS_S10)
            {
                LED_1_2 = 1;         // LED PORT1 0N
                TRAN_4               // send : K000B1M
                    uart4_chr(0x4B); //"K"
                uart4_chr(0x30);     // 0
                uart4_chr(0x30);     // 0
                uart4_chr(0x30);     // 0
                uart4_chr(0x42);     //"B"
                uart4_chr(0x31);     //"1"
                uart4_chr(0x4D);     //"M"
                uart4_chr(0x0D);
                uart4_chr(0x0A);
                REC_4
            }
            if (!RS485_STATUS_S10)
            {
                LED_1_2 = 0;         // LED PORT1 0ff
                TRAN_4               // send : K00001M
                    uart4_chr(0x4B); //"K"
                uart4_chr(0x30);     // 0
                uart4_chr(0x30);     // 0
                uart4_chr(0x30);     // 0
                uart4_chr(0x54);     //"T"
                uart4_chr(0x31);     //"1"
                uart4_chr(0x4D);     //"M"
                uart4_chr(0x0D);
                uart4_chr(0x0A);
                REC_4
            }
        }

        // statusConnect=SPI_Ethernet_doPacket();
        //  process_touch();
    }
}