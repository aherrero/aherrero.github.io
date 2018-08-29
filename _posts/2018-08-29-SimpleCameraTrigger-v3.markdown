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


***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
