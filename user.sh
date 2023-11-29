#!/bin/bash
usuario=$(id -un)

echo "Configuraciones para usuario $usuario"

./banner.sh
echo "alias clear='printf \"\033c\" && /etc/$usuario.sh'" >> /home/$usuario/.bash_aliases
echo "alias ls='lsd --group-dirs=first'" >> /home/$usuario/.bash_aliases
echo "alias ll='lsd -l --group-dirs=first'" >> /home/$usuario/.bash_aliases
echo "alias la='lsd -A --group-dirs=first'" >> /home/$usuario/.bash_aliases
echo "alias l='ls -CF --group-dirs=first'" >> /home/$usuario/.bash_aliases
echo "alias cat='batcat --paging=never'" >> /home/$usuario/.bash_aliases
echo "alias catn='/usr/bin/cat'" >> /home/$usuario/.bash_aliases
echo "alias realip='curl -s ifconfig.me'" >> /home/$usuario/.bash_aliases
echo "alias realip='curl -4 http://wttr.in/?lang=es'" >> /home/$usuario/.bash_aliases

echo "#WINDOWS ALIAS"
echo "alias cmd='cmd.exe /c \"cmd\" 2>/dev/null'" >> /home/$usuario/.bash_aliases
echo "alias powershell='cmd.exe /c \"powershell\" 2>/dev/null' >> /home/$usuario/.bash_aliases
echo "alias firefox='cmd.exe /c \"start firefox\" 2>/dev/null' >> /home/$usuario/.bash_aliases
echo "alias ipconfig='cmd.exe /c \"ipconfig\" 2>/dev/null' >> /home/$usuario/.bash_aliases
echo "alias winget='cmd.exe /c \"winget\" 2>/dev/null' >> /home/$usuario/.bash_aliases
