#!/bin/bash

set -x

# Define network interface configurations
sudo ip addr add 192.168.10.1/24 dev ens4f0np0
sudo ip link set dev ens4f0np0 mtu 9000

sudo ip addr add 192.168.20.1/24 dev ens4f1np1
sudo ip link set dev ens4f1np1 mtu 9000
