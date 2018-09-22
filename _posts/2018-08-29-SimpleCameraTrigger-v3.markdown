---
layout: post
title:  "Simple Camera Trigger - v3"
date:   2018-08-29 08:00 +0200
categories: arduino iot
comments: true
---

# Introduction
In the [latest version](https://aherrero.github.io/arduino/iot/2018/08/16/SimpleCameraTrigger-v2.html), we've tried to use the remote controlled [bought in amazon](https://www.amazon.fr/IR-Telecommande-TOOGOO-Cameras-Compact/dp/B01G37SVXG/ref=sr_1_2?ie=UTF8&qid=1534395448&sr=8-2&keywords=telecommande+sony+camera) to control the camera, using an Arduino.

But something doesn't work about this remote control and I wasn't able to interact with this PCB from the Arduino.

So, the project is going to be simpler (HW technically talking) with only an IR Led for controlling the camera and the Arduino's library [IR Remote](https://github.com/z3t0/Arduino-IRremote)

Button
Simple
https://www.arduino.cc/en/tutorial/pushbutton

State change detection
https://www.arduino.cc/en/Tutorial/StateChangeDetection

Array in Arduino...
https://www.arduino.cc/reference/en/language/variables/data-types/array/

Arduino library
https://playground.arduino.cc/Code/Button
https://github.com/tigoe/Button

https://www.elprocus.com/pull-up-and-pull-down-resistors-with-applications/ (Concept button pull up)

Class C++ in Arduino
http://polygondoor.com.au/creating-classes-in-c-for-arduino/
https://www.arduino.cc/en/Hacking/LibraryTutorial (concept libray as a class)

Timer
https://www.arduino.cc/reference/en/language/functions/time/millis/

External interrupts
https://www.arduino.cc/reference/en/language/functions/external-interrupts/attachinterrupt/
https://www.allaboutcircuits.com/technical-articles/using-interrupts-on-arduino/

Arduino thread. neccesary?

https://www.arduinolibraries.info/libraries/arduino-thread
https://www.hackster.io/reanimationxp/how-to-multithread-an-arduino-protothreading-tutorial-dd2c37
https://github.com/ivanseidel/ArduinoThread

Camera - Tips for battery saving

https://timfordphoto.com/sony-a7-battery-saving-tips/

Git personal with project...
https://github.com/aherrero/CAM01_SimpleCameraTrigger

***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
