#include "tasks.h"
#include "interrupts.h"
#include "message.h"
#include "hid.h"
#include "motors.h"
#include "radio.h"

// Task Handlers
TaskHandle_t handleTaskPowerButton = NULL;
TaskHandle_t handleTaskRadio = NULL;

void taskPowerButton(void *arg)
{    
    uint8_t buffer = 0;
    while(1)
    {   
        if (xQueueReceive(powerButtonQueue, &buffer, pdMS_TO_TICKS(10)))
        {             
            powerOff();
        }
        else vTaskDelay(pdMS_TO_TICKS(1));
    }
}

void taskRadio(void *arg)
{
    bool txOk, txFail, rxReady;
    uint8_t buffer = 0;
    while(1)
    {                
        if (xQueueReceive(radioInterruptQueue, &buffer, pdMS_TO_TICKS(110)))
        {             
            radio.whatHappened(txOk, txFail, rxReady);        
            if (radio.available()) 
            {   
                radio.read(&rxMsg, rxMsgSize);
                updateRadioTxData();
                toggleLedBuiltIn();            
                if (rxMsg.msgs[whoAmI-1].msgStart.start == 1 && rxMsg.msgs[whoAmI-1].msgStart.experimentStatus == 1)
                {
                    setPwmAllMotors();
                }
                else
                {
                    disableAllMotors();
                }
                lastMessageReceived = xTaskGetTickCount();
            }
        }
        else vTaskDelay(pdMS_TO_TICKS(100));
    }
}
