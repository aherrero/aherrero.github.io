---
layout: post
title:  "Mobile robots in a Box!"
date:   2018-11-18 08:00 +0200
categories: arduino robots radio
comments: true
youtubelink: U-sQe68Bytg
---

## Sunday's
Hummm... Arduino, motor shield to control CC motors, 4 motors, 4 wheels, battery and a RC radio... What could I do with that? =D

![1](/assets/rbt02/1.JPG)

## Bill of materials
Having all those components, thinking about putting them together and build something; it is not a big deal, but, it is always funny for Sunday.

Essentials,
- Motor control shield, as this one, from [adafruit](https://learn.adafruit.com/adafruit-motor-shield)
- Arduino
- [Motors](https://www.gotronic.fr/art-paire-de-motoreducteurs-dg01d-18760.htm)
- [Wheels](https://www.gotronic.fr/art-paire-de-roues-bleues-tam6427b-19360.htm)
- [Battery Lipo](https://hobbyking.com/en_us/batteries-chargers/batteries/lipo.html)

Remote control
- [RC Radio transmitter](https://hobbyking.com/en_us/orangerx-t-six-2-4ghz-dsm2-6ch-programmable-transmitter-w-10-model-memory-mode-1.html)
- [RC radio receiver](https://hobbyking.com/en_us/orangerx-r615x-dsm2-dsmx-compatible-6ch-2-4ghz-receiver-w-cppm.html?___store=en_us)

## Hardware
Basically, connecting everything:
- The CC motors in the motors from M1 to M4
- The radio receiver could be fitted together in the servo signal (We need to read the PWM signal)
- Lipo in the motor shield power

Et voilà!

![2](/assets/rbt02/2.JPG)

![4](/assets/rbt02/4.JPG)

## Software
The full source code in my [github](https://github.com/aherrero/RBT02_MobileRobot/tree/master/Software)

### Motors
You could control directly the motors using PWM as in this link,  https://www.dfrobot.com/wiki/index.php/Arduino_Motor_Shield_(L298N)_(SKU:DRI0009) ,

    //Arduino PWM Speed Control：
    int E1 = 5;
    int M1 = 4;
    int E2 = 6;
    int M2 = 7;

    void setup()
    {
        pinMode(M1, OUTPUT);
        pinMode(M2, OUTPUT);
    }

    void loop()
    {
      int value;
      for(value = 0 ; value <= 255; value+=5)
      {
        digitalWrite(M1,HIGH);
        digitalWrite(M2, HIGH);
        analogWrite(E1, value);   //PWM Speed Control
        analogWrite(E2, value);   //PWM Speed Control
        delay(30);
      }
    }

Or using some library, as these from adafruit
- [lib v1](https://github.com/adafruit/Adafruit-Motor-Shield-library)
- [lib v2](https://github.com/adafruit/Adafruit_Motor_Shield_V2_Library)

### Radio
The second thing to take into account is to read the signal from the radio receiver, a PWM signal, to Arduino.
We could use this [expression](http://www.benripley.com/diy/arduino/three-ways-to-read-a-pwm-signal-with-arduino/),

    byte PWM_PIN = 3;

    int pwm_value;

    void setup() {page.youtubeTmr01v2_b %}
      pinMode(PWM_PIN, INPUT);
      Serial.begin(115200);
    }

    void loop() {
      pwm_value = pulseIn(PWM_PIN, HIGH);
      Serial.println(pwm_value);
    }

## Final results
The result,

![3](/assets/rbt02/3.JPG)

And the video expected,

{% include youtubePlayer.html id=page.youtubelink %}


***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
