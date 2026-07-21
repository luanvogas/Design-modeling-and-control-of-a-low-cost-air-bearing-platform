#include "interrupts.h"
#include "tasks.h"
#include "gpios.h"

// Based on: https://esp32tutorials.com/esp32-gpio-interrupts-esp-idf/#google_vignette

xQueueHandle powerButtonInterruptQueue;
xQueueHandle loadCellInterruptQueue;

void initISRService()
{
    gpio_install_isr_service(0);
}

void initPowerButtonInterrupt()
{
    gpio_reset_pin(pinPowerButton);
    gpio_pad_select_gpio(pinPowerButton);
    gpio_set_direction(pinPowerButton, GPIO_MODE_INPUT);
    gpio_set_intr_type(pinPowerButton, GPIO_INTR_POSEDGE);   
    powerButtonInterruptQueue = xQueueCreate(16, sizeof(int));    
    gpio_isr_handler_add(pinPowerButton, powerButtonHandler, (void *)pinPowerButton);
}

// ISR triggered when HX711 data is ready (DOUT goes LOW)
void IRAM_ATTR powerButtonHandler(void *args)
{
    uint8_t itemToQueue = (int)args;
    xQueueSendFromISR(powerButtonInterruptQueue, &itemToQueue, NULL);
}

// GPIO and interrupt initialization for HX711 DOUT pin
void initLoadCellInterrupt()
{
    gpio_reset_pin(pinDtLoadCell);
    gpio_pad_select_gpio(pinDtLoadCell);
    gpio_set_direction(pinDtLoadCell, GPIO_MODE_INPUT);
    gpio_set_intr_type(pinDtLoadCell, GPIO_INTR_NEGEDGE); // Trigger when DOUT goes LOW (data ready) 
    loadCellInterruptQueue = xQueueCreate(512, sizeof(uint8_t));
    gpio_isr_handler_add(pinDtLoadCell, loadCellHandler, (void *)pinDtLoadCell);
}

void IRAM_ATTR loadCellHandler(void *args)
{
    uint8_t pin = (uint8_t)(int)args;
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;
    xQueueSendFromISR(loadCellInterruptQueue, &pin, &xHigherPriorityTaskWoken);
    portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
}