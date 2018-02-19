---
layout: post
title:  "Borarm. First Robotic Arm. Part I"
date:   2018-02-12 08:00 +0200
categories: arduino robotic
comments: true
youtubeId: rRRQp8YUqT0
youtubeId2: r8ElZAFM2SY
youtubeId3: nhzhC5NQzSk
---

![borarm_v1_img](/assets/borarm/2.1_2.JPG)

# Borarm as a first robotic Arm
The goal of this projects is very simple to understand: Build a simple robotic arm to start using Arduino again.

The problem: I've never been a Hardware guy, so, there are so many simple task that I have to face.

I've found this simple robotic arm on Internet, which seems not very difficult to achive,

[http://www.instructables.com/id/4-Axis-Robot-Arm-DIY/](http://www.instructables.com/id/4-Axis-Robot-Arm-DIY/)

{% include youtubePlayer.html id=page.youtubeId %}

But until then, there is so much work to do.

# Servo testing
The first to do is to try the electronic available.

![borarm_v1_img](/assets/borarm/1.1_2.JPG)

Here is where I've realized that the servos need more power, more current. So, I use an external power supply for the servos (using a microusb adaptator and a normal tranformer from a mobile, 5V, 2A) to move them, and we can use also this power supply to turn on the Arduino with the pin Vin.

The USB cable is connected to the PC for seeing the serial communication terminal.

# Structure
I've used polystyrene to build the structure. Very easy to build something quickly, but not too stable.

![borarm_v1_img](/assets/borarm/1.2_2.JPG)

Here, I've realized that I would need spaces between the walls, to restrict the movement. Otherwise, when I tighten the screw, the walls bend. Also, longer screws should work better.

![borarm_v1_img](/assets/borarm/1.4_2.png)

In the second iteration,

![borarm_v1_img](/assets/borarm/2.1_2.JPG)

![borarm_v1_img](/assets/borarm/2.2_2.JPG)

# Control
I've used a nunchuck to control the servos, instead of multiples potentiometer, or serial communication and a keybord.

The nunchuck is easy to use with the correct library, allows multiple options (joystick 360°, 2 buttons, accelerometers XYZ) and not very expensive

[https://www.amazon.fr/dp/B001T1GX2S/ref=pe_3044141_189395771_TE_3p_dp_1](https://www.amazon.fr/dp/B001T1GX2S/ref=pe_3044141_189395771_TE_3p_dp_1)

You could use this projects as examples of using the nunchuck,

[https://create.arduino.cc/projecthub/mtashiro/control-servos-using-wii-nunchuk-9136bd](https://create.arduino.cc/projecthub/mtashiro/control-servos-using-wii-nunchuk-9136bd)

[http://arduinoarts.com/2014/07/tutorial-wii-nunchuck-pan-tilt-servo/](http://arduinoarts.com/2014/07/tutorial-wii-nunchuck-pan-tilt-servo/)

# Software
The software is very simple for only move servos and test the structure.

All in [Github](https://github.com/aherrero/Borarm).

One remark; I don't like at all the Arduino IDE. Of course, you can use Arduino IDE to program the Arduino with this source code, but I've started to use this Pakckage for Atom, and it's awesome.


<img src="https://platformio.org/images/platformio-logo.17fdc3bc.png" width="50">

[https://platformio.org/](https://platformio.org/)

# Video result

First iteration

{% include youtubePlayer.html id=page.youtubeId2 %}

Second iteration

{% include youtubePlayer.html id=page.youtubeId3 %}

***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
