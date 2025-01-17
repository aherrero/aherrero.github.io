---
layout: post
title:  "Home Automation - IoT"
date:   2025-01-13 08:00 +0200
categories: iot arduino electronics ble mqtt matter thread
comments: true

---

# Introduction
Like many of us, we started to have several devices to control different smart systems in our homes: lights, robot vacuum cleaners, TVs, and more.

Each device operates with its own system and app, making things a bit disjointed. But what if we could connect everything into one seamless system?

Welcome to home automation with [Home assistant](https://www.home-assistant.io/)

![iot](/assets/20250113/9.png)

Demo here, [https://demo.home-assistant.io/#/lovelace/home](https://demo.home-assistant.io/#/lovelace/home)

# Connectivity
Many devices could be connected to our system (being the core a server, raspberry pi like) and, nowadays, not only the Wi-Fi, ZigBee and Bluetooth ones, also using the new protocols, Matter and Thread.

![iot](/assets/20250113/10.png)

Image from [leonardocavagnis](https://leonardocavagnis.medium.com/retrofitting-with-matter-how-to-make-any-device-smart-4cdbc9459863)

In my case, I am interesting in connecting the different devices I have at home, plus some devices I had to buy in order to test all the possibilities of the system.

Wi-Fi
* Matter devices as the IKEA Dirigera Controller, with some devices such as lights, door sensor and smart plugs. All IKEA sensors are ZigBee but with the Dirigera, it will be controlled by WiFi
* Smart TV (Samsung TV)
* MQTT devices with ESP32/ESP8266 connecting sensors or relays
* MQTT devices with RPi

ZigBee
* Sensors (Temperature and Humidity Sensors, devices on the market)
* Eventually, the IKEA devices without Dirigera

Bluetooth / BLE / Matter
* BLE devices (IoT with nrf52840 or nrf54L15) to connect sensors
* Matter devices (IoT with Arduino Nano Matter) to connect sensors

Radio
* 433MHz modules could be use as the cheapest option to connnect sensors

## Home Assistant (HA)

![iot](/assets/20250113/15.png)
All pretty straight forward to install the HA in the raspberry pi (In my case Rpi3), on the [official documentation](https://www.home-assistant.io/installation/raspberrypi)

The assistant will probably already find some devices that can be added to the network, and you can spend a good couple of hours clicking through all the possible possibilities without watching any tutorials.
## IKEA Dirigera

![iot](/assets/20250113/14.png)

1. Follow the instructions to enmable the Matter feature on the device, https://www.matteralpha.com/how-to/how-to-use-the-ikea-dirigera-with-matter
2. Settings > Devices > Add Integration, we could add a Matter device
3. After that, you will see HA has found directly a Matter Device, the IKEA Hub, with all the devices already associated to this device, so you can control them directly
![iot](/assets/20250113/11.png)

## Zigbee sensors

![iot](/assets/20250113/13.jpeg)

1. Buy an additional board, a Zigbee to USB (Like the [Sonoff](https://sonoff.tech/product/gateway-and-sensors/sonoff-zigbee-3-0-usb-dongle-plus-p/) one, or the official from HA, [connectzbt1](https://www.home-assistant.io/connectzbt1/))
2. The HA detects the new device and added as Zigbee Home Automation integration
![iot](/assets/20250113/12.png)
3. You can now add all the devices/sensors that use Zigbee to communicate.

I have two kind of sensors using Zigbee at this moment:
* Indoor temperature/humidity sensors [Sonoff](https://www.amazon.de/dp/B0CLLVHGWN/ref=pe_27091401_487027711_TE_SCE_dp_i1)
* Outdoor temperature/humidity sensors [Comboss](https://www.amazon.de/dp/B0BWJGCD1G?th=1)

## MQTT devices with ESP8266 / ESP32

![iot](/assets/20250113/16.png)

Now the fun / most custom IoT part: Developing our own sensors. In the rpi, we can install a MQTT broker (With the help of HA) and our Wifi systems MQTT client could communicate and be part of the HA whole system.

Two kind of programming our ESP devices
* The easiest way, with [ESPHome](https://randomnerdtutorials.com/getting-started-with-esp8266-wifi-transceiver-review/)
* Programming an MQTT client from zero, with Arduino IDE, VSCode or ESP SDK

### MQTT Client with ESP8266
For this second option, there are several guides we could follow:
* [getting-started-with-esp8266](https://randomnerdtutorials.com/getting-started-with-esp8266-wifi-transceiver-review/)
* [beginners-guide-to-esp8266-dht11-mqtt-and-home-assistant-integration](https://medium.com/@tomer.klein/title-beginners-guide-to-esp8266-dht11-mqtt-and-home-assistant-integration-7ba75df5ecfb)
* [how-to-use-mqtt-on-esp8266](https://cedalo.com/blog/how-to-use-mqtt-on-esp8266/)

On my case, I use an ESP8266 and for testing, the Arduino IDE with the PubSubClient library to use the MQTT client. The code I use could be found on [github](https://github.com/aherrero/Mqtt-esp8266-test)

### MQTT Broker with mosquitto
Anyway, in order to use a MQTT device on the HA, we have to install a MQTT Broker on the rpi:
* [How to](https://github.com/home-assistant/addons/blob/174f8e66d0eaa26f01f528beacbde0bd111b711c/mosquitto/DOCS.md#how-to-use)
* [Youtube tutorial](https://www.youtube.com/watch?v=dqTn-Gk4Qeo)

Mosquito MQTT Broker

![iot](/assets/20250113/1.png)

MQTT integration:

![iot](/assets/20250113/2.png)

We could test our mqtt broker on the MQTT settings (Publish and listen),

![iot](/assets/20250113/3.png)

### Configuration in HA (yaml file)
And finally, a special configuration to get the parameters from these MQTT devices and process them as sensors,

* [editor yaml file](https://www.home-assistant.io/docs/configuration/#to-set-up-access-to-the-files-and-prepare-an-editor)
* [yaml file example](https://www.home-assistant.io/integrations/sensor.mqtt/#temperature-and-humidity-sensors)

![iot](/assets/20250113/4.png)

### Final result
Temperature measurement coming from a ESP device (With one or several sensors connected to it) using MQTT protocol over WiFi

![iot](/assets/20250113/6.png)

# Wrap-up and Ideas for Enhancement
* In this post, we configure Home Assistent and basic configuration, covering from standard IoT devices such as the IKEA devices, or ZigBee devices, and also own devices with ESP & MQTT.
* For the next project,
    * Use ESPHome, instead of developing MQTT device from zero
    * We could finish the implementation of a MQTT device with ESP32/ESP8266 with real sensors and battery powered
    * Work on Bluetooth Low Energy with nRF and seeing the capabilitiies to connect to our system
    * Using directly Matter protocol with Arduino Nano Matter


***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
