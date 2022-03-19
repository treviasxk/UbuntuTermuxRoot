#!/bin/bash
rm install
banner (){
    clear
    echo " ============= UBUNTU TERMUX ROOT ============="
    echo -e "\e[1m\e[32m ______  ___  ___ _    _ .   _   ___   _  _ _ _"
    echo "   ||   |__/ |___  \  /  |  /_\  |__    \/  |/ "
    echo "   ||   |  \ |___   \/   | /   \  __|  _/\_ |\_"
    echo -e "\e[0m\e[39m ______________________________________________"
    echo " REDES SOCIAIS:                       treviasxk"
    echo " VERSÃO:                              1.0.0.0"
    echo " LICENÇA:                             GPL-3.0"
    echo " =============================================="
}
banner
echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m BAIXANDO... \e[0m"
apt update
apt install tsu -y
apt install xz-utils -y
apt install wget -y
wget https://cdimage.ubuntu.com/ubuntu-base/releases/21.10/release/ubuntu-base-21.10-base-arm64.tar.gz
banner
echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALANDO... \e[0m"

sudo mkdir -p /data/local/ubuntu 
sudo tar -xzf ./ubuntu-base-21.10-base-arm64.tar.gz --exclude='dev' -C /data/local/ubuntu
rm ./ubuntu-base-21.10-base-arm64.tar.gz

mount -o rw,remount /data
mount -o rw,remount /system/bin

echo "nameserver 8.8.8.8" > ./resolv.conf
echo "nameserver 8.8.4.4" >> ./resolv.conf
sudo mv ./resolv.conf /data/local/ubuntu/etc/resolv.conf
sudo chmod 644 /data/local/ubuntu/etc/resolv.conf

echo "groupadd -g 3003 aid_inet" > ./finalizar
echo "usermod -a -G aid_inet root" >> ./finalizar
echo "adduser --force-badname --system --home /nonexistent --no-create-home --quiet _apt || true" >> ./finalizar
echo "usermod -g 3003 _apt" >> ./finalizar
echo 'echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALAÇÃO FINALIZADO! \e[0m"' >> ./finalizar
echo 'rm ./finalizar' >> ./finalizar
sudo mv ./finalizar /data/local/ubuntu/root
sudo chmod +x /data/local/ubuntu/root/finalizar 

sudo mkdir -p /data/local/ubuntu/dev
echo "127.0.0.1 localhost" > ./hosts
echo "::1   localhost.localdomain" >> ./hosts
sudo mv ./hosts /data/local/ubuntu/etc/hosts

cd
echo "unset LD_PRELOAD" > ../usr/bin/ubuntu
echo "clear" >> ../usr/bin/ubuntu
echo "sudo setenforce 0" >> ../usr/bin/ubuntu
echo "export bin=/system/bin" >> ../usr/bin/ubuntu
echo 'export PATH=/usr/bin:/usr/sbin:/bin:/usr/local/bin:/usr/local/sbin:$PATH' >> ../usr/bin/ubuntu
echo "export TERM=linux" >> ../usr/bin/ubuntu
echo "export HOME=/root" >> ../usr/bin/ubuntu
echo "export USER=root" >> ../usr/bin/ubuntu
echo "export LOGNAME=root" >> ../usr/bin/ubuntu
echo "sudo busybox chroot /data/local/ubuntu /bin/login -f root" >> ../usr/bin/ubuntu

chmod 777 ../usr/bin/ubuntu
sudo cp ../usr/bin/ubuntu /system/bin
sudo chmod 777 /system/bin/ubuntu

banner
echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALADO COM SUCESSO! \e[0m"
echo "Use o comando 'ubuntu' para iniciar o sistema."