---
layout: post
title:  "Cross compile Qt5 for Rpi3 on Linux (Ubuntu)"
date:   2017-12-07 08:00 +0200
categories: qt5 rpi linux
---

# How to cross compile Qt5 for Rpi3 on Linux
I've found three methods to get the Qt libraries running on our Raspberry Pi:

1. Download the qt libraries in the rpi and compile in native (easiest method) See [Native_Build_of_Qt5_on_a_Raspberry_Pi](https://wiki.qt.io/Native_Build_of_Qt5_on_a_Raspberry_Pi). More information [here](http://wiki.qt.io/RaspberryPi)

2. Cross compile from a PC using the sysroot of the Rpi through SSH directly. [RaspberryPi2EGLFS](http://wiki.qt.io/RaspberryPi2EGLFS).

3. Cross compilation from a computer. Tutorial of reference [How to cross compile QT for Raspberry Pi 3 on Linux (Ubuntu) for Beginners!](https://medium.com/@amirmann/how-to-cross-compile-qt-for-raspberry-pi-3-on-linux-ubuntu-for-beginners-75acf2a078c) and also this tutorial, [Guide To Cross Compile Qt 5.4 for the Raspberry Pi](https://exploreembedded.tumblr.com/). The tutorial from the [Qt Wiki](http://wiki.qt.io/index.php?title=Raspberrypi_beginners_guide&redirect=no) appears to be old, but anyway.

The first option could take us hours, and we will force to  develop also in the rpi (Although, you also can develop on a PC, export the source code to rpi and compile there..).

The second option has the advantage of using the latest version of everything, but we will not have an entire system on our PC, only the parts for compiling (Could be better having the full system directly on the PC. Although, once the system in the rpi is configured, we also could copy the full system as an image).

Third option. The chosen option in this tutorial. But why get the things complicated and try the effort for cross compiling?
From my point of view, these are the advantages:

1. You can install qt5 for the rpi, but the qtcreator will be for qt4 version. You still will need another computer to develop for qt5 (Otherwise, export the source code from PC and compile in rpi, but forget about debugging)

2. The rpi is sloooow. The time for building the qt5 on native could takes hours (Some people talk about 24 hours). And develop applications is always faster in your own computer.

3. Once you have the system configured, you won't need a rpi for developing applications. This could be useful if you don't have the rpi yet.

4. You will have the entire system of the rpi on your computer, before flash the system in the SC card. This have another two advantages:
  * You can modify whatever you want on the root system (For example, you might want put an static IP in /etc/dhcpcd.conf and enable the SSH connection)
  * To replicate the system to whatever rpi3 it will be enough with copy and paste the image file.

## First steps and result
The initial configuration was:

- A computer with Ubuntu 16.04.3 LTS 64-bit (With the great Gnome Desktop, [https://ubuntugnome.org/](https://ubuntugnome.org/)) but should be work, at least, in any Ubuntu.
- Rpi3 (Could work in rpi2 also, not tried).
- SD Card 16GB.
- Extra Keyboard for the rpi3 is useful.
- Internet connection for the rpi3 (Useful if you don't have a keyboard and you want to start your application...)

At the end of the process, after a few hours (2-3 hours..) you will have:

1. A customized Rpi3 image with Raspbian Jessie, ready to flash into the SD card for the rpi3. (I've installed from the 'Jessie' 2017-07-05, I couldn't install everything with the last version, 'stretch')

2. Qt5 version on your computer for the Rpi.

3. Arm toolchain to cross-compile from your computer to the Rpi.

## Necessary libraries
```
sudo apt-get install lib32z1

to be check...
apt-get install build-essential libfontconfig1-dev libdbus-1-dev libfreetype6-dev libicu-dev libsqlite3-dev libssl-dev libpng12-dev libjpeg9-dev libglib2.0-dev
```

## Keep things in order
Everything to save in this folder ~/crosscompile-tools
```
mkdir ~/crosscompile-tools
cd ~/crosscompile-tools
```

## Install Qt and Qt Creator
Go to the Qt page and install the latest version of Qt.
It will be enough with the online installer:
[http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run](http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run)

```
mv ~/Downloads/qt-unified-linux-x64-3.0.1-online.run ~/crosscompile-tools
chmod +x qt-unified-linux-x64-3.0.2-online.run
./qt-unified-linux-x64-3.0.2-online.run
```
And the installer will start.
I've installed in the path **/opt/Qt**

At this moment, the latest Qt Version, Qt 5.10, was released a few days ago, but for the cross compiling and Rpi, I couldn't compile with a newer version than 5.4 (The same as [the tutorial of reference](https://medium.com/@amirmann/how-to-cross-compile-qt-for-raspberry-pi-3-on-linux-ubuntu-for-beginners-75acf2a078c)). But, as I need additional features for newest versions, I've manage to install the package independently (E.g.: Qt Charts).

So, the qt version to install will be the latest one, with the source code and examples (Always it's good to have the latest one, at least in this case, to develop desktop applications) and the 5.4 with the source code and examples. Also, of course, the latest Qt Creator (We can cross compile for the Rpi with Qt5.4 and still use the desktop version of the latest Qt Creator).

Make the Qt 5.4 the default compiler and create a new project with QWidget, to check if it's working.

## Customized Linux Raspbian for Rpi
First, download Raspbian for Rpi.
As I said before, the latest version of Raspbian didn't work for me, instead of that, we will use Raspbian - Jessie version.

```
cd ~/crosscompile-tools
wget https://downloads.raspberrypi.org/raspbian/images/raspbian-2017-07-05/2017-07-05-raspbian-jessie.zip
```

You can try to install the latest Raspian version from [here](https://www.raspberrypi.org/downloads/raspbian/) or any images from [here](https://downloads.raspberrypi.org/raspbian/images/)

Mount the system,
```
sudo mkdir /mnt/rasp-pi-rootfs
unzip 2017-07-05-raspbian-jessie.zip
```
```
fdisk -l 2017-07-05-raspbian-jessie.img
```

And then, when we have the black size and the starting point,
```
sudo mount 2017-07-05-raspbian-jessie.img -o loop,offset=$(( 512 * 94208 )) /mnt/rasp-pi-rootfs/
```

If you go where the image is mounted, you should see,
[image]

## Set the toolchain
Get the cross compiler
```
cd ~/crosscompile-tools
git clone https://github.com/raspberrypi/tools.git
```

And fix the relative path according to our system mounted,
```
wget https://raw.githubusercontent.com/riscv/riscv-poky/master/scripts/sysroot-relativelinks.py
chmod +x sysroot-relativelinks.py
sudo ./sysroot-relativelinks.py /mnt/rasp-pi-rootfs
```

Note... Some people uses this script for fix the symbolic links: fixQualifiedLibraryPaths
https://exploreembedded.tumblr.com/

## Compile Qt
Go where the Source of Qt is installed,
```
cd /opt/Qt/5.4/Src/
```

And export where the cross compile is and the system mounted,

Ubuntu 64 bits
```
export RPI_SYSROOT=/mnt/rasp-pi-rootfs

export RPI_TOOLCHAIN=~/crosscompile-tools/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-
```

Or Ubuntu 32 Bits,
```
export RPI_SYSROOT=/mnt/rasp-pi-rootfs

export RPI_TOOLCHAIN=~/crosscompile-tools/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-
```

And then, start the compilation.

#### Configure

```
sudo ./configure -opengl es2 \
-device linux-rasp-pi-g++ -device-option CROSS_COMPILE=$RPI_TOOLCHAIN \
-sysroot $RPI_SYSROOT -opensource \
-confirm-license -optimized-qmake \
-reduce-exports -release -make libs \
-prefix /usr/local/qt5pi -skip qtwebkit
```

To avoid problems, I've skipped qtwebkit, and because is a big package, but you can remove this instruction.

For more information, [these are the options](http://doc.qt.io/qt-5/configure-options.html) for the configure.

After 3 minutes, the configure finishes.
You should not have errors at all.

Note... Different options for configure,
http://www.tal.org/building_qt_5_for_raspberrypi_jessie

#### Make

We probably want to do the "make" with our 4 processors, if you have.
```
sudo make -j4
```
After 20-30 minutes and not errors at all,


#### Install

```
sudo make install
```
After 1-2 minutes, the qt (rpi version) will be installed in our system and in the sysroot mounted (For flashing the rpi)

#### Results

After that, you should have:
1. A folder in your system with the Qt for Rpi,
[todo, picture]
2. In the Raspbian mounted, a folder with the Qt libraries,
[todo, picture]

## Compile some extra module
Once we have the QtBase installed, we don't want to limit with this modules and we will try to install another one.

Here in this tutorial we will install QtChart, because it was a needed library.

http://download.qt.io/official_releases/qt/5.7/5.7.1/submodules/

```
cd ~/crosscompile-tools
wget http://download.qt.io/official_releases/qt/5.7/5.7.1/submodules/qtcharts-opensource-src-5.7.1.tar.gz
sudo cp qtcharts-opensource-src-5.7.1.tar.gz /opt/Qt/5.4/Src/
cd /opt/Qt/5.4/Src/
sudo tar -zxf qtcharts-opensource-src-5.7.1.tar.gz
```

```
/usr/local/qt5pi/bin/qmake .
sudo make -j4 # 3-4 minutes
sudo make install
```

Make in 3-4 minutes, because it is only a module (Not error at all again) and make install in seconds.

http://wiki.qt.io/index.php?title=Raspberrypi_beginners_guide&redirect=no

## Qt Creator configuration

Before of umount the system.. (the system must be mounted when compile for rpi)

https://www.olimex.com/forum/index.php?topic=3826.0

https://www.ics.com/blog/configuring-qt-creator-raspberry-pi


## Flash SD Card
https://www.raspberrypi.org/documentation/installation/installing-images/

## First start
Static IP address
https://www.modmypi.com/blog/how-to-give-your-raspberry-pi-a-static-ip-address-update

Install a keyboard on screen
https://raspberrypi.stackexchange.com/questions/59849/how-to-install-on-screen-keyboard-in-raspbian-without-a-physical-keyboard

Enable SSH
https://www.raspberrypi.org/documentation/remote-access/ssh/

https://www.raspberrypi.org/forums/viewtopic.php?f=29&t=167326

You can always make a copy...
https://thepihut.com/blogs/raspberry-pi-tutorials/17789160-backing-up-and-restoring-your-raspberry-pis-sd-card

## References
* Cross compiling an "Hello World" application, without Qt.
[https://hackaday.com/2016/02/03/code-craft-cross-compiling-for-the-raspberry-pi/](https://hackaday.com/2016/02/03/code-craft-cross-compiling-for-the-raspberry-pi/)

* Linaro Compiler for ARM systems
[https://launchpad.net/gcc-linaro](https://launchpad.net/gcc-linaro)

* Qt for embedded Linux
[http://doc.qt.io/qt-5/embedded-linux.html](http://doc.qt.io/qt-5/embedded-linux.html)

## Errors
https://stackoverflow.com/questions/46654778/error-while-cross-compiling-qt-for-a-raspberry-pi3

```
Note: No wayland-egl support detected. Cross-toolkit compatibility disabled.
```

```
ERROR: The OpenGL functionality tests failed!
You might need to modify the include and library search paths by editing QMAKE_INCDIR_OPENGL[_ES2],
QMAKE_LIBDIR_OPENGL[_ES2] and QMAKE_LIBS_OPENGL[_ES2] in the mkspec for your platform.
```

https://forum.qt.io/topic/29795/qmake-can-t-find-wayland-egl-building-qtwayland/7

https://stackoverflow.com/questions/37059310/building-qt5-6-or-qt5-7-on-raspberry-pi3-or-and-pi-zero

## Hardware
https://www.sparkfun.com/products/13733
