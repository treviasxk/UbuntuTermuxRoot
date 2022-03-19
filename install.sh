#!/bin/bash
rm install
if [ "$EUID" -ne 0 ]
  then echo "Por favor execute com o modo root"
  exit
fi
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
wget https://cdimage.ubuntu.com/ubuntu-base/releases/21.10/release/ubuntu-base-21.10-base-arm64.tar.gz
banner
echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALANDO... \e[0m"

mount -o rw,remount /data
mount -o rw,remount /system/bin

mkdir -p /data/local/ubuntu 
tar -xzf ./ubuntu-base-21.10-base-arm64.tar.gz --exclude='dev' -C /data/local/ubuntu
rm ./ubuntu-base-21.10-base-arm64.tar.gz


echo "nameserver 8.8.8.8" > /data/local/ubuntu/etc/resolv.conf
echo "nameserver 8.8.4.4" >> /data/local/ubuntu/etc/resolv.conf
chmod 644 /data/local/ubuntu/etc/resolv.conf

echo "groupadd -g 3003 aid_inet" > /data/local/ubuntu/root/finalizar
echo "usermod -a -G aid_inet root" >> /data/local/ubuntu/root/finalizar
echo "adduser --force-badname --system --home /nonexistent --no-create-home --quiet _apt || true" >> /data/local/ubuntu/root/finalizar
echo "usermod -g 3003 _apt" >> /data/local/ubuntu/root/finalizar
echo 'echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALAÇÃO FINALIZADO! \e[0m"' >> /data/local/ubuntu/root/finalizar
echo 'rm /data/local/ubuntu/root/finalizar' >> /data/local/ubuntu/root/finalizar
chmod +x /data/local/ubuntu/root/finalizar 

mkdir -p /data/local/ubuntu/dev
echo "127.0.0.1 localhost" > /data/local/ubuntu/etc/hosts
echo "::1   localhost.localdomain" >> /data/local/ubuntu/etc/hosts

cd
echo "unset LD_PRELOAD" > ./ubuntu
echo "clear" >> ./ubuntu
echo "setenforce 0" >> ./ubuntu
echo "export bin=/system/bin" >> ./ubuntu
echo 'export PATH=/usr/bin:/usr/sbin:/bin:/usr/local/bin:/usr/local/sbin:$PATH' >> ./ubuntu
echo "export TERM=linux" >> ./ubuntu
echo "export HOME=/root" >> ./ubuntu
echo "export USER=root" >> ./ubuntu
echo "export LOGNAME=root" >> ./ubuntu
echo "busybox chroot /data/local/ubuntu /bin/login -f root" >> ./ubuntu
chmod 777 ./ubuntu
cp ./ubuntu /system/bin
cp ./ubuntu /data/data/com.termux/files/usr/bin

banner
echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALADO COM SUCESSO! \e[0m"
echo "Use o comando 'ubuntu' para iniciar o sistema."