#!/system/bin/sh
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
echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m ATUALIZANDO... \e[0m"

download (){
    case `dpkg --print-architecture` in
		aarch64)
			archurl="arm64" ;;
		arm)
			archurl="armhf" ;;
		amd64)
			archurl="amd64" ;;
		x86_64)
			archurl="amd64" ;;
		*)
			echo "Arquitetura desconhecida"; exit 1;;
	esac
    banner
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m BAIXANDO ubuntu-base-21.10-$archurl... \e[0m"
    wget "https://cdimage.ubuntu.com/ubuntu-base/releases/21.10/release/ubuntu-base-21.10-base-$archurl.tar.gz" -O ubuntu-base.tar.gz
}
if [ "$EUID" -ne 0 ]
then
    apt update
    apt install curl -y
    apt install tsu -y
    apt install xz-utils -y
    apt install wget -y

    download

    banner
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALANDO... \e[0m"

    sudo mount -o rw,remount /data
    sudo mount -o rw,remount /system/bin

    sudo mkdir -p /data/local/ubuntu 
    sudo tar -xzf ./ubuntu-base.tar.gz --exclude='dev' -C /data/local/ubuntu
    rm ./ubuntu-base.tar.gz

    echo "nameserver 8.8.8.8" > ./resolv.conf                       # Adicionado DNS Primário
    echo "nameserver 8.8.4.4" >> ./resolv.conf                      # Adicionado DNS Segundário
    sudo mv ./resolv.conf /data/local/ubuntu/etc/resolv.conf
    sudo chmod 644 /data/local/ubuntu/etc/resolv.conf


    echo "Set disable_coredump false" > ./sudo.conf                 # Desativando Coredump para mais segurança
    sudo mv ./sudo.conf /data/local/ubuntu/etc/sudo.conf

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

    curl -s -L https://raw.githubusercontent.com/treviasxk/UbuntuTermuxRoot/master/scripts/ubuntu -o ubuntu
    chmod +x ./ubuntu
    cp ./ubuntu /data/data/com.termux/files/usr/bin
    sudo mv ./ubuntu /system/bin
else
    download
    
    banner
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALANDO... \e[0m"

    mount -o rw,remount /data
    mount -o rw,remount /system/bin

    mkdir -p /data/local/ubuntu 
    tar -xzf ./ubuntu-base.tar.gz --exclude='dev' -C /data/local/ubuntu
    rm ./ubuntu-base.tar.gz

    echo "nameserver 8.8.8.8" > /data/local/ubuntu/etc/resolv.conf                  # Adicionado DNS Primário
    echo "nameserver 8.8.4.4" >> /data/local/ubuntu/etc/resolv.conf                 # Adicionado DNS Segundário
    chmod 644 /data/local/ubuntu/etc/resolv.conf

    echo "Set disable_coredump false" > /data/local/ubuntu/etc/sudo.conf             # Desativando Coredump para mais segurança

    echo "groupadd -g 3003 aid_inet" > /data/local/ubuntu/root/finalizar 
    echo "usermod -a -G aid_inet root" >> /data/local/ubuntu/root/finalizar 
    echo "adduser --force-badname --system --home /nonexistent --no-create-home --quiet _apt || true" >> /data/local/ubuntu/root/finalizar 
    echo "usermod -g 3003 _apt" >> /data/local/ubuntu/root/finalizar 
    echo 'echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALAÇÃO FINALIZADO! \e[0m"' >> /data/local/ubuntu/root/finalizar 
    echo 'rm ./finalizar' >> /data/local/ubuntu/root/finalizar 
    chmod +x /data/local/ubuntu/root/finalizar 

    mkdir -p /data/local/ubuntu/dev
    echo "127.0.0.1 localhost" > /data/local/ubuntu/etc/hosts
    echo "::1   localhost.localdomain" >> /data/local/ubuntu/etc/hosts

    curl -s -L https://raw.githubusercontent.com/treviasxk/UbuntuTermuxRoot/master/scripts/ubuntu -o ubuntu
    chmod +x ./ubuntu
    cp ./ubuntu /data/data/com.termux/files/usr/bin
    mv ./ubuntu /system/bin
fi

banner
echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALADO COM SUCESSO! \e[0m"
echo "Use o comando 'ubuntu' para iniciar o sistema."