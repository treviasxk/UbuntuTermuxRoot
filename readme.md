# Ubuntu Termux Root
Instale o Ubuntu Base 21.10 na raiz do seu smartphone com o termux. Para poder iniciar o sistema utilize o comando `ubuntu`.

## AVISO!
Instale por conta própria, não serei responsavel por qualquer dano que possa acontecer em seu aparelho.
## Requisitos
• Magisk

• Arquitetura arm64, armhf, amd64 ou x86_64
## Instalação
Insira o comando shell abaixo no Termux para poder fazer a instalação.
```bash
curl -s -L https://raw.githubusercontent.com/treviasxk/UbuntuTermuxRoot/master/install.sh -o install && bash install
```
## Desinstalação
Primeiro pare todos os serviços e saia do ubuntu com o comando `exit` em seguida fecha o termux, depois insira o comando shell abaixo no Termux para poder fazer a desinstalação. Caso não consiga, reinicia o smartphone e inicie o código novamente.
```bash
ubuntu -u
```
Ou
```bash
ubuntu --uninstall
```
### Problema no apt upgrade
Caso não consiga fazer o `apt upgrade`, esse problema acontece devido o ubuntu não reconhecer a versão do kernel corretamente no libc6, use o comando abaixo para "manobrar" esse problema.
```bash
apt-mark hold libc6
```