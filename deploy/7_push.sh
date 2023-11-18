#!/bin/bash

echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"
echo -e "${RED}5. Push...${RESET}"
echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"
git remote remove dokku
git remote add dokku dokku@$IP:$APP_NAME
git push dokku $DEPLOY_BRANCH:master
