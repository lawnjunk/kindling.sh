#!/bin/sh
# check os
# backup old bashconf
# install bash git aware prompt
# set PS1
# set convienece alisus
# link bashrc bash_profile and profile to be the same

PNK="\e[95m"
RED="\e[91m"
CYN="\e[96m" 
WHT="\e[39m"

debug () {
  if [ $DEBUG = "ENABLED" ]; then
    echo -e ${PNK}${1}${WHT}
  fi
}

USAGE_ERROR="true"
[ $# -eq 0 ] || [ $# -eq 2 ] && USAGE_ERROR="flase"
if [ $USAGE_ERROR = "true" ]; then 
  echo -e "$RED USAGE ERROR:"
  echo -e "    $CYN Run Installer:$WHT ./bash-starter.sh"
  echo -e "    $CYN Development:$WHT ./bash-starter.sh --test <Linux || Darwin>" 
  exit 1
fi

if [ $# -eq 2 ]; then
  DEBUG="ENABLED"
  OS="$2"
  HOME="./USER_TEST"
  [ ! -d $HOME ] && mkdir $HOME
  echo "" > $HOME/.profile
  echo "" > $HOME/.bashrc
  echo "" > $HOME/.bash_profile
else 
  echo -e $RED "exiting here for test so i dont break my computer"
  exit 0 
  OS=`uname`
fi
debug "OS: $OS\n"

# only run script for linux or mac
OS_ERROR="true"
[ $OS = "Linux" ] || [ $OS = "Darwin" ] && OS_ERROR="false"
[ $OS_ERROR = "true" ] && echo -e "${RED}ERROR:${WHT} This script must be run on a Linux or OS X Operating System." && exit 1

# make back-up of origional bashrc
if [ -f $HOME/.bashrc ]; then 
  WARNING="$WARNING\n${RED}Warning:${WHT} your original${CYN} $HOME/.bashrc${WHT} has been moved to${CYN} $HOME/.bashrc.back"
  mv $HOME/.bashrc $HOME/.bashrc.back 
fi 
if [ -f $HOME/.bash_profile ]; then 
  mv $HOME/.bash_profile $HOME/.bash_profile.back
  WARNING="$WARNING\n${RED}Warning:${WHT} your original${CYN} $HOME/.bash_profile${WHT} has been moved to${CYN} $HOME/.bash_profile.back"
fi
if [ -f $HOME/.profile ]; then 
  mv $HOME/.profile $HOME/.profile.back
  WARNING="$WARNING\n${RED}Warning:${WHT} your original${CYN} $HOME/.profile${WHT} has been moved to${CYN} $HOME/.profile.back"
fi

# make a $HOME/.bash dir if doesnt all read exist
[ ! -d $HOME/.bash ] && mkdir $HOME/.bash
if [ ! -d $HOME/.bash/git-aware-prompt ]; then
  # download git-aware prompt
  echo -e $CYN"Installing git-aware-promt:$WHT"
  mkdir $HOME/.bash/git-aware-prompt
  git clone git://github.com/jimeh/git-aware-prompt.git $HOME/.bash/git-aware-prompt
  echo ""
fi

# create $HOME/.bashrc
BASH_PATH=$HOME/.bashrc
curl -p $BASH_PATH 

# make links so bashrc bash_profile and profile are all the same

echo -e "$WARNING"
