#include "init.c"
#include "__EthEnc28j60.h"
// PORT 1
#define BUT1_0 GPIOE_IDR.B2
#define BUT1_1 GPIOE_IDR.B4
#define BUT1_2 GPIOE_IDR.B6
#define LED_1_0 GPIOE_ODR.B3
#define LED_1_1 GPIOE_ODR.B5
#define LED_1_2 GPIOC_ODR.B13
// PORT 2
#define BUT2_0 GPIOC_IDR.B0
#define BUT2_1 GPIOC_IDR.B2
#define BUT2_2 GPIOA_IDR.B0
#define LED_2_0 GPIOC_ODR.B1
#define LED_2_1 GPIOC_ODR.B3
#define LED_2_2 GPIOA_ODR.B1
// PORT 3 3INPUT-2OUTLED
#define BUT3_0 GPIOC_IDR.B5
#define BUT3_1 GPIOB_IDR.B1
#define BUT3_2 GPIOE_IDR.B7
#define LED_3_0 GPIOB_ODR.B0
//      LED_3_1   NULL
#define LED_3_2 GPIOB_ODR.B2

// PORT 4  2INPUT-3OUTLED
#define BUT4_0 GPIOE_IDR.B9
#define BUT4_1 GPIOE_IDR.B11
// KHONG CO BUTTON3
#define LED_4_0 GPIOE_ODR.B8
#define LED_4_1 GPIOE_ODR.B10
#define LED_4_2 GPIOE_ODR.B12

// PORT 5   (2IN-2LED)
#define BUT5_0 GPIOE_IDR.B13
#define BUT5_1 GPIOE_IDR.B15
#define LED_5_0 GPIOE_ODR.B14
#define LED_5_1 GPIOB_ODR.B10

// PORT6
#define BUT6_0 GPIOB_IDR.B11
#define LED_6_0 GPIOB_ODR.B12
// PORT7
#define BUT7_0 GPIOB_IDR.B13
#define LED_7_0 GPIOB_ODR.B14

// PORT 8
#define BUT8_0 GPIOB_IDR.B15
#define BUT8_1 GPIOD_IDR.B9
#define LED_8_0 GPIOD_ODR.B8
#define LED_8_1 GPIOD_ODR.B10
// PORT 9
#define BUT9_0 GPIOD_IDR.B11
#define BUT9_1 GPIOD_IDR.B13
#define LED_9_0 GPIOD_ODR.B12
#define LED_9_1 GPIOD_ODR.B14
// PORT 10
#define BUT10_0 GPIOD_IDR.B15
#define BUT10_1 GPIOC_IDR.B7
#define LED_10_0 GPIOC_ODR.B6
#define LED_10_1 GPIOC_ODR.B8
// PORT 11
#define BUT11_0 GPIOB_IDR.B6
#define BUT11_1 GPIOB_IDR.B8
#define LED_11_0 GPIOB_ODR.B7
#define LED_11_1 GPIOB_ODR.B9

// PORT 12
#define LED_12_0 GPIOE_ODR.B1
#define BUT12_0 GPIOE_IDR.B0
// PORT 13   ( AC INPUT FORM KEYCARD)
#define BUT13_0 GPIOD_IDR.B6

// scan button
#define SAMPLE 2
#define PRESS 2
#define UNPRESS 0
#define PRE_PRESS 3
#define PRES_UP 4
#define PRES_DOW 5
#define PRESSING 6
//(hop add new 1)
// #define SUM_BUT     24
// unsigned char but_sample[24][SAMPLE];
// unsigned char but_state[24];
// unsigned char but_status[24];
// unsigned char but_sum_sample[24];
#define SUM_BUT 25
unsigned char but_sample[25][SAMPLE];
unsigned char but_state[25];
unsigned char but_status[25];
unsigned char but_sum_sample[25];
//
#define DIM_UP 0
#define DIM_DOWN 1
// process button
#define BUT_ACTIVE 1
#define BUT_UNACTIVE 0
#define BUT_MASTER_ON 1
#define BUT_MASTER_OFF 2
unsigned int count_time_but2 = 0;
unsigned char flag_enable_but2 = 0;
unsigned int flag_but_master = BUT_MASTER_OFF;

// touch_panel
#define SERVICE_1 0X0A
#define SERVICE_2 0x0B
#define ENTRANCE 0X06
#define MASTER 0X05
#define LIGHT_BATH 0X03
#define LIGHT_READING 0X00
#define LIGHT_BEDSIDE 0X0F
#define CURTAIN_O 0X09
#define CURTAIN_C 0X08
#define S_RELAX 0X0C
#define S_NIGHT 0X0D
#define S_PARTY 0X0E
#define FAN_ON_OFF 0X07
#define FAN_LOW 0X04
#define FAN_MEDIUM 0X02
#define FAN_HIGHT 0X01

#define T_PRESS 0
#define T_UNPRESS 1
// EUROWINDOW CAMRANH - RCU1 - master-ethernet
#define S1A RELAY_8     //(S1A=S1+S4)VESTIBULE
#define S2A RELAY_7     //(S2A=S2+S3)AMBIENT LIVING
#define S5 RELAY_3      // ACCENT LIVING
#define S6 RELAY_6      // ENTRANCE
#define S9 RELAY_2      // AMBIENT BATH
#define S10 RELAY_16    // ACCENT BATH
#define S11 RELAY_1     // AMBIENT BATH
#define AIRCON RELAY_15 // S19=AIRCON
#define SOCKET RELAY_14 // S20=SOCKET
#define S21 RELAY_12    // CURTAIN 1_FORW
#define S22 RELAY_11    // CURTAIN 1_BACKW
#define S23 RELAY_10    // CURTAIN 2_FORW
#define S24 RELAY_9     // CURTAIN 2_BACKW
#define BELL RELAY_13   // S25=BELL
// RCU2 S8/S12/S13A/S14/S15/S17/S18

// RELAY_1
#define RELAY_1 0b00000000000000000000000000000001
// RELAY_2
#define RELAY_2 0b00000000000000000000000000000010
// RELAY_3
#define RELAY_3 0b00000000000000000000000000000100
// RELAY_4
#define RELAY_4 0b00000000000000000000000000001000
// RELAY_5
#define RELAY_5 0b00000000000000000000000000010000
// RELAY_6
#define RELAY_6 0b00000000000000000000000000100000
// RELAY_7
#define RELAY_7 0b00000000000000000000000001000000
// RELAY_8
#define RELAY_8 0b00000000000000000000000010000000
// RELAY_9
#define RELAY_9 0b00000000000000000000000100000000
// RELAY_10
#define RELAY_10 0b00000000000000000000001000000000
// RELAY_11
#define RELAY_11 0b00000000000000000000010000000000
// RELAY_12
#define RELAY_12 0b00000000000000000000100000000000
// RELAY_13
#define RELAY_13 0b00000000000000000001000000000000
// RELAY_14
#define RELAY_14 0b00000000000000000010000000000000
// RELAY_15
#define RELAY_15 0b00000000000000000100000000000000
// RELAY_16
#define RELAY_16 0b00000000000000001000000000000000

#define BELL_DOOR 0b00000000000000000000000010000000
#define CUR_CLOSE 0b00000000000000000000000100000000
#define FAN_L 0b00000000000000000000001000000000
#define FAN_M 0b00000000000000000000010000000000
#define FAN_H 0b00000000000000000000100000000000

#define RELAY_17 0b00000000000000010000000000000000
#define RELAY_18 0b00000000000000100000000000000000
#define RELAY_19 0b00000000000001000000000000000000
#define RELAY_20 0b00000000000010000000000000000000
#define RELAY_21 0b00000000000100000000000000000000
#define RELAY_22 0b00000000001000000000000000000000
#define RELAY_23 0b00000000010000000000000000000000
#define RELAY_24 0b00000000100000000000000000000000
#define RELAY_25 0b00000001000000000000000000000000
#define RELAY_26 0b00000010000000000000000000000000
#define RELAY_27 0b00000100000000000000000000000000
#define RELAY_28 0b00001000000000000000000000000000
#define RELAY_29 0b00010000000000000000000000000000
#define RELAY_30 0b00100000000000000000000000000000
#define RELAY_31 0b01000000000000000000000000000000
#define RELAY_32 0b10000000000000000000000000000000
unsigned long out_relay = 0;
// touch
unsigned char buf_rc_u4[6], count_buf_rc_4 = 0, status_but_touch = 0xff, channel_touch = 0xff, touch_but = 0xff;
unsigned int status_led_touch = 0, status_led_touch_save = 0;
// dimer
#define STEP_INC_20 51 // ms
#define STEP_INC_40 52
#define STEP_INC_60 53
#define STEP_INC_80 54
#define STEP_INC_100 55
#define STEP_INC_120 56
#define STEP_INC_140 57
#define STEP_INC_160 58
#define STEP_INC_180 59
#define STEP_INC_200 60

unsigned char value_dimer = 0, count_but_dimer = 0, flag_but_dimer = 0, value_dimer_save = 100, flag_dimer_up_down = DIM_UP;
// curtain
#define CUR_DIR_OPEN 1
#define CUR_DIR_CLOSE 2
unsigned long value_count_time_curtain = 0;
unsigned char flag_count_curtain = 0, flag_curtain_direction = 0;
// fan
#define FAN_SP_L 1
#define FAN_SP_M 2
#define FAN_SP_H 3

unsigned long count_time_fan = 0, flag_count_time_fan = 0;
unsigned char flag_fan_speed = 0;
// wed
#define putConstString SPI_Ethernet_putConstString
#define putString SPI_Ethernet_putString
#define PORT 60
unsigned long wed_status_button = 0;
unsigned char flag_reset_ip = 0, flag_new_rec = 0, flag_response_wed = 0;
unsigned long status_wed_service = 0, status_wed_light = 0, status_wed_curtain = 0, status_wed_scenes = 0;
unsigned long status_wed_fan = 0, status_wed_dimer = 0;
enum page
{
    Page_Login = 0,
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
// dimer ex
#define DIM_UP_EX 1
#define DIM_DOWN_EX 2
#define DIM_EN_EX 1
#define DIM_DE_EX 2

unsigned char flag_dimer_ex[4] = {0, 0, 0, 0};
unsigned char flag_dimer_ex_up_down[4] = {DIM_UP_EX, DIM_UP_EX, DIM_UP_EX, DIM_UP_EX};
unsigned long count_time_dimer_ex[4] = {0, 0, 0, 0};
unsigned char value_dimer_ex[4] = {0, 0, 0, 0};