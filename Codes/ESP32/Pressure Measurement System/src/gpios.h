#ifndef _FIRMWARE_GPIOS
#define _FIRMWARE_GPIOS

#include <Arduino.h>
#include "driver/gpio.h"

#define pinLedBuiltIn        GPIO_NUM_2
#define pinCsSdCard          GPIO_NUM_15 // SD Card CS
#define pinPressureSensor    ADC1_CHANNEL_0   //GPIO_NUM_36

#endif // _FIRMWARE_GPIOS
