#!/bin/sh

echo $1

# check os
OS=$1

if [ $OS = "Linux" ]; then 
  LSColorFlag="--color=auto"
elif [ $OS = "Darwin" ]; then
  LSColorFlag="-G"
else
  echo "This script must be ran on Linux or OS X"
  exit 1
fi

echo "LS COLOR FLAG: $LSColorFlag"

# make back-up of origional bashrc
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

