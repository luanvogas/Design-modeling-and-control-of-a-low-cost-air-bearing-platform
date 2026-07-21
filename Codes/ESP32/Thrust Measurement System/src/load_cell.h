#ifndef _FIRMWARE_LOAD_CELL
#define _FIRMWARE_LOAD_CELL

#include "gpios.h"
#include "HX711.h"
#include "sd_card.h"

// Queue to hold load cell data between tasks
extern QueueHandle_t loadCellDataQueue;

extern void initLoadCellCalibration();

extern void loadCellCalibration();

extern void initLoadCellWeighing();

extern double loadCellWeighing();

#endif // _FIRMWARE_LOAD_CELL