#include "gpios.h"
#include "tasks.h"
#include "hid.h"
#include "sd_card.h"
#include "analog.h"
#include <iostream>
#include <cstdlib>

void taskPrintRawData(void *arg)
{
    while(1)
    {          
       readRawPressure(); 
       vTaskDelay(pdMS_TO_TICKS(1000));
    }
}

void taskPrintPressure(void *arg)
{
    while(1)
    {          
       readPressureSensor();
       Serial.println(pressurePsi);
       vTaskDelay(pdMS_TO_TICKS(1000));
    }    
}

void taskSavePressureDataSdCard(void *arg)
{
    uint8_t experimentDuration = 3; // Minutes  
    if (isSdCardConnected) openSdCard();
    while(1)
    {   
        if (isSdCardConnected)
        {
            if (xTaskGetTickCount() <= experimentDuration*60*1000)   
            {
                savePressureSdCard();
                toggleLedBuiltIn();
            }
            else
            {
                closeSdCard();
                ledBuiltInOff();
            }        
        }
        vTaskDelay(pdMS_TO_TICKS(50));
    }
}