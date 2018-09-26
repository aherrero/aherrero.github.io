---
layout: post
title:  "Simple Camera Trigger - v4"
date:   2018-09-26 08:00 +0200
categories: arduino iot
comments: true
youtubeId: 7FIHgy1nlaw
---

## Introduction
In the [previous version](https://aherrero.github.io/arduino/iot/2018/08/29/SimpleCameraTrigger-v3.html), I've completed the "simple camera trigger" project in a Breadboard. As my intention of this project is using it in the real field (I mean, the real real field), outside in a mountain, to make this timelapse for my camera, I should make a solution more "industrial".

Also, in the [Arduino To Breadboard entry](https://aherrero.github.io/arduino/iot/2018/09/24/ArduinoToBreadboard.html), I've learned to rid of the Arduino and using only the processor, the Atmega328p.

So, this version will improve the version 3 with the same components to put it in a Prototype PCB.

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

![PCB_Front.JPG](/assets/cam01/PCB_Front.JPG)

![PCB_Back.JPG](/assets/cam01/PCB_Back.JPG)

## Software
I did a state machine to change between the configuration of timing and the trigger operation.

Also, as I wanted to configure more than 9 seconds, I've use the same display to configure the 3 digits in seconds for the timing (So, up to 999 seconds)

The display and the camera are in different classes.

You can see all of the code from my [github](https://github.com/aherrero/CAM01_SimpleCameraTrigger)

## Final design
TODO
- Box
- Battery 9V


***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
