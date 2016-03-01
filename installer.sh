#!/usr/bin/env bash
# check os
# backup old bashconf
# install bash git aware prompt
# curl bashrc
# link bashrc bash_profile and profile to be the same

# ansi color characters

backup () {
  #mv "$1" "$1.bak"
  if [ -f $1 ]; then 
    WARNING="$WARNING\n${red}Warning:${white} your original${cyan} $1${white} has been moved to${cyan} ${1}.bak"
    mv "$1" "${1}.bak"
  fi
}

debug() {
  if [ $DEBUG_ENABLED = True ]; then
    echo -e ${pink}${@}${white}
  fi
}


ncolors="$(tput colors)"

if [ -n $ncolors ] && [ $ncolors -ge 8 ];then 
  pink="$(tput setaf 5)"
  red="$(tput setaf 1)"
  cyan="$(tput setaf 6)" 
  white="$(tput setaf 15)"
else 
  pink=""
  red=""
  cyan=""
  white=""
fi

echo -e "${pink}###  ${red} #   ${cyan} ## ${white}#  #   ${pink}###  ${red}#  # ${cyan}#    ${white}#### ${pink} ## ${red} #" 
echo -e "${pink}#  # ${red}# #  ${cyan}#   ${white}#  #   ${pink}#  # ${red}#  # ${cyan}#    ${white}#    ${pink}#   ${red} #"
echo -e "${pink}#  # ${red}#  # ${cyan}#   ${white}#  #   ${pink}#  # ${red}#  # ${cyan}#    ${white}#    ${pink}#   ${red} #"
echo -e "${pink}###  ${red}#### ${cyan} #  ${white}####   ${pink}###  ${red}#  # ${cyan}#    ${white}#### ${pink} #  ${red} #"
echo -e "${pink}#  # ${red}#  # ${cyan}  # ${white}#  #   ${pink}#  # ${red}#  # ${cyan}#    ${white}#    ${pink}  # ${red} #"
echo -e "${pink}#  # ${red}#  # ${cyan}  # ${white}#  #   ${pink}#  # ${red}#  # ${cyan}#    ${white}#    ${pink}  # ${red}  "
echo -e "${pink}###  ${red}#  # ${cyan}##  ${white}#  #   ${pink}#  # ${red} ##  ${cyan}#### ${white}#### ${pink}##  ${red} #"
echo ""

# check for usage error
if ! $( [ $# -eq 0 ] || [ $# -eq 2 ] ); then 
  echo -e "$red USAGE ERROR:"
  echo -e "    ${cyan}Run Installer:${white} ./bash-starter.sh"
  echo -e "    ${cyan}Development:${white} ./bash-starter.sh --test <Linux || Darwin>" 
  exit 1
fi

# setup script variables
if [ $KINDLING_DEBUG ]; then
  DEBUG_ENABLED=True
  KINDLING_OS="$2"
  HOME="./USER_TEST"
  [ ! -d $HOME ] && mkdir $HOME
else 
  KINDLING_DEBUG=False
  KINDLING_OS=`uname`
fi

debug "KINDLING_OS: $KINDLING_OS\n"

# only run script for linux or mac
if ! $([ $KINDLING_OS = "Linux" ] || [ $KINDLING_OS = "Darwin" ]); then 
  echo -e "${red}ERROR:${white} This script must be run on a Linux or KINDLING_OS X Operating System."
  exit 1
fi

# make back-up of origional bashrc
backup $HOME/.bashrc
backup $HOME/.bash_profile
backup $HOME/.profile
#if [ -f $HOME/.bashrc ]; then 
  #WARNING="$WARNING\n${red}Warning:${white} your original${cyan} $HOME/.bashrc${white} has been moved to${cyan} $HOME/.bashrc.back"
  #backup $HOME/.bashrc
#fi 
#if [ -f $HOME/.bash_profile ]; then 
  #WARNING="$WARNING\n${red}Warning:${white} your original${cyan} $HOME/.bash_profile${white} has been moved to${cyan} $HOME/.bash_profile.back"
  #backup $HOME/.bash_profile
#fi
#if [ -f $HOME/.profile ]; then 
  #mv $HOME/.profile $HOME/.profile.back
  #WARNING="$WARNING\n${red}Warning:${white} your original${cyan} $HOME/.profile${white} has been moved to${cyan} $HOME/.profile.back"
  #backup $HOME/.profile
#fi

# make a $HOME/.bash dir if doesnt all read exist
[ ! -d $HOME/.bash ] && mkdir $HOME/.bash
if [ ! -d $HOME/.bash/git-aware-prompt ]; then
  # download git-aware prompt
  echo -e "${cyan}Installing git-aware-promt:${white}"
  mkdir $HOME/.bash/git-aware-prompt
  git clone git://github.com/jimeh/git-aware-prompt.git $HOME/.bash/git-aware-prompt
  echo ""
fi
curl -o $HOME/.bash/git-completion.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

# create $HOME/.bashrc
BASH_PATH=$HOME/.bashrc
echo -e "${cyan}Installing bashrc:${white}"
curl -o $BASH_PATH https://raw.githubusercontent.com/slugbyte/code-101-prework/master/src/bashrc

# make links so bashrc bash_profile and profile are all the same
echo -e "${cyan}Linking ~/.profile and ~/.bash_profile to ~/.bashrc${white}"
ln -sf $HOME/.bashrc $HOME/.bash_profile
ln -sf $HOME/.bashrc $HOME/.profile

echo -e "$WARNING"

# source new bashrc if $SHELL == $(env bash)
if [ $SHELL = $(env bash) ] && source $HOME/.bashrc
