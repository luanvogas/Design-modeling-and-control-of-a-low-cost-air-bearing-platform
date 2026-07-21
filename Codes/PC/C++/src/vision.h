#ifndef PC_DRIVER_VISION
#define PC_DRIVER_VISION

#include <stdio.h>
#include <stdlib.h>

#include <opencv2/aruco/charuco.hpp>
#include <opencv2/aruco.hpp>
#include <opencv2/highgui.hpp>
#include "opencv2/imgcodecs.hpp"
#include "opencv2/imgproc.hpp"
#include <aruco_samples_utility.hpp>
#include <iostream>

#define _USE_MATH_DEFINES
#include <math.h>
#include "timer.h"
#include "radio.h"
#include "data_structures.h"

using namespace std;
using namespace cv;

extern void visionInit();
extern void visionPoseEstimation(markerVector_t &marker, bool showImage);
extern void visionInclinationCheck();
extern void visionCameraCalibrationCheck();

#endif //PC_DRIVER_VISION