#ifndef _FIRMWARE_HID
#define _FIRMWARE_HID

#include "gpios.h"

extern void serialInit();

extern void ledBuiltInInit();

extern void ledBuiltInOn();

extern void ledBuiltInOff();

extern void blinkLedBuiltIn();

extern void toggleLedBuiltIn();

#endif // _FIRMWARE_HID
