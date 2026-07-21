#ifndef _FIRMWARE_GPIOS
#define _FIRMWARE_GPIOS

#include <Arduino.h>
#include "driver/gpio.h"

// Platform

#define pinLedBuiltIn     GPIO_NUM_2
#define pinPowerButton    GPIO_NUM_13
#define pinEnable3V3      GPIO_NUM_12
#define pinPwmMotor1      GPIO_NUM_14
#define pinPwmMotor2      GPIO_NUM_27
#define pinPwmMotor3      GPIO_NUM_26
#define pinPwmMotor4      GPIO_NUM_25
#define pinPwmMotor5      GPIO_NUM_33
#define pinPwmMotor6      GPIO_NUM_32

// Additional Hardware

#define pinCsSdCard          GPIO_NUM_4  // SD Card CS
#define pinDtLoadCell        GPIO_NUM_5  // HX711 DT
#define pinSckLoadCell       GPIO_NUM_17 // HX 711 SCK

#endif // _FIRMWARE_GPIOS
