---
layout: post
title:  "Simple Camera Trigger - v4"
date:   2018-09-26 08:00 +0200
categories: arduino iot
comments: true
youtubeId: KgTajizav5w
---

## Introduction
In the [previous version](https://aherrero.github.io/arduino/iot/2018/08/29/SimpleCameraTrigger-v3.html), I've completed the "simple camera trigger" project in a Breadboard. As my intention of this project is using it in the real field (I mean, the real real field), outside in a mountain, to make this timelapse for my camera, I should make a solution more "industrial".

Also, in the [Arduino To Breadboard entry](https://aherrero.github.io/arduino/iot/2018/09/24/ArduinoToBreadboard.html), I've learned to rid of the Arduino and using only the processor, the Atmega328p.

So, this version will improve the version 3 with the same components to put it in a Prototype PCB.

![pcb_complete.JPG](/assets/cam01/pcb_complete.JPG)

## List of components
- [7-segment display](https://www.sparkfun.com/products/8546)
- 3 x [pushbuton](https://www.sparkfun.com/products/9190)
- 1 x [Atmega328p](https://www.sparkfun.com/products/9061)
- 1 x [16 MHz crystal](https://www.distrelec.ch/en/quartz-hc49-4h-16-mhz-iqd-lfxtal003240/p/17451701) or 8Mhz if it is your option.
- 2 x [18 to 22 pF (ceramic) capacitors](https://www.distrelec.ch/en/capacitor-22-pf-500-vdc-mm-hitano-tch2h220j-l515b/p/16569149) for the external clock
- 5 x [0.1uF capacitor](https://www.distrelec.ch/en/capacitor-100-nf-50-vdc-mm-hitano-sf1h104z-l515b/p/16565659) for regulator and RST line
- 1 x [Led IR](https://www.sparkfun.com/products/9349?_ga=2.32862392.783308004.1538109926-1058029582.1533465469)
- 1 x [L7805 voltage regulator](https://www.sparkfun.com/products/107)
- 9 x 220 ohms resistor (Display and led ir)
- 4 x 10k resistor (buttons and atmega reset)
- [Battery 9V](https://www.distrelec.ch/en/primary-battery-6lr61-varta-industrial-9v/p/16901614)
- [Straight pin male](https://www.distrelec.ch/en/pin-header-male-10-rnd-connect-rnd-205-00631/p/30093651)

Connector with battery suggestion
- [2 pin male](https://www.distrelec.ch/en/pin-header-male-rnd-connect-rnd-205-00671/p/30093691)
- [2 pin female](https://www.distrelec.ch/en/crimp-housing-female-rnd-connect-rnd-205-00662/p/30093682)
- [Crimp contact](https://www.distrelec.ch/en/crimp-contact-female-28-22-awg-rnd-connect-rnd-205-00696/p/30093716)

## Schematic
Before continue, I've discovered a tool very useful for someone with zero knowledge of electronics (But also helps me if I forget to put something, or, why I should use this capacitor...)

The tool is the [web designer from circuito.io](https://www.circuito.io/app?components=512,11021)

You only have to drag and drop the main components you want to use it, and the tool is going to:
- Connect all the components with the respective pins (and with his pinout proposal for the atmega)
- Generate the real electronic schematic with "Go to pro" option.
- Generate the example code for using this components.

Brief, if in this project I want to use a Atmega328p, 7-segements display, 3 buttons and IR Led, I have to place this 4 kind of components, and the tool is going to tell me what are all the connexion!

![board-328.JPG](/assets/cam01/board-328.png)

Sure, it is not perfect, but it give to you an idea about what you want.

## PCB
As I didn't design the PCB schematic, I put all my components in a prototype PCB and I've started soldering everything. It is not the best solution if you want something more structural and with less cables, but if you have a project with a few components, it could be enough.

| PCB Front | PCB Back|
|-------|--------|
| ![PCB_Front.JPG](/assets/cam01/PCB_Front.JPG) | ![PCB_Back.JPG](/assets/cam01/PCB_Back.JPG) |

## Software
I did a state machine to change between the configuration of timing and the trigger operation.

Also, as I wanted to configure more than 9 seconds, I've use the same display to configure the 3 digits in seconds for the timing (So, up to 999 seconds)

The display and the camera are in different classes.

You can see all of the code from my [github](https://github.com/aherrero/CAM01_SimpleCameraTrigger)

## Final Result

You could manufacture your own box if you want to carry this remote control outside or...

[Buy one](https://www.distrelec.ch/en/plastic-enclosure-65-120-40-mm-grey-abs-high-impact-ip54-rnd-components-rnd-455-00052/p/30043295), there are hundreds of boxes.

![PCB_Back.JPG](/assets/cam01/box_pcb.JPG)


{% include youtubePlayer.html id=page.youtubeId %}


***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
