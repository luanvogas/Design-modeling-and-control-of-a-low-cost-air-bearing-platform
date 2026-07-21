#include "radio.h"
#include "message.h"

// Radio object
Nrfusb* radio;

void radioInit()
{
    #if WIN32
        radio = new Nrfusb((char*)"COM7");
    #else
        radio = new Nrfusb((char*)"/dev/ttyACM0");
    #endif

        const uint8_t pcAddress[6] = "0-ITA";
        const uint8_t  client1Address[6] = "1-ITA";
        radio->setChannel(120);
        radio->setPALevel(RF24_PA_HIGH);
        radio->setDataRate(RF24_2MBPS);
        radio->enableDynamicPayloads();
        radio->enableAckPayload();
        radio->setRetries(3, 5);
        radio->openWritingPipe(client1Address);
        radio->openReadingPipe(1, pcAddress);
        radio->stopListening();
}

void radioCommunicate(motorData_t motorsPlatform1, gyroscopeData_t &gyroData)
{
    // Message structure
    sentMessage_t txMsg;
    receivedMessage_t rxMsg;

    // Message to be sent (can be expanded for multiple platforms) 
    TxMsg_t* platform1Tx = &txMsg.msgs[0];
    //TxMsg_t* platform2Tx = &txMsg.msgs[1]; // Reserved for future use

    // Platform 1 motor settings
    platform1Tx->msgStart.start = 1;
    platform1Tx->msgStart.id = 1;
    platform1Tx->msgStart.experimentStatus = 1;
    platform1Tx->msgMotorParameters.enableHBridges = 1;
    platform1Tx->msgMotorParameters.directionMotor1 = motorsPlatform1.M1.directionRotation;
    platform1Tx->msgMotorParameters.directionMotor2 = motorsPlatform1.M2.directionRotation;
    platform1Tx->msgMotorParameters.directionMotor3 = 1;
    platform1Tx->msgMotorParameters.directionMotor4 = 1;
    platform1Tx->msgMotorParameters.directionMotor5 = 1;
    platform1Tx->msgMotorParameters.directionMotor6 = 0;
    platform1Tx->msgDutyPwmMotor1 = motorsPlatform1.M1.dutyCycle;
    platform1Tx->msgDutyPwmMotor2 = motorsPlatform1.M2.dutyCycle;
    platform1Tx->msgDutyPwmMotor3 = motorsPlatform1.M3.dutyCycle;
    platform1Tx->msgDutyPwmMotor4 = motorsPlatform1.M4.dutyCycle;
    platform1Tx->msgDutyPwmMotor5 = motorsPlatform1.M5.dutyCycle;
    platform1Tx->msgDutyPwmMotor6 = motorsPlatform1.M6.dutyCycleUs;

    // Data sending and receiving

    radio->write(&txMsg, txMsgSize);
    if (radio->available())
    {
        radio->read(&rxMsg, rxMsgSize);
    }

    // Message to be received 
    RxMsg_t* platform1Rx = &rxMsg.msgs[0];
    //RxMsg_t* platform2Rx = &rxMsg.msgs[1]; // Reserved for future use

    // Reception of gyro data from Platform 1    
    gyroData.xRaw = static_cast<double>(platform1Rx->msgImuGyroX);
    gyroData.yRaw = static_cast<double>(platform1Rx->msgImuGyroY);
    gyroData.zRaw = static_cast<double>(platform1Rx->msgImuGyroZ);
} 

