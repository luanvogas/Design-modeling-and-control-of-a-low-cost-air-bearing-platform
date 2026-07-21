#ifndef _FIRMWARE_TASKS
#define _FIRMWARE_TASKS

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"

// Motor characterization
extern int actualDuty;

// Task Handlers
extern TaskHandle_t handleTaskPowerButton;
extern TaskHandle_t handleTaskLoadCellCalibration;
extern TaskHandle_t handleTaskLoadCellWeighing;
extern TaskHandle_t handleTaskMotorCharacterizationSignalGeneration;
extern TaskHandle_t handleTaskWeighing;
extern TaskHandle_t handleTaskSaveDataSdCard;
extern TaskHandle_t handleTaskHID;

extern void taskPowerButton(void *arg);

extern void taskLoadCellCalibration(void *arg);

extern void taskLoadCellWeighing(void *arg);

extern void taskWeighing(void *arg);

extern void taskMotorCharacterizationSignalGeneration(void *arg);

extern void taskSaveDataSdCard(void *arg);

extern void taskHID(void *arg);

#endif // _FIRMWARE_TASKS