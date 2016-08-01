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

clear
interfa=$(route | grep default | awk '{print $8}')
ip=$(ifconfig $interfa | awk '/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ {print substr($2,1,length($2))}')
service beef-xss stop
if [ -d "/usr/share/beef-xss" ]; then
echo && echo -e " \e[1;31mbeef-xss exist \e[0m";
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
echo -e "\e[1;32m[*] Locate At Your config.yaml\e[0m \e[1;31mdb_file: "beef.db"\e[0m \e[1;32mand change to\e[0m \e[1;31mdb_file: "db/beef.db"\e[0m\e[1;32m,save and exit to contunie\e[0m"
echo && echo
echo -e " \e[1;32m[*] Wait To Open config.yaml......\e[0m"
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
echo -e " \e[1;32m[*] Wait To Be Redirected To Your BeEF Web Interface......\e[0m"
sleep 2
echo -e " \e[1;32m[*] When it's done, Login To Your BeEF Control Panel With (user/pass)=beef,To Generate a Beef Database\e[0m"
sleep 15
firefox http://$ip:$port/ui/panel
sleep 6
echo && echo
echo -e " \e[1;32m Have You Been loged To Your BeEF Control Panel ? (Y/N)\e[0m"
read install
if [[ $install = Y || $install = y ]] ; then
echo -e "\e[1;32m[*] Wait Please\e[0m"
sleep 2
echo && echo
echo "[*] Wait Beef Is Stopping Service Now ."
killall ruby && service beef-xss stop
rm -r /usr/share/beef-xss/db/beef.db
service beef-xss start
sleep 2
service beef-xss force-reload
sleep 8
echo "[*] It's Done Your beef-xss Is Fixed"
echo && echo -e "Do An Update To Your beef-xss ? (Y/N)"
read update
if [[ $update = Y || $update = y ]] ; then
cd /usr/share/beef-xss && ./update-beef
else
echo -e "[-] You Can Do It After run: cd /usr/share/beef-xss && ./update-beef"
fi
else
killall ruby
echo -e "\e[1;32m[-] there is an error run the script again !\e[0m"
fi
