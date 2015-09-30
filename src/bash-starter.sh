#!/bin/sh
# check os
# backup old bashconf
# install bash git aware prompt
# curl bashrc
# link bashrc bash_profile and profile to be the same

# ansi color characters
PNK="\e[95m"
RED="\e[91m"
CYN="\e[96m" 
WHT="\e[39m"

echo -e "${PNK}###  ${RED} #   ${CYN} ## ${WHT}#  #   ${PNK}###  ${RED}#  # ${CYN}#    ${WHT}#### ${PNK} ## ${RED} #" 
echo -e "${PNK}#  # ${RED}# #  ${CYN}#   ${WHT}#  #   ${PNK}#  # ${RED}#  # ${CYN}#    ${WHT}#    ${PNK}#   ${RED} #"
echo -e "${PNK}#  # ${RED}#  # ${CYN}#   ${WHT}#  #   ${PNK}#  # ${RED}#  # ${CYN}#    ${WHT}#    ${PNK}#   ${RED} #"
echo -e "${PNK}###  ${RED}#### ${CYN} #  ${WHT}####   ${PNK}###  ${RED}#  # ${CYN}#    ${WHT}#### ${PNK} #  ${RED} #"
echo -e "${PNK}#  # ${RED}#  # ${CYN}  # ${WHT}#  #   ${PNK}#  # ${RED}#  # ${CYN}#    ${WHT}#    ${PNK}  # ${RED} #"
echo -e "${PNK}#  # ${RED}#  # ${CYN}  # ${WHT}#  #   ${PNK}#  # ${RED}#  # ${CYN}#    ${WHT}#    ${PNK}  # ${RED}  "
echo -e "${PNK}###  ${RED}#  # ${CYN}##  ${WHT}#  #   ${PNK}#  # ${RED} ##  ${CYN}#### ${WHT}#### ${PNK}##  ${RED} #"

debug () {
  if [ $debug = True ]; then
    echo -e ${PNK}${@}${WHT}
  fi
}

# check for usage error
if ! $([ $# -eq 0 ] || [ $# -eq 2 ]); then 
  echo -e "$RED USAGE ERROR:"
  echo -e "    ${CYN}Run Installer:${WHT} ./bash-starter.sh"
  echo -e "    ${CYN}Development:${WHT} ./bash-starter.sh --test <Linux || Darwin>" 
  exit 1
fi

# setup script variables
if [ $# -eq 2 ]; then
  debug=True
  OS="$2"
  HOME="./USER_TEST"
  [ ! -d $HOME ] && mkdir $HOME
  #echo "" > $HOME/.profile
  #echo "" > $HOME/.bashrc
  #echo "" > $HOME/.bash_profile
else 
  echo -e $RED "exiting here for test so i dont break my computer"
  exit 0 
  OS=`uname`
fi
debug "OS: $OS\n"

# only run script for linux or mac
if ! $([ $OS = "Linux" ] || [ $OS = "Darwin" ]); then 
  echo -e "${RED}ERROR:${WHT} This script must be run on a Linux or OS X Operating System."
  exit 1
fi

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
  echo -e "${CYN}Installing git-aware-promt:${WHT}"
  mkdir $HOME/.bash/git-aware-prompt
  git clone git://github.com/jimeh/git-aware-prompt.git $HOME/.bash/git-aware-prompt
  echo ""
fi

# create $HOME/.bashrc
BASH_PATH=$HOME/.bashrc
echo -e "${CYN}Installing bashrc:${WHT}"
curl -o $BASH_PATH https://raw.githubusercontent.com/slugbyte/code-101-prework/master/src/bashrc

# make links so bashrc bash_profile and profile are all the same
echo -e "${CYN}Linking ~/.profile and ~/.bash_profile to ~/.bashrc${WHT}"
ln -sf $HOME/.bashrc $HOME/.bash_profile
ln -sf $HOME/.bashrc $HOME/.profile

echo -e "$WARNING"
