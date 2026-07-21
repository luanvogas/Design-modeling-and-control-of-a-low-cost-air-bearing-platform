#include "load_cell.h"
#include "interrupts.h"

// See: https://www.usinainfo.com.br/blog/balanca-arduino-com-celula-de-peso-e-hx711-tutorial-calibrando-e-verificando-peso/
//      https://randomnerdtutorials.com/esp32-load-cell-hx711/

// Queue to hold load cell data between tasks
QueueHandle_t loadCellDataQueue;

// HX711 module class definition
HX711 scale;   

void initLoadCellCalibration()
{
    scale.begin (pinDtLoadCell, pinSckLoadCell);
    scale.read(); 
    scale.set_scale();  
    scale.tare(20);
    Serial.println("Raw values: "); 
}

void loadCellCalibration()
{      
    Serial.println(scale.get_value(20));
}

void initLoadCellWeighing()
{
    initLoadCellInterrupt();

    // Creation of the queue for load cell data storage
    loadCellDataQueue = xQueueCreate(QUEUE_LENGTH, sizeof(loadCellData_t));

    if (loadCellDataQueue == NULL) {
        Serial.println("Failed to create queue!");
        while (1);
    }

    scale.begin (pinDtLoadCell, pinSckLoadCell);
    scale.read(); 
    scale.set_scale(); 
    scale.tare(20);     
}

double loadCellWeighing()
{
    double weightLoadCell = 0;
    double rawWeight = scale.read();
    rawWeight = rawWeight - scale.get_offset();
    if (abs(rawWeight) > 50) weightLoadCell = rawWeight / 1971.1438 + 0.0361;  
    return weightLoadCell;
}