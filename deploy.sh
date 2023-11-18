#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

source "$SCRIPT_DIR/deploy/1_utils.sh"
source "$SCRIPT_DIR/deploy/2_colors.sh"
source "$SCRIPT_DIR/deploy/3_setup.sh" $1
source "$SCRIPT_DIR/deploy/4_update_vps.sh"
source "$SCRIPT_DIR/deploy/5_install_dokku.sh"
source "$SCRIPT_DIR/deploy/6_ssl.sh"
source "$SCRIPT_DIR/deploy/7_push.sh"
# source "$SCRIPT_DIR/deploy/8_post.sh"
source "$SCRIPT_DIR/deploy/9_report.sh"
