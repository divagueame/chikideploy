#!/bin/bash
echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"
echo -e "${GREEN}   2.Setup {RESET}    "
echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"

source ./.env

APP_NAME=$(basename "$PWD")
declare -n IP="${APP_NAME^^}_IP"

current_branch=$(git rev-parse --abbrev-ref HEAD)
DEPLOY_BRANCH=${current_branch:-main}
MASTER_KEY=$(cat ./config/master.key)

if [ -z "$IP" ]; then
	read -p "Enter the IP: " IP

	if [ -z "$IP" ]; then
		echo "ABORTED"
		exit 1
	fi

	if ! validate_ip $IP; then
		exit 1
	fi

	echo "${APP_NAME^^}_IP=$IP" >>.env
fi

if [ -z "$DOMAIN_NAME" ]; then
	read -p "Enter the domain name. i.e. my-domain.com    :  " DOMAIN_NAME

	if [ -z "$DOMAIN_NAME" ]; then
		echo "NO VALID DOMAIN. EXITING"
		exit 1
	fi
	echo DOMAIN_NAME=$DOMAIN_NAME >>.env
fi

SSL_FLAG=false
# SSL_FLAG=true

echo -e "${YELLOW}"
echo "APP_NAME: $APP_NAME"
echo "IP: $IP"
echo "DOMAIN_NAME: $DOMAIN_NAME"
echo "DEPLOY_BRANCH: $DEPLOY_BRANCH"
echo "SSL_FLAG: $SSL_FLAG"
echo -e "${RESET}"
