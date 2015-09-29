#!/bin/sh

# check os
# backup old bashconf
# install bash git aware prompt
# set PS1
# set convienece alisus
# link bashrc bash_profile and profile to be the same

echo "OS input $1"
echo ""

HOME="./USER_TEST"

# check os
OS=$1

if [ $OS = "Linux" ]; then 
  LSColorFlag="--color=auto"
elif [ $OS = "Darwin" ]; then
  LSColorFlag="-G"
else
  echo "This script must be run on a Linux or OS X Operating System."
  exit 1
fi

# make back-up of origional bashrc
[ -f $HOME/.bashrc ] && echo "bashrc exists"
[ -f $HOME/.bash_profile ] && echo "bash_profile exists"
[ -f $HOME/.profile ] && echo "profile exits"
echo ''

echo "LS COLOR FLAG: $LSColorFlag"
# set convienence aliases
# note: intentional use of double qoutes and \"
#       single quotes dont expand variables, and
#       I want their files to have double qoutes.
echo "alias ls=\"ls $LSColorFlag\""
echo "alias la=\"ls -a\""
echo "alias ll=\"ls -lh\""
echo "alias lal=\"ls -lah\""
echo "alias ..=\"cd ..\""

# download bash-git help
# set new ps1
# make links so bashrc bash_profile and profile are all the same

