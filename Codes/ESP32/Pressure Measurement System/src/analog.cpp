#include "analog.h"
#include "hid.h"

// See: https://embeddedexplorer.com/esp32-adc-esp-idf-tutorial/

// Global variables
float pressureSensorVoltage = 0;   
float pressurePsi;

void adcInit()
{
    adc1_config_width(ADC_WIDTH_BIT_12);
    adc1_config_channel_atten(pinPressureSensor, ADC_ATTEN_DB_11); // ADC_ATTEN_DB_11 => 150 ~ 2450 mV 
}

void readRawPressure()
{
    uint8_t counter = 0;
    uint8_t samples = 250;      
    pressureSensorVoltage = 0;
    while (counter <= samples)
    {
        counter += 1;
        pressureSensorVoltage += (float)adc1_get_raw(pinPressureSensor);
    }    
    float rawPressure = pressureSensorVoltage / samples;
    Serial.println(rawPressure);
}

void readPressureSensor()
{
    adcInit();
    uint8_t counter = 0;
    uint8_t samples = 250;      
    pressureSensorVoltage = 0;
    while (counter <= samples)
    {
        counter += 1;
        pressureSensorVoltage += (float)adc1_get_raw(pinPressureSensor);
    }    
    float rawPressure  = pressureSensorVoltage / samples;    
    pressurePsi = (rawPressure  - 323.2204)/19.5850;
}

