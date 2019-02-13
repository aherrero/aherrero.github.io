---
layout: post
title:  "Bora Watch - A simple and geek homemade watch"
date:   2018-10-20 08:00 +0200
categories: arduino iot watch
comments: true
youtubeTmr01: SHC-i1KxNCg
---

## Introduction
Hey, I've made my own watch!

![Bora_Watch](/assets/tmr01/DSC_0262_2.JPG)

One day, I was really impressed with the project I saw in [hackaday](https://hackaday.com/2018/08/24/an-arduino-watch-without-a-clock/). A project created by [electronoobs](https://www.electronoobs.com/eng_arduino_tut40.php) with internal clock using the atmega328p, 12 leds and resistors, 3V battery and very few components more.

So, as it was well documented with all the list of materials, design files and so on, I decided to made it.

The challenges I had with the project were basically two;
- Using the atmega328p with the internal clock (Until now, I got rid of the Arduino components for using only the core, the atmega328 and a few components, but not using the internal clock)
- And, the really challenge here, the **SMD soldering**

Example of components size,

![DSC_0196_2.JPG](/assets/tmr01/DSC_0196_2.JPG)

## Bill-Of-Materials
- 1 x PCB: [GERBERS here](https://github.com/aherrero/TMR01_Watch/blob/master/v1/HW/Gerber_EN_watch_PCB_20180922223706.zip), [schematics](https://github.com/aherrero/TMR01_Watch/blob/master/v1/HW/Schematic_EN-Bora-watch_Sheet-1_20180922223903.pdf) and [board](https://github.com/aherrero/TMR01_Watch/blob/master/v1/HW/PCB_EN-watch-PCB_20180922223520.pdf). [Designed here](https://easyeda.com/) and [manufactured here](https://jlcpcb.com/)
- 1 x ATMega328p-AU: [Amazon Atmega328p](https://www.amazon.fr/gp/product/B01N0DNQ78/ref=oh_aui_detailpage_o01_s00?ie=UTF8&psc=1). Bought here because my usual provider didn't have.
- 12 x 200R 0402 SMD resistors: [Distrelec 200 0402](https://www.distrelec.ch/en/smd-resistor-thick-film-200-ohm-0402-rnd-components-rnd-1550402wgf2000tce/p/30056372)
- 12 x 0402 SMD LED: [Distrelec Led 0402](https://www.distrelec.ch/en/smd-led-red-0402-wuerth-elektronik-150040rs73240/p/30114006)
- 1 x SMD Tactile Switch: [Distrelec Button](https://www.distrelec.ch/en/tactile-switch-50-ma-12-vdc-te-connectivity-1437566/p/13566524)
- 2 x 10K 0402 SMD resistors: [Distrelec 10k 0402](https://www.distrelec.ch/en/smd-resistor-thick-film-10-kohm-0402-rnd-components-rnd-1550402wgf1002tce/p/30056338)
- 1 x 100nF 0402 SMD capacitor: [Distrelec 100nF 0402](https://www.distrelec.ch/en/capacitor-100-nf-25-vdc-0402-rnd-components-rnd-150c0402b104k250nu/p/30087075)
- 1 x 10uF 0805 SMD capacitor: [Distrelec 10uF 0805](https://www.distrelec.ch/en/capacitor-10-uf-vdc-0805-rnd-components-rnd-1500805x106k063n3/p/30086816)
- Battery Holder CR2032 [Distrelec Battery Holder](https://www.distrelec.ch/en/battery-holder-cr2032-renata-smtu2032/p/16950022)

**Tools**
- [Soldering Paste](https://www.distrelec.ch/en/soldering-paste-syringe-solder-chemistry-blf03-ch-de/p/18249570) and [needle](https://www.distrelec.ch/en/dosing-needle-58-mm-pink-pink-solder-chemistry-047031/p/18249574)
- [Heat gun](https://www.amazon.fr/gp/product/B01N0X1LFK/ref=oh_aui_detailpage_o00_s01?ie=UTF8&psc=1), although, I've realized that this one it wasn't powerful enough, but it was fine.
- [Velcro strip](https://www.amazon.fr/gp/product/B07DFBHN5J/ref=oh_aui_detailpage_o00_s01?ie=UTF8&psc=1)
- [Arduino uno](https://www.distrelec.ch/en/arduino-uno-rev3-smd-arduino-a000073/p/30101956) and [Capacitor 10uF](https://www.distrelec.ch/en/aluminium-electrolytic-capacitor-10-uf-50-vdc-jamicon-skr100m1hd11/p/16701353) for burning the bootloader and programmer **or** an [AVR programmer](https://www.sparkfun.com/products/9825)

## Schematic and Board
I've use the same schematic and board as the original with minor modifications, because the goal this time it wasn't the electronics design.

Schematic

![schema](/assets/tmr01/schema.png)

Board

![board](/assets/tmr01/board.png)

It is basically an Atmega328p connected to 12 resistor and 12 leds, to a pushbutton, well configured the reset pin for the bootloader and programming (capacitor and resistor), the pins for programming (SPI and UART) and a battery holder for CR2032.

You can see in the online editor
- The [schematic](https://easyeda.com/editor#id=e2f64f5df199459d9788ec1f2d2dd938)
- The [board](https://easyeda.com/editor#id=42fc56697c8e4275b725ab0ee3979312)

Or from PDF,
- [schematics-pdf](https://github.com/aherrero/TMR01_Watch/blob/master/v1/HW/Schematic_EN-Bora-watch_Sheet-1_20180922223903.pdf)
- [board-pdf](https://github.com/aherrero/TMR01_Watch/blob/master/v1/HW/PCB_EN-watch-PCB_20180922223520.pdf)

## PCB
Once you have the design of your board, you have to generate the [GERBER files](https://github.com/aherrero/TMR01_Watch/blob/master/v1/HW/Gerber_EN_watch_PCB_20180922223706.zip) and order in your favorite manufacturer. In this case I choose the manufacture associated to this online designer, [jlcpcb](https://jlcpcb.com/), but you could use another tool for design and generate the gerbers as [Eagle](https://www.autodesk.com/products/eagle/overview) and then, the manufacturer could be [oshpark](https://oshpark.com/) or [seeedstudio](https://www.seeedstudio.com/1-usd-for-3-pcbs.html), as examples

But jlcpcb it was fine, 10PCBs for ~7 euros.

### Soldering
I've used a technique that I've never used before, with the [soldering paste](https://en.wikipedia.org/wiki/Solder_paste).

It is a paste you put in the PCB, you put the components on top of it, and then, ideally with a hot station but if you don't have anything better with a hot gun, you reflow the components until the paste disappears with the metallic parts joined.

PCB with soldering paste,

![DSC_0198_2.JPG](/assets/tmr01/DSC_0198_2.JPG)

PCB, paste and components

![DSC_0200_2.JPG](/assets/tmr01/DSC_0200_2.JPG)

After apply the hot gun,

![DSC_0202_2.JPG](/assets/tmr01/DSC_0202_2.JPG)

On the back,

![DSC_0204_2.JPG](/assets/tmr01/DSC_0204_2.JPG)

Atmega328p solder,

![DSC_0205_2.JPG](/assets/tmr01/DSC_0205_2.JPG)

| Leds and resistors | resistor|
|-------|--------|
| ![DSC_0208_2](/assets/tmr01/DSC_0208_2.JPG) | ![DSC_0209_2](/assets/tmr01/DSC_0209_2.JPG) |

Something very important, you should check all the connection after make this procedure (Specially the correlated pins in the microcontroller, and both pins of capacitor and resistor if they are connected between them). It is probably that some components are bad solder and you have to finish the work manually.

## Software
### Bootloader
I've been playing with bootloader and programming since the last month for a few projects, so you may want to check this blog entries:
- [Arduino to breadboard - Atmega328p](https://aherrero.github.io/arduino/iot/2018/09/24/ArduinoToBreadboard.html). How to use the Atmega328p without the Arduino and with an external clock.
- [Atmega328p without clock: Internal clock - Mhz](https://aherrero.github.io/arduino/iot/2018/10/17/ArduinoToBreadboard-v2.html)

In these post I explain basically what we should to do here for having the Atmega328 with bootloader and programmed.

But one point missing: Connection to this watch.

![boot_1.png](/assets/tmr01/boot_1.png)

First, I've used Arduino as ISP for burning the bootloader in the watch. This is not the best programmer you should use, and if possible, you could use an [AVR programmer](https://www.sparkfun.com/products/9825).

If you are using an Arduino, as I've indicate in previous entries, **be sure you have the 10 uF capacitor between reset and ground on the programmer**

For burning the bootloader I've used the library [MiniCore](https://github.com/MCUdude/MiniCore). I've selected the Arduino 328p, with internal 8Mhz clock and the BOD 1.8V (As we are going to use a small battery, we want to reduce the shutdown of the atmega to the minimum).

The complete instructions for the bootloader are also in the [arduino official tutorial](https://www.arduino.cc/en/Tutorial/ArduinoToBreadboard)

### Programming - Transfer the code
For programming the Arduino we have the UARTs pinout (RX,TX and DTR for the reset) on the watch. We only need an FTDI cable and connect as shown,

![boot_3.png](/assets/tmr01/boot_3.png)

FTDI pinout,

![FTDI cable schema](/assets/cam01/ftdi_schema.png)

In this case, we already have the 0.1uF capacitor between the reset and the DTR line, so, it is not necessary to add.

To send the code to the watch, we could use the Blink example, once we have the same board used for the bootloader, and changinig in the Arduino IDE from _Arduino as ISP_ to _AVRISP mkII_.
One of the leds (I don't remember which corresponds to the pin13 in Arduino) is going to Blink, which means, we are able to send the program to our watch.

Some references with the pinout of the Atmega328p and the Arduino from [circuito.io blog](https://www.circuito.io/blog/arduino-uno-pinout/)

![pinout atmega arduino](/assets/cam01/arduino-uno-pinout-diagram.png)

And you can download the version of my code, as well ad the original version in my [github](https://github.com/aherrero/TMR01_Watch/tree/master/v1/Software/Code/TMR01_Watch).

I didn't modify so much the source code, even if it seems there are some issues related with the clock (The time is going faster on this watch!) and also the hour programming is not working always. But it has interruption to wake up the Atmega328 when you press the button, and it only shows the hour when pressing the button.

## Final results

Video:

{% include youtubePlayer.html id=page.youtubeTmr01 %}


## Future
I've learned a lot in this (simple) project, but this doesn't means I am going to stop here. There are several improvements we could perform in this project:
- The battery performance is not great. At all. As I've reduce the BOD to 1.8V (Mechanism to deactivate the Atmega328 when reach this voltage), we can use the watch more than the original project.. But still, the battery is for 3-4 days. Only showing a few leds sometimes during the day!
- The time is not correct 80% of the time. Using the internal clock is not the best idea if you want to have a constant clock for measuring the time. Instead, it is normally better using an external oscillator.. Or even better, a RTC
Keyword: 32.768kHz.
This is a Real-Time-Clock crystal. 32.768kHz means it is precisely half of a 16-bit counter. Start counting at 0x8000 (or 32768). When the counter rolls over from 65535 to 0, then you know that exactly one second has passed.
- Related with both topics: We could improve the time and the battery using a RTC: They consume very little, and we could really put the Atmega328p in sleep mode, so only wakes up when a button is pressed, read the time from the RTC, show the tiem and go to sleep again

***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
