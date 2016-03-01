#!/usr/bin/env bash
# check os
# backup old bashconf
# install bash git aware prompt
# curl bashrc
# link bashrc bash_profile and profile to be the same

# ansi color characters
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
if [ $# -eq 2 ]; then
  DEBUG_ENABLED=True
  OS="$2"
  HOME="./USER_TEST"
  [ ! -d $HOME ] && mkdir $HOME
else 
  DEBUG_ENABLED=False
  OS=`uname`
fi

debug() {
  if [ $DEBUG_ENABLED = True ]; then
    echo -e ${pink}${@}${white}
  fi
}

debug "OS: $OS\n"

# only run script for linux or mac
if ! $([ $OS = "Linux" ] || [ $OS = "Darwin" ]); then 
  echo -e "${red}ERROR:${white} This script must be run on a Linux or OS X Operating System."
  exit 1
fi

# make back-up of origional bashrc
if [ -f $HOME/.bashrc ]; then 
  WARNING="$WARNING\n${red}Warning:${white} your original${cyan} $HOME/.bashrc${white} has been moved to${cyan} $HOME/.bashrc.back"
  mv $HOME/.bashrc $HOME/.bashrc.back 
fi 
if [ -f $HOME/.bash_profile ]; then 
  mv $HOME/.bash_profile $HOME/.bash_profile.back
  WARNING="$WARNING\n${red}Warning:${white} your original${cyan} $HOME/.bash_profile${white} has been moved to${cyan} $HOME/.bash_profile.back"
fi
if [ -f $HOME/.profile ]; then 
  mv $HOME/.profile $HOME/.profile.back
  WARNING="$WARNING\n${red}Warning:${white} your original${cyan} $HOME/.profile${white} has been moved to${cyan} $HOME/.profile.back"
fi

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
