#include "hardware.h"

void updateGyroData(gyroscopeData_t& gyroData)
{
	double sensitivity = 14.375; // Sensitivity ITG-3205	

	gyroData.x = (gyroData.xRaw - gyroData.xOffset) / sensitivity;
	gyroData.y = (gyroData.yRaw - gyroData.yOffset) / sensitivity;
	gyroData.z = (gyroData.zRaw - gyroData.zOffset) / sensitivity;
}

void getAngularVelocity(motorData_t motors, gyroscopeData_t& gyroData)
{
	bool validReading = false;
	while (validReading == false)
	{
		radioCommunicate(motors,
			             gyroData);
		updateGyroData(gyroData);

		if ((gyroData.xRaw != 0) && (gyroData.yRaw != 0) && (gyroData.zRaw != 0))
			validReading = true;
		else
			myDelayUs(500);
			
	}
}

void gyroOffsetDetermination(gyroscopeData_t &gyroData)
{
	startTimerGyro();

	// Variables
	motorData_t motor;
	double time = getTimeTimerGyro();
	double aquitisionTime = 5; // Seconds
	double sumX, sumY, sumZ;
	int sampleCounter = 0;

	sumX = 0;
	sumY = 0;
	sumZ = 0;

	cout << "Determining gyro offset... ";

	while (getTimeTimerGyro() < (time + aquitisionTime))
	{
		double startTime = getTimeTimerGyro();
		sampleCounter += 1;
		getAngularVelocity(motor, gyroData);

		sumX += gyroData.xRaw;
		sumY += gyroData.yRaw;
		sumZ += gyroData.zRaw;

		myDelayUs((0.01 - (getTimeTimerGyro() - startTime)) * 1e6);
	}

	cout << endl;
	cout << endl;

	gyroData.xOffset = sumX / sampleCounter;
	gyroData.yOffset = sumY / sampleCounter;
	gyroData.zOffset = sumZ / sampleCounter;
	
	cout << "Offset determined!" << endl;
	cout << endl;
}

void hardwareInit(gyroscopeData_t& gyroData)
{
	visionInit();
	radioInit();
	gyroOffsetDetermination(gyroData);
}

void forceDecomposition(motorData_t &motor, platformControl_t control, double rotation)
{
	double Fx = control.xAxisForce;
	double Fy = control.yAxisForce;
	double theta = rotation;
	double delta;

	double F = sqrt(pow(Fx, 2) + pow(Fy, 2));
	double gamma = atan2(Fy, Fx) * 180 / M_PI;
	if (gamma < 0) gamma += 360;	

	if (gamma-theta >= 0 && gamma - theta < 120)
	{
		delta = gamma - theta;
		motor.M3.force = (2 / sqrt(3)) * F * sin((120 - delta) * M_PI / 180);
		motor.M4.force = (2 / sqrt(3)) * F * sin(delta * M_PI / 180);
		motor.M5.force = 0;
	}
	if (gamma - theta >= 120 && gamma - theta < 240)
	{
		delta = gamma - 120 - theta;
		motor.M3.force = 0;
		motor.M4.force = (2 / sqrt(3)) * F * sin((120 - delta) * M_PI / 180);
		motor.M5.force = (2 / sqrt(3)) * F * sin(delta * M_PI / 180);		
	}
	if (gamma - theta >= 240 && gamma - theta < 360)
	{
		delta = gamma - 240 - theta;
		motor.M3.force = (2 / sqrt(3)) * F * sin(delta * M_PI / 180);
		motor.M4.force = 0;
		motor.M5.force = (2 / sqrt(3)) * F * sin((120 - delta) * M_PI / 180);
	}
	if (gamma - theta < 0 && gamma - theta >= -120)
	{
		delta = gamma - (theta - 120);
		motor.M3.force = (2 / sqrt(3)) * F * sin(delta * M_PI / 180);
		motor.M4.force = 0;
		motor.M5.force = (2 / sqrt(3)) * F * sin((120 - delta) * M_PI / 180);
	}
	if (gamma - theta < -120 && gamma - theta >= -240)
	{
		delta = gamma - (theta - 240);
		motor.M3.force = 0;
		motor.M4.force = (2 / sqrt(3)) * F * sin((120 - delta) * M_PI / 180);
		motor.M5.force = (2 / sqrt(3)) * F * sin(delta * M_PI / 180);
	}
	if (gamma - theta < -120 && gamma - theta >= -240)
	{
		delta = gamma - (theta - 240);
		motor.M3.force = 0;
		motor.M4.force = (2 / sqrt(3)) * F * sin((120 - delta) * M_PI / 180);
		motor.M5.force = (2 / sqrt(3)) * F * sin(delta * M_PI / 180);
	}
	if (gamma - theta < -240 && gamma - theta >= -360)
	{
		delta = gamma - (theta - 360);
		motor.M3.force = (2 / sqrt(3)) * F * sin((120 - delta) * M_PI / 180);
		motor.M4.force = (2 / sqrt(3)) * F * sin(delta * M_PI / 180);
		motor.M5.force = 0;
	}
}

double force2DutyCycle(double a, double b, double c, double d, double transition, double force)
{
	double dutyCycle;

	// Force to duty cycle conversion
	if (force < transition)		
		dutyCycle = (-b + sqrt(pow(b,2) + 4 * a * force)) / (2 * a);
	else
		dutyCycle = (force - d)/c;

	return dutyCycle;
}

uint8_t force2DutyCycleM1(motorDefinitions_t &motor)
{
	double dutyCycle;

	if (motor.force >= 0.0)
	{
		// Pusher operation mode
		motor.directionRotation = 1;
		dutyCycle = force2DutyCycle(4.9125e-05, 4.5293e-04, 3.3729e-03, -4.3385e-02, 5.7801e-02, motor.force);
	}
	else
	{
		// Tractor operation mode
		motor.directionRotation = 0;
		dutyCycle = force2DutyCycle(9.2423e-05, 8.4151e-04, 6.1821e-03, -7.7036e-02, 1.0843e-01, -motor.force);
	}

	return static_cast<uint8_t>(round(dutyCycle));
}

uint8_t force2DutyCycleM2(motorDefinitions_t &motor)
{
	double dutyCycle;

	if (motor.force >= 0.0)
	{
		// Tractor operation mode
		motor.directionRotation = 0;	
		dutyCycle = force2DutyCycle(9.2112e-05, 7.8728e-04, 6.1999e-03, -7.9478e-02, 1.0652e-01, motor.force);
		
	}
	else
	{
		// Pusher operation mode
		motor.directionRotation = 1;
		dutyCycle = force2DutyCycle(5.3569e-05, 2.6940e-04, 3.4049e-03, -4.5852e-02, 5.6294e-02, -motor.force);
	}

	return static_cast<uint8_t>(round(dutyCycle));
}

uint8_t force2DutyCycleM3(double force)
{
	double dutyCycle;

	if (force >= 0)
	{
		// Tractor operation mode
		dutyCycle = force2DutyCycle(9.1489e-05, 7.4294e-04, 6.2800e-03, -8.3772e-02, 1.0463e-01, force);
	}
	else
	{
		dutyCycle = 0;
	}

	return static_cast<uint8_t>(round(dutyCycle));
}

uint8_t force2DutyCycleM4(double force)
{
	double dutyCycle;

	if (force >= 0)
	{
		// Tractor operation mode
		dutyCycle = force2DutyCycle(8.5706e-05, 8.7225e-04, 6.0293e-03, -7.7575e-02, 1.0330e-01, force);
	}
	else
	{
		dutyCycle = 0;
	}

	return static_cast<uint8_t>(round(dutyCycle));
}

uint8_t force2DutyCycleM5(double force)
{
	double dutyCycle;

	if (force >= 0)
	{
		// Tractor operation mode
		dutyCycle = force2DutyCycle(8.9487e-05, 7.4178e-04, 5.9995e-03, -7.7193e-02, 1.0279e-01, force);
	}
	else
	{
		dutyCycle = 0;
	}

	return static_cast<uint8_t>(round(dutyCycle));
}

uint16_t reactionWheelDutyCalculation(double dutyCycleVariation)
{
	uint16_t duty;

	duty = 1460 + static_cast<uint16_t>(round(dutyCycleVariation));
	
	return duty;
}

void motorsDutyCycleUpdate(motorData_t& motor, platformControl_t control)
{
	uint8_t saturation = 50;

	motor.M1.dutyCycle = force2DutyCycleM1(motor.M1);
	motor.M2.dutyCycle = force2DutyCycleM2(motor.M2);
	motor.M3.dutyCycle = force2DutyCycleM3(motor.M3.force);
	motor.M4.dutyCycle = force2DutyCycleM4(motor.M4.force);
	motor.M5.dutyCycle = force2DutyCycleM5(motor.M5.force);
	motor.M6.dutyCycleUs = reactionWheelDutyCalculation(control.dutyCycleVariation);

	// Protection against high duty cycle values
	if (motor.M1.dutyCycle >= saturation) motor.M1.dutyCycle = saturation;
	if (motor.M2.dutyCycle >= saturation) motor.M2.dutyCycle = saturation;
	if (motor.M3.dutyCycle >= saturation) motor.M3.dutyCycle = saturation;
	if (motor.M4.dutyCycle >= saturation) motor.M4.dutyCycle = saturation;
	if (motor.M5.dutyCycle >= saturation) motor.M5.dutyCycle = saturation;
	if (motor.M6.dutyCycleUs >= 1710) motor.M6.dutyCycleUs = 1710;

	// Protection against negative duty cycle values
	if (motor.M1.dutyCycle <= 0) motor.M1.dutyCycle = 0;
	if (motor.M2.dutyCycle <= 0) motor.M2.dutyCycle = 0;
	if (motor.M3.dutyCycle <= 0) motor.M3.dutyCycle = 0;
	if (motor.M4.dutyCycle <= 0) motor.M4.dutyCycle = 0;
	if (motor.M5.dutyCycle <= 0) motor.M5.dutyCycle = 0;
	if (motor.M6.dutyCycleUs <= 1210) motor.M6.dutyCycleUs = 1210;
}

void sendMotorsParameters(motorData_t motors, gyroscopeData_t &gyroData)
{
	bool dataSentSuccessfully = false;

	double prevGyroX = gyroData.xRaw;
	double prevGyroY = gyroData.yRaw;
	double prevGyroZ = gyroData.zRaw;

	while (dataSentSuccessfully == false)
	{
		radioCommunicate(motors, gyroData);

		if ((gyroData.xRaw != prevGyroX) && (gyroData.yRaw != prevGyroY) && (gyroData.zRaw != prevGyroZ))
			dataSentSuccessfully = true;
		else
			myDelayUs(500);
	}
}

void disableMotors(motorData_t &motor, gyroscopeData_t &gyroData)
{
	motor.M1.dutyCycle = static_cast<uint8_t>(0);
	motor.M2.dutyCycle = static_cast<uint8_t>(0);
	motor.M3.dutyCycle = static_cast<uint8_t>(0);
	motor.M4.dutyCycle = static_cast<uint8_t>(0);
	motor.M5.dutyCycle = static_cast<uint8_t>(0);
	motor.M6.dutyCycleUs = static_cast<uint16_t>(1060);

	sendMotorsParameters(motor, gyroData);
}




