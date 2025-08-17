#!/bin/bash

sudo hostnamectl set-hostname xxxxxx

git clone https://github.com/tfyr/kirsa-ext.git

wget 27.9733.ru/install_comproxy_2.4.26_409.sh
chmod +x install_comproxy_2.4.26_409.sh
sudo bash install_comproxy_2.4.26_409.sh
sudo systemctl disable comproxy

wget http://ftp.us.debian.org/debian/pool/main/p/pangox-compat/libpangox-1.0-0_0.0.2-5.1_amd64.deb && sudo apt install ./libpangox-1.0-0_0.0.2-5.1_amd64.deb
wget --no-check-certificate https://egais.ru/files/distr/u-trans-4.2.0-2623-i386.deb
wget 27.9733.ru/Fito
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget http://27.9733.ru/librtpkcs11ecp_2.8.1.0-1_amd64.deb
sudo wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo add-apt-repository ppa:oibaf/graphics-drivers
sudo dpkg --add-architecture i386
sudo apt update
sudo apt upgrade -y
sudo apt install -y openssh-server curl socat libgtk2.0-0:i386 libc6:i386 libstdc++6:i386 pcscd libpcsclite1:i386 libccid \
                    pcscd libpcsclite1 pcsc-tools opensc supervisor python3.12-venv anydesk

mkdir -p .ssh && printf "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD2nNZJpGtQDYQasPS3Om+lBQlvC0QPhnXCxiiC7nbmHnHhhi4gHlmKGI6tzrmz5VHMHZzq12wuCGQrvOHLAsXkBpcQ+vtmKjEaMzxG4KYueqsISMNcpHQIJnP8GSZySGreflfJWHwIusK/MV9BngX0f9eEeei8p3N0vOCOWHY17dYo0bEBwXCX/Tg7ghhcmsiNl6YXeFGE/wV5hT2edhgf+d3mExCBdxPHdy+hpbvzGULgzMW/BeryzFS3grA5lXmqDLBBu+i9f6QXi8s23+UTkafZPdo3B+B1h18TxQFGot4Ck/oUjCjpMUtCbKSyIvhAElGU4fkTOs6nXN4wwVwJ nash@nashlinux
" >> ~/.ssh/authorized_keys
printf "PermitRootLogin no
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM no
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
" | sudo tee -a /etc/ssh/sshd_config.d/pos.conf

sudo service ssh restart

#права на ком-порты
sudo usermod -a -G dialout $USER

# отключение ввода пароля после засыпания
gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend false
gsettings set org.gnome.desktop.screensaver lock-enabled false

sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb

sudo apt autoremove -y firefox && sudo snap remove firefox

sudo dpkg -i u-trans-4.2.0-2623-i386.deb
sudo systemctl enable pcscd

python3 -m venv env
source env/bin/activate
cd ~/ && git clone https://github.com/tfyr/kirsa-plugin.git
cd kirsa-plugin/ && pip install -r requirements.txt && deactivate
cd ~/
# crontab -e
# */5 * * * * ~/kirsa-plugin/download.sh

sudo apt install -y xserver-xorg-video-intel mesa-utils
sudo apt full-upgrade

sudo echo fdnjvj,bkbcnjd8u | sudo anydesk --set-password
anydesk --get-id
printf "\n[daemon]\nWaylandEnable=false\n" | sudo tee -a /etc/gdm3/custom.conf

mkdir ~/ArcusIngenicoDriver
mkdir ~/ArcusIngenicoDriver/Linux64
scp -r vds2:~/ArcusIngenicoDriver/Linux64/libarccom21036 pos@xxx:~/ArcusIngenicoDriver/Linux64
ln -s ~/ArcusIngenicoDriver/Linux64/libarccom21036/cashreg.ini ~/cashreg.ini

sudo apt install -y ffmpeg

wget http://27.9733.ru/librtpkcs11ecp_2.8.1.0-1_amd64.deb
sudo dpkg -i librtpkcs11ecp_2.8.1.0-1_amd64.deb
find  /usr/*(lib|lib64) -name librtpkcs11ecp.so

sudo cp ~/ubuntu_init/10-viki.rules /etc/udev/rules.d
sudo cp ~/ubuntu_init/12-arcus.rules /etc/udev/rules.d
sudo systemctl restart udev
sudo udevadm control --reload-rules
sudo udevadm trigger

#pkcs11-tool --module $(find  /usr/*(lib|lib64) -name librtpkcs11ecp.so) -O
#pkcs11-tool --module $(find  /usr/*(lib|lib64) -name librtpkcs11ecp.so) -r -y cert --id 34414438464430334338464234414533 | openssl x509 -inform der -text
