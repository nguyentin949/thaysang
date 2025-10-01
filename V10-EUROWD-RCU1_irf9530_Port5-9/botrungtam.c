#include "main.h"
#include "__EthEnc28j60.h"
#include "main.h"
#include "init.h"
#include "__EthEnc28j60.c"

// NHATRANG EUROWINDOW
// RCU 1   -RL5,RL4  USELESS
// PORT1 BELL+2LED:       BELL       RL13
// PORT2 VESTIB-LIV       (S1+S4)      RL8
//       AMBIEN-LIV       (S2+S3)+S6   RL7+RL6
//       ACCENT-LIV       S5         RL3
// PORT3 CURTAIN_1        C21,C22    RL12,RL11
// PORT4 CURTAIN_2        C23,C24    RL10,RL9
// PORT5 NC
// PORT6 NC
// PORT7 POWDER ENTRANCE    S6           RL6
// PORT8 AMBIENT-BATH     S9+S11         RL2,RL1
//       ACCENT-BATH      S10            RL16
// PORT9 MASTER-LIV    (S2+S3)+S6+ S5    RL7,RL6,RL4
//       VESTIB-LIV      (S1+S4)           RL8
// PORT10 DND-MUR
// PORT11 NC
// PORT12 KEYCARD
// PORT13   AC-INPUT DIMMER  TO KEYCARD
//  KEYCARD  SOCKET   RL15
//           AIRCON   RL14
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
<br>IP:192.168.1.123-\
<br>MAC:00-14-A5-76-18-00-</h1>\
</body></html>\
";

const code char *indexPage =
    "<html><head>\
";
const code char *HomePage =
    "<head>\
</html>\
";
const code char *ServicePage =
    "<tr><th colspan=3>Service</th></tr>\
</html>\
";

const code char *LightingPage =
    "<tr><th colspan=3>Light</th></tr>\
</html>\
";

const code char *CurtainPage =
    "<tr><th colspan=3>Curtain</th></tr>\
</html>\
";
const code char *ScenesPage =
    "<tr><th colspan=6>Scenes</th></tr>\
</html>\
";
const code char *Fan_SpeedPage =
    "<tr><th colspan=3>Fan Speed</th></tr>\
</html>\
";
const code char *Dimer_ExtantPage =
    "<tr><th colspan=4>Dimer</th></tr>\
</html>\
";

const code char *Device_ExtantPage =
    "<head>\
</html>\
";
const code char *SettingPage =
    "<head>\
</html>\
";

unsigned char myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x18, 0x00}; // my MAC address
unsigned char myIpAddr[4] = {192, 168, 1, 123};                    // my IP Address CHO LAN CHAY DAU TIEN
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
unsigned char curtain;
unsigned char flag_all_dimer_percent = 0;
unsigned char DELAY_SEND_DIMMER = 0;
unsigned char PERCENT_DIMMER = 0;
unsigned char DATA_TRUE, PROCESSING_RS485, RESPOND_PROCESSING_RS485;
unsigned char MASTER_SWITCH = 0;
unsigned char MASTER_LIVING = 0;
unsigned char MASTER_LIV_STATUS = 0;
unsigned char AMBIENT_LIVING = 0;
unsigned char AMBIENT_LIV_STATUS = 0;
unsigned char AMBIENT_BATH = 0;
unsigned char AMBIENT_BATH_STATUS = 0;

unsigned char CURTAIN_1_STATUS = 0;
unsigned char CURTAIN_2_STATUS = 0;
unsigned char CURTAIN_1_OFFRELAY = 0;
unsigned char CURTAIN_2_OFFRELAY = 0;

unsigned char CURTAIN_2_FORWARD = 0;
unsigned char CURTAIN_2_BACKWARD = 0;
unsigned char CURTAIN_2_TIMEOUT = 0;
unsigned long CURTAIN_2_COUNTER_CLOSE = 0;
unsigned char CURTAIN_1_FORWARD = 0;
unsigned char CURTAIN_1_BACKWARD = 0;
unsigned char CURTAIN_1_TIMEOUT = 0;
unsigned long CURTAIN_1_COUNTER_CLOSE = 0;

unsigned char CMD_CHART_RS485 = 0;
unsigned char CMD_STATUS_SCHART_RS485 = 0;
unsigned char SEND_RS485_KEY = 0;
unsigned char KEYCARD_SEND_RS485 = 0;

unsigned char DO_NOT_DISTURB = 0;
unsigned char KEYCARD_ENABLE = 0;
unsigned char KEYCARD_STARTUP = 0;
unsigned char KEYCARD_INSERT = 0;
unsigned long KEYCARD_COUNTER = 0;
unsigned long KEYCARD_COUNTER_CLOSE = 0;
unsigned long BELL_COUNTER = 0;
unsigned char BELL_ENABLE = 0;
unsigned char DIM4_EVERGREEN = 0;
unsigned char DIM2_EVERGREEN = 0;
void settingEthenet(void)
{
    ptr = (unsigned long *)Address;
    i = *ptr;
    if (i == 0xffffffff)
    { // khi moi nap frimware thi dia chi ip se la fffffff
        FLASH_ErasePage(Address);
        // start Address Flash : 0x08000000  - bo nho chuong trinh
        // stm32f103vct6 co 256 kb flash -> 0x08000000->0x08040000
        // add=0800.8000 -> 32kb dau tien cua chuong
        // Used ROM (bytes): 29581 (11%)  Free ROM (bytes): 232563 (89%)
        // Static RAM (bytes): 641   Dynamic RAM (bytes): 48507
        FLASH_Write_Word(Address, 0xC0A8017B); // c0:a8:01:7B  = 192.168.1.123
    }
    // i=0xC0A8017A ;       // hop sua lai i= ma ko can flash address
    myIpAddr[0] = i >> 24;
    myIpAddr[1] = i >> 16;
    myIpAddr[2] = i >> 8;
    myIpAddr[3] = i;
    gwIpAddr[0] = myIpAddr[0];
    gwIpAddr[1] = myIpAddr[1];
    gwIpAddr[2] = myIpAddr[2];
    gwIpAddr[3] = 1;
    SPI_Ethernet_Init(myMacAddr, myIpAddr, SPI_Ethernet_FULLDUPLEX);
    SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr);
}
void putChar(unsigned char c)
{
    while (UART4_SRbits.TC == 0)
        ;
    UART4_DRbits.DR = c;
}
void saveIP(unsigned char buf[])
{
    unsigned long ipWord;
    unsigned char i = 0, j, pos = 0;
    while (i < 39)
    {
        if (buf[i] == 'i' && buf[i + 1] == 'p')
        {
            for (j = 0; j < 4; j++)
            {
                if (buf[i + 4] >= 48 && buf[i + 4] <= 57 && (buf[i + 5] < 48 || buf[i + 5] > 57))
                {
                    ipAddress[j] = buf[i + 4] - 48;
                    i += 2;
                }
                else if (buf[i + 4] >= 48 && buf[i + 4] <= 57 && (buf[i + 5] >= 48 || buf[i + 5] <= 57) && (buf[i + 6] < 48 || buf[i + 6] > 57))
                {
                    ipAddress[j] = 10 * (buf[i + 4] - 48) + (buf[i + 5] - 48);
                    i += 3;
                }
                else if (buf[i + 4] >= 48 && buf[i + 4] <= 57 && (buf[i + 5] >= 48 || buf[i + 5] <= 57) && (buf[i + 6] >= 48 || buf[i + 6] <= 57))
                {
                    ipAddress[j] = 100 * (buf[i + 4] - 48) + 10 * (buf[i + 5] - 48) + (buf[i + 6] - 48);
                    i += 4;
                }
            }
            FLASH_ErasePage(Address);
            ipword = (((unsigned long)ipAddress[0]) << 24) | (((unsigned long)ipAddress[1]) << 16) | (((unsigned long)ipAddress[2]) << 8) | (((unsigned long)ipAddress[3]));
            FLASH_Write_Word(Address, ipWord);
            settingEthenet();
        }
        i++;
    }
}
void copyBuf(unsigned char a[], unsigned char b[], unsigned char size)
{
    unsigned char index;
    for (index = 0; index < size; index++)
    {
        b[index] = a[index];
    }
}
unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
{
    unsigned int len = 0;
    unsigned char vt_button = 0;
    unsigned long shift = 1;

    unsigned char locate = 0, _locate = 0, h = 0;
    unsigned int _myip[4];
    if (localPort != 80)
    {
        return (0);
    }
    for (len = 0; len < 30; len++)
    {
        getRequest[len] = SPI_Ethernet_getByte();
    }
    getRequest[len] = 0;
    len = 0;
    if (memcmp(getRequest, httpMethod, 5))
    {
        return (0);
    }

    if (getRequest[5] == 't')
    {
        if (isdigit(getRequest[6]))
        {
            index_page = getRequest[6] - '0';
            if (index_page == Page_Setting)
            {
                _locate = 10;
                for (h = 0; h < 4; h++)
                {
                    locate = get_point(getRequest, _locate, 25);
                    _myip[h] = chuoi_so(getRequest, _locate, (locate - 1));
                    _locate = locate + 1;
                }
                if ((_myip[0] <= 255) && (_myip[1] <= 255) && (_myip[2] <= 255) && (_myip[3] <= 255))
                {
                    for (h = 0; h < 4; h++)
                    {
                        myIpAddr[h] = _myip[h];
                    }
                    flag_reset_ip = 1;
                }
            }
        }
    }
    else if (getRequest[5] == 's')
    {
        STAT = ~STAT; // LED INDICATOR HOPTEST
        len = putConstString(httpHeader);
        len += putConstString(httpMimeTypeHTML);
        switch (index_page)
        {
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
    switch (index_page)
    {
    case Page_Service:
        if (getRequest[5] == 'o')
        {
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
                switch (vt_button)
                {
                case 0: // SERVICE_1
                    break;
                case 1: // SERVICE_2
                    break;
                default:
                    break;
                }
            }
            len += putConstString("r");
            status_wed_service |= (shift << vt_button);
            LongWordToStr(status_wed_service, dyna);
            len += putString(dyna);
            // xuat_32bit(out_relay);
        }
        else if (getRequest[5] == 'f')
        {
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
            }
            status_wed_service |= (shift << vt_button);
            len += putConstString("r");
            LongWordToStr(status_wed_service, dyna);
            len += putString(dyna);
        }
        break;
    case Page_Lighting:
        if (getRequest[5] == 'o')
        {
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
                switch (vt_button)
                {
                case 0: // ENTRANCE
                    break;
                case 1: // MASTER
                    break;
                case 2: // LIGHT_BATH
                    break;
                case 3: // LIGHT_READING
                    break;
                case 4: // LIGHT_BEDSIDE
                    break;
                default:
                    break;
                }
            }
            len += putConstString("r");
            status_wed_light |= (shift << vt_button);
            LongWordToStr(status_wed_light, dyna);
            len += putString(dyna);
            xuat_32bit(out_relay);
        }
        else if (getRequest[5] == 'f')
        {
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
                switch (vt_button)
                {
                case 0: // ENTRANCE
                    break;
                case 1: // MASTER
                    break;
                case 2: // LIGHT_BATH
                    break;
                case 3: // LIGHT_READING
                    break;
                case 4: // LIGHT_BEDSIDE
                    break;
                default:
                    break;
                }
            }
            flag_but_dimer = 0;
            len += putConstString("r");
            status_wed_light |= (shift << vt_button);
            LongWordToStr(status_wed_light, dyna);
            len += putString(dyna);
        }
        break;
    case Page_Curtain:
        if (getRequest[5] == 'o')
        {
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
                switch (vt_button)
                {
                case 0: // CURTAIN_O 1   OPEN THEN CLOSE
                    break;
                case 1: // CURTAIN_C 1   OPEN THEN STOP
                    break;
                case 2: // CURTAIN_O 2
                    break;
                case 3: // CURTAIN_C 2
                    break;

                default:
                    break;
                }
            }
            len += putConstString("r");
            status_wed_curtain |= (shift << vt_button);
            LongWordToStr(status_wed_curtain, dyna);
            len += putString(dyna);
            // xuat_32bit(out_relay);    //de cho chuong trinh ngat button xuat
        }
        else if (getRequest[5] == 'f')
        {
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
                switch (vt_button)
                {
                case 0: // CURTAIN_O 1
                    break;
                case 1: // CURTAIN_C 1  OPEN THEN STOP ( TURN ON 8&9)
                    break;
                case 2: // CURTAIN_O 2
                    break;
                case 3: // CURTAIN_C 2
                    break;
                default:
                    break;
                }
            }
            len += putConstString("r");
            status_wed_curtain &= ~(shift << vt_button);
            LongWordToStr(status_wed_curtain, dyna);
            len += putString(dyna);
            // xuat_32bit(out_relay);   //de cho chuong trinh ngat button xuat ???
        }
        break;
    case Page_Scenes:
        if (getRequest[5] == 'o')
        {
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
                switch (vt_button)
                {
                case 0: // S_RELAX
                    break;
                case 1: // S_NIGHT
                    break;
                case 2: // S_PARTY
                    break;
                default:
                    break;
                }
            }
            len += putConstString("r");
            status_wed_scenes |= (shift << vt_button);
            LongWordToStr(status_wed_scenes, dyna);
            len += putString(dyna);
            xuat_32bit(out_relay);
        }
        else if (getRequest[5] == 'f')
        {
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
                switch (vt_button)
                {
                case 0: // S_RELAX
                    break;
                case 1: // S_NIGHT
                    break;
                case 2: // S_PARTY
                    break;
                default:
                    break;
                }
            }
            len += putConstString("r");
            status_wed_scenes |= (shift << vt_button);
            LongWordToStr(status_wed_scenes, dyna);
            len += putString(dyna);
        }
        break;
    case Page_Fan_Speed:
        if (getRequest[5] == 'o')
        {
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
                switch (vt_button)
                {
                case 0: // FAN_ON_OFF
                    break;
                case 1: // FAN_LOW
                    break;
                case 2: // FAN_MEDIUM
                    break;
                case 3: // FAN_HIGHT
                    break;
                default:
                    break;
                }
            }
            len += putConstString("r");
            if ((out_relay & FAN_L) ? 1 : 0)
                status_wed_fan |= (shift << 1);
            else
                status_wed_fan &= ~(shift << 1);
            if ((out_relay & FAN_M) ? 1 : 0)
                status_wed_fan |= (shift << 2);
            else
                status_wed_fan &= ~(shift << 2);
            if ((out_relay & FAN_H) ? 1 : 0)
                status_wed_fan |= (shift << 3);
            else
                status_wed_fan &= ~(shift << 3);
            LongWordToStr(status_wed_fan, dyna);
            len += putString(dyna);
        }
        else if (getRequest[5] == 'f')
        {
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
                switch (vt_button)
                {
                case 0: // FAN_ON_OFF
                    break;
                case 1: // FAN_LOW
                    break;
                case 2: // FAN_MEDIUM
                    break;
                case 3: // FAN_HIGHT
                    break;
                default:
                    break;
                }
            }
            len += putConstString("r");
            if ((out_relay & FAN_L) ? 1 : 0)
                status_wed_fan |= (shift << 1);
            else
                status_wed_fan &= ~(shift << 1);
            if ((out_relay & FAN_M) ? 1 : 0)
                status_wed_fan |= (shift << 2);
            else
                status_wed_fan &= ~(shift << 2);
            if ((out_relay & FAN_H) ? 1 : 0)
                status_wed_fan |= (shift << 3);
            else
                status_wed_fan &= ~(shift << 3);
            LongWordToStr(status_wed_fan, dyna);
            len += putString(dyna);
        }
        break;
    case Page_Dimer_Extant:
        if (getRequest[5] == 'o')
        {
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
                switch (vt_button)
                {
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
            status_wed_dimer |= (shift << vt_button);
            LongWordToStr(status_wed_dimer, dyna);
            len += putString(dyna);
        }
        else if (getRequest[5] == 'f')
        {
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
                switch (vt_button)
                {
                case 0: // up1
                    break;
                case 1: // dow1
                    break;
                case 2: // up34
                    break;
                case 3: // down34
                    break;
                case 4: // up3;
                    break;
                case 5: // down3
                default:
                    break;
                }
            }
            len += putConstString("r");
            status_wed_dimer &= ~(shift << vt_button);
            LongWordToStr(status_wed_dimer, dyna);
            len += putString(dyna);
        }
        break;
    case Page_Device_Extant:
        if (getRequest[5] == 'd')
        {
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
            }
            if (isdigit(getRequest[6]))
            {
                if (getRequest[7] == '$')
                    vt_button = getRequest[6] - '0';
                else if (getRequest[8] == '$')
                    vt_button = chuoi_so(getRequest, 6, 7);
                else if (getRequest[9] == '$')
                    vt_button = chuoi_so(getRequest, 6, 8);
            }
            len += putConstString("r");
            wed_status_button ^= (shift << vt_button);
            out_relay ^= (shift << vt_button);
            LongWordToStr(wed_status_button, dyna);
            len += putString(dyna);
            // xuat_32bit(out_relay);   //de cho chuong trinh ngat button xuat
        }
        break;
    case Page_Setting:
        copyBuf(getRequest, buf, 40);
        saveIP(buf);
        if (getRequest[5] == 'f')
        {
            len += putConstString("r");
            len += putString(dyna);
        }
        break;
    default:
        break;
    }
    if (len == 0)
    {
        len = putConstString(httpHeader);
        len += putConstString(httpMimeTypeHTML);
        switch (index_page)
        {
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
    return (len);
}
unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags)
{
    return (0);
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
        duphong67_A8 = ~duphong67_A8; // LED INDICAROR QUET BAN PHIM
                                      // PORT 1 _ 3INPUT-3LED
        //  PHIA BEN NGOAI CUA RA VAO : 1INPUT BELL-3LED : BELL;MUR;DND
        //  INPUT KO SU DUNG; LED_1_0: MUR
        if (but_status[0] == PRES_DOW)
        {
            // LED_1_0=1;
        }
        else if (but_status[0] == PRES_UP)
        {
            // LED_1_0=0;
        }
        // INPUT KO SU DUNG; LED_1_1: DND
        if (but_status[1] == PRES_DOW)
        {
            // LED_1_1=1;
        }
        else if (but_status[1] == PRES_UP)
        {
            // LED_1_1=0;
        }
        // BELL OUTSIDE -RELAY-13
        if (but_status[2] == PRES_DOW)
        {
            // LED_1_2=1;
            if (!DO_NOT_DISTURB)
            {
                out_relay |= RELAY_13;
                BELL_ENABLE = 1;
            }
        }
        else if (but_status[2] == PRES_UP)
        {
            // LED_1_2=0;
        }
        // PORT 2  3-INPUT-3LED (S1+S4)+ [(S2+S3)+S6)] + (S5)
        // VESTIBULE-LIVING  (S1+S4) -> RELAY-8
        if (but_status[3] == PRES_DOW)
        {
            LED_2_0 = 1;
            out_relay ^= RELAY_8;
        }
        else if (but_status[3] == PRES_UP)
        {
            LED_2_0 = (out_relay & RELAY_8) ? 1 : 0;
            LED_9_1 = LED_2_0; // VESTIBULE-LIV port9
        }
        // AMBIENT LIVING S2+S3+S6
        // S2+S3: RELAY-7;   S6:RELAY-6
        if (but_status[4] == PRES_DOW)
        {
            // LED_2_1=1;
            // out_relay^=RELAY_7;
            // out_relay^=RELAY_6;
            AMBIENT_LIV_STATUS ^= 1;
            AMBIENT_LIVING = 1;
        }
        else if (but_status[4] == PRES_UP)
        {
            // LED_2_1=(out_relay&RELAY_7)?1:0;
        }

        //  ACCENT LIVING  S5 - RELAY-3
        if (but_status[5] == PRES_DOW)
        {
            LED_2_2 = 1;
            out_relay ^= RELAY_3;
        }
        else if (but_status[5] == PRES_UP)
        {
            LED_2_2 = (out_relay & RELAY_3) ? 1 : 0;
        }

        // PORT3  (3IN-2LED)_KO CO LED BUTTON2 LED_3_1=NULL)
        // INPUT1_KO_SU_DUNG; INPUT 2;3: C21-C22 CURTAIN-1
        if (but_status[6] == PRES_DOW)
        {
            // LED_3_0=1;
        }
        else if (but_status[6] == PRES_UP)
        {
            // LED_3_0=0;
        }
        //  CURTAIN-1 _ C21+C22 (RL12+RL11)  FORWARD
        if (but_status[7] == PRES_DOW)
        {
            LED_3_0 = 1;
            CURTAIN_1_TIMEOUT = 1;
            CURTAIN_1_FORWARD ^= 1;
            CURTAIN_1_STATUS = 1;
            CURTAIN_1_OFFRELAY = 0;
        }
        else if (but_status[7] == PRES_UP)
        {
            // LED_3_0=(out_relay&RELAY_12)?1:0;
        }
        //  CURTAIN-1 _ C21+C22 (RL12+RL11)  BACKWARD
        if (but_status[8] == PRES_DOW)
        {
            LED_3_2 = 1;
            CURTAIN_1_TIMEOUT = 1;
            CURTAIN_1_BACKWARD ^= 1;
            CURTAIN_1_STATUS = 2;
            CURTAIN_1_OFFRELAY = 0;
        }
        else if (but_status[8] == PRES_UP)
        {
            // LED_3_2=(out_relay&RELAY_11)?1:0;
        }
        //
        // PORT4(2IN-3LED)( KO CO BUTTON3) C23-C24 CURTAIN-2
        // CURTAIN-2 _ C23+C24 (RL10+RL9)  FORWARD
        if (but_status[9] == PRES_DOW)
        {
            LED_4_0 = 1;
            CURTAIN_2_TIMEOUT = 1;
            CURTAIN_2_FORWARD ^= 1;
            CURTAIN_2_STATUS = 1;
        }
        else if (but_status[9] == PRES_UP)
        {
            // LED_4_0=(out_relay&RELAY_10)?1:0;
        }
        // CURTAIN-2 _ C23+C24 (RL10+RL9)  BACKWARD
        if (but_status[10] == PRES_DOW)
        {
            LED_4_1 = 1;
            CURTAIN_2_TIMEOUT = 1;
            CURTAIN_2_BACKWARD ^= 1;
            CURTAIN_2_STATUS = 2;
        }
        else if (but_status[10] == PRES_UP)
        {
            // LED_4_1=(out_relay&RELAY_9)?1:0;
        }

        // PORT5-(2LED-2IN)
        // KHONG SU DUNG
        if (but_status[11] == PRES_DOW)
        {
        }
        else if (but_status[11] == PRES_UP)
        {
        }
        // KHONG SU DUNG - PHAN ARM BI LOI DI'NH CHA^N voi GND Vinput=0v
        if (but_status[12] == PRES_DOW)
        {
        }
        else if (but_status[12] == PRES_UP)
        {
        }
        // PORT6(1LED-1IN)
        // KHONG SU DUNG - PHAN ARM BI LOI DI'NH CHA^N voi GND Vinput=0v
        if (but_status[13] == PRES_DOW)
        {
            // LED_6_0=1;
        }
        else if (but_status[13] == PRES_UP)
        {
        }
        // PORT7-(1LED-1IN) POWDER ROOM ENTRANCE S6-RL6
        if (but_status[14] == PRES_DOW)
        {
            LED_7_0 = 1;
            out_relay ^= S6; //  S6-RL6
        }
        else if (but_status[14] == PRES_UP)
        {
            LED_7_0 = (out_relay & S6) ? 1 : 0;
        }
        // PORT8- AMBIENT BATH + ACCENT BATH
        //  AMBIENT BATH S9+S11  (RL2-RL1)
        if (but_status[15] == PRES_DOW)
        {
            LED_8_0 = 1;
            // out_relay^=RELAY_2;    //S9=RCU2-NIGHTLIGHT
            // out_relay^=RELAY_1;    //S11
            AMBIENT_BATH = 1;
            AMBIENT_BATH_STATUS ^= 1;
        }
        else if (but_status[15] == PRES_UP)
        {
            // LED_8_0=(out_relay&RELAY_1)?1:0;
        }

        //  ACCENT BATH   S10-RL16
        if (but_status[16] == PRES_DOW)
        {
            LED_8_1 = 1;
            out_relay ^= RELAY_16;
            // wed_status_button^=(shift<<15);
            // TIMEOUT_RELAY_16 =0;
        }
        else if (but_status[16] == PRES_UP)
        {
            LED_8_1 = (out_relay & RELAY_16) ? 1 : 0;
        }
        ////PORT9-0:  MASTER LIVING+ VESIBULE LIVING
        // MASTER LIVING  S2+S3 +S6  +S5
        if (but_status[17] == PRES_DOW)
        {
            MASTER_LIV_STATUS ^= 1;
            MASTER_LIVING = 1;
        }
        else if (but_status[17] == PRES_UP)
        {
        }
        // PORT9-1: VESIBULE LIVING  S1A=RELAY_8
        if (but_status[18] == PRES_DOW)
        {
            LED_9_1 = 1;
            out_relay ^= S1A;
        }
        else if (but_status[18] == PRES_UP)
        {
            LED_9_1 = (out_relay & S1A) ? 1 : 0;
            LED_2_0 = LED_9_1; // VESTIBULE-LIV port2
        }
        //  PORT10 MUR+DND
        // 10-0 MAKE UP ROOM
        if (but_status[19] == PRES_DOW)
        {
            DO_NOT_DISTURB = 0;
            LED_10_0 ^= 1; // LED MUR port10
            LED_1_0 ^= 1;  // LED MUR port1
            LED_10_1 = 0;  // LED DND port10 OFF
            LED_1_1 = 0;   // LED DND port1  OFF
        }
        else if (but_status[19] == PRES_UP)
        {
        }
        // PORT10 DND
        if (but_status[20] == PRES_DOW)
        {
            DO_NOT_DISTURB = (DO_NOT_DISTURB ^ 0x01);
            LED_10_1 = DO_NOT_DISTURB; // LED DND port10
            LED_1_1 = DO_NOT_DISTURB;  // LED DND port1
            LED_10_0 = 0;              // LED MUR port10 OFF
            LED_1_0 = 0;               // LED MUR port1  OFF
        }
        else if (but_status[20] == PRES_UP)
        {
        }
        // PORT11 KO SU DUNG
        if (but_status[21] == PRES_DOW)
        {
            LED_11_0 ^= 1;
        }
        else if (but_status[21] == PRES_UP)
        {
            // LED_11_0=0;
        }
        // KO SU DUNG
        if (but_status[22] == PRES_DOW)
        {
            // LED_11_1^=1;
        }
        else if (but_status[22] == PRES_UP)
        {
            // LED_11_1=(out_relay&RELAY_5)?1:0;
        }
        // PORT12 (1IN - 1LED) - KEYCARD
        //
        if (but_status[23] == PRES_DOW)
        {
            // LED_12_0=1;  khong co den
            // KEYCARD_COUNTER_CLOSE=0;
            // KEYCARD_INSERT=1;
        }
        else if (but_status[23] == PRES_UP)
        {
            // LED_12_0=0;
            // KEYCARD_INSERT=0;
        }
        // PORT13 (ac input from DIMMER for KEYCARD direct)
        if (but_status[24] == PRES_DOW)
        {
            STAT = 1;
            KEYCARD_INSERT = 1;
            // KEYCARD_COUNTER_CLOSE=0;
            KEYCARD_ENABLE = 1; // enable xuat_32bit(out_relay)
        }
        else if (but_status[24] == PRES_UP)
        {
            STAT = 0;
            KEYCARD_INSERT = 0;
        }
        //    // xu ly KEYCARD - TRONG BO KEYCARD CUA HAGER CO SAN DELAY 30 GIAY
        // CHECK KEYCARD TO ENABLE OUT RELAY

        if (KEYCARD_ENABLE == 1)
        {
            // XU LY MASTER_LIVING (S2+S3)+S5+S6
            if (MASTER_LIVING == 1)
            {
                if (MASTER_LIV_STATUS != 0)
                {
                    // neu dang OFF thi turn ALL ON
                    out_relay |= S2A; // AMBIENT-LIV
                    out_relay |= S6;  // POWDER-LIV
                    out_relay |= S5;  // ACCENT-LIV
                    LED_9_0 = 1;      // MASTER-LIV         PORT5
                    LED_2_1 = 1;      // AMBIENT-LIV s2+s3  PORT2
                    LED_2_2 = 1;      // ACCENT-LIV s5      PORT2
                    LED_7_0 = 1;      // POWDER-LIV s6      PORT6
                }
                if (MASTER_LIV_STATUS == 0)
                {
                    // neu dang ON thi turn ALL OFF
                    out_relay &= ~S2A; // AMBIENT-LIV
                    out_relay &= ~S6;  // POWDER-LIV
                    out_relay &= ~S5;  // ACCENT-LIV
                    LED_9_0 = 0;       // MASTER-LIV         PORT5
                    LED_2_1 = 0;       // AMBIENT-LIV s2+s3  PORT2
                    LED_2_2 = 0;       // ACCENT-LIV s5      PORT2
                    LED_7_0 = 0;       // POWDER-LIV s6      PORT6
                }
                MASTER_LIVING = 0;
            }
            // XU LY AMBIENT_LIVING  (S2+S3)+S6
            if (AMBIENT_LIVING == 1)
            {
                if (AMBIENT_LIV_STATUS != 0)
                {
                    out_relay |= S2A; // S2A=RELAY_7 AMBIENT-LIV
                    out_relay |= S6;  // S6=RELAY_6 POWDER-LIV
                    LED_2_1 = 1;      // AMBIENT-LIV s2+s3  PORT2
                    LED_7_0 = 1;      // POWDER-LIV s6      PORT6
                }
                if (AMBIENT_LIV_STATUS == 0)
                {
                    // neu dang ON thi turn ALL OFF
                    out_relay &= ~S2A;
                    out_relay &= ~S6;
                    LED_2_1 = 0; // AMBIENT-LIV s2+s3  PORT2
                    LED_7_0 = 0; // POWDER-LIV s6      PORT6
                }
                AMBIENT_LIVING = 0;
            }
            // XU LY AMBIENT_BATHROOM  S9+S11  PORT3.0 & RCU2 call
            if (AMBIENT_BATH == 1)
            {
                if (AMBIENT_BATH_STATUS != 0)
                {
                    out_relay |= S11; // S11=RELAY_1
                    out_relay |= S9;  // S9=RELAY_2
                    LED_8_0 = 1;      // PORT8
                }
                if (AMBIENT_BATH_STATUS == 0)
                {
                    // neu dang ON thi turn ALL OFF
                    out_relay &= ~S11; // S11=RELAY_1
                    out_relay &= ~S9;  // S9=RELAY_2
                    LED_8_0 = 0;       // PORT8
                }
                AMBIENT_BATH = 0;
                // KEYCARD TO ENABLE OUT RELAY
            }
            xuat_32bit(out_relay);
        }
        // KEYCARD disable OUT RELAY
        if (KEYCARD_ENABLE == 0)
        {
            out_relay = 0;
            xuat_32bit(out_relay);
        }
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
                // UART4_CR1bits.RE=0; // DISAnable receiver
                // TIM1_CR1bits.CEN=0;   // TURN OFF TIMER1
                // NVIC_SETENA1bits.SETENA52=0;   // DISABLE NestedvectoredInterruptCcontroller (NVIC) usart4 ( positions= 52)
                // buf_rc_u4[1]=data_rc;
            }
        }
        // else{
        //     buf_rc_u4[count_buf_rc_4++]=data_rc;
        // }
    }
    // TIM1_CR1bits.CEN=1;   // TURN ON TIMER1
}

/*   HOTEL USELESS
void process_touch(){

}
*/

void main()
{
    /*    union U32_      // place this above "main" somewhere
      {
         unsigned long dblword;   // For accessing the whole 32-bit unsigned long
         unsigned char byte[4];  // For accessing all 32-bits as individual bytes
      };
       union U32_ Bytes2long;  // create an instance of the declared union called 'Bytes2long' in this function
    */
    gpio_init();
    // out_relay=0;
    // xuat_32bit(out_relay);
    GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_14); // KICK MOSFET IRF9530 FOR RELAY 12V
    GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_15);
    duphong8_C14 = 0; // KICK MOSFET IRF9530 FOR RELAY 12V
    duphong9_C15 = 0;

RESET:
    // gpio_init();     HOP DELETE AFTER RESET
    ////// HOP HERE ///////////
    // k=0;
    // VALUE_RECEIVED=0;
    GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_12); // den bao mau xanh da troi Port A12
    GPIO_Digital_Output(&GPIOA_BASE, _GPIO_PINMASK_8);  //
    GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_9);  // KICK MOSFET IRF9530 FOR RELAY 12V
    // GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_6);   // DUNG LAM SCANBUTTON  port13 - BUT13_0
    GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_6); // chuyen thanh INPUT

    GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_7); // ke ben pinD6- kick 74hc595
    GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_3); //
    GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_4); //
    STAT = 0;
    duphong66_C9 = 1;
    duphong67_A8 = 1;
    // duphong87_D6=1;   // chuyen vao SCANBUTTON  port13 - BUT13_0
    duphong88_D7 = 0; // ke ben pinD6- kick 74hc595
    duphong89_B3 = 1;
    duphong90_B4 = 1;
    buf_rc_u4[0] = 0;
    buf_rc_u4[1] = 0;
    buf_rc_u4[2] = 0;
    buf_rc_u4[3] = 0;
    buf_rc_u4[4] = 0;
    buf_rc_u4[5] = 0;
    buf_rc_u4[6] = 0;
    //    usart1_init();
    usart2_init();
    uart4__init(); // baud=9600 rs485 uart 4
    DATA_TRUE = 0;
    PROCESSING_RS485 = 0;
    // RESPOND_PROCESSING_RS485=0;
    count_buf_rc_4 = 0;
    TRAN_4 //   rs485 uart 4
        uart4_string("ok");
    uart4_chr(0x0D);
    uart4_chr(0x0A);
    REC_4
    //// kick 74hc595
    out_relay = 0;
    xuat_32bit(out_relay);
    ////
    delay_ms(1500);
    duphong88_D7 = 1; // ke ben pinD6- kick 74hc595
    out_relay = 0;
    xuat_32bit(out_relay);
    memset(but_state, 0, 25);
    timer1_init();
    KEYCARD_ENABLE = 0; // disable xuat_32bit(out_relay)
    // SPI1_Init_Advanced(_SPI_FPCLK_DIV8, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI1_PA567);
    // settingEthenet();
    // FLASH_ErasePage(Address);    ADDREESS LA DIA CHI FLASH CHUA IP
    // delay_ms(1000);
    duphong8_C14 = 1; // KICK MOSFET IRF9530 FOR RELAY 12V
    duphong9_C15 = 1;
    RCC_APB1ENR.B11 = 1; // Enable clock gating for Watchdog Timer 0 module

    // Bit 11 WWDGEN: Window watchdog clock enable
    // The window watchdog is based on a 7-bit downcounter that can be set as free running.
    //  It can be used as a watchdog to reset the device when a problem occurs
    //  WWDG_CFR:CONFIGURATION REGISTER
    //  [W7=0][W6][W5][W4][W3][W2][W1][W0]
    WWDG_CFR = 1; // Write window value to be compared to the downcounter
    while (1)
    {
        //
        // xu ly BELL
        if (BELL_ENABLE)
        {
            BELL_COUNTER++;
            if (BELL_COUNTER >= 0x05ffff)
            {
                out_relay &= ~RELAY_13; // TURN OFF BELL
                BELL_COUNTER = 0;
                BELL_ENABLE = 0;
                // LED_1_2=0;      // LED BELL USELESS
            }
        }
        // xu ly CURTAIN_1
        if (CURTAIN_1_STATUS == 1) // FORWARD
        {
            if (CURTAIN_1_FORWARD)
            {
                CURTAIN_1_OFFRELAY++;
                out_relay &= ~RELAY_11;
                out_relay &= ~RELAY_12;
                if (CURTAIN_1_OFFRELAY >= 0xFE)
                {
                    out_relay |= RELAY_12;  // C21=1
                    out_relay &= ~RELAY_11; // C22=0
                    LED_3_2 = 0;            // LED BACKWARD OFF
                    CURTAIN_1_STATUS = 0;
                    CURTAIN_1_OFFRELAY = 0;
                }
            }
            if (!CURTAIN_1_FORWARD)
            {                          // STOP
                out_relay |= RELAY_12; // C21=1
                out_relay |= RELAY_11; // C22=1
                LED_3_0 = 0;           // STOP
                LED_3_2 = 0;
                CURTAIN_1_STATUS = 0;
            }
        }
        // xu ly CURTAIN_1   // BACKWARD
        if (CURTAIN_1_STATUS == 2) // BACKWARD
        {
            if (CURTAIN_1_BACKWARD)
            {
                CURTAIN_1_OFFRELAY++;
                out_relay &= ~RELAY_11;
                out_relay &= ~RELAY_12;
                if (CURTAIN_1_OFFRELAY >= 0xFE)
                {
                    out_relay &= ~RELAY_12; // C21=0
                    out_relay |= RELAY_11;  // C22=1
                    LED_3_0 = 0;            // LED FORWARD OFF
                    CURTAIN_1_STATUS = 0;
                    CURTAIN_1_OFFRELAY = 0;
                }
            }
            if (!CURTAIN_1_BACKWARD)
            {                          // STOP
                out_relay |= RELAY_12; // C21=1
                out_relay |= RELAY_11; // C22=1
                LED_3_2 = 0;           // STOP
                LED_3_0 = 0;
                CURTAIN_1_STATUS = 0;
            }
            // END BACKWARD
        }

        // xu ly CURTAIN_1 CLOSE THEN OPEN WHEN INSERT KEYCARD
        if (CURTAIN_1_TIMEOUT)
        {
            CURTAIN_1_COUNTER_CLOSE++;
            if (CURTAIN_1_COUNTER_CLOSE >= 0x000fffff)
            {
                out_relay &= ~RELAY_12; // TURN OFF CURTAIN_1 C21
                out_relay &= ~RELAY_11; // TURN OFF CURTAIN_1 C22
                CURTAIN_1_COUNTER_CLOSE = 0;
                CURTAIN_1_TIMEOUT = 0;
                LED_3_0 = 0;
                LED_3_2 = 0;
                CURTAIN_1_STATUS = 0;
            }
        }
        // xu ly CURTAIN_2   // FORWARD
        if (CURTAIN_2_STATUS == 1) // FORWARD
        {
            if (CURTAIN_2_FORWARD)
            {
                out_relay |= RELAY_10; // C23=1
                out_relay &= ~RELAY_9; // C24=0
                LED_4_1 = 0;           // LED BACKWARD OFF
            }
            if (!CURTAIN_2_FORWARD)
            {
                out_relay |= RELAY_10; // C23=1
                out_relay |= RELAY_9;  // C24=1
                LED_4_0 = 0;           // STOP
                LED_4_1 = 0;
            }
            CURTAIN_2_STATUS = 0;
        }
        // xu ly CURTAIN_2   // BACKWARD
        if (CURTAIN_2_STATUS == 2) // BACKWARD
        {
            if (CURTAIN_2_BACKWARD)
            {
                out_relay &= ~RELAY_10; // C23=0
                out_relay |= RELAY_9;   // C24=1
                LED_4_0 = 0;            // LED FORWARD OFF
            }
            if (!CURTAIN_2_BACKWARD)
            {
                out_relay |= RELAY_10; // C23=1
                out_relay |= RELAY_9;  // C24=1
                LED_4_1 = 0;           // STOP
                LED_4_0 = 0;
            }
            CURTAIN_2_STATUS = 0;
        }
        // xu ly CURTAIN_2 CLOSE THEN OPEN WHEN INSERT KEYCARD
        if (CURTAIN_2_TIMEOUT)
        {
            CURTAIN_2_COUNTER_CLOSE++;
            if (CURTAIN_2_COUNTER_CLOSE >= 0x000fffff)
            {
                out_relay &= ~RELAY_10; // TURN OFF CURTAIN1 C23
                out_relay &= ~RELAY_9;  // TURN OFF CURTAIN1 C24
                CURTAIN_2_COUNTER_CLOSE = 0;
                CURTAIN_2_TIMEOUT = 0;
                LED_4_0 = 0;
                LED_4_1 = 0;
                CURTAIN_2_STATUS = 0;
            }
        }
        // xu ly KEYCARD
        if (KEYCARD_INSERT == 1)
        {
            // KEYCARD_COUNTER++;
            KEYCARD_COUNTER_CLOSE = 0;
            // if(KEYCARD_COUNTER>=0x0FFF){
            // KEYCARD_COUNTER=0;
            // KEYCARD_ENABLE=1;       // enable xuat_32bit(out_relay)
            // KEYCARD_SEND_RS485++;
            // SEND_RS485_KEY=1;
            if (!KEYCARD_STARTUP)
            {
                // duphong8_C14=0; // KICK MOSFET IRF9530 FOR RELAY 12V
                // TURN ON WHEN KEYCARD_INSERT
                // RELAY-14: SOCKET
                // RELAY-15: AIR CONDITIONER (AC)
                out_relay |= SOCKET;  // SOCKET=RELAY_14
                out_relay |= AIRCON;  // AIRCON==RELAY_15
                                      //  CURTAIN1 - C21 CLOSE; C22 OPEN
                                      //  CURTAIN2 - C23 CLOSE; C24 OPEN
                CURTAIN_1_STATUS = 1; // curtain_1=forward
                CURTAIN_1_FORWARD = 1;
                CURTAIN_2_STATUS = 1; // curtain_2=forward
                CURTAIN_2_FORWARD = 1;
                CURTAIN_1_TIMEOUT = 1;
                CURTAIN_2_TIMEOUT = 1;
                // CURTAIN_1_COUNTER_CLOSE=0;
                // CURTAIN_2_COUNTER_CLOSE=0;
                // SEND_RS485_KEY=1;
                KEYCARD_STARTUP = 1;
            }
        }
        //////////////////////////////////
        if (KEYCARD_INSERT == 0)
        {
            KEYCARD_COUNTER_CLOSE++;
            if (KEYCARD_COUNTER_CLOSE >= 0x00100000)
            {
                KEYCARD_COUNTER_CLOSE = 0;
                KEYCARD_ENABLE = 0;
                KEYCARD_STARTUP = 0;
                // TURN OFF ALL RELAY WHEN KEYCARD_REMOVED
                out_relay = 0;
                STAT = 0;
                // KEYCARD_SEND_RS485=200;
                // SEND_RS485_KEY=2;
                // duphong8_C14=0; // KICK OFF MOSFET IRF9530 FOR RELAY 12V
                //  TURN OFF ALL LED WHEN KEYCARD_REMOVED
                // CALL FUNC AMBIENT_BATH S9+S11
                AMBIENT_BATH_STATUS = 0;
                MASTER_LIV_STATUS = 0;
                AMBIENT_LIV_STATUS = 0;
                CURTAIN_1_STATUS = 0;
                CURTAIN_2_STATUS = 0;
                //  PORT11;PORT9;PORT7  KO SU DUNG
                LED_11_0 = 0;
                LED_11_1 = 0;
                LED_9_0 = 0;
                LED_9_1 = 0;
                // PORT10 DND-MUR
                LED_10_0 = 0;
                LED_10_1 = 0;
                // PORT8 (S9+S11)  +(S10)
                LED_8_0 = 0;
                LED_8_1 = 0;
                // PORT6   S6-RL6
                LED_6_0 = 0;
                // PORT5  (S2+S3+S6+S5) (S1+S4)
                LED_5_0 = 0;
                LED_5_1 = 0;
                // PORT4  C23+C24
                LED_4_0 = 0;
                LED_4_1 = 0;
                // PORT3  C21+C22
                LED_3_0 = 0;
                LED_3_2 = 0;
                // PORT2  (S2+S3+S6) (S1+S4)+(S5)
                LED_2_0 = 0;
                LED_2_1 = 0;
                LED_2_2 = 0;
                DO_NOT_DISTURB = 0;
                // PORT1
                LED_1_0 = 0; // MUR LED
                LED_1_1 = 0; // DND LED
            }
        }

        //  rs485 process

        if (PROCESSING_RS485)
        {
            // send : K00000M
            //   RECEIVED :   COUNTER-BUFFER >= 6; not-save "K"
            // buf_rc_u4[0] = 0
            // buf_rc_u4[1] = 0
            // buf_rc_u4[2] = 0
            // buf_rc_u4[3] = 0
            // buf_rc_u4[4] = 0
            // buf_rc_u4[5] = 3 = 0x4D
            PROCESSING_RS485 = 0;

            // CALL FUNC AMBIENT_BATH S9+S11
            //  send : K000x3M
            if (buf_rc_u4[4] == 0x33)
            { // 0x33= "3"
                STAT = ~STAT;
                if (buf_rc_u4[3] == 0x42)
                { // 0x33= "B"
                    AMBIENT_BATH = 1;
                    AMBIENT_BATH_STATUS = 1;
                }
                if (buf_rc_u4[3] == 0x54)
                { // 0x33= "T"
                    AMBIENT_BATH = 1;
                    AMBIENT_BATH_STATUS = 0;
                }
            }
            // CALL CONTROL S9
            //  send : K000x2M
            if (buf_rc_u4[4] == 0x32)
            { // 0x32= "2"
                if (buf_rc_u4[3] == 0x42)
                {                    // 0x33= "B"
                    out_relay |= S9; // S9 = RELAY-2
                }
                if (buf_rc_u4[3] == 0x54)
                {                     // 0x33= "T"
                    out_relay &= ~S9; // S9 = RELAY-2
                }
                STAT = ~STAT;
            }
            // CALL CONTROL S10
            //  send : K000x1M
            if (buf_rc_u4[4] == 0x31)
            { // 0x31="1"
                if (buf_rc_u4[3] == 0x42)
                {                     // 0x33= "B"
                    out_relay |= S10; // S9 = RELAY-2
                }
                if (buf_rc_u4[3] == 0x54)
                {                      // 0x33= "T"
                    out_relay &= ~S10; // S9 = RELAY-2
                }
                STAT = ~STAT;
            }

            /* code switch(){} nay ko chay
            CMD_CHART_RS485=buf_rc_u4[4];
            CMD_STATUS_SCHART_RS485==buf_rc_u4[3];
                switch (CMD_CHART_RS485)
                {
                case 49:   //K000[BT][1]M rcu2 CALL "RS485_CONTROL_S10"
                     if(CMD_STATUS_SCHART_RS485==0x42)   // 0x42 = "B"
                     {out_relay|=S10;   // S10 = RELAY_16
                     }
                     if(CMD_STATUS_SCHART_RS485==0x54)   // 0x54 = "T"
                     {out_relay&=~S10;   // S10 = RELAY_16
                     }
                break;
                case 50:   //="2" rcu2 CALL "RS485_CONTROL_S9"
                      if(CMD_STATUS_SCHART_RS485==0x42)   // 0x42 = "B"
                     {out_relay|=S9;   // S9 = RELAY_2
                     }
                     if(CMD_STATUS_SCHART_RS485==0x54)   // 0x54 = "T"
                     {out_relay&=~S9;   // S9 = RELAY_2
                     }
                break;
                case 51:  // 0x33="3" rcu2 CALL "RS485_CONTROL_S9_S11"
                      AMBIENT_BATH=1;
                      if(CMD_STATUS_SCHART_RS485==0x42)   // 0x42 = "B"
                     {AMBIENT_BATH_STATUS=1;
                     }
                     if(CMD_STATUS_SCHART_RS485==0x54)   // 0x54 = "T"
                     {AMBIENT_BATH_STATUS=0;
                     }
                break;
                default:
                break;
                }
            */
            // RESPOND_PROCESSING_RS485=1;
        }

        if (KEYCARD_SEND_RS485 >= 200)
        {
            KEYCARD_SEND_RS485 = 0;
            if (SEND_RS485_KEY == 1)
            {
                TRAN_4
                // send : K0000EM
                uart4_chr(0x4B); //"K"
                uart4_chr(0x30); // 1
                uart4_chr(0x30); // 2
                uart4_chr(0x30); // 3
                uart4_chr(0x30); // 4
                uart4_chr(0x45); // E
                uart4_chr(0x4D); //"M"
                uart4_chr(0x0D);
                uart4_chr(0x0A);
                REC_4
                SEND_RS485_KEY = 0;
            }
            if (SEND_RS485_KEY == 2)
            {
                TRAN_4
                // send : K0000HM
                uart4_chr(0x4B); //"K"
                uart4_chr(0x30); // 1
                uart4_chr(0x30); // 2
                uart4_chr(0x30); // 3
                uart4_chr(0x30); // 4
                uart4_chr(0x48); //"H"
                uart4_chr(0x4D); //"M"
                uart4_chr(0x0D);
                uart4_chr(0x0A);
                REC_4
                SEND_RS485_KEY = 0;
            }
        }

        // SPI_Ethernet_doPacket();
    }
}