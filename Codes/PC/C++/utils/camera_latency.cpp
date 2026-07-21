#include <iostream>
#include <hil.h>
#include <array>
#include "vision.h"
#include "data_storage.h"
#include "timer.h"
#include <iostream>
#include <cmath>
#include "data_structures.h"
using namespace std;

// Data storage variable
FILE* fpt;

// https://docs.quanser.com/hil_sdk/documentation/hil_open_c.html
// https://docs.quanser.com/hil_sdk/documentation/hil_read_encoder_c.html
// https://docs.quanser.com/hil_sdk/documentation/hil_write_analog_c.html
// https://docs.quanser.com/hil_sdk/documentation/hil_close_c.html

constexpr std::array<t_uint32, 1> DAC_CHANNELS = { 0 };
constexpr std::array<t_uint32, 1> ENC_CHANNELS = { 0 };


std::array<t_double, DAC_CHANNELS.size()> DAC_VALUES = { 0.0 };
std::array<t_int32, ENC_CHANNELS.size()> ENC_VALUES = { 0.0 };
std::array<t_encoder_quadrature_mode, ENC_CHANNELS.size()> ENC_MODES = { ENCODER_QUADRATURE_4X };
std::array<t_int32, ENC_CHANNELS.size()> ENC_COUNTS = { 0 };

t_card card;

void initServo()
{
	t_error error;
	error = hil_open("q2_usb", "0", &card);
	if (error != QERR_NO_ERROR)
	{
		cout << "Error opening the board:  " << error << endl;
	}
}

void initEncoder()
{
	t_error error;
	error = hil_set_encoder_counts(card, ENC_CHANNELS.data(), ENC_CHANNELS.size(), ENC_COUNTS.data());
	if (error != QERR_NO_ERROR)
	{
		cout << "Error in encoder count setting:  " << error << endl;
	}

	error = hil_set_encoder_quadrature_mode(card, ENC_CHANNELS.data(), ENC_CHANNELS.size(), ENC_MODES.data());
	if (error != QERR_NO_ERROR)
	{
		cout << "Error in encoder quadrature setting:  " << error << endl;
	}
}

void setMotorVoltage(double motorVoltage)
{
	t_error error;
	DAC_VALUES.at(0) = motorVoltage;
	error = hil_write_analog(card, DAC_CHANNELS.data(), DAC_CHANNELS.size(), DAC_VALUES.data());
	if (error != QERR_NO_ERROR)
	{
		cout << "Error in analog writing: " << error << endl;
	}
}

t_int32 readEncoder()
{
	t_error error;
	error = hil_read_encoder(card, ENC_CHANNELS.data(), ENC_CHANNELS.size(), ENC_VALUES.data());
	if (error != QERR_NO_ERROR)
	{
		cout << "Encoder reading error: " << error << endl;
	}
	return ENC_VALUES[0];
}

t_int32 communicateBoard(double motorVoltage)
{
	t_error error;
	DAC_VALUES.at(0) = motorVoltage;
	error = hil_read_write(card,
			NULL, 0,
		    ENC_CHANNELS.data(), ENC_CHANNELS.size(),
			NULL, 0,
			NULL, 0,
			DAC_CHANNELS.data(), DAC_CHANNELS.size(),
			NULL, 0,
			NULL, 0,
			NULL, 0,
			NULL,
			ENC_VALUES.data(),
			NULL,
			NULL,
			DAC_VALUES.data(),
			NULL,
			NULL,
			NULL);

	return ENC_VALUES[0];
}

void initStorageProcedureCameraDelay()
{
	fpt = fopen("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/camera_latency_data.csv", "w + ");
}

void saveCameraDelayData(double time, double angle, double x, double y)
{
	fprintf(fpt, "%f, %f, %f, %f \n", time, angle, x, y);
}

void finishStorageProcedureCameraDelay()
{
	fclose(fpt);
}

typedef struct {
	double time;
	double angle;
	double x;
	double y;	
} Coordinate;

std::vector<Coordinate> cameraData;
void captureCamera(markerVector_t &marker, double T, int samples)
{
	Coordinate data;

	int sampleCounter = 0;

	while (sampleCounter <= samples)
	{
		sampleCounter++;
		data.time = getTimeTimer1();
		visionPoseEstimation(marker,false);
		data.x = marker.id[0].x;
		data.y = marker.id[0].y;
		data.angle = marker.id[0].rotation;
		
		cameraData.push_back(data);
		myDelayUs((T - (getTimeTimer1() - data.time)) * 1e6);
	}
}

std::vector<Coordinate> boardData;
void captureBoard(double T, int samples)
{
	Coordinate data;

	int sampleCounter = 0;

	while (sampleCounter <= samples)
	{
		sampleCounter++;
		double motorVoltage = 0;
		double omega = 0;
		double encoderCounts = 0;
		double amplitude = 2;
		double freq = 0.5;

		data.time = getTimeTimer1();
		omega = 2 * M_PI * freq;
		motorVoltage = amplitude * cos(omega * data.time);

		if (sampleCounter < 5 / T)
		{
			encoderCounts = communicateBoard(0);
		}
		if (sampleCounter >= 5 / T && sampleCounter < 10 / T)
		{			
			encoderCounts = communicateBoard(motorVoltage);
		}
		if (sampleCounter >= 10/T && sampleCounter < 15/T)
		{
			encoderCounts = communicateBoard(0);
		}
		if (sampleCounter >= 15/T && sampleCounter < 20/T)
		{
			encoderCounts = communicateBoard(motorVoltage);			
		}
		data.angle = (encoderCounts / 4095) * 360;
		boardData.push_back(data);
		myDelayUs((T - (getTimeTimer1() - data.time)) * 1e6);		
	}
}

int main()
{
	initServo();
	initEncoder();
	initStorageProcedureCameraDelay();
	visionInit();
	startTimer1();	
	markerVector_t marker;
	visionPoseEstimation(marker,false);

	cout << "Measuring..." << endl;

	cout << endl;

	double cameraSampleTime = 0.1;
	double boardSampleTime = 0.01;	
	double durationExperiment = 20;

	int cameraSamples = durationExperiment / cameraSampleTime;
	int boardSamples = durationExperiment / boardSampleTime;

	std::thread threadCamera(captureCamera, marker, cameraSampleTime, cameraSamples); // https://stackoverflow.com/questions/266168/simple-example-of-threading-in-c
	std::thread threadBoard(captureBoard, boardSampleTime, boardSamples);

			
	threadCamera.join();
	threadBoard.join();

	cout << "Measurement completed!" << endl;

	int i;
	for (i = 0; i < cameraData.size(); i++)
	{
		saveCameraDelayData(cameraData[i].time, cameraData[i].angle, cameraData[i].x, cameraData[i].y);
	}

	saveCameraDelayData(1234,1234,1234,1234);

	for (i = 0; i < boardData.size(); i++)
	{
		saveCameraDelayData(boardData[i].time, boardData[i].angle, 0, 0);
	}
	
	finishStorageProcedureCameraDelay();
	setMotorVoltage(0);
	hil_close(card);

	return 0;
}



