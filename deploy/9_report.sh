#!/bin/bash
echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"
echo -e "${GREEN}9. Deployment completed.${RESET}"
echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"

ssh "root@$IP" <<EOF

echo -e "${GREEN}:::::::::::::::::::::::::::::::CURRENT ENV:::::::::::::::::::::::::::::::::::::${RESET}"
dokku config ${APP_NAME}
echo -e "${GREEN}::::::::::::::::::::::::::::::: APP REPORT:::::::::::::::::::::::::::::::::::::${RESET}"
dokku ps:report ${APP_NAME}
echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"
dokku storage:report ${APP_NAME}
echo -e "${GREEN}::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${RESET}"


echo -e "${YELLOW}  ssh root@${IP}  ${RESET}"
echo -e "${YELLOW} dokku logs ${APP_NAME} -t ${RESET}"

EOF

echo -e "${YELLOW}${APP_NAME} Deployed to: ${IP}${RESET}"
echo -e "${YELLOW}  ssh root@${IP}  ${RESET}"
echo -e "${YELLOW} dokku logs ${APP_NAME} -t ${RESET}"
