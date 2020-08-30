#!/bin/bash

TONOS_IP=$1
TONOS_USER=$2

sed "s/\${tonos_ip}/$TONOS_IP/; s/\${tonos_user}/$TONOS_USER/" \
    ../inventory.tpl > ../../ansible/inventory
