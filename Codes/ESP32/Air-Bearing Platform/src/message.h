#ifndef _FIRMWARE_MESSAGE
#define _FIRMWARE_MESSAGE

#include <cstdint>
#include <cstddef>

// Define the maximum number of devices in the network (limited to 8)
// More devices means more data to be sent, making transmission slower
const uint8_t numberDevicesNetwork = 2;

// Define the identification of the client (1-8)
extern uint8_t whoAmI;

typedef struct firstByte
{
    uint8_t start              : 1;  // MSB, 0b1 mark message start
    uint8_t id                 : 3;
    uint8_t experimentStatus   : 1;
    uint8_t reserved           : 3;  // LSB
} firstByte_t;

typedef struct TxMsg 
{
    int16_t msgImuAccX;  
    int16_t msgImuAccY;  
    int16_t msgImuAccZ;      
    int16_t msgImuGyroX;  
    int16_t msgImuGyroY;  
    int16_t msgImuGyroZ;  
    int16_t msgImuCompX; 
    int16_t msgImuCompY; 
    int16_t msgImuCompZ;
    int16_t msgImuTemp;   
} TxMsg_t;

typedef struct sentMessage
{
    TxMsg_t msgs[numberDevicesNetwork];
} sentMessage_t;

typedef struct motorParameters
{
    uint8_t     enableHBridges      : 1;
    uint8_t     directionMotor1     : 1;
    uint8_t     directionMotor2     : 1;
    uint8_t     directionMotor3     : 1;
    uint8_t     directionMotor4     : 1;
    uint8_t     directionMotor5     : 1;
    uint8_t     directionMotor6     : 1;
    uint8_t     reserved            : 1;
} motorParameters_t;

typedef struct RxMsg 
{
    firstByte_t          msgStart;    
    motorParameters_t    msgMotorParameters;
    uint8_t              msgDutyPwmMotor1;
    uint8_t              msgDutyPwmMotor2;
    uint8_t              msgDutyPwmMotor3;
    uint8_t              msgDutyPwmMotor4;
    uint8_t              msgDutyPwmMotor5;
    uint8_t              msgReserved;
    uint16_t             msgDutyPwmMotor6;
} RxMsg_t;

typedef struct receivedMessage
{
    RxMsg_t msgs[numberDevicesNetwork];
} receivedMessage_t;

// Configuration
constexpr size_t txMsgSize = sizeof(sentMessage_t);
constexpr size_t rxMsgSize = sizeof(receivedMessage_t);

// Received message data
extern receivedMessage_t rxMsg;

// Sent message data
extern sentMessage_t txMsg; 

#endif // _FIRMWARE_MESSAGE