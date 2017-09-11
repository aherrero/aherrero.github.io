---
layout: post
title:  "IoT Automatic Plant Watering - Part 1"
date:   2017-06-17 08:00 +0200
categories: arduino iot
---

# IoT Automatic Plant Watering - Part 1

The goal of this project is to automate the plant watering, measuring the soil moisture and activating the pump motor if the plant needs water.

<b>[UPDATE] Second prototype with limit current protection, here</b>

## Prototype v0.1.1

![alt text](/assets/IoTAutomaticPlantWatering_v0.1.0/complete.JPG)

## Material used
- [Arduino Pro Mini 5V](https://www.sparkfun.com/products/11113)
- [Soil Moisture Sensor](https://www.sparkfun.com/products/13322)
- Mosfet [IRF540N](https://www.infineon.com/dgdl/irf540n.pdf?fileId=5546d462533600a4015355e396cb199f)
- Resistor 10k
- [UBec](https://hobbyking.com/en_us/hobbykingtm-micro-ubec-3a-5v.html?___store=en_us)
  - 11.1V to 5V
- [Lipo 1800mAh](https://hobbyking.com/en_us/turnigy-1800mah-3s-20c-lipo-pack.html)
  - 11.1V
  - 20C
- [Pump motor](https://www.amazon.fr/dp/B008OCZUK6/ref=pe_3044141_189395771_TE_3p_dp_1)
  - Input DC 3.5-9V, 1-3W
  - Hmax 0.4-1.5m
  - Qmax 200L/H

## Instructions
### Pump motor control
The first problem is control the pump motor, which needs 3.5 to 9V of input and up to 3W. This means, we will need an extra power supply which doesn't come from the Arduino (Arduino gives an ouput of 5V, which could be fine, but a current of XXmA).

As an external power supply, <b>we should use another power supply than a Lipo</b>, because the Lipo batteries give so much current. But if you don't have anything similar at home...

This is the circuit:

![alt text](/assets/IoTAutomaticPlantWatering_v0.1.0/mosfetControl.png)

More information: [http://bildr.org/2012/03/rfp30n06le-arduino/](http://bildr.org/2012/03/rfp30n06le-arduino/)

### Read the soil moisture sensor
We can read this sensor as any other analogic sensor.

[https://www.arduino.cc/en/Tutorial/ReadAnalogVoltage](https://www.arduino.cc/en/Tutorial/ReadAnalogVoltage)

The difficulty, you should "calibrate" the sensor, measuring when the plant needs water.

The threshold for me was 800 (from a 1024 ADC values)

Also, if you are going to use the system outside, you probably want cover the sensor from the water:

![alt text](/assets/IoTAutomaticPlantWatering_v0.1.0/moisturesensor.JPG)

### Power
The ubec was used to reduce the voltage from the Lipo (11V-12V) to 5V. Although the Arduino accepts 5V, it's the input limit, so, just in case.

The ubec has in the inputs the lipo, and the output the Arduino.

The lipo is connected directly to the pump motor (Reminder, the pump motor input voltage should not pass the 9V) so, we use the PWM to "limit" the voltage (This means, the PWM that normally can write from 0 to 255, we won't use the 255)

### Code

```
#include <LowPower.h>       //Library to sleep the micro

/*
 * Input/Output
 */

int inMoistureSensor = 1;    //Analog: Read Sensor
int pinOnMoistureSensor = 2; //Digital: on/off sensor
int outControl = 3;          //PWM Digital: Motor output
int pinInternalLed = 13;     //Digital: Led output (internal) used as indicator

/*
 * Var
 */

int motorSpeed = 255;

/*
 * Functions
 */

int getMoistureValue()
{
  // sensor temperature
  int sensorMoisture = analogRead(inMoistureSensor);
  //Serial.print(sensorMoisture); Serial.println(" raw value.");
  return sensorMoisture;
}

/*
 * setup()
 */
void setup()
{
  Serial.begin(9600);                   //Start the serial connection with the computer

  pinMode(pinOnMoistureSensor, OUTPUT); //pin to power on the sensor
  pinMode(outControl, OUTPUT);          //pin to control de pump motor

  pinMode(pinInternalLed, OUTPUT);      //led to show if the pump motor is working
}


/*
 * loop()
 */
void loop()                     // run over and over again
{
  //Show the micro wakes up
  digitalWrite(pinInternalLed, HIGH);

  //Power on the moisture Sensor
  digitalWrite(pinOnMoistureSensor, HIGH);
  delay(100);

  //Read Sensor
  int sensorMoisture = getMoistureValue();

  //Action
  int firstAction = 0;
  while(sensorMoisture < 800)   //emperic value to determinate if the plant needs water
  {
    //Notify the pump motor is running with blink
    digitalWrite(pinInternalLed, LOW);
    delay(100);

    //Run pump motor
    if(firstAction == 0)
    {
      analogWrite(outControl, motorSpeed);
      firstAction = 1;
    }

    //Update sensor value
    sensorMoisture = getMoistureValue();

    //Blink
    digitalWrite(pinInternalLed, HIGH);
    delay(100);
  }

  //Power off pump motor
  analogWrite(outControl, 0);

  //Show the micro is going to wait
  digitalWrite(pinInternalLed, LOW);

  //Power off the moisture Sensor
  digitalWrite(pinOnMoistureSensor, LOW);
  delay(100);

  //Main Sleep
  delay(2000);

  //Sleep for 8s
  //LowPower.powerDown(SLEEP_8S, ADC_OFF, BOD_OFF);
}

```

### Results
It seems it's working, the sensor read the moisture, and when the mositure has a level less than "800" as an input raw value, the pump motor start to work. Otherwise, the Arduino sleeps until the next interaction to read the value.

## Prototype v0.1.2

In this prototype, we use the same circuit but, as the intention is to work outside, this circuit will be "less" prototyping.

![alt text](/assets/IoTAutomaticPlantWatering_v0.1.1/complete.JPG)

More in detail

![alt text](/assets/IoTAutomaticPlantWatering_v0.1.1/detail.JPG)

And from the back,

![alt text](/assets/IoTAutomaticPlantWatering_v0.1.1/back.JPG)


# Conclusion
The complete circuit seems to work.. Until the pump motor crash. Different solutions have though about that:
- There is no diode between the positive and negative of the pump motor. The diode should helps to avoid the reverse voltage when we stop the motor.
- The current is too high. Remember, the power supply used for all the circuit is a Lipo, and the Lipo battery will give us as much as current as we want. If the pump motor hasn't a curret limiter, which probably has not, we are the responsible to limit this current in another way.

## Possible improvements
- Diode between positive and negative in the pump motor.
- Current limiter with a motor controller type [L298N](https://www.sparkfun.com/datasheets/Robotics/L298_H_Bridge.pdf). The problem with that is, we don't need run the motor in the opposite direction and the motor may consume more than the motor controller can give us.
- Current limiter with [LM317](http://www.ti.com/lit/ds/symlink/lm317.pdf). It seems a good idea, and the circuit is simple to make. ![alt text](/assets/IoTAutomaticPlantWatering_v0.1.1/lm317Circuit.png). The problem, I don't have a resitor so low to limit the current until the level that I want. More information, [http://www.ti.com/lit/ds/symlink/lm317.pdf](http://www.ti.com/lit/ds/symlink/lm317.pdf) and [http://www.techlib.com/electronics/regulators.html](http://www.techlib.com/electronics/regulators.html)
- Current limiter with [L7812](https://www.sparkfun.com/products/12766). The circuit will be ![alt text](/assets/IoTAutomaticPlantWatering_v0.1.1/7812Circuit.png). It seems the best solution. For the next interation.

[Link to project](https://github.com/aherrero/IoTAutomaticPlantWatering)
