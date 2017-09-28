---
layout: post
title:  "Arcade game with TM4C123G Launch Pad"
date:   2015-08-28 08:00 +0200
categories: microcontroller ti
---

# Arcade Game with TM4C123G Microcontroller

In this project, I've developed a little arcade game using all the knowledge acquired in the [edX Embedded System course](https://www.edx.org/course/embedded-systems-shape-world-utaustinx-ut-6-02x)

I've used the [TM4C123G LaunchPad](http://www.ti.com/tool/EK-TM4C123GXL?DCMP=stellaris-launchpad&HQS=tm4c123g-launchpad) based in ARM Cortex microcontroller from Texas Instruments.

![tmc123g](http://users.ece.utexas.edu/~valvano/arm/portfolio/fulls/pic02.jpg)

It is a funny platform where you have to consider all the registers, you must open the ports and select the corresponding memory address to use a pin as input or output. Definitely, it’s a platform more difficult than [Arduino](https://www.arduino.cc/) because you will develop in a lower level.

The course uses a bottom-up approach to problem solving, building gradually from simple interfacing of switches and LEDs to complex concepts like display drivers, digital to analog conversion, generation of sound, analog to digital conversion, graphics, interrupts, and communication.

The course present both general principles and practical tips for building circuits and programming the microcontroller in the C programming language.

To obtain all the components, the professors of the course make a great description of the basic kit in their [web page](http://users.ece.utexas.edu/~valvano/edX/kit.html) and the [bill of material](http://www.element14.com/community/community/learning-center/online-learning/moocs/edxutexas-embedded/) from Farnell element14 is very useful also.

The evaluation software of Keil uVision4 for student can be obtain in their [web page](https://www.keil.com/demo/eval/armv4.htm) and the instructions to install in the [course web page](http://edx-org-utaustinx.s3.amazonaws.com/UT601x/download.html)

# TM4C123G microcontroller LaunchPad
We have all the documentation in the [TI web page](http://www.ti.com/tool/ek-tm4c123gxl)

## Inputs and outputs
As an example, for using input and output pins, it's necessary initialize an I/O port and instructions as

    #define PA5   (*((volatile unsigned long *)0x40004080))
    ...
    PA5 = 0x20;       // make PA5 high


## Switches and LEDs control
Selected the switch as input, the LEDs as output and choosing the port, we can build the hardware as follows

![switch btn](http://users.ece.utexas.edu/~valvano/Volume1/E-Book/C8_SwitchLEDv2_files/Figure8_4.jpg)

For test this hardware and software systems, I have developed a traffic light systems (Simulating two roads and a crosswalk), developing a state machine.

<iframe width="560" height="315" src="https://www.youtube.com/embed/CgPjV8hBAYk" frameborder="0" allowfullscreen></iframe>

[Link to GitHub Project](https://github.com/aherrero/EmbeddedSystems/tree/master/UT.6.02x/Lab10_TrafficLight)


## DAC - Digital-to-analog converter
The DAC is necessary if we want convert a digital signal from the microcontroller, to an analog system (For example, a sound). It’s necessary some knowledge about signal processing, but the result is a few electronics circuits (formed with resistors, for example) between the microcontroller output and the speaker in this case.
The music is produced with different frequencies in the microcontroller, selected for each note.

This is the result:
<iframe width="560" height="315" src="https://www.youtube.com/embed/McDHbQl84TI" frameborder="0" allowfullscreen></iframe>

## ADC - Analog-to-digital converter
It’s the opposite conversion, when you have a signal in the real world, and you want read the signal in the microcontroller.
Normally, the signals in the real world are analog signals, and we can read them with several sensors for several measures. In this case, I use a potentiometer for measure the distance.
In this case, it is not necessary any circuit extra because the TM4C123G LaunchPad microcontroller has included an ADC.
For show the measure, I have used a Nokia 5110 LCD display connected through the Synchronous Serial Interface or SSI modules.

This is the result:
<iframe width="560" height="315" src="https://www.youtube.com/embed/RZW5aqny9Gg" frameborder="0" allowfullscreen></iframe>

## Real Embedded System
Finally, I have joined all the systems to create an embedded system that can play a basic game.
<iframe width="560" height="315" src="https://www.youtube.com/embed/7BozoCaN9yg" frameborder="0" allowfullscreen></iframe>

[Link to project](https://github.com/aherrero/EmbeddedSystems/tree/master/UT.6.02x/Lab15_SpaceInvaders)
