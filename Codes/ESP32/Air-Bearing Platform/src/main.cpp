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
#include "radio.h"
#include "motors.h"
#include "i2c.h"
#include "interrupts.h"

void setup() 
{  
  pwmInit();
  initInterruptService();
  powerInit();
  escInit();
  ledBuiltInInit();      
  serialInit();  
  gyroscopeInit();
  radioInit();
  xTaskCreate(taskPowerButton, "Power_Off_Task", 4096, NULL, 10, &handleTaskPowerButton);
  xTaskCreate(taskRadio, "Radio_Task", 4096, NULL, 9, &handleTaskRadio);
}

void loop() 
{
}
