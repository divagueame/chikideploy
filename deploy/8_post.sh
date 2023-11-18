#!/bin/bash

echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"
echo -e "${RED}6. Post${RESET}"
echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"
ssh root@$IP <<EOF
dokku run $APP_NAME rake db:migrate
dokku run $APP_NAME rake db:seed
EOF
