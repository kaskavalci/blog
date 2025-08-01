---
layout: single
title: "ESP32 Atom M5Stack connection issues with Home Assistant"
tags:
 - linux
 - esp32
 - homeautomation
---

I recently upgraded to an Asus ZenWifi XT9 mesh system with one main router and
one mesh node. After setting up the mesh network, I needed to reconfigure all my
IoT devices to use the new network.

I have several ESP32 devices for home automation, particularly one that acts as a
Bluetooth gateway for Aranet4. When I flashed the [bluetooth
gateway](https://esphome.io/projects/?type=bluetooth) firmware and configured it
for the new network, Home Assistant couldn't connect to the device.

## The Problem

Home Assistant kept giving errors about including the API in the config YAML.
Even though the default configuration should have this already, I went ahead and
flashed the device locally with a custom config. Surprisingly, it still didn't
work.

## The Investigation

While troubleshooting, I discovered that Home Assistant couldn't ping the device,
but my laptop could reach it successfully. This was puzzling since both devices
were on the same subnet with no AP isolation enabled.

After scratching my head for a while, I got a hint from Gemini: the issue could
be related to the mesh node configuration.

## The Solution

I disabled the 2.4 GHz radio signal from the mesh node, which forced the Atom
M5Stack to connect to the main router instead. Immediately, Home Assistant could
connect to the device successfully.

## Why This Happens

Mesh networks can sometimes create connectivity issues between devices, even when
they appear to be on the same network. The mesh node's radio configuration can
interfere with device-to-device communication, especially for IoT devices that
rely on specific network behaviors.

This was a tricky issue to diagnose, but disabling the mesh node's 2.4 GHz radio
resolved the connectivity problem between Home Assistant and the ESP32 device.
