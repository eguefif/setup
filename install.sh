#/bin/bash

uname | grep Linux
if [[ $? == 0  ]]; then
	if [[ `whoami` != 'root' ]]; then
		echo "You need to execute this script with sudo"
		exit
	fi
	PM="apt-get install -y "
	apt-get -y update && apt-get -y upgrade
else
	which brew
	if [[ $? != 0 ]]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
	PM="brew install -y"
fi

echo "*********************************************************************"
echo "****************Installing Emmanuel's terminal setup*****************"
echo "*********************************************************************"


USERNAME=$(who | awk '{print $1;exit}')
sudo -u $USERNAME /bin/bash kitty-install.sh

which starship
if [[ $? != 0 ]]; then
	echo "Installing starhip"
	curl -sS https://starship.rs/install.sh | sh
	echo 'eval "$(starship init bash)"' >> ~/.bashrc
	starship preset tokyo-night -o ~/.config/starship.toml
fi

which tmux
if [[ $? != 0 ]]; then
	echo "Installing Tmux"
	$PM libevent-dev ncurses-dev build-essential bison pkg-config
	$PM tmux
fi

which npm
if [[ $? != 0 ]]; then
	echo "Installing npm"
	$PM npm
fi

which nvim
if [[ $? != 0 ]]; then
	echo "Installing Neovim"
	$PM neovim
fi

which ruby
if [[ $? != 0 ]]; then
	echo "Installing Ruby"
	$PM ruby
	$PM rbenv
fi


which stow
if [[ $? != 0 ]]; then
	echo "Installing stow"
	$PM nodejs
fi

echo "Stowing config"
stow -t ~ -S nvim
stow -t ~ -S tmux
stow -t ~ -S kitty

echo "Setting up git"
git config --global core.editor "nvim"
git config --global user.name "Emmanuel Guefif"
git config --global user.email "eguefif@fastmail.com"
git config --global user.username "eguefif"
