#include "interrupts.h"
#include "tasks.h"
#include "gpios.h"

// Based on: https://esp32tutorials.com/esp32-gpio-interrupts-esp-idf/#google_vignette

xQueueHandle radioInterruptQueue;
xQueueHandle powerButtonQueue;

void initInterruptService()
{
    gpio_install_isr_service(0);
}

void initPowerButtonInterrupt()
{
    gpio_reset_pin(pinPowerButton);
    gpio_pad_select_gpio(pinPowerButton);
    gpio_set_direction(pinPowerButton, GPIO_MODE_INPUT);
    gpio_set_intr_type(pinPowerButton, GPIO_INTR_POSEDGE);   
    powerButtonQueue = xQueueCreate(10, sizeof(int));    
    gpio_isr_handler_add(pinPowerButton, powerButtonHandler, (void *)pinPowerButton);
}

void initRadioInterrupt()
{
    gpio_pad_select_gpio(pinRadioInterrupt);
    gpio_set_direction(pinRadioInterrupt, GPIO_MODE_INPUT);
    gpio_set_intr_type(pinRadioInterrupt, GPIO_INTR_NEGEDGE);   
    radioInterruptQueue = xQueueCreate(10, sizeof(int));
    gpio_isr_handler_add(pinRadioInterrupt, radioInterrupHandler, (void *)pinRadioInterrupt);
}

void IRAM_ATTR powerButtonHandler(void *args)
{
    uint8_t itemToQueue = (int)args;
    xQueueSendFromISR(powerButtonQueue, &itemToQueue, NULL);
}

void IRAM_ATTR radioInterrupHandler(void *args)
{
    uint8_t itemToQueue = (int)args;
    xQueueSendFromISR(radioInterruptQueue, &itemToQueue, NULL);
}