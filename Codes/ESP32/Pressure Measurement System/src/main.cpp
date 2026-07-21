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
#include "analog.h"
#include "tasks.h"
#include "sd_card.h"
#include <stdio.h>

void setup() 
{  
  ledBuiltInInit();   
  adcInit(); 
  serialInit();  
  initSdCard();  
  xTaskCreate(taskPrintRawData, "Print_Raw_Sensor_Data", 4096, NULL, 1, NULL);
  // xTaskCreate(taskPrintPressure, "Print_Pressure", 4096, NULL, 1, NULL);
  // xTaskCreate(taskSavePressureDataSdCard, "Save_Pressure_Data_SD_Card_Task", 4096, NULL, 1, NULL);
}

void loop() 
{
}
