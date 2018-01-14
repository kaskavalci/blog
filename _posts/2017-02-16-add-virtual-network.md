---
layout: single
title:  "Add a virtual network interface"
date:   2017-02-16 08:57:04 +0300
categories: network
---
# Add a virtual network interface

## Set environmental variables

You will need following information of the real interface. (ie: `ifconfig eth0`)
* IP address
* IP Mask
* Broadcast Address
```shell
# Real interface that virtual one will direct
export REAL_INTERFACE_NAME=eth0
# Fake interface name
export COMMON_INTERFACE_NAME=vinterface
# IP address of REAL_INTERFACE_NAME
export REAL_IP=$(ifconfig $REAL_INTERFACE_NAME | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
# Mask bit of real interface
export REAL_MASK=24
# Broadcast IP of real interface (0.0.0.0 for docker container)
export REAL_BROADCAST_IP=$(ifconfig eth0 | grep 'Bcast:' | cut -d: -f3 | awk '{print $1}')
# Random ID. Leave it if you will add only one interface
export VLAN_ID=32
```

## Execute them all

```shell
ip link add link $REAL_INTERFACE_NAME name $COMMON_INTERFACE_NAME type vlan id $VLAN_ID
ip link
ip -d link show $COMMON_INTERFACE_NAME
ip addr add $REAL_IP/$REAL_MASK brd $REAL_BROADCAST_IP dev $COMMON_INTERFACE_NAME
ip link set dev $COMMON_INTERFACE_NAME up
```

## (Optional) Check if interface appears

```shell
ifconfig
```
# Remove interface
```shell
ip link delete $COMMON_INTERFACE_NAME
```
