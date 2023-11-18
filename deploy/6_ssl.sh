#!/bin/bash

echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"
echo -e "${RED} .- Checking if SSL CERTIFICATE is present .${RESET}"
echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"

REMOTE_PATH=/home/dokku/${APP_NAME}/
FILENAME=cert-key.tar

if [ "$SSL_FLAG" = true ]; then

	ssh root@$IP <<EOF
echo -e "${RED}LETSENCRYPT.${RESET}"
sudo dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
dokku config:set --global --no-restart DOKKU_LETSENCRYPT_EMAIL=info@boomletter.com
dokku letsencrypt:set ${APP_NAME} email info@boomletter.com
dokku letsencrypt:enable ${APP_NAME}
dokku letsencrypt:cron-job --add

EOF
fi

if ssh -q "root@$IP" "[ -e '$REMOTE_PATH$FILENAME' ]"; then
	echo -e "${YELLOW} Certificate present .${RESET}"
else
	echo -e "${YELLOW} Certificate NOT present. Copying... ${RESET}"
	scp "./${FILENAME}" "root@$IP:$REMOTE_PATH"
	if [ $? -eq 0 ]; then
		echo -e "${YELLOW} Certificate copied sucessfully ${RESET}"
	else
		echo -e "${YELLOW} Certificate could not be copied. ${RESET}"
	fi

	ssh root@$IP <<EOF
dokku certs:add $APP_NAME < $REMOTE_PATH$FILENAME
dokku domains:set ${APP_NAME}  ${DOMAIN_NAME} 
EOF

fi

sleep 10
