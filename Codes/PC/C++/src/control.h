#ifndef PC_DRIVER_CONTROL
#define PC_DRIVER_CONTROL

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "vision.h"
#include "data_storage.h"
#include "timer.h"
#include "radio.h"
#include "hardware.h"
#include "data_structures.h"
#include <eigen3/Eigen/Dense>

using namespace std;
using namespace Eigen;

#define sind(x) (sin((x) * M_PI / 180))

extern void DLQRController();
extern void DLMIController();

#endif //PC_DRIVER_CONTROL
