#include "motors.h"
#include "driver/mcpwm.h"
#include "soc/mcpwm_periph.h"
#include "hid.h"

// https://www.arduinoecia.com.br/como-usar-pcf8574-expansor-de-portas-i2c/
// https://lastminuteengineers.com/esp32-pwm-tutorial/#:~:text=The%20ESP32's%20PWM%20resolution%20can,(216)%20different%20levels.


uint32_t pwmFrequencyAllMotors = 1e5; // 100 kHz
unsigned long int resolution = 1e7; // 10 MHz -> (10M / 100k = 100 divisions)

void pwmMotor1Init()
{
    mcpwm_timer_set_resolution(MCPWM_UNIT_0, MCPWM_TIMER_0, resolution);

    mcpwm_gpio_init(MCPWM_UNIT_0, MCPWM0A, pinPwmMotor1);
    mcpwm_config_t pwmConfigMotor1;
    pwmConfigMotor1.frequency = pwmFrequencyAllMotors;  
    pwmConfigMotor1.cmpr_a = 0;                           
    pwmConfigMotor1.cmpr_b = 0;                          
    pwmConfigMotor1.counter_mode = MCPWM_UP_COUNTER;
    pwmConfigMotor1.duty_mode = MCPWM_DUTY_MODE_0;
    mcpwm_init(MCPWM_UNIT_0, MCPWM_TIMER_0, &pwmConfigMotor1);
}

void pwmMotor2Init()
{
    
    mcpwm_timer_set_resolution(MCPWM_UNIT_0, MCPWM_TIMER_1, resolution);

    mcpwm_gpio_init(MCPWM_UNIT_0, MCPWM1A, pinPwmMotor2);
    mcpwm_config_t pwmConfigMotor2;
    pwmConfigMotor2.frequency = pwmFrequencyAllMotors;    
    pwmConfigMotor2.cmpr_a = 0;                           
    pwmConfigMotor2.cmpr_b = 0;                           
    pwmConfigMotor2.counter_mode = MCPWM_UP_COUNTER;
    pwmConfigMotor2.duty_mode = MCPWM_DUTY_MODE_0;
    mcpwm_init(MCPWM_UNIT_0, MCPWM_TIMER_1, &pwmConfigMotor2);
}

void pwmMotor3Init()
{
    mcpwm_timer_set_resolution(MCPWM_UNIT_0, MCPWM_TIMER_2, resolution);

    mcpwm_gpio_init(MCPWM_UNIT_0, MCPWM2A, pinPwmMotor3);
    mcpwm_config_t pwmConfigMotor3;
    pwmConfigMotor3.frequency = pwmFrequencyAllMotors;   
    pwmConfigMotor3.cmpr_a = 0;                           
    pwmConfigMotor3.cmpr_b = 0;                           
    pwmConfigMotor3.counter_mode = MCPWM_UP_COUNTER;
    pwmConfigMotor3.duty_mode = MCPWM_DUTY_MODE_0;
    mcpwm_init(MCPWM_UNIT_0, MCPWM_TIMER_2, &pwmConfigMotor3);
}

void pwmMotor4Init()
{
    mcpwm_timer_set_resolution(MCPWM_UNIT_1, MCPWM_TIMER_0, resolution);

    mcpwm_gpio_init(MCPWM_UNIT_1, MCPWM0A, pinPwmMotor4);
    mcpwm_config_t pwmConfigMotor4;
    pwmConfigMotor4.frequency = pwmFrequencyAllMotors;   
    pwmConfigMotor4.cmpr_a = 0;                           
    pwmConfigMotor4.cmpr_b = 0;                           
    pwmConfigMotor4.counter_mode = MCPWM_UP_COUNTER;
    pwmConfigMotor4.duty_mode = MCPWM_DUTY_MODE_0;
    mcpwm_init(MCPWM_UNIT_1, MCPWM_TIMER_0, &pwmConfigMotor4);
}

void pwmMotor5Init()
{
    mcpwm_timer_set_resolution(MCPWM_UNIT_1, MCPWM_TIMER_1, resolution);

    mcpwm_gpio_init(MCPWM_UNIT_1, MCPWM1A, pinPwmMotor5);
    mcpwm_config_t pwmConfigMotor5;
    pwmConfigMotor5.frequency = pwmFrequencyAllMotors;   
    pwmConfigMotor5.cmpr_a = 0;                           
    pwmConfigMotor5.cmpr_b = 0;                           
    pwmConfigMotor5.counter_mode = MCPWM_UP_COUNTER;
    pwmConfigMotor5.duty_mode = MCPWM_DUTY_MODE_0;
    mcpwm_init(MCPWM_UNIT_1, MCPWM_TIMER_1, &pwmConfigMotor5);
}

void pwmMotor6Init()
{
    mcpwm_timer_set_resolution(MCPWM_UNIT_1, MCPWM_TIMER_2, resolution);

    mcpwm_gpio_init(MCPWM_UNIT_1, MCPWM2A, pinPwmMotor6);
    mcpwm_config_t pwmConfigMotor6;
    pwmConfigMotor6.frequency = pwmFrequencyAllMotors;   
    pwmConfigMotor6.cmpr_a = 0;                           
    pwmConfigMotor6.cmpr_b = 0;                           
    pwmConfigMotor6.counter_mode = MCPWM_UP_COUNTER;
    pwmConfigMotor6.duty_mode = MCPWM_DUTY_MODE_0;
    mcpwm_init(MCPWM_UNIT_1, MCPWM_TIMER_2, &pwmConfigMotor6);    
}

void disableHBridges()
{     
    Wire.beginTransmission(32);
    Wire.write(0b00000000);
    Wire.endTransmission();
}

void pwmInit()
{   
    Wire.begin();  

    disableHBridges();

    pwmMotor1Init();  
    pwmMotor2Init();
    pwmMotor3Init();
    pwmMotor4Init();
    pwmMotor5Init();
    pwmMotor6Init();

    setPwmMotor1(0);
    setPwmMotor2(0);
    setPwmMotor3(0);
    setPwmMotor4(0);
    setPwmMotor5(0);
    setPwmMotor6(0);      
}

void setPwmMotor1(float dutyPwmMotor1)
{
    mcpwm_set_duty(MCPWM_UNIT_0, MCPWM_TIMER_0, MCPWM_OPR_A, dutyPwmMotor1);
}

void setPwmMotor2(float dutyPwmMotor2)
{
    mcpwm_set_duty(MCPWM_UNIT_0, MCPWM_TIMER_1, MCPWM_OPR_A, dutyPwmMotor2);
}

void setPwmMotor3(float dutyPwmMotor3)
{
    mcpwm_set_duty(MCPWM_UNIT_0, MCPWM_TIMER_2, MCPWM_OPR_A, dutyPwmMotor3);
}

void setPwmMotor4(float dutyPwmMotor4)
{
    mcpwm_set_duty(MCPWM_UNIT_1, MCPWM_TIMER_0, MCPWM_OPR_A, dutyPwmMotor4);
}

void setPwmMotor5(float dutyPwmMotor5)
{
    mcpwm_set_duty(MCPWM_UNIT_1, MCPWM_TIMER_1, MCPWM_OPR_A, dutyPwmMotor5);
}

void setPwmMotor6(float dutyPwmMotor6)
{
    mcpwm_set_duty(MCPWM_UNIT_1, MCPWM_TIMER_2, MCPWM_OPR_A, dutyPwmMotor6);
}

void setMotorDirection(bool enable, bool d1, bool d2, bool d3, bool d4, bool d5, bool d6)
{
    bool bit0 = enable;
    bool bit1 = d1;
    bool bit2 = d2;
    bool bit3 = d3;
    bool bit4 = d4;
    bool bit5 = d5;
    bool bit6 = d6;
    bool bit7 = 0;

    Wire.beginTransmission(32);
    Wire.write(bit7 << 7 | bit6 << 6 | bit5 << 5 | bit4 << 4 | bit3 << 3 | bit2 << 2 | bit1 << 1 | bit0 << 0);
    Wire.endTransmission(); 
}

void disableAllMotors()
{
    setPwmMotor1(0);
    setPwmMotor2(0);
    setPwmMotor3(0);
    setPwmMotor4(0);
    setPwmMotor5(0);
    setPwmMotor6(0);
}

void tractorOperationMode()
{
    setMotorDirection(1,0,0,1,1,1,0); 
}

void pusherOperationMode()
{
    setMotorDirection(1,1,1,0,0,0,0); 
}

