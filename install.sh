#!/bin/sh
set -e
###########################################################################
#
# Node Bootstrap Installer
# https://github.com/polymimetic/ansible-role-node
#
# This script is intended to replicate the ansible role in a shell script
# format. It can be useful for debugging purposes or as a quick installer
# when it is inconvenient or impractical to run the ansible playbook.
#
# Usage:
# wget -O- https://raw.githubusercontent.com/polymimetic/ansible-role-node/master/install.sh | sh
#
###########################################################################

if [ `id -u` = 0 ]; then
  printf "\033[1;31mThis script must NOT be run as root\033[0m\n" 1>&2
  exit 1
fi

###########################################################################
# Constants and Global Variables
###########################################################################

readonly LINUX_MTYPE="$(uname -m)"                   # x86_64
readonly LINUX_ID="$(lsb_release -i -s)"             # Ubuntu
readonly LINUX_CODENAME="$(lsb_release -c -s)"       # xenial
readonly LINUX_RELEASE="$(lsb_release -r -s)"        # 16.04
readonly LINUX_DESCRIPTION="$(lsb_release -d -s)"    # GalliumOS 2.1
readonly LINUX_DESKTOP="$(printenv DESKTOP_SESSION)" # /usr/bin/xfce
readonly LINUX_USER="$(who am i | awk '{print $1}')" # user

readonly GIT_REPO="https://github.com/polymimetic/ansible-role-node.git"
readonly GIT_RAW="https://raw.githubusercontent.com/polymimetic/ansible-role-node/master"

###########################################################################
# Basic Functions
###########################################################################

# Output Echoes
# https://github.com/cowboy/dotfiles
e_error()   { printf "\033[1;31m✖  $@\033[0m\n";     } # red
e_success() { printf "\033[1;32m✔  $@\033[0m\n";     } # green
e_prompt()  { printf "\033[1;33m$@ \033[0m\n";       } # yellow
e_info()    { printf "\033[1;34m$@\033[0m\n";        } # blue
e_title()   { printf "\033[1;35m$@.......\033[0m\n"; } # magenta
e_output()  { printf "$@\n"; }

###########################################################################
# Install Node
# https://nodejs.org/en/download/package-manager/
# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04
# http://nodesource.com/blog/installing-node-js-tutorial-ubuntu/
# https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
###########################################################################

install_node() {
  e_title "Installing Node"

  local NPM_DIR="${HOME}/.npm-packages"
  local ENV_NPM='export NPM_PACKAGES="%s"'

  # Install dependencies
  sudo install -y build-essential

  # Install nodesource PPA
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  sudo apt install -y nodejs

  # Check node version
  node -v

  # Create a directory for global packages
  if [ ! -d "${HOME}/.npm-packages" ]; then
    mkdir "${HOME}/.npm-packages"
    npm config set prefix "${HOME}/.npm-packages"
  fi

  # Indicate to npm where to store globally installed packages
  if [ ! -f "${HOME}/.npmrc" ]; then
    echo "prefix=${HOME}/.npm-packages" | tee ${HOME}/.npmrc
  fi

  # Ensure npm will find installed binaries and man pages (Shell).
  printf "${ENV_NPM}\n\n" ${NPM_DIR} | tee -a ${HOME}/.profile
  echo 'PATH="$NPM_PACKAGES/bin:$PATH"\n' | tee -a ${HOME}/.profile
  echo 'unset MANPATH' | tee -a ${HOME}/.profile
  echo 'export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"' | tee -a ${HOME}/.profile
  source ${HOME}/.profile

  # Ensure npm will find installed binaries and man pages (Bash).
  printf "${ENV_NPM}\n\n" ${NPM_DIR} | tee -a ${HOME}/.bashrc
  echo 'PATH="$NPM_PACKAGES/bin:$PATH"\n' | tee -a ${HOME}/.bashrc
  echo 'unset MANPATH' | tee -a ${HOME}/.bashrc
  echo 'export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"' | tee -a ${HOME}/.bashrc
  source ${HOME}/.bashrc

  # Ensure npm will find installed binaries and man pages (Zsh).
  printf "${ENV_NPM}\n\n" ${NPM_DIR} | tee -a ${HOME}/.zshrc
  echo 'PATH="$NPM_PACKAGES/bin:$PATH"\n' | tee -a ${HOME}/.zshrc
  echo 'unset MANPATH' | tee -a ${HOME}/.zshrc
  echo 'export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"' | tee -a ${HOME}/.zshrc
  source ${HOME}/.zshrc

  # Update NPM
  npm install npm --global

  e_success "Node installed"
}

###########################################################################
# Install Node Version Manager (NVM)
# https://github.com/creationix/nvm
# https://gist.github.com/d2s/372b5943bce17b964a79
# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04
###########################################################################

install_nvm() {
  e_title "Installing NVM"

  # Install dependencies
  sudo apt update
  sudo install -y build-essential libssl-dev

  # Run installation script
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
  source ~/.profile

  # Check nvm version
  command -v nvm

  # Install latest node LTS
  nvm install v8.9.1
  nvm install --lts=boron

  # Set default node version
  nvm alias default v8.9.1
  nvm use default

  e_success "NVM installed"
}

###########################################################################
# Install Global Node Packages
###########################################################################

install_npm() {
  e_title "Installing Global Node Packages"

  npm install -g gulp-cli
  npm install -g bower
  npm install -g yarn
  npm install -g grunt-cli
  npm install -g browser-sync
  npm install -g webpack
  npm install -g webpack-dev-server
  npm install -g yo
  npm install -g less
  npm install -g node-sass
  npm install -g jslint

  # npm install -g npm-check-updates
  # npm install -g phantomjs-prebuilt
  # npm install -g casperjs
  # npm install -g simplehttpserver
  # npm install -g xlsx
  # npm install -g webfont-dl
  # npm install -g diff-so-fancy


  e_success "Global packages installed"
}

###########################################################################
# Program Start
###########################################################################

program_start() {
  install_node
  install_npm
}

program_start