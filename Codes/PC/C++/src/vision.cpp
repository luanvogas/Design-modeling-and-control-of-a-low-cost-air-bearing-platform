#include "vision.h"

// Vision variables
cv::VideoCapture inputVideo;
cv::Mat cameraMatrix, distCoeffs;
cv::Mat image, imageCopy;
std::string cameraParamsFilename = "calibration_data_4x4_50_1280x720.txt";
cv::Mat objPoints(4, 1, CV_32FC3);
cv::aruco::DetectorParameters detectorParams = cv::aruco::DetectorParameters();
cv::aruco::Dictionary dictionary = cv::aruco::getPredefinedDictionary(cv::aruco::DICT_4X4_50);
cv::aruco::ArucoDetector detector(dictionary, detectorParams);
std::vector<int> ids;
std::vector<std::vector<cv::Point2f>> corners;

// Image parameters
double frameWidth = 1280;
double frameHeight = 720;

// Makers parameters
double markerLength = 0.106;
int waitTime = 1;

// Extracted from: https://learnopencv.com/rotation-matrix-to-euler-angles/
// Checks if a matrix is a valid rotation matrix.
bool isRotationMatrix(Mat& R)
{
    Mat Rt;
    transpose(R, Rt);
    Mat shouldBeIdentity = Rt * R;
    Mat I = Mat::eye(3, 3, shouldBeIdentity.type());

    return  norm(I, shouldBeIdentity) < 1e-6;

}

// Calculates rotation matrix to euler angles
// The result is the same as MATLAB except the order
// of the euler angles ( x and z are swapped ).
Vec3f rotationMatrixToEulerAngles(Mat& R)
{
    assert(isRotationMatrix(R));

    double sy = sqrt(R.at<double>(0, 0) * R.at<double>(0, 0) + R.at<double>(1, 0) * R.at<double>(1, 0));

    bool singular = sy < 1e-6; // If

    double x, y, z;
    if (!singular)
    {
        x = atan2(R.at<double>(2, 1), R.at<double>(2, 2));
        y = atan2(-R.at<double>(2, 0), sy);
        z = atan2(R.at<double>(1, 0), R.at<double>(0, 0));
    }
    else
    {
        x = atan2(-R.at<double>(1, 2), R.at<double>(1, 1));
        y = atan2(-R.at<double>(2, 0), sy);
        z = 0;
    }
    return Vec3f(x, y, z) * (180/M_PI);
}

void visionInit()
{
    // Based in: https://docs.opencv.org/4.x/d5/dae/tutorial_aruco_detection.html  

    inputVideo.open(0);
    inputVideo.set(CAP_PROP_FOURCC, VideoWriter::fourcc('M', 'J', 'P', 'G'));
    inputVideo.set(CAP_PROP_FRAME_WIDTH, frameWidth);
    inputVideo.set(CAP_PROP_FRAME_HEIGHT, frameHeight);

    // You can read camera parameters from tutorial_camera_params.yml
    readCameraParameters(cameraParamsFilename, cameraMatrix, distCoeffs); // This function is implemented in aruco_samples_utility.hpp

    // Set coordinate system
    objPoints.ptr<cv::Vec3f>(0)[0] = cv::Vec3f(-markerLength / 2.f, markerLength / 2.f, 0);
    objPoints.ptr<cv::Vec3f>(0)[1] = cv::Vec3f(markerLength / 2.f, markerLength / 2.f, 0);
    objPoints.ptr<cv::Vec3f>(0)[2] = cv::Vec3f(markerLength / 2.f, -markerLength / 2.f, 0);
    objPoints.ptr<cv::Vec3f>(0)[3] = cv::Vec3f(-markerLength / 2.f, -markerLength / 2.f, 0);
    
}

void visionPoseEstimation(markerVector_t &marker, bool showImage)
{
    // Based in: https://docs.opencv.org/4.x/d5/dae/tutorial_aruco_detection.html  

    markerVector_t markerRaw;

    if (inputVideo.grab()) {
        inputVideo.retrieve(image);
        image.copyTo(imageCopy);
        std::vector<int> ids;
        std::vector<std::vector<cv::Point2f>> corners;
        detector.detectMarkers(image, corners, ids);
        // If at least one marker detected
        if (ids.size() > 0) {
            cv::aruco::drawDetectedMarkers(imageCopy, corners, ids);
            int nMarkers = corners.size();
            std::vector<cv::Vec3d> rvecs(nMarkers), tvecs(nMarkers);
            // Calculate pose for each marker
            for (int i = 0; i < nMarkers; i++) {
                solvePnP(objPoints, corners.at(i), cameraMatrix, distCoeffs, rvecs.at(i), tvecs.at(i));
            }

            if (showImage)
            {
                // Draw axis for each marker
                for (unsigned int i = 0; i < ids.size(); i++) {
                    cv::drawFrameAxes(imageCopy, cameraMatrix, distCoeffs, rvecs[i], tvecs[i], 0.1);
                }
            }

            for (unsigned int i = 0; i < ids.size(); i++)
            {
                Mat R;
                cv::Rodrigues(rvecs.at(i), R);
                markerRaw.id[ids[i]].x = tvecs.at(i)(0); // Positive X on the right of the image
                markerRaw.id[ids[i]].y = -tvecs.at(i)(1); // Positive Y on the top of the image
                if (-rotationMatrixToEulerAngles(R)(2) >= 0)
                    marker.id[ids[i]].rotation = -rotationMatrixToEulerAngles(R)(2); // Positive angle counterclockwise
                else
                    marker.id[ids[i]].rotation = -rotationMatrixToEulerAngles(R)(2) + 360; // Positive angle counterclockwise

            }

            for (unsigned int i = 0; i < ids.size(); i++)
            {
                marker.id[ids[i]].x = 0.9311 * markerRaw.id[ids[i]].x - 0.0018 * markerRaw.id[ids[i]].y + 0.0008 * 1;
                marker.id[ids[i]].y = 0.0014 * markerRaw.id[ids[i]].x + 0.9310 * markerRaw.id[ids[i]].y + 0.0026 * 1;
            }
        }
        if (showImage)
        {
            // Draw a line to represent the axes
            line(imageCopy, cv::Point2f(0, frameHeight / 2), cv::Point2f(frameWidth, frameHeight / 2), cv::Scalar(0, 0, 255), 1, LINE_AA);  // X
            line(imageCopy, cv::Point2f(frameWidth / 2, 0), cv::Point2f(frameWidth / 2, frameHeight), cv::Scalar(0, 255, 0), 1, LINE_AA); // Y

            // Show how the axes are defined  
            cv::putText(imageCopy, "X", cv::Point(0.97 * frameWidth, 0.49 * frameHeight), cv::FONT_HERSHEY_SIMPLEX, 1, cv::Scalar(0, 0, 255), 2, cv::LINE_AA);
            cv::putText(imageCopy, "Y", cv::Point(0.51 * frameWidth, 0.04 * frameHeight), cv::FONT_HERSHEY_SIMPLEX, 1, cv::Scalar(0, 255, 0), 2, cv::LINE_AA);
            cv::putText(imageCopy, "(-,+)", cv::Point(0.25 * frameWidth, 0.25 * frameHeight), cv::FONT_HERSHEY_SIMPLEX, 1, cv::Scalar(0, 200, 180), 2, cv::LINE_AA);
            cv::putText(imageCopy, "(+,+)", cv::Point(0.75 * frameWidth, 0.25 * frameHeight), cv::FONT_HERSHEY_SIMPLEX, 1, cv::Scalar(0, 200, 180), 2, cv::LINE_AA);
            cv::putText(imageCopy, "(-,-)", cv::Point(0.25 * frameWidth, 0.75 * frameHeight), cv::FONT_HERSHEY_SIMPLEX, 1, cv::Scalar(0, 200, 180), 2, cv::LINE_AA);
            cv::putText(imageCopy, "(+,-)", cv::Point(0.75 * frameWidth, 0.75 * frameHeight), cv::FONT_HERSHEY_SIMPLEX, 1, cv::Scalar(0, 200, 180), 2, cv::LINE_AA);

            // Draw a red circle in the center of the image
            cv::circle(imageCopy, cv::Point2f(frameWidth / 2, frameHeight / 2), 4, cv::Scalar(0, 0, 255), -1);

            // Show resulting image
            cv::imshow("out", imageCopy);
            char key = (char)cv::waitKey(waitTime);
        }
    }
}


void visionInclinationCheck()
{
    visionInit();
    FILE* file_pointer;
    file_pointer = fopen("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/inclination_check.csv", "w+");
    unsigned int i;
    markerVector_t marker;
    int angle;
    double x = 0, y = 0;
    bool finished = false;

    while (finished == false)
    {
        x = 0;
        y = 0;

        for (i = 0; i < 5; i++)
        {
            visionPoseEstimation(marker, false);
            x = x + marker.id[0].x / 5;
            y = y + marker.id[0].y / 5;
        }

        cout << "x = " << x << ", y = " << y << ", angle = ";
        cin >> angle;
        fprintf(file_pointer, "%f, %f, %f\n", x, y, static_cast<double>(angle) / 100.0f);
        cout << endl;

        if (angle > 1000)
        {
            finished = true;
        }
    }

    fclose(file_pointer);
}

void visionCameraCalibrationCheck()
{
   visionInit();
   FILE* file_pointer;
   file_pointer = fopen("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/calibration_check.csv", "w");
   markerVector_t marker;
   unsigned int i, position;
   double x = 0, y = 0, angle = 0;
   bool finished = false;

   while (finished == false)
   {
       x = 0;
       y = 0;
       angle = 0;

       for (i = 0; i < 5; i++)
       {
           visionPoseEstimation(marker, false);
           x = x + marker.id[0].x / 5;
           y = y + marker.id[0].y / 5;
           angle = angle + marker.id[0].rotation / 5;
       }

       cout << "x = " << x << ", y = " << y << ", angle = " << angle << ", position = ";
       cin >> position;
       fprintf(file_pointer, "%d, %f, %f, %f\n", position, x, y, angle );
       cout << endl;

       if (position > 1000)
       {
           finished = true;
       }
   }

   fclose(file_pointer);
}



