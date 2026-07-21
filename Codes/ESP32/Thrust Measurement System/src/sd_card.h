#ifndef _FIRMWARE_SD_CARD
#define _FIRMWARE_SD_CARD

#include "gpios.h"
#include <SD.h>

// Structure to store the load cell data
typedef struct loadCellData{
    uint32_t timestamp;
    uint8_t dutyCycle;
    float weight;
} loadCellData_t;

// SD Card Queue Buffer
#define BUFFER_SIZE 128
#define QUEUE_LENGTH 256


// Checking if the SD card is inserted
extern bool isSdCardConnected;

extern void openSdCard();

extern void initSdCard();

extern void closeSdCard();

extern void saveDataSdCard(TickType_t time, uint8_t duty, double weight);

#endif // _FIRMWARE_SD_CARD