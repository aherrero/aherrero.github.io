---
layout: post
title:  "Radio communication 433MHz with ATtiny85"
date:   2019-11-17 08:00 +0200
categories: arduino rf
comments: true
youtube01: jW19Q1njsn8

---

# Introduction

The goal of this small project is to test the radio modules at 433MHz and the ATTiny85, also know as _the mini arduino_, and avoiding as possible the ArduinoIDE in favor of the PlatformIO (Plugin for atom or Visual Studio Code).

![screenshot](/assets/images/sml/4.jpg)


# Material
- [433MHz radio transmitter and receiver](https://www.amazon.de/dp/B07DK3BGWZ)
- [ATtiny85 microcontroller](https://www.sparkfun.com/products/9378)
- 2 x [Pushbuton](https://www.sparkfun.com/products/9190)
- Anyway for power supply, e.g.: Connector to [micro usb](https://www.sparkfun.com/products/12035) or [L7805 Voltage regulator 5V](https://www.sparkfun.com/products/107)
- 1 x 0.33uF and 1 x 0.1uF capacitors if using voltage regulator L7805.
- 2 x 1k resistor
- 1 x 10uF capacitor if using Arduino for programming the ATtiny.

# Transmitter
First, the ATtiny microcontroller needs a new bootloader and a program.

To load the bootloader, we could use the ArduinoIDE with this [tutorial](https://create.arduino.cc/projecthub/arjun/programming-attiny85-with-arduino-uno-afb829) and the configuration: ATtiny85, 8MHz clock and using as programmer "Arduino as ISP".

![screenshot](/assets/images/sml/screenshot.png)

Make sure the pinout is correct in the [datasheet](http://ww1.microchip.com/downloads/en/DeviceDoc/atmel-2586-avr-8-bit-microcontroller-attiny25-attiny45-attiny85_datasheet.pdf)

![screenshot](/assets/images/sml/1.jpg)

Then, we could use PlatformIO for loading the new software, e.g.: the blink program, following this [tutorial from platformio](http://docs.platformio.org/en/latest/platforms/atmelavr.html#upload-using-programmer) to use Arduino as ISP.

An example of blink project configured for this attiny in [github](https://github.com/aherrero/SML/tree/master/SML01/Software/sml01)

After that, we could program the attiny with this [program](https://github.com/aherrero/SML/tree/master/SML01/Software/sml01_transmitter) which writes a square pulse of 2ms if no button is pressed, 1.5ms if button right is pressed and 1ms if button left is pressed. This will be our radio protocol for this project.

![pinout](/assets/images/sml/pinout.png)

Connect the 5V and the ground, then the left push button to the input 1 (pin6) and the right button to the input 2 (pin7). In the output 3 (pin2) from the microcontroller, will be the signal for the transmitter.

![screenshot](/assets/images/sml/2.jpg)

Connect the transmitter with this signal from the microcontroller, 5V and ground.

Then, simply connect VCC and ground to the micro usb interface, and then to a phone charger for example to the mains.

# Receiver
The receiver is quite simple; it's only the radio module receiver connected to VCC, gnd and to the analog3 from the Arduino Uno.

![screenshot](/assets/images/sml/3.jpg)

Then, the Arduino is connected to the computer via USB, for powering the Arduino side and for the serial communication.

The software used is in [github](https://github.com/aherrero/SML/tree/master/SML01/Software/sml01_receiver). If using ArduinoIDE for programming, make sure you change the programmer from "Arduino as ISP" with "AVRISP mkii"

The Arduino will count the milliseconds of the square length: If the length is around 1ms means the button left was pressed. If it is around 1.5ms, the right button. Otherwise, do nothing. The result will be printed in the serial port.

# Powering
To make the project portable (and due the radio communication will be normally portable), we could power the project with a battery 9V and using a voltage regulator to convert to 5V.

We will need:
- [L7805 Voltage regulator](https://www.sparkfun.com/products/107)
- 1 x [0.33 uF capacitor](https://www.distrelec.ch/en/aluminium-electrolytic-capacitor-330-nf-100-vdc-jamicon-tkpr33m2ad11me4/p/16716518)
- 1 x [0.1 uF capacitor](https://www.distrelec.ch/en/capacitor-100-nf-50-vdc-mm-hitano-sf1h104z-l515b/p/16565659)

A good tutorial to how to use this voltage regulator is [this one](https://www.electronicshub.org/understanding-7805-ic-voltage-regulator/)

A better one could be the [datasheet of the component.](https://cdn.sparkfun.com/datasheets/Components/General/TO-220.pdf)

![L7800_circuit_example](/assets/images/cam01/L7800_circuit_example.png)

Make sure in the datasheet the pinout is correct and the ouptut is 5V. Otherwise, you will burn your regulator and/or your micro.

# Final result
{% include youtubePlayer.html id=page.youtube01 %}

# References
- [Electronoobs](https://www.electronoobs.com/eng_arduino_tut45.php)
- [github](https://github.com/aherrero/SML/tree/master/SML01/)


***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
