#ifndef _FIRMWARE_ANALOG
#define _FIRMWARE_ANALOG

#include "gpios.h"
#include "driver/adc.h"
#include "esp_adc_cal.h"

// Global variables 
extern float pressurePsi;

extern void adcInit();
extern void readRawPressure();
extern void readPressureSensor();

#endif // _FIRMWARE_ANALOG