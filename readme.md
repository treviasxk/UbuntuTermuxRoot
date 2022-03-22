# Ubuntu Termux Root
Instale o Ubuntu Base 21.10 na raiz do seu smartphone com o termux. Para poder iniciar o sistema utilize o comando `ubuntu`.
## Requisitos
• Busybox

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
Caso não consiga fazer o `apt upgrade`, esse problema acontece devido o ubuntu não reconhecer a versão do kernel corretamente no libc6, use `apt-mark hold libc6` para "manobrar" esse problema.
### Sem internet ao criar um novo usuário
Se for criar uma conta no `adduser` ao finalizar, lembre-se de adicionar a nova conta de usuário para o grupo aid_inet, o kernel do smartphone só concede internet via root se o usuário estiver nesse grupo.
```bash
usermod -a -G aid_inet SeuUserAqui
```