#!/bin/bash
clear
    echo " ============= UBUNTU TERMUX ROOT ============="
    echo -e "\e[1m\e[32m ______  ___  ___ _    _ .   _   ___   _  _ _ _"
    echo "   ||   |__/ |___  \  /  |  /_\  |__    \/  |/ "
    echo "   ||   |  \ |___   \/   | /   \  __|  _/\_ |\_"
    echo -e "\e[0m\e[39m ______________________________________________"
    echo " REDES SOCIAIS:                       treviasxk"
    echo " VERSÃO:                              1.0.1.1"
    echo " LICENÇA:                             GPL-3.0"
    echo " =============================================="
echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m BAIXANDO! \e[0m"
apt update
apt install tsu
apt install xz-utils
apt install wget -y
wget https://cdimage.ubuntu.com/ubuntu-base/releases/21.10/release/ubuntu-base-21.10-base-arm64.tar.gz

echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALANDO! \e[0m"

sudo mkdir -p /data/local/ubuntu 
sudo tar -xzf ./ubuntu-base-21.10-base-arm64.tar.gz --exclude='dev' -C /data/local/ubuntu

#mount -o rw,remount /
#mount -o rw,remount /system

sudo echo "nameserver 8.8.8.8" > /data/local/ubuntu/etc/resolv.conf
sudo echo "nameserver 8.8.4.4" >> /data/local/ubuntu/etc/resolv.conf
sudo chmod 644 /data/local/ubuntu/etc/resolv.conf
sudo mkdir -p /data/local/ubuntu/dev
sudo echo "127.0.0.1 localhost" > /data/local/ubuntu/etc/hosts
sudo echo "::1   localhost.localdomain" >> /data/local/ubuntu/etc/hosts

cd
echo "sudo busybox chroot /data/local/ubuntu /bin/login -f root" > ../usr/bin/ubuntu
chmod 777 ../usr/bin/ubuntu
echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALADO COM SUCESSO! \e[0m"