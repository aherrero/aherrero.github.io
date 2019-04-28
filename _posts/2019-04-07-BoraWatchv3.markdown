---
layout: post
title:  "Bora Watch v3 - Digital homemade wrist watch"
date:   2019-04-07 08:00 +0200
categories: atmega328 rtc clock diy
comments: true
youtube01: SHC-i1KxNCg
---

# [WORK IN PROGRESS...]

## Introduction
A third iteration of my watch!

As improvements compare with the [previous version](https://aherrero.github.io/atmega328/rtc/clock/diy/2018/11/29/BoraWatchv2.html), I did:

- The oscillator and RTC is now the same chip: A DS3231 RTC. Normally, this chip is an expensive a much dedicated chip for measuring the precise time, but I found it cheaper from China, and avoids the problem with the oscillator footprint. See my [quick test](https://aherrero.github.io/arduino/rtc/2019/02/26/RTC-DS3231.html) for this RTC.
- The software change in consequence with this new RTC.
- As normally the watch is going to use 1 o 2 leds at the same time, I've reduced the number of resistor to 1, instead of 12. It will be a difference of intensity if 1 or 2 leds are at the same time, but it is a risk worth it.
- And must important, a redesign PCB to fit in a real watch enclosure.
[todo picture enclosure]

## Bill-Of-Materials
- 1 x [ATMEGA328P-AU](https://www.aliexpress.com/item/ATMEGA328P-AU-QFP-ATMEGA328-AU-TQFP-ATMEGA328P-MEGA328-AU-SMD-new-and-original-IC-ATMEGA328P-U/32887927630.html?spm=a2g0s.9042311.0.0.27424c4d4zTc3I)
- 1 x [RTC DS3231SN](https://www.aliexpress.com/item/Real-Time-Clock-chip-10PCS-DS3231SN-DS3231-16-SOIC/32837219361.html?spm=a2g0s.9042311.0.0.74784c4dAOxq7w)
- 12 x [LED 0402 Blue](https://www.mouser.ch/ProductDetail/inolux/in-s42atb/?qs=qSfuJ%252bfl%2Fd44mcX80VSqfQ==&countrycode=CH&currencycode=CHF)
- 1 x [470k 0402](https://www.mouser.ch/ProductDetail/yageo/rc0402jr-13470rl/?qs=fPU49sp6fCK89krzeMh7Zw==&countrycode=CH&currencycode=CHF)
- 4 x [10k 0402](https://www.mouser.ch/ProductDetail/Panasonic/ERJ-U02D1002X?qs=sGAEpiMZZMu61qfTUdNhG%252B3%2FJaRAwRoXejmwl8ytQw4%3D)
- 1 x [100nF 0402](https://www.mouser.ch/ProductDetail/Wurth-Electronics/885012105010?qs=sGAEpiMZZMvsSlwiRhF8qunkWFWGyo%252BvtYKx4Fsahp4UKn5mJYOzhg%3D%3D)
- 1 x [Mini Pushbutton switch](https://www.sparkfun.com/products/8720) or https://www.sparkfun.com/products/10791
- 1 x [Battery holder CR2332](https://www.distrelec.ch/en/battery-holder-br2020-cl2020-br2025-cr2025-dl2025-br2032-cr2032-dl2032-keystone-3002/p/16952527)

### Tools
- [AVR programmer](https://www.sparkfun.com/products/9825)

## PCB Design
This is the link for my [project in eagle](https://github.com/aherrero/TMR01_Watch/tree/master/v3/Hardware/eagle_files)

If you don't know eagle before, [EAGLE](https://www.autodesk.com/products/eagle/overview) is a _scriptable electronic design automation (EDA) application with schematic capture, printed circuit board (PCB) layout, auto-router and computer-aided manufacturing (CAM) features_

The free version includes: 2 schematic sheets, 2 signal layers, and an 80cm2 board. So normally, could be enough for prototype and hobby.

There are many solutions for schematics and PCB design but, why I choose Eagle?

First, the free solution. Even if it is not open source any more, it is enough for my purpose. With the same idea, I could choose [Kicad](http://kicad-pcb.org/)

Then, the functionality offline, unlike some programs like [Altium](https://www.altium.com/).

And finally, it is supported for my favorite manufacturer [sparkfun](https://www.sparkfun.com/) where all their designs have a project with eagle free for download and ready if you want to use it.

And lot of tutorials!
- https://learn.sparkfun.com/tutorials/how-to-install-and-setup-eagle
- https://learn.sparkfun.com/tutorials/using-eagle-board-layout
- https://learn.sparkfun.com/tutorials/using-eagle-schematic

### Schematics

![sch1.png](https://raw.githubusercontent.com/aherrero/TMR01_Watch/master/v3/Hardware/TMR01_v3_pcb_top.png)

[The schematic in pdf](https://github.com/aherrero/TMR01_Watch/blob/master/v3/Hardware/TMR01_v3_schematic.pdf)

The schematics is pretty simple:
- 12 Leds with the resistor
- Microcontroller Atmega328P
- RTC with 32.768 Oscillator integrated
- Battery CR2032 with the capacitor.
- Push button for displaying the time
- Test point for programming (ISP programming) and serial communication for Debug (RX,TX)

![atmega_schematics.png](/assets/tmr01_v2/bora2/atmega_schematics.png)

### Board

| Top layer| Bottom layer|
|-------|--------|
| ![PCB_Front.JPG](https://raw.githubusercontent.com/aherrero/TMR01_Watch/master/v3/Hardware/TMR01_v3_pcb_top.png) | ![PCB_Back.JPG](https://raw.githubusercontent.com/aherrero/TMR01_Watch/master/v3/Hardware/TMR01_v3_pcb_bottom.png) |

The board in pdf, [top layer](https://github.com/aherrero/TMR01_Watch/blob/master/v3/Hardware/TMR01_v3_pcb_top.pdf) and [bottom layer](https://github.com/aherrero/TMR01_Watch/blob/master/v3/Hardware/TMR01_v3_pcb_bottom.pdf)


### Order
Once you generate the GERBERS, you can send them to the manufacturer to print the PCB.

- [Seeedstudio](https://www.seeedstudio.com/). This time, I choose this manufacturer for the PCBs. They even have a tutorial about [how to generate](http://support.seeedstudio.com/knowledgebase/articles/1176949-how-to-generate-gerber-file-from-eagle) the gerbers, according to their specification, with eagle.
Cost: $4.90 each 10 PCBs and $12.62 deliver to EU (Total: $17). Delivering time: 18 days.
- [jlcpcb](https://jlcpcb.com/) The last time I ordered here. The cost was $2 each 10 PCBs, and shipping $6.15 (Total: $8.15) Deliver time: Around 21 days.

The differences between them for the moment are; Seeedstudio seems more serious and they allow to manufacture PCB with other colors of PCB without extra cost. On the other hand, I don't know if it is worth it compeering the price (Double than jlcpcb). Also, jlcpcb only cost $2 if you order only one design. For more design, they increase to $5 each.

## Soldering
This time for soldering the atmega328, I have taken advantage of I am working in a electronics company for using a [soldering microscope](https://www.microscope.com/specialty-microscopes/soldering-microscopes/), so I could solder manually.

[todo...]

## Software
You can find the software in [github](https://github.com/aherrero/TMR01_Watch/tree/master/v2/Software/TMR01v2)
#TODO

### Bootloader
I've use the [MiniCore](https://github.com/MCUdude/MiniCore) library with Arduino to configure the fuses of the atmega, with the following configuration:

![arduino_config.png](/assets/tmr01_v2/bora2/arduino_config.png)

### Programming
#TODO
As you may have seen, there are 6 setpoints at the bottom, to connect the ISP for programming. Finally, as I programmed several times to get it works, I solder the pins and then remove it.

May attention the sense of the pins with the schematics and your ISP cable (Detect for example the VCC, with the  battery, and compare the VCC with the cable)

## Final results
#TODO

## Improvements
#TODO

***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
