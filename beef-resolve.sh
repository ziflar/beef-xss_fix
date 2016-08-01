#!/bin/bash
#
# - Coded By Ziflar zemba 
#
# - Youtube_channel :  https://www.youtube.com/channel/UC3miO-JcqsorPhmtFTJZ21g
#
# - This script help you to resolve all problem beef in kali rolling
#  
# - Run:
# ./beef_resolv.sh - Installs all dependencies. Best run from Kali Linux

BOLD="\033[01;01m"     # Highlight
RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success
YELLOW="\033[01;33m"   # Warnings/Information
RESET="\033[00m"       # Normal
clear
ip=$(ip route show | awk '(NR == 2) {print $9}')
service beef-xss stop
if [ -d "/usr/share/beef-xss" ]; then
echo && echo -e ${BOLD}'\nbeef-xss exist \n'${RESET}
fi
sleep 1
rm -r /usr/share/beef-xss
sleep 2
rm -r /etc/beef-xss/config.yaml
sleep 2
cd /usr/share/
sleep 2
git clone https://github.com/beefproject/beef.git
mv beef beef-xss
sleep 2
cd beef-xss
sleep 2
echo && echo 
echo -e ${YELLOW}'\n\n[*] Locate At Your config.yaml'${RESET}${BOLD}' db_file: "beef.db"'${RESET} ${YELLOW}',change to'${RESET} ${BOLD}'db_file: "db/beef.db"'${RESET}${YELLOW}',save and exit to contunie'${RESET}
echo && echo
echo -e ${YELLOW}'[*] Wait To Open config.yaml......'${RESET}
sleep 4
echo
leafpad config.yaml
mv /usr/share/beef-xss/config.yaml /etc/beef-xss
ln -s /etc/beef-xss/config.yaml /usr/share/beef-xss/config.yaml
ln -s /var/lib/beef-xss/ /usr/share/beef-xss/db
apt-get install libsqlite3-dev
sleep 2
bundle install
sleep 2
clear
port=$(ruby -ryaml -e "print YAML.load_file('/etc/beef-xss/config.yaml')['beef']['http']['port']")
gnome-terminal -x sh -c 'cd /usr/share/beef-xss && ./beef; exec bash'
echo -e ${BOLD}'[*] Wait To Be Redirected To Your BeEF Web Interface......'${RESET}
sleep 2
echo -e ${YELLOW}"[*] When it's done, Login To Your BeEF Control Panel With (user/pass)=beef,To Generate a Beef Database"${RESET}
sleep 15
firefox http://$ip:$port/ui/panel
sleep 6
echo && echo -e ${RED}'\n\n Have You Been loged To Your BeEF Control Panel ? (Y/N)\n\n'${RESET}
read install
if [[ $install = Y || $install = y ]] ; then
echo -e ${BOLD}'[*] Wait Please Beef Is Stopping Service Now......'${RESET}
killall ruby && service beef-xss stop
rm -r /usr/share/beef-xss/db/beef.db
service beef-xss start
sleep 2
service beef-xss force-reload
sleep 8
echo && echo -e ${GREEN}"[*] It's Done Your beef-xss Is Fixed"${RESET}
echo && echo -e ${YELLOW}"Do An Update To Your beef-xss ? (Y/N)"${RESET}
read update
if [[ $update = Y || $update = y ]] ; then
cd /usr/share/beef-xss && ./update-beef
else
echo -e ${GREEN}"[-] You Can Do It After run: cd /usr/share/beef-xss && ./update-beef"${RESET}
fi
else
killall ruby
echo -e ${RED}"[-] there is an error run the script again !"${RESET}
fi
