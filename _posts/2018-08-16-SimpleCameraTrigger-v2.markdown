---
layout: post
title:  "Simple Camera Trigger - v2"
date:   2018-08-14 08:00 +0200
categories: arduino iot
comments: true
---

# Introduction
In the [latest version](https://aherrero.github.io/arduino/iot/2018/08/14/SimpleCameraTrigger.html), we had a functional prototype to control the camera through IR and an Arduino for controlling the time of the trigger.

## Elements of the fast prototype
- Original coin cell separated of the main power (I didn't know if the current from the Arduino could be enough).
- An Arduino UNO (Which we could change for an Arduino Pro Mini, for lower current consummation proposes)
- The Arduino connected to the PC (We want to have an standalone application, with a battery)
- A simple BJT to control the power supply. The BJT could, theoretically, works as an electronic switch, but for real, sometimes there is some current passing through Collector-Emitter, so, the BJT could trigger accidentally when we don't want. Solution: Use a specific MOSFET for this kind of situation.

## Projects improvements
- A single battery which could be able to power both Arduino and the remote control.
- The battery could be a Lipo with 1 cell, which means, 3.7V.
    - For the Arduino Pro Mini, we could use the raw voltage input, which it is able to admit between 3.3 and 12V.
    - The remote control needs 3V
- Even if is not much, we could regulate the voltage with something.
- We could add Buttons to select the timing/period of the trigger
- We could use a display (7 segments, 4 x 7 segments, LCD) to show the information of the timing programmed, or we could use even leds to indicate the status of the timing (Depends of current consummation calculation).
- A [great tool](http://fritzing.org/home/) to draw the schematics in high level

# Arduino Pro Mini
[!Pinout](/assets/cam01/arduino-pinout.jpg)
[Pdf](https://cdn.sparkfun.com/datasheets/Dev/Arduino/Boards/ProMini8MHzv1.pdf)

# Powering
## Battery
I have two kind of batteries,

![power1](/assets/cam01/power1.jpg)
[Buy from sparkfun](https://www.sparkfun.com/products/13851)

or

![power2](/assets/cam01/power2.jpg)
[Buy from hobby king](https://hobbyking.com/en_us/zippy-flightmax-1800mah-3s1p-20c.html?___store=en_us)

Normally, the lipo batteries are for RC planes, car, etc. This is way, we have high current and big capacity.
A small calculator of our needs [here](http://multicopter.forestblue.nl/lipo_need_calculator.html)

## Voltage regulator
In the past, I've used voltage regulator to [convert to 5V](https://www.sparkfun.com/products/107), or even more stable regulators from pololu [here](https://www.pololu.com/product/2562) and [here](https://www.pololu.com/product/2119) but in this case, we need something more specific, and even less than the typical 3.3V. We introduce the [LM317](https://www.onsemi.com/pub/Collateral/LM317-D.PDF) or the [LD1117](https://www.sparkfun.com/datasheets/Components/LD1117V33.pdf).

I've bought this regulator because it is possible also to regulate the current with them, but in this case, it is a great oportunity to use as voltage regulator.

I've found this [schema](https://microcontrollerelectronics.com/lm317-3-3v-source/),
![lm317_schema.png](/assets/cam01/lm317_schema.png)

which it's nice, because we have the capacitor to improve the stability of the current, and we have even [this calculator](http://www.reuk.co.uk/wordpress/electric-circuit/lm317-voltage-calculator/) to calculate the resistor for our desired output voltage.

## Low Powering
Talking about low powering, here we have some tips to reduce the current consumation
[here](http://www.home-automation-community.com/arduino-low-power-how-to-run-atmega328p-for-a-year-on-coin-cell-battery/) and [here](https://www.gammon.com.au/power)

# Remote Control switch
I'm going to use the same mosfet I've use to control 12/24V from Arduino. But, in this case, it is not critical because we are going to control the 3.7V from the Lipo.

[IRF540N](https://www.infineon.com/dgdl/irf540n.pdf?fileId=5546d462533600a4015355e396cb199f)

And, in this case, instead of control a [motor](http://bildr.org/2012/03/rfp30n06le-arduino/), it will be the remote control.

# HMI (Human Machine Interface)

## Button
[Buttons](https://www.arduino.cc/en/Tutorial/Button)

## Display
[4 digits 7 segments](https://www.hackster.io/SAnwandter1/programming-4-digit-7-segment-led-display-2d33f8)
[7 segments](https://www.allaboutcircuits.com/projects/interface-a-seven-segment-display-to-an-arduino/)
[7 segments](http://elcajondeardu.blogspot.com/2014/04/display-de-7-segmentos-1-digito.html)

# Schema
![quickSchema.jpg](/assets/cam01/quickSchema.jpg)

***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
