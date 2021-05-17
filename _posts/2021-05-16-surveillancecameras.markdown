---
layout: post
title:  "Cheap Surveillance cameras - Normal webcam, RPI and NAS"
date:   2021-05-16 08:00 +0200
categories: rpi linux synology
comments: true

---

## Introduction

It's been a long time since the last time I wrote a post and, as I have taken advantage of an update that github has recommended to me, I am going to write about a quick project I did today.

Imagine you have a _a new and puppy_ dog, and you have to and you have to leave it alone for some periods. As a new father, you worry about her and you were wondering what was she doing all the time.

So, as the normal surveillance cameras + interface are so expensive and you want something quick and dirty, as usual, you use whatever you have at home.

![material](/assets/2021may/material.jpeg)


### Target
I have found a great application in synology to be able to surveillance the cameras from an application in my smartphone and at the same time, to record the streaming and saving at the same time in the NAS.

The only problem, it only admits IP Cameras.


## Material used
- 2 RaspberryPi: rpi3 and rpi zero w
- 1 NAS Synology
- 1 Standard Webcam
- [1 Rpi camera module](https://www.raspberrypi.org/products/camera-module-v2/)

## Normal webcam (USB or cable) to IP cameras
Using raspberrypi and a [library](https://github.com/Motion-Project/motion) in linux, you can convert these webcams to share the streaming via web.

I have followed the tutorial from [https://tutorials-raspberrypi.com/raspberry-pi-security-camera-livestream-setup/](https://tutorials-raspberrypi.com/raspberry-pi-security-camera-livestream-setup/), very good explained.

In a few lines,

    sudo apt-get install motion
    sudo modprobe bcm2835-v4l2 # For rpi camera modules
    sudo nano /etc/motion/motion.conf # Edit with the desired configuration like daemon enable, image width and height and framerate
    sudo nano /etc/default/motion # Again daemon enable
    # Mkdir folder for saving stram and give rights
    sudo service motion start


I have stopped in the moment I should make it available outside the local network.

For my project, it is enough having a camera available within ip address like

    http://192.168.0.22:8081

### Note for raspberrypi
I have installed [Raspberry Pi OS](https://downloads.raspberrypi.org/raspios_full_armhf/images/raspios_full_armhf-2021-03-25/2021-03-04-raspios-buster-armhf-full.zip), using the standard method with _dd command_ (although I guess the suggested [rPi Imager](https://www.raspberrypi.org/software/) also works)

https://www.raspberrypi.org/documentation/installation/installing-images/linux.md

    sudo dd if=2021-03-04-raspios-buster-armhf.img of=/dev/mmcblk0 bs=4M conv=fsync status=progress

But then, once I have configured everything for the rpi3 with the Motion libraries and so on, I have cloned the micro SD for the other rpi (rpi zero) and it works without any change

https://beebom.com/how-clone-raspberry-pi-sd-card-windows-linux-macos/

A command like that should do the trick for cloning.

    sudo dd if=/dev/mmcblk0 of=custom_raspios.img bs=4M conv=fsync status=progress

## Synology NAS
Once we have both cameras sharing the stream via IP, we have to configure the NAS side.

In Synology, the package for the NAS station is called Synology surveillance.

The configuration is easy, it is only set the IP and the port where you are doing the straming.. and that's it !

![nas_surveillance_config](/assets/2021may/nas_surveillance_config.png)

### Web
The NAS can record several cameras at the same time, activate only with movement and also track some features (not tested on my side). More information in the synology [website](https://www.synology.com/en-global/surveillance)

![web](/assets/2021may/web.png)

### Mobile - Android
As usual with synology, every tool on the web has a good application for smartphone.
[Here for Android](https://play.google.com/store/apps/details?id=com.synology.DScam)

You can do the same as in the web, as see several webcams at the same time, see the history through a timeline and also receive a notification if the cameras detect some movement.

## Final conclusion
A quick project of 2 hours so easy and fast that I almost feel sorry for my poor dog that I will have constantly watched :/


***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
