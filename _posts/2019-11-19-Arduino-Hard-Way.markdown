---
layout: post
title:  "Arduino Hard Way"
date:   2019-11-19 08:00 +0200
categories: arduino Atmega328p
comments: true

---

# Introduction

The goal of this post is to know how to hard codded the pinout of Arduino. So instead of using the digitalWrite functions and so on, we are going to move bits iregister...

Why do that?
- Because is cool.
- Over that, because is cool.
- And over that, because is faster, and we may used it in some occasion with limit ressources. Besides, all the microcontrollers works using this way if the libraries are not enough developed.

# First steps
First, there is good pinout diagram from [circuito.io blog](https://www.circuito.io/blog/arduino-uno-pinout/)

![pinout atmega arduino](/assets/cam01/arduino-uno-pinout-diagram.png)

# Hello World (Blink!)
Following the pinout and this [reference](https://www.arduino.cc/en/Reference/PortManipulation), we could be able to do something.

In a few words,

    void setup()
    {
      // pinMode(13, OUTPUT);
      DDRB = DDRB | B00100000;  //Set as output bit PB5 (13 in Arduino Uno), other untouched
    }

    void loop()
    {
      // digitalWrite(13, HIGH);
      PORTB = PORTB | B00100000;  // Set HIGH PB5, other untouched
      delay(500);
      // digitalWrite(13, LOW);
      PORTB = PORTB & B11011111;  // clear out bit PB5, leave others untouched (xx & 11 == xx)
      delay(500);
    }




***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
