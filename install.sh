#!/system/bin/sh
# Software desenvolvido por Trevias Xk
# Redes sociais:       treviasxk
# Github:              https://github.com/treviasxk

localbuild="/data/local/ubuntu"

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

    sudo mount -o rw,remount /data 2> /dev/null
    sudo mount -o rw,remount /system/bin 2> /dev/null

    if [ -d "$localbuild" ]
    then
        rm $PREFIX/bin/ubuntu 2> /dev/null
        sudo rm /system/bin/ubuntu 2> /dev/null
        sudo rm -rf $localbuild 2> /dev/null
	fi

    #Ferramentas necessários no Termux para instalar o ubuntu
    apt update -qq
    apt install git -y -qq
    apt install curl -y -qq
    apt install tsu -y -qq
    apt install xz-utils -y -qq
    apt install wget -y -qq

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

    sudo mkdir -p $localbuild                                    #Criando pasta para instalação do ubuntu
    sudo mkdir -p $localbuild/dev                                #Criando pasta para recursos adicionais do ubuntu.

    sudo tar -xzf ./ubuntu-base.tar.gz --exclude='dev' -C $localbuild
    
    #Alterando permissões de arquivos
    chmod 777 ./scripts/ubuntu
    chmod 644 ./scripts/passwd
    chmod 644 ./scripts/resolv.conf
    chmod 644 ./scripts/hosts
    chmod 644 ./scripts/group
    chmod 640 ./scripts/shadow
    chmod 640 ./scripts/gshadow
    chmod 755 ./scripts/adduser

    #Configurações necessário para o funcionamento do Ubuntu
    sudo mv ./scripts/resolv.conf $localbuild/etc                #Adicionando DNS
    sudo mv ./scripts/hosts $localbuild/etc                      #Adicionando domínios locais
    sudo mv ./scripts/group $localbuild/etc                      #Permissões dos grupos
    sudo mv ./scripts/passwd $localbuild/etc                     #Permissões do usuário
    sudo mv ./scripts/shadow $localbuild/etc                     #Segurança das informações da conta
    sudo mv ./scripts/gshadow $localbuild/etc                    #Segurança das informações dos grupos
    sudo mv ./scripts/adduser $localbuild/sbin                   #Script personalizado, para corrigir internet
    cp ./scripts/ubuntu $PREFIX/bin                              #Atalho para iniciar o ubuntu
    sudo mv ./ubuntu /system/bin                                 #Atalho para iniciar o ubuntu

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