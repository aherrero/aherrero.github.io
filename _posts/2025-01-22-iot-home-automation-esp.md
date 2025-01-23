---
layout: post
title: Home Automation - Espressif ESP8266 and ESP32 (Part I)
date: 2025-01-22 08:00 +0200
categories: iot arduino electronics mqtt esp
comments: true
---

# Introduction
In this post, we explore the diverse capabilities and opportunities offered by Espressif's renowned microcontrollers, the ESP8266 and ESP32.

There is a nice "Getting started" guide on [this page](https://randomnerdtutorials.com/getting-started-with-esp8266-wifi-transceiver-review/), as introduction for the ESP8266 systems

In order to program and use the boards, we could use different methods:
* [Arduino IDE](https://randomnerdtutorials.com/how-to-install-esp8266-board-arduino-ide/), as briefly mentioned in the previous post.
* [ESPHome](https://esphome.io/guides/getting_started_command_line#installation)
* [ESPHome Device Builder](https://esphome.io/guides/getting_started_command_line#bonus-esphome-device-builder)
* [ESP-IDF (Espressif IoT Development Framework)](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/get-started/index.html), we will explore this possibility in the next entry.

Personally, I have the two types of boards,
* ESP8266 with NodeMCU Amica [amazon](https://www.amazon.de/diymore-ESP8266-Development-Compatible-Micropython/dp/B09Z6T2XS4/ref=mp_s_a_1_3), [pinout](https://randomnerdtutorials.com/esp8266-pinout-reference-gpios/)
* ESP32-WROOM-32 [amazon](https://www.amazon.de/dp/B0D9BTQRYT/ref=pe_27091401_487024491_TE_item), [datasheet](https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32_datasheet_en.pdf), [ES32 Series datasheet](https://www.espressif.com/sites/default/files/documentation/esp32_datasheet_en.pdf)

# Arduino IDE
Using the [Arduino IDE](https://randomnerdtutorials.com/how-to-install-esp8266-board-arduino-ide/) is the easiest way to program and use any ESP board, with plenty of examples for development

IDE,

![iot](/assets/20250122/1.png)

Examples,

![iot](/assets/20250122/2.png)

Blink code example,

```
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
  digitalWrite(LED_BUILTIN, HIGH);
  delay(2000);
}
```

And if using the MQTT Client library, [PubSubClient](https://docs.arduino.cc/libraries/pubsubclient/), we could use the ESP8266 with MQTT to communicate with Home Assistent, as previous post.

# ESPHome
Using python to install the tool and following the [official guide](https://esphome.io/guides/getting_started_command_line#installation), it is very easy as well to just program anything on the board (ESP8266 or ESP32), reusing components to communicate with different sensors only by adding the description in the `yaml` file, and even programming Over-The-Air (OTA) the microcontroller.

Create a project,
`esphome wizard livingroom.yaml`

Adding some features,
```
switch:
  - platform: gpio
    name: "Living Room Dehumidifier"
    pin: D0
```
Upload the code,
`esphome run livingroom.yaml`

On the Home Assistant side, the ESPHome is detected as new integration, and a new Device (in this case, called espi) could be found

![iot](/assets/20250122/3.png)

The feature of the ESP8266 is a simple switch, which will toggle the LED status, D0, between HIGH and LOW. 
This can now be controlled by the Home Assistant with the control entity

![iot](/assets/20250122/4.png)

From here, all the components could be added following the same logic (More component description [here](https://esphome.io/#sensor-components)). 

And after this first programming, the next could be done by OTA.

![iot](/assets/20250122/5.png)

## ESPHome ESP8266 Example - Temperature and Humidity
If we want to add a sensor for Temperature and Humidity such as the AHT20, it is available in the ESPHome so we just follow the example for the sensor component page for [AHT Sensors](https://esphome.io/components/sensor/aht10)

```
# Example configuration entry
sensor:
  - platform: aht10
    variant: AHT20
    temperature:
      name: "Living Room Temperature"
    humidity:
      name: "Living Room Humidity"
    update_interval: 60s
```

Including the I2C communication, also as a [component](https://esphome.io/components/i2c)
```
i2c:
  sda: GPIO4
  scl: GPIO5
  scan: true
```

Hardware connection as follow (According the [pinout](https://randomnerdtutorials.com/esp8266-pinout-reference-gpios/))

![iot](/assets/20250122/6.jpeg)

And after uploading the code, we can already see in the logs the communication the communication is successful.
![iot](/assets/20250122/7.png)

The ESP is getting the information from the sensor and sending out.
![iot](/assets/20250122/8.png)

And finally, in the home assistant, we can see the Sensor values humidity and temperature, with the names defined in the .yaml.
![iot](/assets/20250122/9.png)

# ESPHome Device Builder
Another way to use the ESPHome is with the Builder, as a web server.
After installing the dependencies following [the tutorial](https://esphome.io/guides/getting_started_command_line#bonus-esphome-device-builder)

`pip install tornado esptool`

We can start the dashboard,

```
mkdir config
esphome dashboard config
```

And launching in chrome the dashboard,
`localhost:6052`

![iot](/assets/20250122/10.png)

The device can be created, and the configuration could be modified directly on the local web. In other words, we could have exaclty the same as the standard ESPHome but with nicer interface.

![iot](/assets/20250122/11.png)

# Wrap-up and Ideas for Enhancement
* In this post, we explore 3 ways to program our Espressif devices: Arduino IDE; ESPHome and ESPHome Builder.
	* ArduinoIDE is nice, with lot of support, but if custom programming needs to be made, I personally will chose ESP-IDF.
	* ESPHome/ESPHome Builder, are a very quick way to integrate a sensor, if you need only that, and the component you want to integrate is on the list.
* For the next project,
    * Use [ESP-IDF (Espressif IoT Development Framework)](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/get-started/index.html) for development

***

<p style="text-align:center;">

<button class="button buttonblue" onclick="window.location.href='https://aherrero.github.io/iot/arduino/electronics/ble/mqtt/matter/thread/2025/01/13/iot-home-automation.html';">Previous</button>
<button class="button buttonblue" disabled="disabled" onclick="window.location.href='';">Next</button>

</p>

***

{% if page.comments %}
{% include disqus.html %}
{% endif %}
