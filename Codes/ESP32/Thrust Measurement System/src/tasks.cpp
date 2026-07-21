#include "gpios.h"
#include "tasks.h"
#include "hid.h"
#include "load_cell.h"
#include "interrupts.h"
#include "motors.h"
#include "sd_card.h"
#include "load_cell.h"
#include <iostream>
#include <cstdlib>

// Motor characterization
int actualDuty = 0;

// Task Handlers
TaskHandle_t handleTaskPowerButton = NULL;
TaskHandle_t handleTaskLoadCellCalibration = NULL;
TaskHandle_t handleTaskLoadCellWeighing = NULL;
TaskHandle_t handleTaskMotorCharacterizationSignalGeneration = NULL;
TaskHandle_t handleTaskWeighing = NULL;
TaskHandle_t handleTaskSaveDataSdCard = NULL;
TaskHandle_t handleTaskHID = NULL;

void taskPowerButton(void *arg)
{    
    uint8_t buffer = 0;
    while(1)
    {   
        if (xQueueReceive(powerButtonInterruptQueue, &buffer, pdMS_TO_TICKS(10)))
        {             
            powerOff();
        }
        else vTaskDelay(pdMS_TO_TICKS(1));
    }
}

void taskLoadCellCalibration(void *arg)
{
    initLoadCellCalibration();
    while(1)
    {
        loadCellCalibration();
        vTaskDelay(pdMS_TO_TICKS(100));
    }    
}

void taskLoadCellWeighing(void *arg)
{
    initLoadCellWeighing();
    while(1)
    {
        Serial.println(loadCellWeighing());
        vTaskDelay(pdMS_TO_TICKS(100));
    }
}

void taskMotorCharacterizationSignalGeneration(void *arg)
{
    const int tests = 10;
    int dutyCycle[tests+1];
    int stepInterval = 1000; // Milliseconds    

    dutyCycle[0] = 0;

    for (int i = 1; i <= tests; i++) 
    {
        dutyCycle[i] = 5 * i;
    }

    if (isSdCardConnected) openSdCard();
    
    vTaskDelay(pdMS_TO_TICKS(2000));

    vTaskResume(handleTaskHID);
    vTaskResume(handleTaskSaveDataSdCard);
    vTaskResume(handleTaskWeighing);

    while(1)
    {   
        if(isSdCardConnected)  
        {               
            for (int i = 0; i <= tests; i++) 
            {
                for (int j = 0; j <= tests; j++) 
                {
                    if (dutyCycle[i] != dutyCycle[j])
                    {
                        setPwmMotor1(dutyCycle[i]);
                        setPwmMotor2(dutyCycle[i]);
                        setPwmMotor3(dutyCycle[i]);
                        setPwmMotor4(dutyCycle[i]);
                        setPwmMotor5(dutyCycle[i]);
                        // setPwmMotor6(dutyCycle[i]);
                        actualDuty = dutyCycle[i];
                        vTaskDelay(pdMS_TO_TICKS(stepInterval));
                        setPwmMotor1(dutyCycle[j]);
                        setPwmMotor2(dutyCycle[j]);
                        setPwmMotor3(dutyCycle[j]);
                        setPwmMotor4(dutyCycle[j]);
                        setPwmMotor5(dutyCycle[j]);
                        // setPwmMotor6(dutyCycle[j]);
                        actualDuty = dutyCycle[j];
                        vTaskDelay(pdMS_TO_TICKS(stepInterval));
                    }                    	
                } 
            }

            setPwmMotor1(0);
            setPwmMotor2(0);
            setPwmMotor3(0);
            setPwmMotor4(0);
            setPwmMotor5(0);
            setPwmMotor6(0);

            // Finishing auxiliary tasks      
            vTaskSuspend(handleTaskWeighing);   
            vTaskSuspend(handleTaskSaveDataSdCard);    
            vTaskSuspend(handleTaskHID); 

            // Storing the remaining data in the queue
            loadCellData_t data;              
            while (xQueueReceive(loadCellDataQueue, &data, 0) == pdTRUE) 
            {               
                saveDataSdCard(data.timestamp, data.dutyCycle, data.weight);
            }

            closeSdCard();
            ledBuiltInOff(); 

            // End of this task
            vTaskSuspend(handleTaskMotorCharacterizationSignalGeneration);   
        }
    } 
}

void taskWeighing(void *arg)
{
    vTaskSuspend(handleTaskWeighing);
    uint8_t gpio;    
    TickType_t xLastWakeTime;
    xLastWakeTime = xTaskGetTickCount();
    loadCellData_t data;
    while (1)
    {
        if (xQueueReceive(loadCellInterruptQueue, &gpio, portMAX_DELAY))
        {
            if (isSdCardConnected)
            {                                
                data.timestamp = xTaskGetTickCount();
                data.dutyCycle = actualDuty;
                data.weight = loadCellWeighing();  
                xQueueSend(loadCellDataQueue, &data, portMAX_DELAY);                    
            }
            else ledBuiltInOn();             
        }
    }
}

void taskSaveDataSdCard(void *arg)
{
    vTaskSuspend(handleTaskSaveDataSdCard);
    loadCellData_t buffer[BUFFER_SIZE];
    int index = 0;
    while(1)
    {
        loadCellData_t data;
        if (xQueueReceive(loadCellDataQueue, &data, portMAX_DELAY)) 
        {
            buffer[index++] = data;

            if (index >= BUFFER_SIZE) {
                for (int i = 0; i < index; i++) 
                {
                    saveDataSdCard(buffer[i].timestamp, buffer[i].dutyCycle,buffer[i].weight);                    
                }
                index = 0;
            }
        }
        vTaskDelay(pdMS_TO_TICKS(1));
    }
}

void taskHID(void *arg)
{
    vTaskSuspend(handleTaskHID);
    while (1)
    {
        blinkLedBuiltIn();
    }
}


