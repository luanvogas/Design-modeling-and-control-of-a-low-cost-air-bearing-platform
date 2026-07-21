#ifndef _FIRMWARE_INTERRUPTIONS
#define _FIRMWARE_INTERRUPTIONS

#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"

extern xQueueHandle powerButtonInterruptQueue;
extern xQueueHandle loadCellInterruptQueue;

extern void initISRService();
extern void initPowerButtonInterrupt();
extern void initLoadCellInterrupt();

extern void IRAM_ATTR powerButtonHandler(void *args);
extern void IRAM_ATTR loadCellHandler(void *args);

#endif // _FIRMWARE_INTERRUPTIONS
