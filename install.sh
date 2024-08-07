#/bin/bash

USERNAME=who | awk '{print $1; exit}'

uname | grep Linux
if [[ $? == 0  ]]; then
	whoami
	if [[ $? != "root" ]]; then
		echo "You need to execute this script as root"
		exit
	fi
	PM="apt-get install -y "
	apt-get -y update && apt-get -y upgrade
	which unzip
	if [[ $? != 0 ]]; then
		$PM unzip
	fi
	unzip Fira.zip -d ~/.fonts/
else
	which brew
	if [[ $? != 0 ]]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
	PM="brew install -y"
	which unzip
	if [[ $? != 0 ]]; then
		$PM unzip
	fi
	unzip Fira.zip -d ~/Library/Fonts/
fi

echo "*********************************************************************"
echo "****************Installing Emmanuel's terminal setup*****************"
echo "*********************************************************************"


which kitty
if [[ $? != 0 ]]; then
	echo "Installing Kitty"
	sudo -u $USERNAME curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
	# Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in
	# your system-wide PATH)
	sudo -u $USERNAME ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
	# Place the kitty.desktop file somewhere it can be found by the OS
	sudo -u $USERNAME cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
	# If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
	sudo -u $USERNAME cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
	# Update the paths to the kitty and its icon in the kitty desktop file(s)
	sudo -u $USERNAME sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
	sudo -u $USERNAME sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
	# Make xdg-terminal-exec (and hence desktop environments that support it use kitty)
	sudo -u $USERNAME echo 'kitty.desktop' > ~/.config/xdg-terminals.list
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
