#!/bin/bash

apt update && apt upgrade -y

mv interoperabilidad /etc/interoperabilidad
mv funciones /etc/funciones
mv ipwsl /etc/ipwsl

echo "Instalando SQUID"
apt install squid -y
rm /etc/squid/squid.conf
mv squid.conf /etc/squid/squid.conf
echo 'squid:$apr1$ebz/wRCD$Dr9/2gKrAXRMA6UW5ro3U1' > /etc/squid/auth
echo "El usuario de Squid es squid"
echo "La clave de Squid es Kalisquid"
squid -k reconfigure

echo "Instalando LSDeluxe - BatCat"
apt install lsd bat -y

echo "Instalando Wordlist"
apt install wordlists -y

echo "Para mas herramientas revise kali.org/tools

echo "Ejecutar user.sh sin ser root"

