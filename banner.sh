#!/bin/bash

usuario=$(id -un)

echo $usuario

sudo mv racso.sh /etc/$usuario.sh

# Agregar el banner al Usuario
if [ -f /home/$usuario/.bashrc ]; then
	echo '/etc/'$usuario'.sh' >> /home/$usuario/.bashrc
fi

if [ -f /home/$usuario/.zshrc ]; then
	echo '/etc/'$usuario'.sh' >> /home/$usuario/.zshrc
fi

if [ -f /home/$usuario/.bash_aliases ]; then
	echo "alias clear='printf \"\033c\" && /etc/$usuario.sh'" >> /home/$usuario/.bash_aliases
else
	echo "alias clear='printf \"\033c\" && /etc/$usuario.sh'" > /home/$usuario/.bash_aliases
fi

# Agregar el banner al ROOT
if [ -f /root/.bashrc ]; then
	sudo echo '/etc/'$usuario'.sh' >> /root/.bashrc
fi

if [ -f /root/.zshrc ]; then
	sudo echo '/etc/'$usuario'.sh' >> /root/.zshrc
fi

if [ -f /root/.bash_aliases ]; then
	sudo echo "alias clear='printf \"\033c\" && /etc/$usuario.sh'" >> /root/.bash_aliases
else
	sudo echo "alias clear='printf \"\033c\" && /etc/$usuario.sh'" >> /root/.bash_aliases
fi


chmod +x /etc/$usuario.sh
gedit /etc/$usuario.sh
firefox https://patorjk.com/software/taag/#p=display&f=Big&t=Racso
