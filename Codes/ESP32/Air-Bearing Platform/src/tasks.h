#ifndef _FIRMWARE_TASKS
#define _FIRMWARE_TASKS

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

// Task Handlers
extern TaskHandle_t handleTaskPowerButton;
extern TaskHandle_t handleTaskRadio;

extern void taskPowerButton(void *arg);
extern void taskRadio(void *arg);

#endif // _FIRMWARE_TASKS