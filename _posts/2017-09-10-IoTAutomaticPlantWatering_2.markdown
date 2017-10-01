---
layout: post
title:  "IoT Automatic Plant Watering - v2"
date:   2017-09-10 08:00 +0200
categories: arduino iot
---

# IoT Automatic Plant Watering - v2

The goal of this project is to automate the plant watering, measuring the soil moisture sensor and activating the pump motor if the plant needs water.

The arduino will sleep 24 hours, then the sensor will read the value, and it will activate the pump motor if needed. Then, the microcontroller will sleep again.

[...] Picture of the complete project...

## Prototype v1.1

![alt text](/assets/IoTAutomaticPlantWatering_v1.1/complete.JPG)

## Material used
- [Arduino Uno](https://www.sparkfun.com/products/11021)
- [Soil Moisture Sensor](https://www.sparkfun.com/products/13322)
- Mosfet [IRF540N](https://www.infineon.com/dgdl/irf540n.pdf?fileId=5546d462533600a4015355e396cb199f)
- 2 x Resistor 10k
- [Diode](https://www.sparkfun.com/products/8589)
- 4 x [Capacitor 0.1uF](https://www.sparkfun.com/products/8375)
- [Lipo 1800mAh](https://hobbyking.com/en_us/turnigy-1800mah-3s-20c-lipo-pack.html)
  - 11.1V
  - 20C
- [L7812](https://www.sparkfun.com/products/12766)
  - Current Limiter to not overfeed the Arduino and the Pump Motor
- [Pump motor](https://www.amazon.fr/Submersible-Aquarium-Fountain-Pump-simulate-Environment/dp/B008OCZUK6)
  - Input DC 3.5-9V, 3W

## Instructions
### Pump motor control
The first problem is control the pump motor, which needs between 3.5 to 9V of input and up to 3W. This means, we will need an extra power supply which doesn't come from the Arduino (Arduino gives an ouput of 5V, which could be fine, but a current between [40-200mA](https://playground.arduino.cc/Main/ArduinoPinCurrentLimitations)).

As an external power supply, <b>we should use another power supply than a Lipo</b>, because the Lipo batteries give so much current. But if you don't have anything similar at home...

The circuit to control the Pump Motor is through a mosfet IRF540N, where the mosfet give the current coming from the power supply to the motor depending of a control in the Arduino (PWM)

This is the circuit:

![alt text](/assets/IoTAutomaticPlantWatering_v0.1/mosfetControl.png)

More information: [http://bildr.org/2012/03/rfp30n06le-arduino/](http://bildr.org/2012/03/rfp30n06le-arduino/)

### Current Limiter - Power Supply
The full circuit is powered by a Lipo, but with the current controlled, to avoid to break some electronics.

The circuit will be:

![alt text](/assets/IoTAutomaticPlantWatering_v0.2/7812Circuit.png)

If we connect the Lipo (Around 12V) in Vi, and we take a R1 resistor of 10k, this should give us approximatelly up to 1.2A (enough to protect our circuits).

Instead of use a 0.33uF capacitor, we can use three 0.1uF capacitor in parallel.

From the output of this power supply, we feed the Arduino directly from this output to the Vin pin in Arduino.
On the other hand, from the same output, we feed the pump motor thought the mosfet, so we connect the ouput of this current limiter to the mosfet.

### Read the soil moisture sensor
We can read this sensor as any other analogic sensor.

[https://www.arduino.cc/en/Tutorial/ReadAnalogVoltage](https://www.arduino.cc/en/Tutorial/ReadAnalogVoltage)

The difficulty, you should "calibrate" the sensor, measuring when the plant needs water.

The threshold for me was 800 in raw value (from a 1024 ADC values)

Also, if you are going to use the system outside, you probably want cover the sensor from the water:

![alt text](/assets/IoTAutomaticPlantWatering_v0.1/moisturesensor.JPG)

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

## Prototype v1.2
PCB...


[Link to the Git Project](https://github.com/aherrero/IoTAutomaticPlantWatering)
