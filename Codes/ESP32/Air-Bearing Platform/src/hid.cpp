#include "hid.h"
#include "interrupts.h"

void powerInit()
{
    gpio_reset_pin(pinEnable3V3);
    gpio_set_direction(pinEnable3V3, GPIO_MODE_OUTPUT);
    gpio_set_level(pinEnable3V3,1);
    vTaskDelay(pdMS_TO_TICKS(2000));
    initPowerButtonInterrupt();
}

void powerOff()
{
    gpio_set_level(pinEnable3V3,0);
}

void serialInit()
{
    Serial.begin(115200);
}

void ledBuiltInInit()
{
    gpio_set_direction(pinLedBuiltIn, GPIO_MODE_INPUT_OUTPUT);
}

void ledBuiltInOn()
{
    gpio_set_level(pinLedBuiltIn,1);
}

void ledBuiltInOff()
{
    gpio_set_level(pinLedBuiltIn,0);
}

void blinkLedBuiltIn()
{
    ledBuiltInOn();
    vTaskDelay(pdMS_TO_TICKS(500));
    ledBuiltInOff();
    vTaskDelay(pdMS_TO_TICKS(500));
}

void toggleLedBuiltIn()
{
    if (gpio_get_level(pinLedBuiltIn) == 0) ledBuiltInOn();
    else ledBuiltInOff();
}