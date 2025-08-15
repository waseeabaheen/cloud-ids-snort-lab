#!/usr/bin/env bash
# Quick-start OpenStack commands (run with your openrc sourced).
set -euo pipefail

NET_NAME=ids-net
SUBNET_NAME=ids-subnet
ROUTER_NAME=ids-router
CIDR=10.10.10.0/24
IMAGE="Ubuntu 22.04"
FLAVOR="m1.small"
KEYNAME="ids-key"
SECGRP="ids-sec"

openstack network create $NET_NAME || true
openstack subnet create --subnet-range $CIDR --network $NET_NAME $SUBNET_NAME || true
openstack router create $ROUTER_NAME || true
openstack router set --external-gateway public $ROUTER_NAME || true
openstack router add subnet $ROUTER_NAME $SUBNET_NAME || true

openstack security group create $SECGRP || true
openstack security group rule create --ingress --protocol icmp $SECGRP || true
openstack security group rule create --ingress --protocol tcp --dst-port 22 $SECGRP || true
openstack security group rule create --egress $SECGRP || true

# Sensor VM
openstack server create --image "$IMAGE" --flavor "$FLAVOR" --key-name $KEYNAME   --security-group $SECGRP --network $NET_NAME --user-data cloud-init-sensor.yaml sensor || true
openstack floating ip create public
SENSOR_FIP=$(openstack floating ip list -f value -c 'Floating IP Address' | tail -n1)
openstack server add floating ip sensor $SENSOR_FIP

# Attacker VM
openstack server create --image "$IMAGE" --flavor "$FLAVOR" --key-name $KEYNAME   --security-group $SECGRP --network $NET_NAME --user-data cloud-init-attacker.yaml attacker || true
openstack floating ip create public
ATTACKER_FIP=$(openstack floating ip list -f value -c 'Floating IP Address' | tail -n1)
openstack server add floating ip attacker $ATTACKER_FIP

echo "Sensor FIP: $SENSOR_FIP"
echo "Attacker FIP: $ATTACKER_FIP"
