#include "extra.h"

void reactionWheelIdentification()
{
	FILE* dataFile;

	typedef struct reactionWheelCalibration {
		double time;
		int dutyInUs;
		double xGyro;
		double yGyro;
		double zGyro;
	} reactionWheelCalibration_t;

	std::vector<reactionWheelCalibration_t> reactionWheelData;

	reactionWheelCalibration_t data;

	dataFile = fopen("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/reaction_wheel_data.csv", "w + ");

	// Duty in Us 
	int value = 0;
	int maxValue = 1860;
	int minValue = 1060;
	int intermediateValue = (maxValue + minValue) / 2;

	gyroscopeData_t gyroData;
	motorData_t motors;

	radioInit();
	gyroOffsetDetermination(gyroData);
	myDelaySec(13);

	cout << "Release the platform!" << endl;

	myDelaySec(2);

	startTimer1();

	double sampleTime = 0.01;
	double durationExperiment = 20;
	//double durationExperiment = 30;

	double samples = durationExperiment / sampleTime;
	int sampleCounter = 0;
	int test = 5; // Select the test here!

	// Test 1 - Acceleration
	if (test == 1)
		value = intermediateValue + 50;

	// Test 2 - Acceleration
	if (test == 2)
		value = intermediateValue + 100;

	// Test 3 - Acceleration
	if (test == 3)
		value = intermediateValue + 150;

	// Test 4 - Acceleration
	if (test == 4)
		value = intermediateValue + 200;

	// Test 5 - Acceleration
	if (test == 5)
		value = intermediateValue + 250;

	// Test 6 - Acceleration
	if (test == 6)
		value = intermediateValue + 300;

	// Test 7 - Acceleration
	if (test == 7)
		value = intermediateValue + 350;

	// Test 8 - Acceleration
	if (test == 8)
		value = intermediateValue + 400;

	// Test 9 - Acceleration
	if (test == 9)
		value = intermediateValue - 50;

	// Test 10 - Acceleration
	if (test == 10)
		value = intermediateValue - 100;

	// Test 11 - Acceleration
	if (test == 11)
		value = intermediateValue - 150;

	// Test 12 - Acceleration
	if (test == 12)
		value = intermediateValue - 200;

	// Test 13 - Acceleration
	if (test == 13)
		value = intermediateValue - 250;

	// Test 14 - Acceleration
	if (test == 14)
		value = intermediateValue - 300;

	// Test 15 - Acceleration
	if (test == 15)
		value = intermediateValue - 350;

	// Test 16 - Acceleration
	if (test == 16)
		value = intermediateValue - 400;

	if (value > maxValue)
		value = maxValue;
	if (value < minValue)
		value = minValue;	

	cout << "Measuring..." << endl;

	cout << endl;

	while (sampleCounter <= samples)
	{
		data.time = getTimeTimer1();

		sampleCounter++;

		motors.M6.dutyCycleUs = value;

		getAngularVelocity(motors,
			               gyroData);

		data.xGyro = gyroData.x;
		data.yGyro = gyroData.y;
		data.zGyro = gyroData.z;
		data.dutyInUs = value;
		reactionWheelData.push_back(data);

		myDelayUs((int)((sampleTime - (getTimeTimer1() - data.time)) * 1e6));
	}
	
	for (int i = 0; i < reactionWheelData.size(); i++)
	{
		fprintf(dataFile, "%f, %d, %f, %f, %f \n", reactionWheelData[i].time, reactionWheelData[i].dutyInUs, reactionWheelData[i].xGyro, reactionWheelData[i].yGyro, reactionWheelData[i].zGyro);
	}

	cout << "Measurement completed!" << endl;

	motors.M6.dutyCycleUs = minValue;
	radioCommunicate(motors, gyroData);

	fclose(dataFile);
}


