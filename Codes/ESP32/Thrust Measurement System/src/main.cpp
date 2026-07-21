/******************************************************************************
 * Design, modeling, and control of a low-cost air-bearing platform
 *
 * Software developed as part of the doctoral thesis.
 *
 * Author:      Luan Mateus Bocalan Vogás
 * Advisor:     Prof. Dr. Roberto Kawakami Harrop Galvão
 * Co-Advisor:  Profa. Dra. Gabriela Werner Gabriel
 *
 * Instituto Tecnológico de Aeronáutica (ITA)
 * Electronics Engineering Division
 * São José dos Campos, SP, Brazil
 * 2026
 ******************************************************************************/

#include "hid.h"
#include "tasks.h"
#include "load_cell.h"
#include "interrupts.h"
#include "motors.h"
#include "sd_card.h"
#include <stdio.h>

void setup() 
{  
  // Initializations
  pwmInit();
  powerInit();  
  ledBuiltInInit();   
  serialInit();    
  initISRService();
  initLoadCellWeighing();
  initSdCard(); 

  delay(2000);

  xTaskCreatePinnedToCore(taskPowerButton, "Power_Off_Task", 1024, NULL, 0, &handleTaskPowerButton,0);

  // Tasks used for load cell calibration

  // xTaskCreatePinnedToCore(taskLoadCellCalibration, "Load_Cell_Calibration_Task", 4096, NULL, 0, &handleTaskLoadCellCalibration,0);
  // xTaskCreatePinnedToCore(taskLoadCellWeighing, "Load_Cell_Weighing_Task", 4096, NULL, 0, &handleTaskLoadCellWeighing,0); 
  
  // Motor operating mode set  

  // tractorOperationMode();
  pusherOperationMode();
  
  // Tasks used to store load cell data on the SD card in real time   
  
  xTaskCreatePinnedToCore(taskHID, "Blink_LED_While_Collecting_Data", 1024, NULL, 0, &handleTaskHID, 0);   
  xTaskCreatePinnedToCore(taskSaveDataSdCard, "Save_Data_SD_Card", 4096, NULL, 1, &handleTaskSaveDataSdCard, 0);  
  xTaskCreatePinnedToCore(taskMotorCharacterizationSignalGeneration, "Motor_Characterization_Signal_Generation", 4096, NULL, configMAX_PRIORITIES - 2, &handleTaskMotorCharacterizationSignalGeneration, 0); 
  xTaskCreatePinnedToCore(taskWeighing, "Weighing", 4096, NULL, configMAX_PRIORITIES - 1, &handleTaskWeighing, 1);  
}

void loop() 
{
}
