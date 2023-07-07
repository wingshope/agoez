#!/bin/bash
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

echo -e "$COLOR1┌──────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}          SERVER PORT INFORMATION       ${NC} $COLOR1│$NC"       
echo -e "$COLOR1└──────────────────────────────────────────┘${NC}"
echo -e "\033[1;93m  >Port SSH Websocket       :80\e[0m"
echo -e "\033[1;93m  >Port SSH Websocket SSL   :443\e[0m"
echo -e "\033[1;93m  >Port SSH SSL             :222,777\e[0m"
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
echo -e "\033[1;94m >>>>Service Support Change Port<<<< \e[0m"
echo -e ""
echo -e "\033[1;97mOrder AutoScript Lifetime wa.me/6283117634078\e[0m"
echo -e ""

clear
echo -e ""
echo -e "======================================"
echo -e ""
echo -e ""
echo -e "    [1] Restart All Services"
echo -e "    [2] Restart OpenSSH"
echo -e "    [3] Restart Dropbear"
echo -e "    [4] Restart Stunnel5"
echo -e "    [5] Restart Nginx"
echo -e "    [6] Restart Badvpn"
echo -e "    [x] Menu"
echo -e ""
read -p "    Select From Options [1-6 or x] :  " Restart
echo -e ""
echo -e "======================================"
sleep 1
clear
case $Restart in
                1)
                clear
                #systemctl restart ws-dropbear.service >/dev/null 2>&1
                systemctl restart ws-stunnel.service >/dev/null 2>&1
                systemctl restart xray.service >/dev/null 2>&1
                /etc/init.d/ssh restart
                /etc/init.d/dropbear restart
                /etc/init.d/stunnel5 restart
                /etc/init.d/fail2ban restart
                /etc/init.d/cron restart
                /etc/init.d/nginx restart
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
                systemctl restart rc-local.service
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "          Service/s Restarted         "
                echo -e ""
                echo -e "======================================"
                ;;
                2)
                clear
                /etc/init.d/ssh restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "         SSH Service Restarted        "
                echo -e ""
                echo -e "======================================"
                ;;
                3)
                clear
                /etc/init.d/dropbear restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "       Dropbear Service Restarted     "
                echo -e ""
                echo -e "======================================"
                ;;
                4)
                clear
                /etc/init.d/stunnel5 restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "        Stunnel5 Service Restarted    "
                echo -e ""
                echo -e "======================================"
                ;;
                5)
                clear
                /etc/init.d/nginx restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "         Nginx Service Restarted      "
                echo -e ""
                echo -e "======================================"
                ;;
                6)
                clear
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
                systemctl restart rc-local.service >/dev/null 2>&1
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "    Badvpn  Badvpn Service Restarted  "
                echo -e ""
                echo -e "======================================"
                ;;
                x)
                clear
                menu
                ;;
        esac
read -n 1 -s -r -p "Press any key to back on menu"

menu
