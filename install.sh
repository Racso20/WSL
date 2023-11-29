#!/bin/bash

if (( $EUID != 0 )); then
  echo "NECESITA SER ROOT PARA EJECUTAR ESTE INSTAlADOR"
  exit
fi
apt update && apt upgrade -y

mv interoperabilidad /etc/interoperabilidad
mv funciones /etc/funciones
mv ipwsl /etc/ipwsl
mv wsl.conf /etc/wsl.conf

echo "INSTALANDO SQUID"
apt install squid -y
rm /etc/squid/squid.conf
mv squid.conf /etc/squid/squid.conf
echo 'squid:$apr1$ebz/wRCD$Dr9/2gKrAXRMA6UW5ro3U1' > /etc/squid/auth
echo "El usuario de Squid es squid"
echo "La clave de Squid es Kalisquid"
echo "La ruta de Squid es kali.wsl2"
echo "El puerto de Squid es 3128"
squid -k reconfigure

echo "Instalando LSDeluxe - BatCat"
apt install lsd bat -y

echo "Instalando Wordlist"
apt install wordlists -y

echo "Para mas herramientas revise kali.org/tools"

echo "Puede seguir la configuración de usuario ejecutando el archivo 'user.sh' sin permisos root"

