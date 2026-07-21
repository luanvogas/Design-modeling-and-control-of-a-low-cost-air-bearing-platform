#ifndef _FIRMWARE_MOTORS
#define _FIRMWARE_MOTORS

#include "gpios.h"

#include <Wire.h>

extern void pwmMotor1Init();

extern void pwmMotor2Init();

extern void pwmMotor3Init();

extern void pwmMotor4Init();

extern void pwmMotor5Init();

extern void pwmMotor6Init();

extern void pwmInit();

extern void setPwmMotor1(float dutyPwmSideMotor1);

extern void setPwmMotor2(float dutyPwmSideMotor2);

extern void setPwmMotor3(float dutyPwmSideMotor3);

extern void setPwmMotor4(float dutyPwmSideMotor4);

extern void setPwmMotor5(float dutyPwmCentralMotor1);

extern void setPwmMotor6(float dutyPwmCentralMotor2);

extern void setMotorDirection(bool enable, bool d1, bool d2, bool d3, bool d4, bool d5, bool d6);

extern void disableAllMotors();

extern void tractorOperationMode();

extern void pusherOperationMode();

#endif // _FIRMWARE_MOTORS