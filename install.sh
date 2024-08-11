#/bin/bash

uname | grep Linux
if [[ $? == 0 ]]; then
  if [[ $(whoami) != 'root' ]]; then
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

echo "We need some information to configure git"
read -p "name: " fullname
read -p "username: " username
read -p "email: " email

USERNAME=$(who | awk '{print $1;exit}')
sudo -u $USERNAME /bin/bash kitty-install.sh

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
  gem install rubocop
fi

which stow
if [[ $? != 0 ]]; then
  echo "Installing stow"
  $PM stow
fi

echo "Stowing config"
sudo -u stow -t /home/$username -S nvim
sudo -u stow -t /home/$username -S tmux
sudo -u stow -t /home/$username -S kitty

echo "Setting up git"
git config --global core.editor "nvim"
git config --global user.name "$name"
git config --global user.email "$email"
git config --global user.username "$username"
