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
###########################################################################

install_script() {
  e_title "Installing Node"

  e_success "Node installed"
}

###########################################################################
# Program Start
###########################################################################

program_start() {
  install_script
}

program_start