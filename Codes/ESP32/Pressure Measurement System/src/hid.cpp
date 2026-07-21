#include "hid.h"

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