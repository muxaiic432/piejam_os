# PieJam OS
This repository contains a `buildroot` based Linux distribution for
the [PieJam](https://github.com/nooploop/piejam) audio mixer application,
optimized as a dedicated DAW for the Behringer Flow 8 mixer.
It's a minimal Linux system which starts PieJam directly after boot with
low-latency audio support and professional audio interface integration.

## Supported devices

#### SoC
* Raspberry Pi 2B
* Raspberry Pi 3B
* Raspberry Pi 4B

#### Sound Cards
* Behringer Flow 8 (primary target)
* Most USB Audio Class compliant interfaces
* Professional USB audio interfaces with MIDI support

#### MIDI Controllers
* USB MIDI controllers and interfaces
#### Screen
* Only the official 7" Raspberry Pi touchscreen

## Build

#### Raspberry Pi 2B
```
make raspberrypi2
```

#### Raspberry Pi 3B
```
make raspberrypi3
```

#### Raspberry Pi 4B
```
make raspberrypi4
```

## Installation
The build step will create an image, which you need to copy to a microSD card:
```
dd if=br2_external/output/raspberrypi2/images/sdcard.img of=/dev/sdX
```
Replace `/dev/sdX` with the device for your microSD card.

## DAW Features

This enhanced version includes:

* **Low-latency audio**: Optimized kernel and JACK audio server
* **Behringer Flow 8 support**: Automatic detection and configuration
* **Real-time scheduling**: CPU isolation and priority optimization
* **Professional audio**: 8-channel I/O with MIDI support
* **USB audio optimization**: Enhanced drivers and buffer management
* **ALSA/JACK integration**: Professional audio routing capabilities

## Usage

Connect your Behringer Flow 8 via USB before powering on. The system will automatically detect and configure the audio interface for optimal DAW performance.
```
Replace `/dev/sdX` with the device for your microSD card.