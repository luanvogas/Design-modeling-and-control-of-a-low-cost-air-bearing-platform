#ifndef PC_DRIVER_DATA_STRUCTURES
#define PC_DRIVER_DATA_STRUCTURES

#include <eigen3/Eigen/Dense>

using namespace std;
using namespace Eigen;

// ------------------- Hardware ------------------- 

typedef struct gyroscopeData
{
    double x = 0;
    double y = 0;
    double z = 0;
    double xRaw = 0;
    double yRaw = 0;
    double zRaw = 0;
    double xOffset = 0;
    double yOffset = 0;
    double zOffset = 0;
} gyroscopeData_t;

typedef struct motorDefinitions
{
    double force = 0;
    uint8_t dutyCycle = 0;
    uint8_t directionRotation = 0;
} motorDefinitions_t;

typedef struct reactionWheelDefinitions
{
    uint16_t dutyCycleUs = 1460;
} reactionWheelDefinitions_t;

typedef struct motorData
{
    motorDefinitions_t         M1;
    motorDefinitions_t         M2;
    motorDefinitions_t         M3;
    motorDefinitions_t         M4;
    motorDefinitions_t         M5;
    reactionWheelDefinitions_t M6;
} motorData_t;

// ------------------- Communication ------------------- 

typedef struct firstByte
{
    uint8_t start : 1;  // MSB, 0b1 mark message start
    uint8_t id : 3;
    uint8_t experimentStatus : 1;
    uint8_t reserved : 3;  // LSB
} firstByte_t;

typedef struct motorParameters
{
    uint8_t     enableHBridges : 1;
    uint8_t     directionMotor1 : 1;
    uint8_t     directionMotor2 : 1;
    uint8_t     directionMotor3 : 1;
    uint8_t     directionMotor4 : 1;
    uint8_t     directionMotor5 : 1;
    uint8_t     directionMotor6 : 1;
    uint8_t     reserved : 1;
} motorParameters_t;

typedef struct TxMsg {
    firstByte_t          msgStart;
    motorParameters_t    msgMotorParameters;
    uint8_t              msgDutyPwmMotor1 = 0;
    uint8_t              msgDutyPwmMotor2 = 0;
    uint8_t              msgDutyPwmMotor3 = 0;
    uint8_t              msgDutyPwmMotor4 = 0;
    uint8_t              msgDutyPwmMotor5 = 0;
    uint8_t              msgReserved;
    uint16_t             msgDutyPwmMotor6 = 0;
} TxMsg_t;

// Structure of the message to be sent
typedef struct sentMessage
{
    TxMsg_t msgs[2];
} sentMessage_t;

typedef struct RxMsg {
    int16_t msgImuAccX = 0;
    int16_t msgImuAccY = 0;
    int16_t msgImuAccZ = 0;
    int16_t msgImuGyroX = 0;
    int16_t msgImuGyroY = 0;
    int16_t msgImuGyroZ = 0;
    int16_t msgImuCompX = 0;
    int16_t msgImuCompY = 0;
    int16_t msgImuCompZ = 0;
    int16_t msgImuTemp = 0;
} RxMsg_t;

typedef struct receivedMessage
{
    RxMsg_t msgs[2];
} receivedMessage_t;

// ------------------- Vision ------------------- 

typedef struct marker
{
	double x = 0;
	double y = 0;
	double rotation = 0;
} marker_t;

typedef struct markerVector
{
	marker_t id[50];
} markerVector_t;

// ------------------- Control  ------------------- 

typedef struct DLQRRotationalControllerGains
{
    double K1 = 0.0;
    double K2 = 0.0;
    double K3 = 0.0;
    double K4 = 0.0;
    double K5 = 0.0;
    double K6 = 0.0;
    double K7 = 0.0;
    double K8 = 0.0;
    double K9 = 0.0;
    double K10 = 0.0;
    double K11 = 0.0;
    double K12 = 0.0;
    double K13 = 0.0;
    double K14 = 0.0;
    double K15 = 0.0;
} DLQRRotationalControllerGains_t;

typedef struct DLQRTranslationalControllerGains
{
    double K1 = 0.0;
    double K2 = 0.0;
    double K3 = 0.0;
    double K4 = 0.0;
    double K5 = 0.0;
    double K6 = 0.0;
    double K7 = 0.0;
} DLQRTranslationalControllerGains_t;

typedef struct DLQRRotationalAugmentedStateVector
{
    double position_k = 0.0;
    double position_k_1 = 0.0;
    double position_k_2 = 0.0;
    double position_k_3 = 0.0;
    double position_k_4 = 0.0;
    double position_k_5 = 0.0;
    double velocity_k = 0.0;
    double velocity_k_1 = 0.0;
    double velocity_k_2 = 0.0;
    double velocity_k_3 = 0.0;
    double control_k = 0.0;
    double control_k_1 = 0.0;
    double control_k_2 = 0.0;
    double control_k_3 = 0.0;
    double control_k_4 = 0.0;
    double control_k_5 = 0.0;
} DLQRRotationalAugmentedStateVector_t;

typedef struct DLQRTranslationalAugmentedStateVector
{
    double position_k = 0.0;
    double position_k_1 = 0.0;
    double position_k_2 = 0.0;
    double position_k_3 = 0.0;
    double control_k = 0.0;
    double control_k_1 = 0.0;
    double control_k_2 = 0.0;
    double control_k_3 = 0.0;
} DLQRTranslationalAugmentedStateVector_t;

typedef struct DLMITranslationalAugmentedStateVector
{    
    MatrixXd controller_k = MatrixXd::Zero(3, 1);
    MatrixXd controller_k_1 = MatrixXd::Zero(3, 1);
    MatrixXd position = MatrixXd::Zero(1, 1);
    MatrixXd control = MatrixXd::Zero(1, 1);
} DLMITranslationalAugmentedStateVector_t;

typedef struct platformControl
{
	double dutyCycleVariation = 0.0;
    double xAxisForceCompensation = 0.0;
    double yAxisForceCompensation = 0.0;
	double xAxisForce = 0.0;
	double yAxisForce = 0.0;
    double currentIncXAxis = 0.0;
    double currentIncYAxis = 0.0;
} platformControl_t;

typedef struct reference
{
    double angularPosition = 0.0;
    double xAxis = 0.0;
    double yAxis = 0.0;
} reference_t;

typedef struct trackingError
{
    double angularPosition = 0.0;
    double xAxis = 0.0;
    double yAxis = 0.0;
} trackingError_t;

typedef struct translationalDisturbance
{
    double maxForce = 0.0;
    double frequency = 0.0;
    double amplitude = 0.0;
    double force = 0.0;
} translationalDisturbance_t;

typedef struct DLQRExperimentData
{
    double initialTime = 0.0;
	double time = 0.0;
	double sampleTime = 0.0;
	double duration = 0.0;
	int platformId = 0;
    int experiment = 0;
    bool glassInclinationCompensation = false;
    bool translationalReferenceTracking = false;
    bool rotaionalReferenceTracking = false;    
	markerVector_t vision;
    gyroscopeData_t gyro;
    reference_t reference;
    trackingError_t trackingError;
	DLQRRotationalAugmentedStateVector_t rotationalState;
	DLQRTranslationalAugmentedStateVector_t xAxisTranslationalState;
	DLQRTranslationalAugmentedStateVector_t yAxisTranslationalState;	
	platformControl_t control;
	motorData_t motor;
	DLQRRotationalControllerGains_t rotationalGain;
	DLQRTranslationalControllerGains_t translationalGain;
    translationalDisturbance_t translationalDisturbance;
} DLQRExperimentData_t;


typedef struct DLMIExperimentData
{
    double initialTime = 0.0;
    double time = 0.0;
    double sampleTime = 0.0;
    double duration = 0.0;
    int platformId = 0;
    int experiment = 0;
    bool glassInclinationCompensation = false;
    bool translationalReferenceTracking = false;
    bool rotaionalReferenceTracking = false;
    markerVector_t vision;
    gyroscopeData_t gyro;
    reference_t reference;
    trackingError_t trackingError;
    DLQRRotationalAugmentedStateVector_t rotationalState;
    DLMITranslationalAugmentedStateVector_t xAxisTranslationalState;
    DLMITranslationalAugmentedStateVector_t yAxisTranslationalState;
    platformControl_t control;
    motorData_t motor;
    DLQRRotationalControllerGains_t rotationalGain;
    translationalDisturbance_t translationalDisturbance;
} DLMIExperimentData_t;

#endif //PC_DRIVER_DATA_STRUCTURES
