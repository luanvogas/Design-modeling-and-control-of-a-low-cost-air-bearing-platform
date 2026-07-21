#include "radio.h"
#include "i2c.h"
#include "message.h"
#include "interrupts.h"
#include <SPI.h>

// Variables for communication timeout 
int32_t lastMessageReceived = 0; 

RF24 radio(4, 5); // (CE, CSN)

void radioInit()
{
    initRadioInterrupt();
    const byte pcAddress[6] = "0-ITA"; 
    const byte client1Address[6] = "1-ITA"; 
    radio.begin(); 
    radio.setChannel(120);
    radio.setPALevel(RF24_PA_HIGH);
    radio.setDataRate(RF24_2MBPS); 
    radio.enableDynamicPayloads();
    radio.enableAckPayload();
    radio.setRetries(3,5); 
    radio.openWritingPipe(pcAddress);
    radio.openReadingPipe(1, client1Address);   
    updateRadioTxData();
    radio.startListening(); 
}

void updateRadioTxData()
{
    gyroscopeRead();
    txMsg.msgs[whoAmI - 1].msgImuCompX = 0;
    txMsg.msgs[whoAmI - 1].msgImuCompY = 0;
    txMsg.msgs[whoAmI - 1].msgImuCompZ = 0;
    txMsg.msgs[whoAmI - 1].msgImuAccX = 0;
    txMsg.msgs[whoAmI - 1].msgImuAccY = 0;
    txMsg.msgs[whoAmI - 1].msgImuAccZ = 0;
    txMsg.msgs[whoAmI - 1].msgImuTemp = 0;
    radio.writeAckPayload(1, &txMsg, txMsgSize);
}





