#/bin/bash

echo "*********************************************************************"
echo "****************Installing Emmanuel's terminal setup*****************"
echo "*********************************************************************"

echo "We need some information to configure git"
read -p "name: " fullname
read -p "username: " username
read -p "email: " email

USERNAME=$(who | awk '{print $1;exit}')
sudo -u $USERNAME /bin/bash kitty-install.sh

uname | grep Linux
if [[ $? == 0 ]]; then
  if [[ $(whoami) != 'root' ]]; then
    echo "You need to execute this script with sudo"
    exit
  fi
  PM="apt-get install -y "
  apt-get -y update && apt-get -y upgrade
  USERHOME="/home/$USERNAME"
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  mkdir -p /opt/nvim
  mv nvim.appimage /opt/nvim/nvim
  echo export PATH="$PATH:/opt/nvim/" >>$USERHOME/.bashrc
else
  which brew
  if [[ $? != 0 ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  PM="brew install --yes"
  USERHOME="/usr/$USERNAME"
  brew install -y neovim
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
fi

which ruby
if [[ $? != 0 ]]; then
  echo "Installing Ruby"
  $PM ruby
  $PM rbenv
  gem install rubocop
fi

which stow
if [[ $? != 0 ]]; then
  echo "Installing stow"
  $PM stow
fi

echo "Stowing config"
sudo -u $USERNAME stow -t $USERHOME -S nvim
sudo -u $USERNAME stow -t $USERHOME -S tmux
sudo -u $USERNAME stow -t $USERHOME -S kitty

echo "Setting up git"
git config --global core.editor "nvim"
git config --global user.name "$name"
git config --global user.email "$email"
git config --global user.username "$username"
