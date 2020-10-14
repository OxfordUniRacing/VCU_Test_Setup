#!/bin/sh

# vcu reset pin
config-pin p9.30 gpio
echo out > /sys/class/gpio/gpio112/direction
echo 1 > /sys/class/gpio/gpio112/value

ip link set can0 up type can bitrate 1000000

# vcu uart3
config-pin P9.24 uart
config-pin P9.26 uart
stty -F /dev/ttyS1 cs8 115200 raw -echo -echoe -echok -echoctl -echoke

# motor controller uart 1
config-pin P9.21 uart
config-pin P9.22 uart
stty -F /dev/ttyS2 cs8 115200 raw -echo -echoe -echok -echoctl -echoke

# motor controller uart 2
config-pin P9.11 uart
config-pin P9.13 uart
stty -F /dev/ttyS4 cs8 115200 raw -echo -echoe -echok -echoctl -echoke
