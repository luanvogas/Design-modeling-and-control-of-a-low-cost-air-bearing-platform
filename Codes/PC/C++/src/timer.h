#ifndef PC_DRIVER_TIME_HELPER
#define PC_DRIVER_TIME_HELPER

#include <chrono>
#include <thread>

using namespace std::chrono;
using namespace std::literals::chrono_literals;

extern void myDelaySec(int delay);
extern void myDelayMs(int delay);
extern void myDelayUs(int delay);

extern void startTimer1();
extern void startTimer2();
extern void startTimer3();
extern void startTimer4();
extern void startTimerGyro();

extern double getTimeTimer1();
extern double getTimeTimer2();
extern double getTimeTimer3();
extern double getTimeTimer4();
extern double getTimeTimerGyro();

#endif //PC_DRIVER_TIME_HELPER
