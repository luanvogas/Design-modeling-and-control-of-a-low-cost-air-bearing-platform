#include "control.h"

void DLQRRotationalControlCalculation(double currentPosition,
									  double currentVelocity,
									  DLQRRotationalControllerGains_t gain,
									  DLQRRotationalAugmentedStateVector_t& state,
									  double& control)
{
	state.position_k_5 = state.position_k_4;
	state.position_k_4 = state.position_k_3;
	state.position_k_3 = state.position_k_2;
	state.position_k_2 = state.position_k_1;
	state.position_k_1 = state.position_k;
	state.position_k = currentPosition;
	state.velocity_k_3 = state.velocity_k_2;
	state.velocity_k_2 = state.velocity_k_1;
	state.velocity_k_1 = state.velocity_k;
	state.velocity_k = currentVelocity;
	state.control_k_5 = state.control_k_4;
	state.control_k_4 = state.control_k_3;
	state.control_k_3 = state.control_k_2;
	state.control_k_2 = state.control_k_1;
	state.control_k_1 = state.control_k;

	control = - state.position_k    * gain.K1
			  - state.position_k_1 * gain.K2
			  - state.position_k_2 * gain.K3
		      - state.position_k_3 * gain.K4
		      - state.position_k_4 * gain.K5
	          - state.position_k_5 * gain.K6
		      - state.velocity_k   * gain.K7
			  - state.velocity_k_1 * gain.K8
			  - state.velocity_k_2 * gain.K9
		      - state.velocity_k_3 * gain.K10
		      - state.control_k_1  * gain.K11
		      - state.control_k_2  * gain.K12
		      - state.control_k_3  * gain.K13
			  - state.control_k_4  * gain.K14
		      - state.control_k_5  * gain.K15;

	state.control_k = control;
}

void DLQRTranslationalControlCalculation(double currentState, 
	                                     DLQRTranslationalControllerGains_t gain, 
	                                     DLQRTranslationalAugmentedStateVector_t &state,
	                                     double &control)
{
	state.position_k_3 = state.position_k_2;
	state.position_k_2 = state.position_k_1;
	state.position_k_1 = state.position_k;
	state.position_k = currentState;
	state.control_k_3 = state.control_k_2;
	state.control_k_2 = state.control_k_1;	
	state.control_k_1 = state.control_k;

	control = - state.position_k * gain.K1
			  - state.position_k_1 * gain.K2
			  - state.position_k_2 * gain.K3
			  - state.position_k_3 * gain.K4
			  - state.control_k_1 * gain.K5
			  - state.control_k_2 * gain.K6
			  - state.control_k_3 * gain.K7;

	state.control_k = control;		
}

void initializationDLQRRotationalStates(DLQRRotationalAugmentedStateVector_t &stateVector, 
	                                    double initialization)
{
	stateVector.position_k = initialization;
	stateVector.position_k_1 = initialization;
	stateVector.position_k_2 = initialization;
	stateVector.position_k_3 = initialization;
	stateVector.position_k_4 = initialization;
	stateVector.position_k_5 = initialization;
	stateVector.velocity_k = 0.0;
	stateVector.velocity_k_1 = 0.0;
	stateVector.velocity_k_2 = 0.0;
	stateVector.control_k_1 = 0.0;
	stateVector.control_k_2 = 0.0;
	stateVector.control_k_3 = 0.0;
}

void initializationDLQRTranslationalStates(DLQRTranslationalAugmentedStateVector_t& stateVector,
	                                       double initialization)
{
	stateVector.position_k = initialization;
	stateVector.position_k_1 = initialization;
	stateVector.position_k_2 = initialization;
	stateVector.position_k_3 = initialization;
	stateVector.control_k_1 = 0.0;
	stateVector.control_k_2 = 0.0;
	stateVector.control_k_3 = 0.0;
}

void rotationalReferenceGenerator(double currentAngularPosition,
								  double &angularPositionReference, 
	                              double time,
	                              double initialTime)
{
	double referenceTime = time - initialTime;	
	double refAngle = 180.0;
	double angularVariation = 10.0;

	if (referenceTime < 12.0)
	{
		angularPositionReference = currentAngularPosition - ((currentAngularPosition - refAngle) / 12.0) * referenceTime;
	}
	if ((referenceTime >= 12.0) && (referenceTime < 18.0))
	{
		angularPositionReference = refAngle;
	}
	if ((referenceTime >= 18.0) && (referenceTime < 24.0))
	{
		angularPositionReference = refAngle - (angularVariation / 6.0) * (referenceTime - 18.0);
	}
	if ((referenceTime >= 24.0) && (referenceTime < 30.0))
	{
		angularPositionReference = (refAngle - angularVariation);
	}
	if ((referenceTime >= 30.0) && (referenceTime < 36.0))
	{
		angularPositionReference = (refAngle - angularVariation) + (angularVariation / 6.0) * (referenceTime - 30.0);
	}
	if ((referenceTime >= 36.0) && (referenceTime < 42.0))
	{
		angularPositionReference = refAngle;
	}
	if ((referenceTime >= 42.0) && (referenceTime < 48.0))
	{
		angularPositionReference = refAngle + (angularVariation / 6.0) * (referenceTime - 42.0);
	}
	if ((referenceTime >= 48.0) && (referenceTime < 54.0))
	{
		angularPositionReference = refAngle + angularVariation ;
	}
	if ((referenceTime >= 54.0) && (referenceTime < 60.0))
	{
		angularPositionReference = (refAngle + angularVariation) - (angularVariation / 6.0) * (referenceTime - 54.0);
	}
}

void translationalReferenceGenerator(double &referenceXAxis, 
									 double &referenceYAxis, 
									 double time, 
									 double initialTime)
{
	double referenceTime = time - initialTime;

	double omega = (2.0 * M_PI) / 48.0;

	if (referenceTime < 6.0)
	{
		referenceXAxis = 0.0;
		referenceYAxis = 0.3;
	}
	if ((referenceTime >= 6.0) && (referenceTime < 54.0))
	{
		referenceXAxis = 0.3 * sin(omega * referenceTime - M_PI / 4.0 - M_PI);
		referenceYAxis = 0.3 * cos(omega * referenceTime - M_PI / 4.0);
	}
	if ((referenceTime >= 54.0) && (referenceTime < 60.0))
	{
		referenceXAxis = 0.0;
		referenceYAxis = 0.3;
	}	
}

void trackingErrorDetermination(double reference, 
	                            double currentState, 
	                            double &trackingError)
{
	trackingError = currentState - reference;
}

void angularPositionTrackingErrorCorrection(double &trackingError) 
{
		if (abs(trackingError) > abs(abs(trackingError) - 360.0)) //Choosing the shortest path
		if (trackingError < 0.0)
			trackingError += 360.0;
		else
			trackingError -= 360.0;
}

double bilinearInterpolation(double x1,
							 double x2,
						     double x1a_j, 
						     double x1a_j1,
						     double x2a_k, 
						     double x2a_k1,
						     double ya_jk, 
						     double ya_j1k,
						     double ya_j1k1,
						     double ya_jk1)
{
	// Numerical Recipes in C++: The Art of Scientific Computing
    // Second Edition
    // 2002
    // Page 126 - 3.6 Interpolation in Two or More Dimensions 

	double y0 = ya_jk;
	double y1 = ya_j1k;
	double y2 = ya_j1k1;
	double y3 = ya_jk1;

	double t = (x1 - x1a_j) / (x1a_j1 - x1a_j);

	double u = (x2 - x2a_k) / (x2a_k1 - x2a_k);

	double y_x1x2 = (1.0 - t) * (1.0 - u) * y0 + t * (1.0 - u) * y1 + t * u * y2 + (1.0 - t) * u * y3;

	return y_x1x2;
}

void gridDefinition(vector<double> &xGrid, 
	                vector<double> &yGrid)
{
	double resolution = 0.05;	

	for (double x = -0.65; x <= 0.65 + 1e-9; x += resolution)
	{
		xGrid.push_back(x);
	}
	for (double y = -0.65; y <= 0.65 + 1e-9; y += resolution)
	{
		yGrid.push_back(y);
	}
}

void gridCoordinateSearch(double x, 
						  double y,
						  vector<double> xGrid,
						  vector<double> yGrid,
						  int &xIndex, 
						  int &yIndex)	
{
	for (int i = 0; i < xGrid.size(); ++i) 
	{
		if (xGrid[i] <= x) {
			xIndex = i;
		}
	}

	for (int i = 0; i < yGrid.size(); ++i) 
	{
		if (yGrid[i] <= y) {
			yIndex = i;
		}
	}
}

void slopeDeterminationBasedOnCoordinates(double x, 
										  double y,
										  vector<vector<double>> incXAxis,
										  vector<vector<double>> incYAxis, 
										  double &currentIncX, 
										  double &currentIncY)
{
	vector<double> xGrid;
	vector<double> yGrid;

	gridDefinition(xGrid,
		           yGrid);

	int xIndex = 0;
	int yIndex = 0;

	gridCoordinateSearch(x,
						 y,
						 xGrid,
						 yGrid,
						 xIndex,
						 yIndex);

	currentIncX = bilinearInterpolation(x,
										y,
										xGrid[xIndex],
										xGrid[xIndex + 1],
										yGrid[yIndex],
										yGrid[yIndex + 1],
										incXAxis[xIndex][yIndex],
										incXAxis[xIndex + 1][yIndex],
										incXAxis[xIndex + 1][yIndex + 1],
										incXAxis[xIndex][yIndex + 1]);

	currentIncY = bilinearInterpolation(x,
										y,
										xGrid[xIndex],
										xGrid[xIndex + 1],
										yGrid[yIndex],
										yGrid[yIndex + 1],
										incYAxis[xIndex][yIndex],
										incYAxis[xIndex + 1][yIndex],
										incYAxis[xIndex + 1][yIndex + 1],
										incYAxis[xIndex][yIndex + 1]);
	
}

void forceCompensationDueGlassInclination(double x, 
										  double y,
										  vector<vector<double>> incXAxis, 
										  vector<vector<double>> incYAxis, 
										  platformControl_t &control)
{
	slopeDeterminationBasedOnCoordinates(x,
										 y,
										 incXAxis,
										 incYAxis,
										 control.currentIncXAxis,
										 control.currentIncYAxis);

	double m = 1.2202;
	double g = 9.8066;

	control.xAxisForceCompensation = m * g * sind(control.currentIncXAxis);
	control.yAxisForceCompensation = m * g * sind(control.currentIncYAxis);

	control.xAxisForce = control.xAxisForce - control.xAxisForceCompensation;
	control.yAxisForce = control.yAxisForce - control.yAxisForceCompensation;
}

void translationalDisturbanceGenerator(translationalDisturbance_t& disturbance,
								       motorData_t& motor,
								       double time,
								       double initialTime)
{

	disturbance.maxForce = 2 * 0.1255; // N (Two time the lower value between pusher and tractor operating mode)
	disturbance.frequency = 0.2732; // rad/s

	disturbance.amplitude = disturbance.maxForce / 8.0;
	double currentTime = time - initialTime;	

	if ((currentTime >= 0) && (currentTime < 6))
	{
		disturbance.force = 0.0;
		motor.M1.force = 0.0;
		motor.M2.force = 0.0;
	}

	if ((currentTime >= 6.0) && (currentTime < (6.0 + (4.0 *M_PI) / disturbance.frequency)))
	{
		disturbance.force = disturbance.amplitude * sin(disturbance.frequency * currentTime - 6.0 * disturbance.frequency);

		if (disturbance.force >= 0.0)
		{
			motor.M1.force = (disturbance.force / 2.0);
			motor.M2.force = (disturbance.force / 2.0) + 0.003;
		}
		else
		{
			motor.M1.force = (disturbance.force / 2.0);
			motor.M2.force = (disturbance.force / 2.0) + 0.0025;
		}	
	}

	if (currentTime >= (6.0 + (4 * M_PI) / disturbance.frequency))
	{
		disturbance.force = 0.0;
		motor.M1.force = 0.0;
		motor.M2.force = 0.0;
	}
	
}

void rotationalControllerGains(DLQRRotationalControllerGains_t &gain)
{
	auto rotationalController = readMatrixFromCSV("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/DLQRRotationalController.csv");

	gain.K1 = rotationalController[0][0];
	gain.K2 = rotationalController[0][1];
	gain.K3 = rotationalController[0][2];
	gain.K4 = rotationalController[0][3];
	gain.K5 = rotationalController[0][4];
	gain.K6 = rotationalController[0][5];
	gain.K7 = rotationalController[0][6];
	gain.K8 = rotationalController[0][7];
	gain.K9 = rotationalController[0][8];
	gain.K10 = rotationalController[0][9];
	gain.K11 = rotationalController[0][10];
	gain.K12 = rotationalController[0][11];
	gain.K13 = rotationalController[0][12];
	gain.K14 = rotationalController[0][13];
	gain.K15 = rotationalController[0][14];
}

void translationalControllerGains(DLQRTranslationalControllerGains_t& gain)
{
	auto translationalController = readMatrixFromCSV("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/DLQRTranslationalController.csv");

	gain.K1 = translationalController[0][0];
	gain.K2 = translationalController[0][1];
	gain.K3 = translationalController[0][2];
	gain.K4 = translationalController[0][3];
	gain.K5 = translationalController[0][4];
	gain.K6 = translationalController[0][5];
	gain.K7 = translationalController[0][6];
}

void DLQRController()
{
	// Variables

	std::vector<DLQRExperimentData_t> DLQRStoredData;
	DLQRExperimentData_t experimentData;

	// Experiment Parameters

	experimentData.sampleTime = 0.125;	
	experimentData.platformId = 0;
	experimentData.experiment = 3; // 0 -> Regulation
								   // 1 -> Rotational Reference Tracking
								   // 2 -> Translational Reference Tracking	
								   // 3 -> Regulation with Disturbance

	experimentData.glassInclinationCompensation = true;
								   
	// Experiments
	
	if ((experimentData.experiment == 0) || (experimentData.experiment == 3)) // Regulation and Regulation with Disturbance
	{
		experimentData.duration = 60;
		experimentData.rotaionalReferenceTracking = false;
		experimentData.translationalReferenceTracking = false;		
	}

	if (experimentData.experiment == 1) // Rotational Reference Tracking
	{
		experimentData.duration = 60;
		experimentData.rotaionalReferenceTracking = true;
		experimentData.translationalReferenceTracking = false;
	}

	if (experimentData.experiment == 2) // Translational Reference Tracking	
	{
		experimentData.duration = 60;
		experimentData.rotaionalReferenceTracking = false;
		experimentData.translationalReferenceTracking = true;
	}
			
	// Controller Gains

	rotationalControllerGains(experimentData.rotationalGain);

	translationalControllerGains(experimentData.translationalGain);

	// Initializations

	auto incXAxis = readMatrixFromCSV("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/xAxisInclinationGrid.csv");

	auto incYAxis = readMatrixFromCSV("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/yAxisInclinationGrid.csv");

	//checkLoadedMatrix(incXAxis);

	//checkLoadedMatrix(incYAxis);		

	hardwareInit(experimentData.gyro);

	visionPoseEstimation(experimentData.vision,
						 false);	

	if (experimentData.experiment == 0) // Regulation
	{
		experimentData.reference.angularPosition = experimentData.vision.id[experimentData.platformId].rotation;

		experimentData.reference.xAxis = experimentData.vision.id[experimentData.platformId].x;

		experimentData.reference.yAxis = experimentData.vision.id[experimentData.platformId].y;
	}

	if (experimentData.experiment == 1) // Rotational Reference Tracking
	{		
		experimentData.reference.angularPosition = 180;

		experimentData.reference.xAxis = experimentData.vision.id[experimentData.platformId].x;

		experimentData.reference.yAxis = experimentData.vision.id[experimentData.platformId].y;
	}

	if (experimentData.experiment == 2) // Translational Reference Tracking	
	{
		experimentData.reference.angularPosition = experimentData.vision.id[experimentData.platformId].rotation;

		experimentData.reference.xAxis = 0.0;

		experimentData.reference.yAxis = 0.3;		
	}

	if (experimentData.experiment == 3) // Regulation with Disturbance
	{
		experimentData.reference.angularPosition = 120;

		experimentData.reference.xAxis = 0.0;

		experimentData.reference.yAxis = 0.0;
		
	}

	trackingErrorDetermination(experimentData.reference.angularPosition,
							   experimentData.vision.id[experimentData.platformId].rotation,
							   experimentData.trackingError.angularPosition);

	trackingErrorDetermination(experimentData.reference.xAxis,
							   experimentData.vision.id[experimentData.platformId].x,
							   experimentData.trackingError.xAxis);

	trackingErrorDetermination(experimentData.reference.yAxis,
							   experimentData.vision.id[experimentData.platformId].y,
							   experimentData.trackingError.yAxis);


	initializationDLQRRotationalStates(experimentData.rotationalState,
									   experimentData.trackingError.angularPosition);

	initializationDLQRTranslationalStates(experimentData.xAxisTranslationalState,
										  experimentData.trackingError.xAxis);

	initializationDLQRTranslationalStates(experimentData.yAxisTranslationalState,
										  experimentData.trackingError.yAxis);

	myDelaySec(13);

	cout << "Release the platform!" << endl;
	cout << " " << endl;

	myDelaySec(2);

	startTimer1();
	experimentData.initialTime = getTimeTimer1();

	cout << "Experiment started!" << endl;
	cout << " " << endl;

	while (getTimeTimer1() <= experimentData.initialTime + experimentData.duration + experimentData.sampleTime)
	{
		// Start of time measurement
		experimentData.time = getTimeTimer1();

		// The determination of the angular velocity of the platform
		getAngularVelocity(experimentData.motor,
						   experimentData.gyro);

		// Determination of the position and orientation of the platform
		visionPoseEstimation(experimentData.vision,
							 false);

		// Generation of the rotational reference signal
		if (experimentData.rotaionalReferenceTracking)
		{
			rotationalReferenceGenerator(experimentData.vision.id[experimentData.platformId].rotation,
									     experimentData.reference.angularPosition,
										 experimentData.time,
										 experimentData.initialTime);
		}		

		// Generation of the translation reference signal
		if (experimentData.translationalReferenceTracking)
		{
			translationalReferenceGenerator(experimentData.reference.xAxis,
											experimentData.reference.yAxis,
											experimentData.time,
											experimentData.initialTime);
		}

		// Determination of the angular position reference tracking error
		trackingErrorDetermination(experimentData.reference.angularPosition,
								   experimentData.vision.id[experimentData.platformId].rotation,
								   experimentData.trackingError.angularPosition);

		// Determination of the best path for correcting the angular position tracking error
		angularPositionTrackingErrorCorrection(experimentData.trackingError.angularPosition);

		// Determination of x-axis reference tracking error
		trackingErrorDetermination(experimentData.reference.xAxis,
								   experimentData.vision.id[experimentData.platformId].x,
								   experimentData.trackingError.xAxis);

		// Determination of y-axis reference tracking error
		trackingErrorDetermination(experimentData.reference.yAxis,
								   experimentData.vision.id[experimentData.platformId].y,
								   experimentData.trackingError.yAxis);

		// Determination of the rotation control signal
		DLQRRotationalControlCalculation(experimentData.trackingError.angularPosition,
										 experimentData.gyro.z,
										 experimentData.rotationalGain,
										 experimentData.rotationalState,
										 experimentData.control.dutyCycleVariation);

		// Determination of the X-axis translation control signal
		DLQRTranslationalControlCalculation(experimentData.trackingError.xAxis,
											experimentData.translationalGain,
											experimentData.xAxisTranslationalState,
											experimentData.control.xAxisForce);

		// Determination of the Y-axis translation control signal
		DLQRTranslationalControlCalculation(experimentData.trackingError.yAxis,
											experimentData.translationalGain,
											experimentData.yAxisTranslationalState,
											experimentData.control.yAxisForce);

		// Compensation for glass inclination
		if (experimentData.glassInclinationCompensation)
		{
			forceCompensationDueGlassInclination(experimentData.vision.id[experimentData.platformId].x,
												 experimentData.vision.id[experimentData.platformId].y,
												 incXAxis,
												 incYAxis,
												 experimentData.control);
		}

		// Decomposition of the forces in the platform axis
		forceDecomposition(experimentData.motor,
						   experimentData.control,
						   experimentData.vision.id[experimentData.platformId].rotation);

		// Generation of translation disturbance
		if (experimentData.experiment == 3)
		{
			translationalDisturbanceGenerator(experimentData.translationalDisturbance,
											  experimentData.motor,
											  experimentData.time,
											  experimentData.initialTime);
		}

		// Motors duty cycle update
		motorsDutyCycleUpdate(experimentData.motor,
							  experimentData.control);

		// Sending and receiving data to the platform
		sendMotorsParameters(experimentData.motor,
							 experimentData.gyro);

		// Storing data from this iteration
		DLQRStoredData.push_back(experimentData);

		// Timing adjustment to ensure fixed sampling time
		myDelayUs((int)((experimentData.sampleTime - (getTimeTimer1() - experimentData.time)) * 1e6));
	}

	cout << "Experiment completed!" << endl;

	DLQRDataStorageProcedure(DLQRStoredData);
}

void DLMITranslationalControlCalculation(double position, 
										 MatrixXd AHat,
										 MatrixXd BHat,
										 MatrixXd CHat,
										 MatrixXd DHat,
										 DLMITranslationalAugmentedStateVector_t &state,
	                                     double &control)
{
	state.controller_k_1 = state.controller_k;
	state.position(0,0) = position;
	state.controller_k = AHat * state.controller_k_1 + BHat * state.position;
	state.control = CHat * state.controller_k_1 + DHat * state.position;	
	control = state.control(0,0);
}

void DLMIController()
{
	// Variables

	std::vector<DLMIExperimentData_t> DLMIStoredData;
	DLMIExperimentData_t experimentData;

	// Experiment Parameters

	experimentData.sampleTime = 0.125;
	experimentData.duration = 60;
	experimentData.platformId = 0;
	experimentData.experiment = 1; // 0 -> Regulation without disturbance
								   // 1 -> Regulation with disturbance
	experimentData.glassInclinationCompensation = true;

	// Ritational Controller Gains

	rotationalControllerGains(experimentData.rotationalGain);

	// Initializations

	auto incXAxis = readMatrixFromCSV("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/xAxisInclinationGrid.csv");
	auto incYAxis = readMatrixFromCSV("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/yAxisInclinationGrid.csv");	

	MatrixXd  AMatrixDLMIController = readCSVtoEigen("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/AMatrixDLMIController.csv");
	MatrixXd  BMatrixDLMIController = readCSVtoEigen("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/BMatrixDLMIController.csv");
	MatrixXd  CMatrixDLMIController = readCSVtoEigen("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/CMatrixDLMIController.csv");
	MatrixXd  DMatrixDLMIController = readCSVtoEigen("C:/Users/Luan/Documents/Repositories/Satellite_simulator/data/DMatrixDLMIController.csv");

	hardwareInit(experimentData.gyro);

	visionPoseEstimation(experimentData.vision,
						 false);

	experimentData.reference.angularPosition = 120;

	experimentData.reference.xAxis = 0.0;

	experimentData.reference.yAxis = 0.0;

	//experimentData.vision.id[experimentData.platformId].y;

	trackingErrorDetermination(experimentData.reference.angularPosition,
							   experimentData.vision.id[experimentData.platformId].rotation,
							   experimentData.trackingError.angularPosition);

	trackingErrorDetermination(experimentData.reference.xAxis,
							   experimentData.vision.id[experimentData.platformId].x,
							   experimentData.trackingError.xAxis);

	trackingErrorDetermination(experimentData.reference.yAxis,
							   experimentData.vision.id[experimentData.platformId].y,
							   experimentData.trackingError.yAxis);


	initializationDLQRRotationalStates(experimentData.rotationalState,
								       experimentData.trackingError.angularPosition);

	myDelaySec(13);

	cout << "Release the platform!" << endl;
	cout << " " << endl;

	myDelaySec(2);

	startTimer1();
	experimentData.initialTime = getTimeTimer1();

	cout << "Experiment started!" << endl;
	cout << " " << endl;

	while (getTimeTimer1() <= experimentData.initialTime + experimentData.duration + experimentData.sampleTime)
	{
		// Start of time measurement
		experimentData.time = getTimeTimer1();

		// The determination of the angular velocity of the platform
		getAngularVelocity(experimentData.motor,
						   experimentData.gyro);

		// Determination of the position and orientation of the platform
		visionPoseEstimation(experimentData.vision,
							 false);

		// Determination of the angular position reference tracking error
		trackingErrorDetermination(experimentData.reference.angularPosition,
								   experimentData.vision.id[experimentData.platformId].rotation,
								   experimentData.trackingError.angularPosition);

		// Determination of the best path for correcting the angular position tracking error
		angularPositionTrackingErrorCorrection(experimentData.trackingError.angularPosition);

		// Determination of x-axis reference tracking error
		trackingErrorDetermination(experimentData.reference.xAxis,
								   experimentData.vision.id[experimentData.platformId].x,
								   experimentData.trackingError.xAxis);

		// Determination of y-axis reference tracking error
		trackingErrorDetermination(experimentData.reference.yAxis,
								   experimentData.vision.id[experimentData.platformId].y,
								   experimentData.trackingError.yAxis);

		// Determination of the rotation control signal
		DLQRRotationalControlCalculation(experimentData.trackingError.angularPosition,
										 experimentData.gyro.z,
										 experimentData.rotationalGain,
										 experimentData.rotationalState,
										 experimentData.control.dutyCycleVariation);

		// Determination of the X-axis translation control signal
		DLMITranslationalControlCalculation(experimentData.trackingError.xAxis,
											AMatrixDLMIController,
											BMatrixDLMIController,
											CMatrixDLMIController,
											DMatrixDLMIController,
											experimentData.xAxisTranslationalState,
											experimentData.control.xAxisForce);

		// Determination of the Y-axis translation control signal
		DLMITranslationalControlCalculation(experimentData.trackingError.yAxis,
											AMatrixDLMIController,
											BMatrixDLMIController,
											CMatrixDLMIController,
											DMatrixDLMIController,
											experimentData.yAxisTranslationalState,
											experimentData.control.yAxisForce);

		// Compensation for glass inclination
		if (experimentData.glassInclinationCompensation)
		{
			forceCompensationDueGlassInclination(experimentData.vision.id[experimentData.platformId].x,
												 experimentData.vision.id[experimentData.platformId].y,
												 incXAxis,
												 incYAxis,
												 experimentData.control);
		}		

		// Decomposition of the forces in the platform axis
		forceDecomposition(experimentData.motor,
						   experimentData.control,
						   experimentData.vision.id[experimentData.platformId].rotation);

		// Generation of translation disturbance
		if (experimentData.experiment == 1)
		{
			translationalDisturbanceGenerator(experimentData.translationalDisturbance,
											  experimentData.motor,
											  experimentData.time,
											  experimentData.initialTime);
		}		

		// Motors duty cycle update
		motorsDutyCycleUpdate(experimentData.motor,
							  experimentData.control);

		// Sending and receiving data to the platform
		sendMotorsParameters(experimentData.motor,
							 experimentData.gyro);

		// Storing data from this iteration
		DLMIStoredData.push_back(experimentData);

		// Timing adjustment to ensure fixed sampling time
		myDelayUs((int)((experimentData.sampleTime - (getTimeTimer1() - experimentData.time)) * 1e6));
	}

	cout << "Experiment completed!" << endl;

	DLMIDataStorageProcedure(DLMIStoredData);
}





