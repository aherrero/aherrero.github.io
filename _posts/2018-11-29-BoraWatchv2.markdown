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

![2.JPG](/assets/images/tmr01_v2/bora2/4.JPG)

After the [first version](https://aherrero.github.io/arduino/iot/watch/2018/10/20/BoraWatch.html), I've discovered several things I could improve, being the most important the time precision (Improving with a RTC) and the battery life (The external oscillator with the RTC allows the microcontroller go to the sleep mode)

## Bill-Of-Materials
- 1 x PCB:
[GERBERS here](https://github.com/aherrero/TMR01_Watch/raw/master/v2/Hardware/TMR1_v2/TMR1_v2_2018-11-29.zip), [schematics and board](https://github.com/aherrero/TMR01_Watch/tree/master/v2/Hardware/TMR1_v2),
[Designed with eagle 9.2.2](https://www.autodesk.com/products/eagle/overview),
and [manufactured in seeedstudio](https://www.seeedstudio.com/fusion_pcb.html)
- 1 x ATMega328p-AU: [Amazon Atmega328p](https://www.amazon.fr/gp/product/B01N0DNQ78/ref=oh_aui_detailpage_o01_s00?ie=UTF8&psc=1). Bought here because my usual provider didn't have.
- 12 x [330R 0603 SMD resistors](https://www.distrelec.ch/en/smd-resistor-thick-film-330-ohm-0603-rnd-components-rnd-1550603saj0331t5e/p/30056701)
- 12 x [0603 SMD Red LED](https://www.distrelec.ch/en/smd-led-645-nm-red-0603-kingbright-kpg-1608surkc/p/30118904)
- 1 x [SMD Tactile Switch](https://www.distrelec.ch/en/tact-switch-with-ground-terminal-smt-black-wuerth-elektronik-431181015816/p/11087413)
- 4 x [10K 0603 SMD resistors](https://www.distrelec.ch/en/smd-resistor-thick-film-10-kohm-0603-rnd-components-rnd-1550603saj0103t5e/p/30056687)
- 1 x [100nF 0603 SMD capacitor](https://www.distrelec.ch/en/ceramic-capacitor-100-nf-25-vdc-0603-wuerth-elektronik-885012206071/p/30067831)
- 1 x [10uF 0805 SMD capacitor](https://www.distrelec.ch/en/ceramic-capacitor-10-uf-vdc-0805-rnd-components-rnd-1500805x106k063n3/p/30086816)
- 1 x [Battery Holder CR2032](https://www.distrelec.ch/en/battery-holder-br2020-cl2020-br2025-cr2025-dl2025-br2032-cr2032-dl2032-keystone-3002/p/16952527)
- 1 x [Quartz 32.768 kHz](https://www.distrelec.ch/en/quartz-smd-32-768-khz-iqd-lfxtal003004reel/p/17453012)
- 2 x [6.8pF 0805 SMD capacitor](https://www.distrelec.ch/en/ceramic-capacitor-pf-50-vdc-0805-rnd-components-rnd-1500805n6r8c500nt/p/30086810)
- 1 x [RTC MCP79410-I/SN SO-8](https://www.distrelec.ch/en/rtc-ic-so-microchip-mcp79410-sn/p/17380943)

**Tools**
- [Soldering Paste](https://www.distrelec.ch/en/soldering-paste-syringe-solder-chemistry-blf03-ch-de/p/18249570) and [needle](https://www.distrelec.ch/en/dosing-needle-58-mm-pink-pink-solder-chemistry-047031/p/18249574)
- [Heat gun](https://www.amazon.fr/gp/product/B01N0X1LFK/ref=oh_aui_detailpage_o00_s01?ie=UTF8&psc=1), although, I've realized that this one it wasn't powerful enough, but it was fine.
- [Velcro strip](https://www.amazon.fr/gp/product/B07DFBHN5J/ref=oh_aui_detailpage_o00_s01?ie=UTF8&psc=1)
- [AVR programmer](https://www.sparkfun.com/products/9825)

## PCB Design
In the first version I modify the design from the original project but this time, I've made my own design with [eagle](https://www.autodesk.com/products/eagle/overview) in order to include the RTC and also, because this time is entirely **Bora Watch brand** =D

This is the link for my [project in eagle](https://github.com/aherrero/TMR01_Watch/tree/master/v2/Hardware/TMR1_v2)

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

![sch1.png](/assets/images/tmr01_v2/sch1.png)

[The schematic in pdf](https://github.com/aherrero/TMR01_Watch/blob/master/v2/Hardware/TMR1_v2/TMR1_v2_Schematic.pdf)

The schematics is pretty simple:
- Leds with the resistor
- Microcontroller Atmega328P
- RTC with 32.768 Oscillator.
- Battery CR2032 with the capacitor.
- Push button for displaying the time
- Test point for programming (ISP programming)
- And just on top, J1-J4, they are only connectors I am going to use to tie the watch strap so, no electrical functionality.

I've also discover two problems in the schematics after ordering the pcb:
- According to the [atmega328 specification](http://ww1.microchip.com/downloads/en/devicedoc/atmega328_p%20avr%20mcu%20with%20picopower%20technology%20data%20sheet%2040001984a.pdf), the chip has ADC6 and ADC7 pins but I've realized they only work as input for voltage references, not as output, so, I can't use them to control the leds. I was forced to change this pins to SCK and MISO with cables. In the github, the schematics are now correct, but the gerbers were sent with this mistake.
- The footprint for the oscillator 32.768 wasn't correct for the oscillator I have. So, I have improvised something.

![atmega_schematics.png](/assets/images/tmr01_v2/bora2/atmega_schematics.png)

### Board

| Top layer| Bottom layer|
|-------|--------|
| ![PCB_Front.JPG](/assets/images/tmr01_v2/board1.png) | ![PCB_Back.JPG](/assets/images/tmr01_v2/board2.png) |

The board in pdf, [top layer](https://github.com/aherrero/TMR01_Watch/raw/master/v2/Hardware/TMR1_v2/TMR1_v2_PCB_Top.pdf) and [bottom layer](https://github.com/aherrero/TMR01_Watch/blob/master/v2/Hardware/TMR1_v2/TMR1_v2_PCB_Bottom.pdf)


### Order
Once you generate the GERBERS, you can send them to the manufacturer to print the PCB.

- [Seeedstudio](https://www.seeedstudio.com/). This time, I choose this manufacturer for the PCBs. They even have a tutorial about [how to generate](http://support.seeedstudio.com/knowledgebase/articles/1176949-how-to-generate-gerber-file-from-eagle) the gerbers, according to their specification, with eagle.
Cost: $4.90 each 10 PCBs and $11.27 deliver to EU (Total: $16,17). Delivering time: 24 days.
- [jlcpcb](https://jlcpcb.com/) The last time I ordered here. The cost was $2 each 10 PCBs, and shipping $6.15 (Total: $8.15) Deliver time: Around 21 days.

The differences between them for the moment are; Seeedstudio seems more serious and they allow to manufacture PCB with other colors of PCB without extra cost. On the other hand, I don't know if it is worth it compeering the price (Double than jlcpcb)

## Fast prototype
In the meantime waiting for the PCB arrives and in order to develop the software, I built a prototype, using the same atmega328 and same RTC MCP7940M

![proto.JPG](/assets/images/tmr01_v2/proto.JPG)

## Soldering
This time for soldering the atmega328, I have taken advantage of I am working in a electronics company for using a [soldering microscope](https://www.microscope.com/specialty-microscopes/soldering-microscopes/), so I could solder manually.

![1.JPG](/assets/images/tmr01_v2/bora2/1.JPG)

For the other components, as it was faster and I didn't need precision, I use again the soldering paste.

![3.JPG](/assets/images/tmr01_v2/bora2/3.JPG)

![2.JPG](/assets/images/tmr01_v2/bora2/2.JPG)

So, the final result,

| Top| Bottom|
|-------|--------|
| ![5.JPG](/assets/images/tmr01_v2/bora2/5.JPG) | ![6.JPG](/assets/images/tmr01_v2/bora2/6.JPG) |

## Software
You can find the software in [github](https://github.com/aherrero/TMR01_Watch/tree/master/v2/Software/TMR01v2)

### Bootloader
I've use the [MiniCore](https://github.com/MCUdude/MiniCore) library with Arduino to configure the fuses of the atmega, with the following configuration:

![arduino_config.png](/assets/images/tmr01_v2/bora2/arduino_config.png)

### Programming
As you may have seen, there are 6 setpoints at the bottom, to connect the ISP for programming. Finally, as I programmed several times to get it works, I solder the pins and then remove it.

May attention the sense of the pins with the schematics and your ISP cable (Detect for example the VCC, with the  battery, and compare the VCC with the cable)

## Final results
Once the velcro strip has been sewn,

![7.JPG](/assets/images/tmr01_v2/bora2/7.JPG)

And if I compare with the previous version,

![8.JPG](/assets/images/tmr01_v2/bora2/8.JPG)

## Improvements
Obviously, the first fix will be:
- Redesign the PCB with the ADC pins correctly.
- A correct oscillator or a correct footprint.

And then, another improvements I was thinking on:
- As I use one or maximum two led at the same time, we could use only one 330 ohm resistor in order to simplify the circuit.
- The footprint for the component 0402 (led, resistor and capacitor) is not correct in eagle, so, we could use this size of component if we fix the footprint.
- A nice enclosure printed in 3D, similar to [this project](https://hackaday.io/project/159919-binary-wrist-watch)

***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
