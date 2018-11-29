---
layout: post
title:  "Bora Watch v2 - Digital homemade wrist watch"
date:   2018-11-29 08:00 +0200
categories: atmega328 rtc clock diy
comments: true
youtube01: SHC-i1KxNCg
---

## Introduction
I've made a second version for my digital watch!

After the [first version](https://aherrero.github.io/arduino/iot/watch/2018/10/20/BoraWatch.html), I've discovered several things I could improve, being the most important the time precision (Improving with a RTC) and the battery life (The external oscillator with the RTC allows the microcontroller go to the sleep mode)

## Bill-Of-Materials
TODO

## PCB Design
In the first version I modify the design from the original project but this time, I've made my own design with [eagle](https://www.autodesk.com/products/eagle/overview) in order to include the RTC and also, because this time is entirely **Bora Watch** =D

This is the link for my [project in eagle](https://github.com/aherrero/TMR01v2_Watch/tree/master/Hardware/TMR1_v2)

If you don't know eagle before, EAGLE is a _scriptable electronic design automation (EDA) application with schematic capture, printed circuit board (PCB) layout, auto-router and computer-aided manufacturing (CAM) features_

The free version includes: 2 schematic sheets, 2 signal layers, and an 80cm2 board. So normally, could be enough for prototype and hobby.

There are many solutions for schematics and PCB design but, why I choose Eagle?

First, the free solution. Even if it is not open source any more, it is enough for my purpose. With the same idea, I could choose [Kicad](http://kicad-pcb.org/)

Then, the functionality without network connection, unlike some programs like [Altium](https://www.altium.com/).

And finally, it is supported for my favorite manufacturer [sparkfun](https://www.sparkfun.com/) where all their designs have a project with eagle free for download and ready if you want to use it.

And lot of tutorials!
- https://learn.sparkfun.com/tutorials/how-to-install-and-setup-eagle
- https://learn.sparkfun.com/tutorials/using-eagle-board-layout
- https://learn.sparkfun.com/tutorials/using-eagle-schematic

### Schematics

![sch1.png](/assets/tmr01_v2/sch1.png)

[The schematic in pdf](https://github.com/aherrero/TMR01v2_Watch/blob/master/Hardware/TMR1_v2/TMR1_v2_Schematic.pdf)

The schematics is pretty simple:
- Leds with the resistor
- Microcontroller Atmega328P
- RTC with 32.768 Oscillator.
- Battery CR2032 with the capacitor.
- Push button for displaying the time
- Test point for programming (ISP programming)
- And just on top, J1-J4, they are only connectors I am going to use to tie the watch strap so, no electrical functionality.

### Board

| Top layer| Bottom layer|
|-------|--------|
| ![PCB_Front.JPG](/assets/tmr01_v2/board1.png) | ![PCB_Back.JPG](/assets/tmr01_v2/board2.png) |

The board in pdf, [top layer](https://github.com/aherrero/TMR01v2_Watch/raw/master/Hardware/TMR1_v2/TMR1_v2_PCB_Top.pdf) and [bottom layer](https://github.com/aherrero/TMR01v2_Watch/blob/master/Hardware/TMR1_v2/TMR1_v2_PCB_Bottom.pdf)


### Order
Once you generate the gerbers ([Gerbers](https://github.com/aherrero/TMR01v2_Watch/blob/master/Hardware/TMR1_v2/TMR1_v2_2018-11-29.zip) from my watch) you can order in some manufacture, the PCB.

- [Seeedstudio](https://www.seeedstudio.com/). This time, I choose this manufacturer for the PCBs. They even have a tutorial about [how to generate](http://support.seeedstudio.com/knowledgebase/articles/1176949-how-to-generate-gerber-file-from-eagle) the gerbers according to their specification.
Cost: $4.90 each 10 PCBs and $11.27 deliver to EU. Delivering time: TODO FROM 14 NOV
- [jlcpcb](https://jlcpcb.com/) The last time I order here. The cost was $2 each 10 PCBs, and shipping $6.15. Deliver time: Around 3 weeks.

The differences between them for the moment is, seeedstudio seems more serious and they allow to manufacture PCB with other colors of PCB without extra cost. On the other hand, I don't know if it is worth it compeering the price.

## Soldering
[image small component...]
[process with soldering paste]

## Software
### Code

### Bootloader

### Programming

## Final results

***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
