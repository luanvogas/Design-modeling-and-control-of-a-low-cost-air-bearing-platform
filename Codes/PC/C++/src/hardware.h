#ifndef HARDWARE
#define HARDWARE

#include "vision.h"
#include "data_storage.h"
#include "timer.h"
#include "radio.h"
#include "data_structures.h"

extern void updateGyroData(gyroscopeData_t& gyroData);
extern void getAngularVelocity(motorData_t motors, gyroscopeData_t& gyroData);
extern void gyroOffsetDetermination(gyroscopeData_t& gyroData);
extern void hardwareInit(gyroscopeData_t& gyroData);
extern void forceDecomposition(motorData_t &motor, platformControl_t control, double rotation);
extern void motorsDutyCycleUpdate(motorData_t& motor, platformControl_t control);
extern void sendMotorsParameters(motorData_t motors, gyroscopeData_t& gyroData);
extern void disableMotors(motorData_t &motor, gyroscopeData_t& gyroData);

#endif //HARDWARE