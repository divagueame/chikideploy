#!/bin/bash

validate_ip() {
	local ip="$1"
	local ip_regex="^([0-9]{1,3}\.){3}[0-9]{1,3}$"

	if [[ $ip =~ $ip_regex ]]; then
		# The IP address is valid
		echo "Valid IP address: $ip"
		return 0
	else
		# The IP address is not valid
		echo "Invalid IP address: $ip"
		return 1
	fi
}
