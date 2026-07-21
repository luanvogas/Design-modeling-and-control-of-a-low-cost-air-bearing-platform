#include <iostream>
#include <hil.h>
#include <array>
#include "vision.h"
#include "timer.h"
#include <iostream>
#include <cmath>
#include "hardware.h"
#include "radio.h"
#include "data_structures.h"
using namespace std;

// Data storage variable
FILE* fptGyro;

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

void initStorageProcedureGyroscope()
{
	fptGyro = fopen("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/gyroscope_calibration_data.csv", "w + ");
}

void saveGyroscopeData(double time, double angle, double xGyro, double yGyro, double zGyro)
{
	fprintf(fptGyro, "%f, %f, %f, %f, %f \n", time, angle, xGyro, yGyro, zGyro);
}

void finishStorageProcedureGyroscope()
{
	fclose(fptGyro);
}

typedef struct {
	double time;
	double angle;
	double xGyro;
	double yGyro;
	double zGyro;
} Experiment;

std::vector<Experiment> gyroscopeData;
void captureGyroscopeData(motorData_t &motors, gyroscopeData_t &gyro, double T, int samples)
{
	Experiment data;

	int sampleCounter = 0;

	while (sampleCounter <= samples)
	{	
		sampleCounter++;
		data.time = getTimeTimer1();
		radioCommunicate(motors,
			             gyro);
		updateGyroData(gyro);		
		data.xGyro = gyro.xRaw;
		data.yGyro = gyro.yRaw;
		data.zGyro = gyro.zRaw;
		gyroscopeData.push_back(data);
		myDelayUs((T - (getTimeTimer1() - data.time)) * 1e6);	
	}
}

std::vector<Experiment> boardData;
void captureBoard(double T, int samples, double freq, double amplitude)
{
	Experiment data;
	int sampleCounter = 0;

	while (sampleCounter <= samples)
	{
		sampleCounter++;
		data.time = getTimeTimer1();		
		double omega = 2 * M_PI * freq;
		double motorVoltage = amplitude * cos(omega * data.time);
		
		double encoderCounts = communicateBoard(motorVoltage);
		data.angle = (encoderCounts/4095)*360; // The encoder has a counting range of 0 to 4095
		boardData.push_back(data);
		myDelayUs((T - (getTimeTimer1() - data.time)) * 1e6);		
	}
}


int main()
{
	initServo();
	initEncoder();
	initStorageProcedureGyroscope();	
	radioInit();
	startTimer1();
	gyroscopeData_t gyro;
	motorData_t motors;
	motors.M6.dutyCycleUs = 1060;
	gyroOffsetDetermination(gyro);	

	cout << "Measuring..." << endl;

	cout << endl;

	double sampleTime = 0.01;
	double durationExperiment = 0;
	double amplitude = 0;
	double cosFreq = 0;
	int test = 9; // Select the test here!

	// Test 1
	if (test == 1)
	{
		durationExperiment = 30;
		amplitude = 0.5;
		cosFreq = 0;
	}

	// Test 2 
	if (test == 2)
	{
		durationExperiment = 30;
		amplitude = 1;
		cosFreq = 0;
	}

	// Test 3 
	if (test == 3)
	{
		durationExperiment = 30;
		amplitude = 1.5;
		cosFreq = 0;
	}

	// Test 4
	if (test == 4)
	{
		durationExperiment = 30;
		amplitude = -0.5;
		cosFreq = 0;
	}

	// Test 5
	if (test == 5)
	{
		durationExperiment = 30;
		amplitude = -1;
		cosFreq = 0;
	}

	// Test 6 
	if (test == 6)
	{
		durationExperiment = 30;
		amplitude = -1.5;
		cosFreq = 0;
	}

	// Test 7
	if (test == 7)
	{
		durationExperiment = 60;
		amplitude = 1;
		cosFreq = 0.5;
	}

	// Test 8 
	if (test == 8)
	{
		durationExperiment = 60;
		amplitude = 1;
		cosFreq = 1;
	}

	// Test 9 
	if (test == 9)
	{
		durationExperiment = 60;
		amplitude = 1;
		cosFreq = 1.5;
	}	

	int samples = (int) durationExperiment / sampleTime;

	std::thread threadGyroscope(captureGyroscopeData, motors, gyro, sampleTime, samples); // https://stackoverflow.com/questions/266168/simple-example-of-threading-in-c 
	std::thread threadBoard(captureBoard, sampleTime, samples, cosFreq, amplitude); 	
	
	threadGyroscope.join();
	threadBoard.join();

	cout << "Measurement completed!" << endl;

	int i;
	for (i = 0; i < gyroscopeData.size(); i++)
	{
		saveGyroscopeData(gyroscopeData[i].time, 0, gyroscopeData[i].xGyro, gyroscopeData[i].yGyro, gyroscopeData[i].zGyro);
	}

	saveGyroscopeData(1234, 1234, 1234, 1234, 1234);

	for (i = 0; i < boardData.size(); i++)
	{
		saveGyroscopeData(boardData[i].time, boardData[i].angle, 0, 0 ,0);
	}

	finishStorageProcedureGyroscope();
	setMotorVoltage(0);
	hil_close(card);

	return 0;
}



