#ifndef _FIRMWARE_RADIO
#define _FIRMWARE_RADIO

#include "gpios.h"
#include <nRF24L01.h>
#include <RF24.h>

// Variables for communication timeout 
extern int32_t lastMessageReceived; 

extern RF24 radio;

extern void radioInit();

extern void updateRadioTxData();

#endif // _FIRMWARE_RADIO