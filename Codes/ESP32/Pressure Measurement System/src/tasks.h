#ifndef _FIRMWARE_TASKS
#define _FIRMWARE_TASKS

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

extern void taskPrintRawData(void *arg);
extern void taskPrintPressure(void *arg);
extern void taskSavePressureDataSdCard(void *arg);

#endif // _FIRMWARE_TASKS