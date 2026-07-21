#ifndef PC_DRIVER_RADIO
#define PC_DRIVER_RADIO

#include "message.h"
#include "nrfusb.hpp"
#include "timer.h"
#include "data_structures.h"
#include "hardware.h"

using namespace std;

extern void radioInit();
extern void radioCommunicate(motorData_t motorsPlatform1, gyroscopeData_t& gyroData);

#endif //PC_DRIVER_RADIO