#!/bin/bash


##VALORES GLOBALES
windows=$(wslpath $(cmd.exe /c "echo %USERPROFILE%" | tr -d '\r'))

escritorio="$windows/Desktop"
descarga="$windows/Downloads"
documentos="$windows/Documents"

usuario=$(id -un -- 1000)
home=$(cat /etc/passwd | grep "$(echo $usuario)" | awk '{print $6}' FS=":")

##COLORES DE TEXTO
rojo="\033[1;31m"
verde="\033[1;32m"
amarillo="\033[1;33m"
azul="\033[1;34m"
magenta="\033[1;35m"
cyan="\033[1;36m"
blanco="\033[1;37m"
reset="\033[0m"

echo -e $verde"[*] INSTALANDO WSL"$reset"\n"
##ACTUALIZACIÓN DE SISTEMA
echo -e $azul"[*] ACTUALIZANDO SISTEMA"$reset"\n"
sleep 2
sudo apt update && sudo apt upgrade -y
touch ~/.hushlogin

##INSTALACION DE APLICACIONES
echo -e $azul"\n\n[+] INSTALANDO APLICACIONES"$reset"\n"
sleep 2
sudo apt install python3 python3-pip wordlists seclists exploitdb man nmap wafw00f whatweb sqlmap lsd bat squid openvpn -y

##REPARAR WFUZZ
echo -e $amarillo"\n\n[+] SOLUCIONANDO ERROR DE WFUZZ"$reset"\n"
sleep 2
sudo apt install wfuzz -y
sudo apt --purge remove python3-pycurl -y
sudo apt install libcurl4-openssl-dev libssl-dev -y
sudo pip3 install pycurl wfuzz
sudo ln -s /usr/local/bin/wfuzz /usr/bin/wfuzz

## BIEN HASTA ACA

##CONFIGURAION DEL SISTEMA
echo -e $azul"\n\n[+] DESCARGANDO COMPLEMENTOS DE WSL"$reset"\n"
sleep 2
sudo wget https://raw.githubusercontent.com/Racso20/WSL/main/ipwsl -O /etc/ipswl
sudo chmod +x /etc/ipswl
sudo wget https://raw.githubusercontent.com/Racso20/WSL/main/interoperabilidad -O /etc/interoperabilidad
sudo chmod +x /etc/interoperabilidad
sudo wget https://raw.githubusercontent.com/Racso20/WSL/main/wsl.conf -O /etc/wsl.conf
sudo echo "" >> /etc/wsl.conf
sudo echo "[user]" >> /etc/wsl.conf
sudo echo -e "\t default=$usuario" >> /etc/wsl.conf
sudo wget https://raw.githubusercontent.com/Racso20/WSL/main/funciones -O /etc/funciones
sudo chmod +x /etc/funciones
sudo wget https://raw.githubusercontent.com/Racso20/WSL/main/racso.sh -O "/etc/$usuario.sh"
sudo chmod +x "/etc/$usuario.sh"
sudo rm /etc/squid/squid.conf
sudo wget https://raw.githubusercontent.com/Racso20/WSL/main/squid.conf -O /etc/squid/squid.conf
sudo sh -c "echo 'squid:$apr1$ebz/wRCD$Dr9/2gKrAXRMA6UW5ro3U1' > /etc/squid/auth"
echo -e $verde"\t[-] El usuario de Squid es squid"$reset
echo -e $verde"\t[-] La clave de Squid es Kalisquid"$reset
echo -e $verde"\t[-] El puerto de Squid es 3128"$reset
sudo squid -k reconfigure
sleep 20


###CONFIGURA DE NANO
echo -e $azul"\n\n[+] CONFIGURANDO NANO Y INPUTRC"$reset"\n"
sudo sed -i "s/# set autoindent/set autoindent/g" /etc/nanorc
sudo sed -i "s/# set linenumbers/set linenumbers/g" /etc/nanorc
sudo sed -i "s/# set mouse/set mouse/g" /etc/nanorc
###CONFIGURACION DEL INPUTRC
sudo sh -c "head -n 38 /etc/inputrc > /etc/inputrc2"
sudo sh -c "echo \"# set sudo in front of command\" >> /etc/inputrc2"
sudo bash -c 'echo "\"\\e\\e\": \"\\e[Hsudo \\e[F\"" >> /etc/inputrc2'
sudo sh -c "tail -n 34 /etc/inputrc >> /etc/inputrc2"
sudo rm /etc/inputrc
sudo mv /etc/inputrc2 /etc/inputrc

##ESTANDARIZAR USUARIO A ROOT
echo -e $azul"[+] APUNTANDO CARPETA ROOT Y DE WINDOWS AL USUARIO"$reset"\n"
sleep 2

sudo ln -s -f $escritorio $home/Escritorio
sudo ln -s -f $descarga $home/Descargas
sudo ln -s -f $documentos $home/Documentos

##AGREGANDO CARPETAS ONEDRIVE A USUARIO

for i in $windows/*; do
	
	if [[ $i == *"OneDrive"* ]]; then
		read -p "Desea incluir $i a su carpeta de usuario [y/N] " incluir
		if [[ "SI" == ${incluir^^} || "S" == ${incluir^^} || "Y" == ${incluir^^} || "YES" == ${incluir^^} ]]; then
			carpeta=$(echo $i | awk '{print $6}' FS='/')
			hacia=$(echo "$home/$carpeta")
			desde=$(echo "$(echo $i)/")
			echo "Agregando $desde a $hacia"
			sudo ln -s -f "$desde" "$hacia"
		fi
	fi
done

builtin cd /
rm -rf /root
sudo ln -s -f $home /root
builtin cd /root

sudo sh -c "echo '$usuario ALL=(ALL:ALL) NOPASSWD: /usr/bin/chown -R $usuario\:$usuario /home/$usuario' >> /etc/sudoers.d/$usuario"
sudo sh -c "echo '$usuario ALL=(ALL:ALL) NOPASSWD: /usr/bin/bash /etc/ipswl' >> /etc/sudoers.d/$usuario"


sudo chown -R $usuario:$usuario $home/*

##CONFIGURANDO BASHRC Y ALIAS
echo -e $azul"\n\n[+] CONFIGURANDO ALIAS"$reset"\n"
echo "#WINDOWS ALIAS" >> $home/.bash_aliases
echo "alias cmd='cmd.exe /c \"cmd\"'" >> $home/.bash_aliases
echo "alias powershell='cmd.exe /c \"powershell\"'" >> $home/.bash_aliases
echo "alias firefox='cmd.exe /c \"start firefox\"'" >> $home/.bash_aliases
echo "alias ipconfig='cmd.exe /c \"ipconfig\"'" >> $home/.bash_aliases
echo "alias winget='cmd.exe /c \"winget\"'" >> $home/.bash_aliases
echo "" >> $home/.bash_aliases
echo "#LINUX ALIAS" >> $home/.bash_aliases
echo "alias clear='printf \"\033c\" && /etc/$usuario.sh'" >> $home/.bash_aliases
echo "alias ls='lsd --group-dirs=first'" >> $home/.bash_aliases
echo "alias ll='lsd -l --group-dirs=first'" >> $home/.bash_aliases
echo "alias la='lsd -A --group-dirs=first'" >> $home/.bash_aliases
echo "alias l='ls -CF --group-dirs=first'" >> $home/.bash_aliases
echo "alias cat='batcat --paging=never'" >> $home/.bash_aliases
echo "alias catn='/usr/bin/cat'" >> $home/.bash_aliases
echo "alias realip='curl -s ifconfig.me'" >> $home/.bash_aliases
echo "alias clima='curl -4 http://wttr.in/?lang=es'" >> $home/.bash_aliases

##COMANDOS PARA BASHRC
echo -e $azul"\n\n[+] CREANDO ALIAS DEL SISTEMA"$reset"\n"
echo "cd ~" >> $home/.bashrc
echo "/etc/$usuario.sh" >> $home/.bashrc
echo ". /etc/funciones" >> $home/.bashrc
echo "sudo /usr/bin/chown -R $usuario:$usuario /home/$usuario" >> $home/.bashrc
echo "sudo /usr/bin/bash /etc/ipswl" >> $home/.bashrc

##ELIMINANDO ZSH
echo -e $azul"\n[+] ACTUAlIZANDO LA BASE DE DATOS DE ARCHIVO"$reset"\n"
read -p "Desea eliminar la ZSH [Y/n] " eliminar

if [[ "NO" != ${eliminar^^} || "N" != ${eliminar^^} ]]; then
	sudo apt remove zsh -y
	sudo rm -rf /usr/share/zsh/
	sudo rm -rf /etc/zsh*
	sudo rm -rf /home/$usuario/.zshrc
	sudo rm -rf /usr/bin/rzsh
	sudo rm -rf /usr/bin/zsh
	sudo rm -rf /usr/bin/zsh5
	sudo rm -rf /usr/lib/x86_64-linux-gnu/zsh*
	sudo rm -rf /usr/local/share/zsh*
	sudo rm -rf /etc/skel/.zshrc
	sudo rm -rf /usr/share/bug/zsh-common
	sudo rm -rf /usr/share/doc/zsh-common*
	sudo rm -rf /usr/share/doc-base/zsh-common.zsh-faq
	sudo rm -rf /usr/share/kali-defaults/etc/zsh*
	sudo rm -rf /usr/share/lintian/overrides/zsh-common
	sudo rm -rf /usr/share/menu/zsh-common
	sudo rm -rf /usr/share/vim/vim91/compiler/zsh.vim
	sudo rm -rf /usr/share/vim/vim91/ftplugin/zsh.vim
	sudo rm -rf /usr/share/vim/vim91/indent/zsh.vim
	sudo rm -rf /usr/share/vim/vim91/syntax/zsh.vim
	sudo rm -rf /var/lib/dpkg/info/zsh-common.*
	sudo rm -rf /usr/share/man/man1/zsh*
	sudo rm -rf /var/lib/dpkg/info/zsh.*
fi

##ACTUALIZAR LA BASE DE DATOS DE ARCHIVOS
echo -e $azul"\n[+] ACTUAlIZANDO LA BASE DE DATOS DE ARCHIVO"$reset"\n"
sudo mandb
sudo updatedb

##LIMPIAR HISTORIAL
sudo apt update && sudo apt upgrade -y
history -c && history -w
echo -e $verde"[*] PROCESO TERMINADO, DEBE REINICIAR WSL"$reset"\n"
echo -e $verde"[*] PARA ELLO DESDE POWERSHELL EJECUTAR 'wsl --shutdown'"$reset"\n"
echo -e $cyan"[*] PUEDES MODIFICAR EL BANNER EN /etc/$usuario"$reset"\n"
