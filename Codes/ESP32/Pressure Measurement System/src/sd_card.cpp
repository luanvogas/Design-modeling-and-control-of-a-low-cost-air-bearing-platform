#include "sd_card.h"
#include "analog.h"

//See: https://esp32io.com/tutorials/esp32-sd-card
//     https://deguez07.medium.com/esp32-with-sd-card-modules-the-master-guide-5d391f6785d7

File sdFile;

// Checking if the SD card is inserted
bool isSdCardConnected = false;

void openSdCard()
{
  sdFile = SD.open("/data.csv", FILE_WRITE);
}

void closeSdCard()
{
  sdFile.close();
}

void initSdCard()
{
  if (!SD.begin(pinCsSdCard)) {
    Serial.println("SD Card not connected!");
    isSdCardConnected = false;
    return;
  }

  openSdCard();
  if (sdFile) 
  {
    Serial.println("File on SD Card opened successfully!");
    isSdCardConnected = true;
  }
  else 
    Serial.println("Failed to open file on SD Card!");
  closeSdCard();

}

void savePressureSdCard()
{ 
  readPressureSensor();
  sdFile.print(xTaskGetTickCount());
  sdFile.print(", ");
  sdFile.print(pressurePsi);
  sdFile.print("\n");
}





