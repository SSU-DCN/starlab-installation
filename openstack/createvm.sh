#!/bin/bash

echo "What is the flavor id?"
read -r FLAVOR_ID

echo "What is the image id?"
read -r IMAGE_ID

echo "what is the keypair-name?"
read -r KEYPAIR

echo "what is the security-group?"
read -r SECURITY_GROUP

echo "What is the network id?"
read -r NET_ID

echo "What is the name of instance?"
read -r NAME

echo "How many instances? "
read -r INSTANCES

for (( i=0; i<INSTANCES; i++ ))
do
    INSTANCE_NAME=$NAME$i
    openstack server create --flavor $FLAVOR_ID --image $IMAGE_ID --key-name $KEYPAIR --security-group $SECURITY_GROUP --nic net-id=$NET_ID $INSTANCE_NAME
done
