#!/bin/bash
 # ========================================= 
 vlx=$(grep -c -E "^#& " "/etc/xray/config.json") 
 let vla=$vlx/2 
 vmc=$(grep -c -E "^### " "/etc/xray/config.json") 
 let vma=$vmc/2 
 ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)" 
  
 trx=$(grep -c -E "^#! " "/etc/xray/config.json") 
 let tra=$trx/2 
 ssx=$(grep -c -E "^## " "/etc/xray/config.json") 
 let ssa=$ssx/2
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
#Download/Upload today 
 dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')" 
 utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')" 
 ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')" 
 #Download/Upload yesterday 
 dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')" 
 uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')" 
 tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')" 
 #Download/Upload current month 
 dmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($4, 1, 1)}')" 
 umon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($7, 1, 1)}')" 
 tmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')" 
 clear
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
    curl -sS https://raw.githubusercontent.com/wingshope10/permission/main/ip > /root/tmp
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
Name=$(curl -sS https://raw.githubusercontent.com/wingshope10/permission/main/ip | grep $MYIP | awk '{print $2}')
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
    IZIN=$(curl -sS https://raw.githubusercontent.com/wingshope10/permission/main/ip | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}


x="ok"


PERMISSION

if [ "$res" = "Expired" ]; then
Exp="\e[36mExpired\033[0m"
rm -f /home/needupdate > /dev/null 2>&1
else
Exp=$(curl -sS https://raw.githubusercontent.com/wingshope10/permission/main/ip | grep $MYIP | awk '{print $3}')
fi

# // Clear
clear
clear && clear && clear
clear;clear;clear
cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
ssh=$(service ssh status | grep active | cut -d ' ' $stat)
if [ "$ssh" = "active" ]; then
ressh="${green}ON${NC}"
else
ressh="${red}OFF${NC}"
fi
sshstunel=$(service stunnel5 status | grep active | cut -d ' ' $stat)
if [ "$sshstunel" = "active" ]; then
resst="${green}ON${NC}"
else
resst="${red}OFF${NC}"
fi
sshws=$(service ws-stunnel status | grep active | cut -d ' ' $stat)
if [ "$sshws" = "active" ]; then
ressshws="${green}ON${NC}"
else
ressshws="${red}OFF${NC}"
fi
ngx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$ngx" = "active" ]; then
resngx="${green}ON${NC}"
else
resngx="${red}OFF${NC}"
fi
dbr=$(service dropbear status | grep active | cut -d ' ' $stat)
if [ "$dbr" = "active" ]; then
resdbr="${green}ON${NC}"
else
resdbr="${red}OFF${NC}"
fi
v2r=$(service xray status | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then
resv2r="${green}ON${NC}"
else
resv2r="${red}OFF${NC}"
fi

ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10)
CITY=$(curl -s ipinfo.io/city)
IPVPS=$(curl -s ipinfo.io/ip)
UDPX="https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2"
clear
echo -e "${PURPLE} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${PURPLE} │  ${PURPLE}  Use Core       : ${BIGreen}Wings Tunneling ${NC}" 
echo -e " ${PURPLE}│  ${PURPLE}  OS VPS         : "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-` $NC
echo -e " ${PURPLE}│  ${PURPLE}  Current Domain : ${BIGreen}$(cat /etc/xray/domain)${NC}"
echo -e " ${PURPLE}│  ${PURPLE}  SLOWDNS Domain : ${BIGreen}$(cat /root/nsdomain)${NC}"
echo -e " ${PURPLE}│  ${PURPLE}  IP-VPS         : ${BIGreen}$IPVPS${NC}"
echo -e " ${PURPLE}│  ${PURPLE}  ISP-Name       : ${BIGreen}$ISP${NC}"
echo -e " ${PURPLE}│  ${BIGreen}  DATE&TIME      : $( date -d "0 days" +"%d-%m-%Y | %X" ) ${NC}"
echo -e " ${PURPLE}└─────────────────────────────────────────────────────┘${NC}"
echo -e "${PURPLE} ┌─────────────────────────────────────────────────────┐${NC}" 
echo -e "${PURPLE} │ \033[0m ${BOLD}${PURPLE}     SSH      VMESS       VLESS      TROJAN $NC" 
echo -e "${PURPLE} │ \033[0m ${Blue}      $ssh1         $vma           $vla           $tra $NC" 
echo -e "${PURPLE} └─────────────────────────────────────────────────────┘${NC}" 

echo -e " ${BIPurple}    SSH ${NC}: $ressh"" ${BIPurple} NGINX ${NC}: $resngx"" ${BIPurple}  XRAY ${NC}: $resv2r"" ${BIPurple} TROJAN ${NC}: $resv2r"
echo -e " ${BIPurple}            DROPBEAR ${NC}: $resdbr" "${BIPurple} SSH-WS ${NC}: $ressshws"
echo -e "${PURPLE} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "  ${PURPLE}  [${BIGreen}1${PURPLE}]${GREEN} SSH/UDP/SlowDNS ${NC}" 
echo -e "  ${PURPLE}  [${BIGreen}2${PURPLE}]${GREEN} VMESS ${NC}"    
echo -e "  ${PURPLE}  [${BIGreen}3${PURPLE}]${GREEN} VLESS ${NC}"    
echo -e "  ${PURPLE}  [${BIGreen}4${PURPLE}]${GREEN} TROJAN ${NC}" 
echo -e "  ${PURPLE}  [${BIGreen}5${PURPLE}]${GREEN} SHADOWSOCKS ${NC}"    
echo -e "  ${PURPLE}  [${BIGreen}6${PURPLE}]${GREEN} BACKUP/RESTORE ${NC}"    
echo -e "  ${PURPLE}  [${BIGreen}7${PURPLE}]${GREEN} SETTINGS ${NC}"    
echo -e "  ${PURPLE}  [${BIGreen}8${PURPLE}]${GREEN} INFO SCRIPT ${NC}"  
echo -e "  ${PURPLE}  [${BIGreen}9${PURPLE}]${GREEN} INFO SERVER ${NC}"    
echo -e "  ${PURPLE}  [${BIGreen}10${PURPLE}]${GREEN}INSTAL UDP ${NC}" 
echo -e "  ${PURPLE}  [${BIGreen}x${PURPLE}]${GREEN} EXIT ${NC}"  
echo -e "${PURPLE} └─────────────────────────────────────────────────────┘${NC}"
 echo -e "${PURPLE} ┌─────────────────────────────────────────────────────┐${NC}" 
 echo -e "${PURPLE} │  ${BIGreen}     HARI ini${NC}: ${red}$ttoday$NC ${BIGreen}KEMARIN${NC}: ${red}$tyest$NC ${BIGreen}BULAN${NC}: ${red}$tmon$NC $NC" 
 echo -e "${PURPLE} └─────────────────────────────────────────────────────┘${NC}"
DATE=$(date +'%d %B %Y')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
   echo -e " ${PURPLE}│$NC  Expiry In     : $(( (d1 - d2) / 86400 )) Days $NC"
}
mai="datediff "$Exp" "$DATE""
echo -e " ${PURPLE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e " ${PURPLE}│  Version       : $(cat /opt/.ver) Last Update ${NC}"
echo -e " ${PURPLE}│  User          :\033[1;36m $Name \e[0m"
if [ $exp \< 1000 ];
then
echo -e " ${PURPLE}│$NC License     :${PURPLE}$sisa_hari$NC Days Tersisa $NC"
else
    datediff "$Exp" "$DATE"
fi;
echo -e " ${PURPLE}└─────────────────────────────────────────────────────┘${NC}"
echo
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; menu-vmess ;;
3) clear ; menu-vless ;;
4) clear ; menu-trojan ;;
5) clear ; menu-ss ;;
6) clear ; menu-backup ;;
7) clear ; menu-set ;;
8) clear ; info ;;
9) clear ; infoserv ;;
10) clear ; clear ; wget --load-cookies /tmp/cookies.txt ${UDPX} -O install-udp && rm -rf /tmp/cookies.txt && chmod +x install-udp && ./install-udp ;;
99) clear ; update ;;
0) clear ; menu ;;
x) exit ;;
*) echo -e "" ; echo "Press any key to back exit" ; sleep 1 ; exit ;;
esac
