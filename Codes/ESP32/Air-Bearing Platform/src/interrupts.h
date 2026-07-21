#ifndef _FIRMWARE_INTERRUPTIONS
#define _FIRMWARE_INTERRUPTIONS

#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"

extern xQueueHandle radioInterruptQueue;
extern xQueueHandle powerButtonQueue;

extern void initInterruptService();

extern void initPowerButtonInterrupt();

extern void initRadioInterrupt();

extern void IRAM_ATTR powerButtonHandler(void *args);

extern void IRAM_ATTR radioInterrupHandler(void *args);

#endif // _FIRMWARE_INTERRUPTIONS
