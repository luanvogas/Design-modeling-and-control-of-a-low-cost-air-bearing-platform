#include "i2c.h"
#include "message.h"
#include "gpios.h"

/*
I2C Device Addresses

0x1E => HMC5883L (3-Axis Magnetometer)
0x53 => ADXL345 (3-Axis Accelerometer)
0x68 => ITG3205 (3-Axis Gyroscope)
*/

// Gyroscope
#define gyroAddress 0x68

void gyroscopeInit()
{
  // Configure DLPF (Digital Low Pass Filter) and full scale range
  Wire.beginTransmission(gyroAddress);
  Wire.write(0x16); // DLPF_FS register
  Wire.write(0x18); // 0x18 = 0b00011000 => Full scale = ±2000°/s, DLPF_CFG = 0 (256Hz LPF, 8kHz internal sample rate)
  Wire.endTransmission();

  // Configure sample rate divider
  Wire.beginTransmission(gyroAddress);
  Wire.write(0x15); // SMPLRT_DIV register
  Wire.write(0);    // Sample rate = 8kHz / (0 + 1) = 8kHz
  Wire.endTransmission();

  // Configure power management (recommended: use internal oscillator)
  Wire.beginTransmission(gyroAddress);
  Wire.write(0x3E); // PWR_MGM register
  Wire.write(0x00); // Use internal oscillator, normal mode
  Wire.endTransmission();
}

void gyroscopeRead()
{
  // Based on: https://portal.vidadesilicio.com.br/sensor-movimento-cabeca/
  // and https://learn.sparkfun.com/tutorials/itg-3200-hookup-guide/all 

  int16_t gyroX = 0;
  int16_t gyroY = 0;
  int16_t gyroZ = 0;

  bool validReading = false;

  while (validReading == false)
  {
    Wire.beginTransmission(gyroAddress);
    Wire.write(0x1D); // Address of the register you want to start reading
    Wire.endTransmission();
  
    Wire.requestFrom(gyroAddress, 6); // Waits for a sequence of 6 registers to be read, starting from the previously indicated one
    
    if(6 <= Wire.available())
    {
      gyroX = Wire.read()<<8; 
      gyroX |= Wire.read(); 
      gyroY = Wire.read()<<8; 
      gyroY |= Wire.read(); 
      gyroZ = Wire.read()<<8; 
      gyroZ |= Wire.read();       
    }

    if((gyroX != 0) && (gyroY != 0) && (gyroZ != 0))
      validReading = true;    
    else
      Serial.println("Trying to acquire valid gyroscope data...");
  }

  txMsg.msgs[whoAmI - 1].msgImuGyroX = gyroX;
  txMsg.msgs[whoAmI - 1].msgImuGyroY = gyroY;
  txMsg.msgs[whoAmI - 1].msgImuGyroZ = gyroZ;
 
}

