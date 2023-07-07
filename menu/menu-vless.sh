#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`

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

BURIQ () {
    curl -sS https://raw.githubusercontent.com/wingshope/permission/main/ip > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/wingshope/permission/main/ip | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/wingshope/permission/main/ip | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi
clear

function detailvless(){
clear
MYIP=$(wget -qO- ipv4.icanhazip.com);
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
        if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
                echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                echo -e "\\E[0;41;36m     Check Detail XRAY Vless     \E[0m"
                echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                echo ""
                echo "You have no existing clients!"
                clear
                exit 1
        fi

        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\\E[0;41;36m     Check Detail XRAY Vless     \E[0m"
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo " Select the existing client to view the config"
        echo " Press CTRL+C to return"
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo "     No  User   Expired"
        grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
                if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                        read -rp "Select one client [1]: " CLIENT_NUMBER
                else
                        read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
                fi
        done
user=$(cat /etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
domain=$(cat /etc/xray/domain)
uuid=$(grep "},{" /etc/xray/config.json | cut -b 11-46 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
hariini=`date -d "0 days" +"%Y-%m-%d"`

vlesslink1="vless://${uuid}@${domain}:443?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:80?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=bug.com#${user}"

clear
echo -e ""
echo -e "\033[0;34m═════════════XRAY/VLESS═════════════${NC}"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "Expired On     : $exp"
echo -e "Port TLS       : 443"
echo -e "Port none TLS  : 80"
echo -e "Port gRPC      : 443"
echo -e "ID             : ${uuid}"
echo -e "Encryption     : none"
echo -e "Network        : ws"
echo -e "Path           : /vless"
echo -e "Path           : vless-grpc"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Link TLS       : ${vlesslink1}"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Link none TLS  : ${vlesslink2}"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Link gRPC      : ${vlesslink3}"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu-vless
}
function trialvless(){
user=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
uuid=$(cat /proc/sys/kernel/random/uuid)
domain=$(cat /etc/xray/domain)
masaaktif=1
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
vlesslink1="vless://${uuid}@${domain}:443?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:80?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=bug.com#${user}"
systemctl restart xray
clear
echo -e "\033[0;34m═════════════XRAY/VLESS═════════════${NC}"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "Port TLS       : 443"
echo -e "Port none TLS  : 80"
echo -e "Port gRPC      : 443"
echo -e "ID             : ${uuid}"
echo -e "Encryption     : none"
echo -e "Network        : ws"
echo -e "Path           : /vless"
echo -e "Path           : vless-grpc"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Link TLS       : ${vlesslink1}"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Link none TLS  : ${vlesslink2}"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Link gRPC      : ${vlesslink3}"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo -e "Expired On     : $exp"
echo -e "\033[0;34m════════════════════════════════════\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu-vless
}
function cekws() {
clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '###' | cut -d ' ' -f 2 | sort | uniq`);
echo "-------------------------------";
echo "-----=[ XRAY User Login ]=-----";
echo "-------------------------------";
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/ipxray.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipxray.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipxray.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipxray.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipxray.txt | nl)
lastlogin=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 2 | tail -1)
echo -e "user :${GREEN} ${akun} ${NC}
${RED}Online Jam ${NC}: ${lastlogin} wib";
echo -e "$jum2";
echo "-------------------------------"
fi
rm -rf /tmp/ipxray.txt
done
rm -rf /tmp/other.txt

echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}
function renewws(){
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "\\E[0;41;36m            Renew Vless            \E[0m"
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
		echo ""
		echo "You have no existing clients!"
		echo ""
		echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        menu
	fi

	clear
	echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "\\E[0;41;36m            Renew Vless            \E[0m"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
  	grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
    echo ""
    red "tap enter to go back"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
	read -rp "Input Username : " user
    if [ -z $user ]; then
    menu
    else
    read -p "Expired (days): " masaaktif
    exp=$(grep -wE "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
    now=$(date +%Y-%m-%d)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(( (d1 - d2) / 86400 ))
    exp3=$(($exp2 + $masaaktif))
    exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
    sed -i "/### $user/c\### $user $exp4" /etc/xray/config.json
    systemctl restart xray > /dev/null 2>&1
    clear
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo " Vless Account Was Successfully Renewed"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo " Client Name : $user"
    echo " Expired On  : $exp4"
    echo ""
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
  fi
}
function delws() {
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "\\E[0;41;36m       Delete XRAY  Account        \E[0m"
        echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
		echo ""
		echo "You have no existing clients!"
		echo ""
		echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
		read -n 1 -s -r -p "Press any key to back on menu"
        menu
	fi

	clear
	echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "\\E[0;41;36m       Delete XRAY Account        \E[0m"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo "  User       Expired  " 
	echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
	grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
    echo ""
    red "tap enter to go back"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
	read -rp "Input Username : " user
    if [ -z $user ]; then
    menu
    else
    exp=$(grep -wE "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
    sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
    systemctl restart xray > /dev/null 2>&1
    clear
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo " XRAY Account Deleted Successfully"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo " Client Name : $user"
    echo " Expired On  : $exp"
    echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    
    menu
    fi
}
clear
echo -e "${BICyan}┌─────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan}│                     VLESS MENU                  │$NC"
echo -e "${BICyan}└─────────────────────────────────────────────────┘${NC}"
echo -e " ${BICyan}┌───────────────────────────────────────────────┐${NC}"
echo -e "     ${BICyan}[${BIWhite}1${BICyan}] Create Vless Account     "
echo -e "     ${BICyan}[${BIWhite}2${BICyan}] Trial Vless Acoount     "
echo -e "     ${BICyan}[${BIWhite}3${BICyan}] Delete Account Vless     "
echo -e "     ${BICyan}[${BIWhite}4${BICyan}] Renew Account Vless     "
echo -e "     ${BICyan}[${BIWhite}5${BICyan}] Cek User Active XRAY     "
echo -e "     ${BICyan}[${BIWhite}6${BICyan}] Detail Account Vless     "

echo -e "     ${BICyan}[${BIWhite}0${BICyan}] Back To Menu     "
echo -e " ${BICyan}└──────────────────────────────────────────────┘${NC}"
echo ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; add-vless ;;
2) clear ; trialvless ;;
3) clear ; delws;;
4) clear ; renewws ;;
5) clear ; cekws;;
6) clear ; detailvless;;
0) clear ; menu ;;
x) exit ;;
*) echo -e "" ; echo "Press any key to back on menu" ; sleep 1 ; menu ;;
esac
