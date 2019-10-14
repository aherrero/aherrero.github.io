---
layout: post
title:  "Robotic Arm - 3D Printed"
date:   2019-10-14 08:00 +0200
categories: arduino robot 3D
comments: true
---

# Introduction
Following this [great tutorial](https://www.instructables.com/id/EEZYbotARM/) from [theGHIZmo](https://www.instructables.com/member/theGHIZmo/), I was able to build this simple robot.

It is not so impressive as the one from the author, but incredible what we can do only printing the design, assembling and doing a quick test.

I feel like assembling an IKEA furniture!

![1](/assets/rbt03/1.JPG)

## 3D Printing
One of my first 3D printed object was this robotic arm, but I've never finished due some material missing, but the 3D printing was pretty good,

![33](/assets/3dprinter/33.JPG)

## Bulding
The assembling of all parts is not a big deal, following the instructions from the [instructables](https://www.instructables.com/id/EEZYbotARM/), including the list of materials.

## Test and results
For testing, I've use an Arduino Uno and a shield for motors / servos, to easy connect everything.

Also, I've use a phone charger and the Arduino port Vin, in the case the current was a bit low for all the servos (From the charger I have 2A)

![2](/assets/rbt03/2.JPG)

Then, a [simple software](https://github.com/aherrero/RBT03_3DPrintedRobot/blob/master/Software/Bora2/Bora2.ino) for controlling the servos in a independent way, from the keyboard.

Using _A D_, _W S_, _J L_, _I K_, I am able to control all the servos, sending a signal for moving from 0 degrees up to 180 degrees (Or up to the physical HW limits, still without calculate).

***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
