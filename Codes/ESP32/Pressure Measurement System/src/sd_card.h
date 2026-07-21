#ifndef _FIRMWARE_SD_CARD
#define _FIRMWARE_SD_CARD

#include "gpios.h"
#include <SD.h>

// Checking if the SD card is inserted
extern bool isSdCardConnected;

extern void openSdCard();

extern void initSdCard();

extern void closeSdCard();

extern void savePressureSdCard();

#endif // _FIRMWARE_SD_CARD