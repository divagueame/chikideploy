#!/bin/bash

if ssh -o BatchMode=yes -o ConnectTimeout=5 -o StrictHostKeyChecking=no "root@$IP" exit; then
	echo "SSH access is successful."
else
	echo "SSH access failed. Exiting."
	exit 1
fi
