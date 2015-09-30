#!/bin/sh
# check os
# backup old bashconf
# install bash git aware prompt
# set PS1
# set convienece alisus
# link bashrc bash_profile and profile to be the same

debug () {
  if [ $DEBUG = "ENABLED" ]; then
    echo -e $1
  fi
}

RED="\e[91m"
CYN="\e[96m" 
WHT="\e[39m"

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

if [ $OS = "Linux" ]; then 
  LSColorFlag="--color=auto"
elif [ $OS = "Darwin" ]; then
  LSColorFlag="-G"
else
  echo "This script must be run on a Linux or OS X Operating System."
# check os and set color flag
  exit 1
fi
debug "LS COLOR FLAG: $LSColorFlag\n"

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

echo "export GITAWAREPROMPT=\$HOME/.bash/git-aware-prompt" >> $BASH_PATH
echo "source \"\${GITAWAREPROMPT}/main.sh\""               >> $BASH_PATH
echo ""                                                   >> $BASH_PATH
echo "export PS1=\"\[\$txtcyn\]\u\[\$txtwht\]@\[\$txtcyn\]\h \[\$txtred\]\W \[\$txtcyn\]\$git_branch\[\$txtred\]\$git_dirty\[\$txtrst\]\$ \"" >> $BASH_PATH
echo "" >> $BASH_PATH
# set convienence aliases
# note: intentional use of double qoutes and \"
#       single quotes dont expand variables, and
#       I want their files to have double qoutes.
echo "alias ls=\"ls $LSColorFlag\"" >> $BASH_PATH
echo "alias la=\"ls -a\""           >> $BASH_PATH
echo "alias ll=\"ls -lh\""          >> $BASH_PATH
echo "alias lal=\"ls -lah\""        >> $BASH_PATH
echo ""                             >> $BASH_PATH
echo "alias ..=\"cd ..\""           >> $BASH_PATH

# set new ps1
# make links so bashrc bash_profile and profile are all the same

echo -e "$WARNING"
