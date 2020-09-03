#!/bin/bash

TONOS_IP=$1
TONOS_USER=$2
GIT_SSH_ID_PATH=$3

INVENTORY=../../ansible/inventory
INVENTORY_TEMPLATE=../templates/inventory.tpl

cp -a $INVENTORY_TEMPLATE $INVENTORY

sed -i "s|\${tonos_ip}|$TONOS_IP|" $INVENTORY
sed -i "s|\${tonos_user}|$TONOS_USER|" $INVENTORY
sed -i "s|\${git_ssh_id_path}|$GIT_SSH_ID_PATH|" $INVENTORY
