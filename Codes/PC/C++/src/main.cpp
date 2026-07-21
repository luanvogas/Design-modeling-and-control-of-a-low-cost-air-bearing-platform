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

#include "message.h"
#include "vision.h"
#include "radio.h"
#include "timer.h"
#include "control.h"
#include "data_storage.h"
#include "extra.h"
#include "hardware.h"
#include "data_structures.h"

int main()
{	
	// Control Tasks	
	//DLQRController();
	//DLMIController();	
	
	// Auxiliary 
	//visionInclinationCheck();
	visionCameraCalibrationCheck();
	//reactionWheelIdentification();
}










































