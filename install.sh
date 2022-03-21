#!/system/bin/sh
banner (){
    clear
    echo " ============= UBUNTU TERMUX ROOT ============="
    echo -e "\e[1m\e[32m ______  ___  ___ _    _ .   _   ___   _  _ _ _"
    echo "   ||   |__/ |___  \  /  |  /_\  |__    \/  |/ "
    echo "   ||   |  \ |___   \/   | /   \  __|  _/\_ |\_"
    echo -e "\e[0m\e[39m ______________________________________________"
    echo " REDES SOCIAIS:                       treviasxk"
    echo " VERSÃO:                              1.0.2.0"
    echo " LICENÇA:                             GPL-3.0"
    echo " =============================================="
}
banner
echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m PREPARANDO... \e[0m"

if [ "$EUID" -ne 0 ]
then
    sudo mount -o rw,remount /data
    sudo mount -o rw,remount /system/bin
    
    rm /system/bin/ubuntu 2> /dev/null
    rm $PREFIX/bin/ubuntu 2> /dev/null
    rm -rf /data/local/ubuntu 2> /dev/null

    apt update 2> /dev/null
    banner
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m BAIXANDO GIT... \e[0m"
    apt install git -y 2> /dev/null
    banner
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m BAIXANDO CURL... \e[0m"
    apt install curl -y 2> /dev/null
    banner
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m BAIXANDO TSU... \e[0m"
    apt install tsu -y 2> /dev/null
    banner
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m BAIXANDO XZ-UTILS... \e[0m"
    apt install xz-utils -y 2> /dev/null
    banner
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m BAIXANDO WGET... \e[0m"
    apt install wget -y 2> /dev/null

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
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m BAIXANDO DATA... \e[0m"

    git clone https://github.com/treviasxk/UbuntuTermuxRoot
    cd UbuntuTermuxRoot

    banner
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m BAIXANDO UBUNTU BASE 21.10... \e[0m"
    wget "https://cdimage.ubuntu.com/ubuntu-base/releases/21.10/release/ubuntu-base-21.10-base-$archurl.tar.gz" -O ubuntu-base.tar.gz

    banner
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALANDO... \e[0m"

    sudo mkdir -p /data/local/ubuntu                                    #Criando pasta para instalação do ubuntu
    sudo mkdir -p /data/local/ubuntu/dev                                #Criando pasta para recursos adicionais do ubuntu.

    sudo tar -xzf ./ubuntu-base.tar.gz --exclude='dev' -C /data/local/ubuntu
    
    #Alterando permissões de arquivos
    chmod 777 ./scripts/ubuntu
    chmod 644 ./scripts/passwd
    chmod 644 ./scripts/resolv.conf
    chmod 644 ./scripts/sudo.conf
    chmod 644 ./scripts/hosts
    chmod 644 ./scripts/group
    chmod 640 ./scripts/shadow
    chmod 640 ./scripts/gshadow

    #Configurações necessário para o funcionamento do Ubuntu
    sudo mv ./scripts/resolv.conf /data/local/ubuntu/etc                #Adicionando DNS
    sudo mv ./scripts/sudo.conf /data/local/ubuntu/etc                  #Desativando Coredump para mais segurança
    sudo mv ./scripts/hosts /data/local/ubuntu/etc                      #Adicionando domínios locais
    sudo mv ./scripts/group /data/local/ubuntu/etc                      #Permissões dos grupos
    sudo mv ./scripts/passwd /data/local/ubuntu/etc                     #Permissões do usuário
    sudo mv ./scripts/shadow /data/local/ubuntu/etc                     #Segurança das informações da conta
    sudo mv ./scripts/gshadow /data/local/ubuntu/etc                    #Segurança das informações dos grupos
    cp ./scripts/ubuntu $PREFIX/bin                                     #Atalho para iniciar o ubuntu
    sudo mv ./ubuntu /system/bin                                        #Atalho para iniciar o ubuntu

    #Limpando instalação
    rm -rf ../UbuntuTermuxRoot
    rm ../install

    banner
    echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALADO COM SUCESSO! \e[0m"
    echo "Use o comando 'ubuntu' para iniciar o sistema."
else
    banner
    echo "Instalação não funciona diretamente pela raiz"
fi