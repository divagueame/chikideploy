#!/bin/bash

ssh root@$IP <<EOF
echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"
echo -e "${GREEN}1. Install DOKKU.${RESET}"
echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"

if [ ! -f "bootstrap.sh" ]; then
wget -NP . https://dokku.com/install/v0.32.3/bootstrap.sh

while [ ! -f "bootstrap.sh" ]; do
  echo -e "${YELLOW}Waiting for Bootstrap installation..${RESET}"
  sleep 3 
done
fi
sleep 3

if ! command -v dokku &> /dev/null; then
sudo DOKKU_TAG=v0.32.3 bash bootstrap.sh
  while ! command -v dokku &> /dev/null; do
  	echo -e "${YELLOW}Waiting for Dokku installation..${RESET}"
    sleep 1 
  done
else
  echo -e "${YELLOW}Dokku is already installed.${RESET}"
fi

cat ~/.ssh/authorized_keys | dokku ssh-keys:add admin

while ! command -v dokku &> /dev/null; do
	echo "Waiting for dokku"
    sleep 3  # Wait for 1 second
done

echo -e "${YELLOW}Creating dokku app${RESET}"
dokku apps:create ${APP_NAME}
sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git
dokku postgres:create ${APP_NAME}_production
dokku postgres:link ${APP_NAME}_production ${APP_NAME}

dokku plugin:install https://github.com/dokku/dokku-redis.git redis
dokku redis:create ${APP_NAME}_redis
dokku redis:link ${APP_NAME}_redis ${APP_NAME}

echo -e "${YELLOW}Setting up domain names${RESET}"
dokku domains:set-global ${IP}
dokku domains:set-global ${IP}.sslip.io 

dokku ports:set ${APP_NAME} http:80:3000

echo -e "${YELLOW}Setting up env variables${RESET}"
dokku config:set ${APP_NAME} RAILS_ENV=production
dokku config:set ${APP_NAME} RAILS_MASTER_KEY=$MASTER_KEY
dokku config:set ${APP_NAME} DEPLOY_BRANCH=$DEPLOY_BRANCH

echo -e "${YELLOW}Setting up persistent storage${RESET}"
dokku storage:ensure-directory ${APP_NAME}
dokku storage:mount ${APP_NAME} /var/lib/dokkudata/storage/${APP_NAME}:/app/public/uploads


EOF

# echo -e "${RED} - NginX.${RESET}"
# rm /etc/nginx/sites-enabled/default
# dokku nginx:stop
# dokku nginx:start

###### END SERVER SIDE #######
