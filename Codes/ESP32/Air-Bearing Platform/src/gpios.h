#ifndef _FIRMWARE_GPIOS
#define _FIRMWARE_GPIOS

#include <Arduino.h>
#include "driver/gpio.h"

#define pinLedBuiltIn     GPIO_NUM_2
#define pinPowerButton    GPIO_NUM_13
#define pinEnable3V3      GPIO_NUM_12
#define pinPwmMotor1      GPIO_NUM_14
#define pinPwmMotor2      GPIO_NUM_27
#define pinPwmMotor3      GPIO_NUM_26
#define pinPwmMotor4      GPIO_NUM_25
#define pinPwmMotor5      GPIO_NUM_33
#define pinPwmMotor6      GPIO_NUM_32
#define pinRadioInterrupt GPIO_NUM_17
#define pinI2cSda         GPIO_NUM_21
#define pinI2cScl         GPIO_NUM_22

#endif // _FIRMWARE_GPIOS
