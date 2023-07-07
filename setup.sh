#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi
clear
# // Exporting Language to UTF-8
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
BIRed='\033[1;91m'
red='\e[1;31m'
bo='\e[1m'
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
# // Export Banner Status Information
export EROR="[${RED} ERROR ${NC}]"
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
    rm -f  /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f  /root/tmp
}
# https://raw.githubusercontent.com/wingshope/permission/main/ip 
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

clear
#System version number
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi
mkdir -p /etc/xray

echo -e "${tyblue} Welcome To Wings AutoScript......${NC} "
sleep 2
echo -e "[ ${green}INFO${NC} ] Preparing the install file"
apt install git curl -y >/dev/null 2>&1
echo -e "[ ${green}INFO${NC} ] installation file is ready"
sleep 2
echo -ne "[ ${green}INFO${NC} ] Check your permission : "

PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
green "Permission Accepted!"
else
red "Permission Denied!
Please Buy AutoScript Premium
WA: 082261333421
Telegram: t.me/wingsofhope"
rm setup.sh > /dev/null 2>&1
sleep 10
exit 0
fi
sleep 3

# // cek old script
if [[ -r /etc/xray/domain ]]; then
clear
echo -e "${INFO} Having Script Detected !"
echo -e "${INFO} If You Replacing Script, All Client Data On This VPS Will Be Cleanup !"
read -p "Are You Sure Wanna Replace Script ? (Y/N) " josdong
if [[ $josdong == "Y" ]]; then
clear
echo -e "${INFO} Starting Replacing Script !"
elif [[ $josdong == "y" ]]; then
clear
echo -e "${INFO} Starting Replacing Script !"
rm -rf /var/lib/scrz-prem 
elif [[ $josdong == "N" ]]; then
echo -e "${INFO} Action Canceled !"
exit 1
elif [[ $josdong == "n" ]]; then
echo -e "${INFO} Action Canceled !"
exit 1
else
echo -e "${EROR} Your Input Is Wrong !"
exit 1
fi
clear
fi
echo -e "${GREEN}Starting Installation............${NC}"
# // Go To Root Directory
cd /root/
# // Remove
apt-get remove --purge nginx* -y
apt-get remove --purge nginx-common* -y
apt-get remove --purge nginx-full* -y
apt-get remove --purge dropbear* -y
apt-get remove --purge stunnel4* -y
apt-get remove --purge apache2* -y
apt-get remove --purge ufw* -y
apt-get remove --purge firewalld* -y
apt-get remove --purge exim4* -y
apt autoremove -y

# // Update
apt update -y

# // Install Requirement Tools
apt-get --reinstall --fix-missing install -y sudo dpkg psmisc socat jq ruby wondershaper python2 tmux nmap bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget vim net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential gcc g++ automake make autoconf perl m4 dos2unix dropbear libreadline-dev zlib1g-dev libssl-dev dirmngr libxml-parser-perl neofetch git lsof iptables iptables-persistent
apt-get --reinstall --fix-missing install -y libreadline-dev zlib1g-dev libssl-dev python2 screen curl jq bzip2 gzip coreutils rsyslog iftop htop zip unzip net-tools sed gnupg gnupg1 bc sudo apt-transport-https build-essential dirmngr libxml-parser-perl neofetch screenfetch git lsof openssl easy-rsa fail2ban tmux vnstat dropbear libsqlite3-dev socat cron bash-completion ntpdate xz-utils sudo apt-transport-https gnupg2 gnupg1 dnsutils lsb-release chrony
gem install lolcat

# // Update & Upgrade
apt update -y
apt upgrade -y
apt dist-upgrade -y

# // Clear
clear
clear && clear && clear
clear;clear;clear

# // Starting Setup Domain
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo -e "Anda Ingin Menggunakan Domain Pribadi ?"
echo -e "Atau Ingin Menggunakan Domain Otomatis ?"
echo -e "Jika Ingin Menggunakan Domain Pribadi, Ketik ${GREEN}1${NC}"
echo -e "dan Jika Ingin menggunakan Domain Otomatis, Ketik ${GREEN}2${NC}"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo ""

read -p "$( echo -e "${GREEN}Input Your Choose ? ${NC}(${YELLOW}1/2${NC})${NC} " )" choose_domain

# // Validating Automatic / Private
if [[ $choose_domain == "2" ]]; then # // Using Automatic Domain

# // Folder Sistem Yang Tidak Boleh Di Hapus
mkdir -p /usr/bin
# // Remove File & Directory
rm -fr /usr/local/bin/xray
rm -fr /usr/local/bin/stunnel
rm -fr /usr/local/bin/stunnel5
rm -fr /etc/nginx
rm -fr /var/lib/scrz-prem/
rm -fr /usr/bin/xray
rm -fr /etc/xray
rm -fr /usr/local/etc/xray
# // Making Directory 
mkdir -p /etc/nginx
mkdir -p /var/lib/scrz-prem/
mkdir -p /usr/bin/xray
mkdir -p /etc/xray
mkdir -p /usr/local/etc/xray

# // String / Request Data
sub=$(</dev/urandom tr -dc a-z0-9 | head -c5)
DOMAIN=scarzvpn.live
SUB_DOMAIN=${sub}.scarzvpn.live
CF_ID=arzstore22@gmail.com
CF_KEY=8772ff286d8515ccb36caf0f0f69b2fde1831
set -euo pipefail
IP=$(curl -sS ifconfig.me);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
     
echo "Host : $SUB_DOMAIN"
echo $SUB_DOMAIN > /root/domain
echo "IP=$SUB_DOMAIN" > /var/lib/scrz-prem/ipvps.conf
sleep 1
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
yellow "Domain added.."
sleep 3
domain=$(cat /root/domain)
cp -r /root/domain /etc/xray/domain

# // Making Certificate
clear
echo -e "[ ${GREEN}INFO${NC} ] Starting renew cert... " 
sleep 2
echo -e "${OKEY} Starting Generating Certificate"
rm -fr /root/.acme.sh
mkdir -p /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
# // Success
echo -e "${OKEY} Your Domain : $domain"
sleep 2

# // ELif For Selection 1
elif [[ $choose_domain == "1" ]]; then

# // Clear
clear
clear && clear && clear
clear;clear;clear

echo -e "${GREEN}Indonesian Language${NC}"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo -e "Silakan Pointing Domain Anda Ke IP VPS"
echo -e "Untuk Caranya Arahkan NS Domain Ke Cloudflare"
echo -e "Kemudian Tambahkan A Record Dengan IP VPS"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo ""
echo ""

# // Reading Your Input
read -p "Input Your Domain : " domain
if [[ $domain == "" ]]; then
    clear
    echo -e "${EROR} No Input Detected !"
    exit 1
fi

# // Folder Sistem Yang Tidak Boleh Di Hapus
mkdir -p /usr/bin
# // Remove File & Directory
rm -fr /usr/local/bin/xray
rm -fr /usr/local/bin/stunnel
rm -fr /usr/local/bin/stunnel5
rm -fr /etc/nginx
rm -fr /var/lib/scrz-prem/
rm -fr /usr/bin/xray
rm -fr /etc/xray
rm -fr /usr/local/etc/xray
# // Making Directory 
mkdir -p /etc/nginx
mkdir -p /var/lib/scrz-prem/
mkdir -p /usr/bin/xray
mkdir -p /etc/xray
mkdir -p /usr/local/etc/xray

# // Input Domain TO VPS
echo "$domain" > /etc/${Auther}/domain.txt
echo "IP=$domain" > /var/lib/scrz-prem/ipvps.conf
echo "$domain" > /root/domain
domain=$(cat /root/domain)
cp -r /root/domain /etc/xray/domain

# // Making Certificate
clear
echo -e "[ ${GREEN}INFO${NC} ] Starting renew cert... " 
sleep 2
echo -e "${OKEY} Starting Generating Certificate"
rm -fr /root/.acme.sh
mkdir -p /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
# // Success
echo -e "${OKEY} Your Domain : $domain"
sleep 2

# // Else Do
else
    echo -e "${EROR} Please Choose 1 & 2 Only !"
    exit 1
fi

#install arzsource
echo -e "┌─────────────────────────────────────────┐"
echo -e " \E[41;1;39m           >>> Install Source <<<          \E[0m$NC"
echo -e "└─────────────────────────────────────────┘"
sleep 1 
wget -q https://raw.githubusercontent.com/wingshope/agoez/main/tools/arzsource.sh && chmod +x arzsource.sh && ./arzsource.sh
#install ssh-vpn
echo -e "┌─────────────────────────────────────────┐"
echo -e " \E[41;1;39m          >>> Install SSH / WS <<<        \E[0m$NC"
echo -e "└─────────────────────────────────────────┘"
sleep 1
wget -q https://raw.githubusercontent.com/wingshope/agoez/main/tools/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
#install ins-xray
echo -e "┌─────────────────────────────────────────┐"
echo -e " \E[41;1;39m            >>> Install Xray <<<         \E[0m$NC"
echo -e "└─────────────────────────────────────────┘"
sleep 1 
wget -q https://raw.githubusercontent.com/wingshope/agoez/main/tools/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
#install ins-xray
echo -e "┌─────────────────────────────────────────┐"
echo -e " \E[41;1;39m            >>> Install BR <<<           \E[0m$NC"
echo -e "└─────────────────────────────────────────┘"
sleep 1 
wget -q https://raw.githubusercontent.com/wingshope/agoez/main/backup/set-br.sh && chmod +x set-br.sh && ./set-br.sh
#install ins-xray
echo -e "┌─────────────────────────────────────────┐"
echo -e " \E[41;1;39m            >>> Install slowdns <<<           \E[0m$NC"
echo -e "└─────────────────────────────────────────┘"
sleep 1 
wget https://raw.githubusercontent.com/Andyvpn/Autoscript-by-azi/main/autoscript-ssh-slowdns-main/slowdns.sh && chmod +x slowdns.sh && ./slowdns.sh

# // Download Data
echo -e "${GREEN}Download Data${NC}"
wget -q -O /usr/bin/usernew "https://raw.githubusercontent.com/wingshope/agoez/main/usernew.sh"
wget -q -O /usr/bin/add-ws "https://raw.githubusercontent.com/wingshope/agoez/main/add-ws.sh"
wget -q -O /usr/bin/add-ssws "https://raw.githubusercontent.com/wingshope/agoez/main/add-ssws.sh"
wget -q -O /usr/bin/add-vless "https://raw.githubusercontent.com/wingshope/agoez/main/add-vless.sh"
wget -q -O /usr/bin/add-tr "https://raw.githubusercontent.com/wingshope/agoez/main/add-tr.sh"
wget -q -O /usr/bin/autoreboot "https://raw.githubusercontent.com/wingshope/agoez/main/options/autoreboot.sh"
wget -q -O /usr/bin/restart "https://raw.githubusercontent.com/wingshope/agoez/main/options/restart.sh"
wget -q -O /usr/bin/tendang "https://raw.githubusercontent.com/wingshope/agoez/main/options/tendang.sh"
wget -q -O /usr/bin/clearlog "https://raw.githubusercontent.com/wingshope/agoez/main/options/clearlog.sh"
wget -q -O /usr/bin/running "https://raw.githubusercontent.com/wingshope/agoez/main/options/running.sh"
#wget -q -O /usr/bin/cek-trafik "https://raw.githubusercontent.com/arzvpn/Arzv/main/options/cek-trafik.sh"
wget -q -O /usr/bin/speedtest "https://raw.githubusercontent.com/wingshope/agoez/main/tools/speedtest_cli.py"
wget -q -O /usr/bin/cek-bandwidth "https://raw.githubusercontent.com/wingshope/agoez/main/options/cek-bandwidth.sh"
wget -q -O /usr/bin/limitspeed "https://raw.githubusercontent.com/wingshope/agoez/main/options/limitspeed.sh"
wget -q -O /usr/bin/menu-vless "https://raw.githubusercontent.com/wingshope/agoez/main/menu/menu-vless.sh"
wget -q -O /usr/bin/menu-vmess "https://raw.githubusercontent.com/wingshope/agoez/main/menu/menu-vmess.sh"
wget -q -O /usr/bin/menu-ss "https://raw.githubusercontent.com/wingshope/agoez/main/menu/menu-ss.sh"
wget -q -O /usr/bin/menu-trojan "https://raw.githubusercontent.com/wingshope/agoez/main/menu/menu-trojan.sh"
wget -q -O /usr/bin/menu-ssh "https://raw.githubusercontent.com/wingshope/agoez/main/menu/menu-ssh.sh"
wget -q -O /usr/bin/menu-backup "https://raw.githubusercontent.com/wingshope/agoez/main/menu/menu-backup.sh"
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/wingshope/agoez/main/menu/menu.sh"
wget -q -O /usr/bin/webmin "https://raw.githubusercontent.com/wingshope/agoez/main/options/webmin.sh"
wget -q -O /usr/bin/xp "https://raw.githubusercontent.com/wingshope/agoez/main/xp.sh"
wget -q -O /usr/bin/update "https://raw.githubusercontent.com/wingshope/agoez/main/options/update.sh"
wget -q -O /usr/bin/addhost "https://raw.githubusercontent.com/wingshope/agoez/main/menu/addhost.sh"
wget -q -O /usr/bin/certxray "https://raw.githubusercontent.com/wingshope/agoez/main/menu/crt.sh"
wget -q -O /usr/bin/menu-set "https://raw.githubusercontent.com/wingshope/agoez/main/menu/menu-set.sh"
wget -q -O /usr/bin/info "https://raw.githubusercontent.com/wingshope/agoez/main/options/info.sh"
wget -q -O /usr/bin/infoserv "https://raw.githubusercontent.com/wingshope/agoez/main/options/infoserv.sh"
chmod +x /usr/bin/usernew
chmod +x /usr/bin/add-ws
chmod +x /usr/bin/add-ssws
chmod +x /usr/bin/add-vless
chmod +x /usr/bin/add-tr
chmod +x /usr/bin/autoreboot
chmod +x /usr/bin/restart
chmod +x /usr/bin/tendang
chmod +x /usr/bin/clearlog
chmod +x /usr/bin/running
chmod +x /usr/bin/speedtest
chmod +x /usr/bin/cek-bandwidth
chmod +x /usr/bin/limitspeed
chmod +x /usr/bin/menu-vless
chmod +x /usr/bin/menu-vmess
chmod +x /usr/bin/menu-ss
chmod +x /usr/bin/menu-trojan
chmod +x /usr/bin/menu-ssh
chmod +x /usr/bin/menu-backup
chmod +x /usr/bin/menu
chmod +x /usr/bin/webmin
chmod +x /usr/bin/xp
chmod +x /usr/bin/update
chmod +x /usr/bin/addhost
chmod +x /usr/bin/certxray
chmod +x /usr/bin/menu-set
chmod +x /usr/bin/info
chmod +x /usr/bin/infoserv

#cat > /etc/cron.d/re_otm <<-END
#SHELL=/bin/sh
#PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
#0 7 * * * root /sbin/reboot
#END

cat > /etc/cron.d/xp_otm <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 0 * * * root /usr/bin/xp
END

cat > /etc/cron.d/cl_otm <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 1 * * * root /usr/bin/clearlog
END

cat > /home/re_otm <<-END
7
END

service cron restart >/dev/null 2>&1
service cron reload >/dev/null 2>&1

clear
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.
if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile

if [ -f "/root/log-install.txt" ]; then
rm -fr /root/log-install.txt 
fi
if [ -f "/etc/afak.conf" ]; then
rm -fr /etc/afak.conf 
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/wingsofhope123/agoez09/main/version  )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
curl -sS ifconfig.me > /etc/myipvps
echo  ""
echo  "------------------------------------------------------------"
echo  ""
echo  "   >>> Service & Port"  | tee -a log-install.txt
echo  "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo  "   - SSH Websocket           : 80" | tee -a log-install.txt
echo  "   - SSH SSL Websocket       : 443" | tee -a log-install.txt
echo  "   - Stunnel5                : 447, 777" | tee -a log-install.txt
echo  "   - Dropbear                : 109, 143" | tee -a log-install.txt
echo  "   - Badvpn                  : 7100-7300" | tee -a log-install.txt
echo  "   - Nginx                   : 81" | tee -a log-install.txt
echo  "   - XRAY  Vmess TLS         : 443" | tee -a log-install.txt
echo  "   - XRAY  Vmess None TLS    : 80" | tee -a log-install.txt
echo  "   - XRAY  Vless TLS         : 443" | tee -a log-install.txt
echo  "   - XRAY  Vless None TLS    : 80" | tee -a log-install.txt
echo  "   - Trojan GRPC             : 443" | tee -a log-install.txt
echo  "   - Trojan WS               : 443" | tee -a log-install.txt
echo  "   - Sodosok WS/GRPC         : 443" | tee -a log-install.txt
echo  "   - SlowDNS                 : 53,5300,443" | tee -a log-install.txt
echo  ""  | tee -a log-install.txt
echo  "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo  "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo  "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo  "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo  "   - IPtables                : [ON]"  | tee -a log-install.txt
echo  "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
#echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo  "   - Autoreboot              : 00.00 GMT +7" | tee -a log-install.txt
#echo "   - Autobackup Data" | tee -a log-install.txt
echo  "   - AutoKill Multi Login User" | tee -a log-install.txt
echo  "   - Auto Delete Expired Account" | tee -a log-install.txt
echo  "   - Fully automatic script" | tee -a log-install.txt
echo  "   - VPS settings" | tee -a log-install.txt
echo  "   - Restore Data" | tee -a log-install.txt
echo  "   - Full Orders For Various Services" | tee -a log-install.txt
echo ""
echo  ""
echo  "------------------------------------------------------------"
echo -e ""
echo  ""
echo  "" | tee -a log-install.txt
rm -fr /root/limit
rm -fr /root/weleh.sh 
rm -fr /root/arzsource.sh 
rm -fr /root/ssh-vpn.sh
rm -fr /root/ins-xray.sh
rm -fr /root/setup.sh
rm -fr /root/domain
history -c

echo -ne "[ ${yell}WARNING${NC} ] Apakah Anda Ingin Reboot Sekarang ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
