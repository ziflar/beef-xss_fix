#!/bin/bash
#
BOLD="\033[01;01m"     # Highlight
RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success
YELLOW="\033[01;33m"   # Warnings/Information
RESET="\033[00m"       # Normal
ip=$(ip route show | awk '(NR == 2) {print $9}')
clear
echo -e "
${BOLD}
- Coded By Ziflar zemba 

- Youtube_channel :  https://www.youtube.com/channel/UC3miO-JcqsorPhmtFTJZ21g

- This Script Help You To Resolve All beef Problem's In kali rolling
  
- Installs All Dependencies. Best run from Kali Linux Rolling
 
"${RESET}          
sleep 4
echo 
service beef-xss stop
if [ -d "/usr/share/beef-xss" ]; then
echo -e ${BOLD}'\nbeef-xss exist \n'${RESET}
fi
sleep 1
apt-get --purge remove beef-xss -y
sleep 2
rm -r usr/bin/beef-xss
sleep 1
clear
echo -e ${BOLD}'[*] Wait Please....................................'${RESET}
echo
apt-get install beef-xss kali-linux-full nodejs -y &> /dev/null
sleep 2
apt-get clean && apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
sleep 2
chmod +x beef-xss
sleep 2
mv beef-xss /usr/bin
sleep 2
rm -r /usr/share/beef-xss
sleep 2
rm -r /etc/beef-xss/config.yaml
sleep 2
cd /usr/share/
sleep 2
git clone https://github.com/beefproject/beef.git beef-xss
sleep 2
cd beef-xss
rm -r INSTALL.txt install liveCD install-beef 
sleep 2
echo 
mv config.yaml config.txt
sleep 2
sed -i '/db_file:/s/"beef.db"/"db\/beef.db"/g' config.txt
sleep 2
mv config.txt config.yaml
sleep 2
mv /usr/share/beef-xss/config.yaml /etc/beef-xss
ln -s /etc/beef-xss/config.yaml /usr/share/beef-xss/config.yaml
ln -s /var/lib/beef-xss/ /usr/share/beef-xss/db
apt-get install libsqlite3-dev
sleep 2
gem install rake
gem install rubocop
gem install therubyracer -v 0.12.2
gem update bundler
gem update --system
gem install bundler
bundle install
sleep 2
clear
port=$(ruby -ryaml -e "print YAML.load_file('/etc/beef-xss/config.yaml')['beef']['http']['port']")
gnome-terminal -x sh -c 'cd /usr/share/beef-xss && ./beef; exec bash'
echo -e ${BOLD}'[*] Wait To Be Redirected To Your BeEF Web Interface......'${RESET}
sleep 2
echo -e ${YELLOW}"[*] When it's done, Login To Your BeEF Control Panel With (user/pass)=beef,To Generate a Beef Database"${RESET}
sleep 20
xdg-open http://$ip:$port/ui/panel
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
