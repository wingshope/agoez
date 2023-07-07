#!/bin/bash
#Script By Wings Premium VPN

BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

clear
echo -e "$BICyan┌──────────────────────────────────────────┐${NC}"
echo -e "$BICyan│           SERVER PORT INFORMATION        │$NC"       
echo -e "$BICyan└──────────────────────────────────────────┘${NC}"
echo -e "\033[1;93m  >Port SSH Websocket       :80\e[0m"
echo -e "\033[1;93m  >Port SSH Websocket SSL   :443\e[0m"
echo -e "\033[1;93m  >Port SSH SSL             :447,777\e[0m"
echo -e "\033[1;93m  >Port OpenSSH             :22\e[0m"
echo -e "\033[1;93m  >Port SSH Dropbear        :109,143\e[0m"
echo -e "\033[1;93m  >Port Xray None TLS       :80\e[0m"
echo -e "\033[1;93m  >Port Xray TLS            :443\e[0m"
echo -e "\033[1;93m  >Port Vmess None TLS      :80\e[0m"
echo -e "\033[1;93m  >Port Vmess TLS           :443\e[0m"
echo -e "\033[1;93m  >Port Vmess GRPC          :443\e[0m"
echo -e "\033[1;93m  >Port Vless None TLS      :80\e[0m"
echo -e "\033[1;93m  >Port Vless TLS           :443\e[0m"
echo -e "\033[1;93m  >Port Vless GRPC          :443\e[0m"
echo -e "\033[1;93m  >Port Trojan WS           :443\e[0m"
echo -e "\033[1;93m  >Port Trojan GRPC         :443\e[0m"
echo -e "\033[1;93m  >Port ShadowSocks WS      :443\e[0m"
echo -e "\033[1;93m  >Port ShadowSocks GRPC    :443\e[0m"
echo -e ""
echo -e "\033[1;97mOrder AutoScript Lifetime wa.me/6282261333421\e[0m"
echo -e ""
echo -e ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu
esac
