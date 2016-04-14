# setup get aware prompt
export GITAWAREPROMPT=$HOME/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

num_colors=$(tput colors)
if [ num_colors ];then 
  txt_black="$(tput setaf 0)" #black
  txt_red="$(tput setaf 1)" #red
  txt_green="$(tput setaf 2)" #green
  txt_yellow="$(tput setaf 3)" #yellow
  txt_blue="$(tput setaf 4)" #blue
  txt_magenta="$(tput setaf 5)" #magenta
  txt_cyan="$(tput setaf 6)" #cyan
  txt_white="$(tput setaf 7)" #white
  txt_reset="$(tput sgr0)" #default foreground color
else 
  txt_black="" #black
  txt_red="" #red
  txt_green="" #green
  txt_yellow="" #yellow
  txt_blue="" #blue
  txt_magenta="" #magenta
  txt_cyan="" #cyan
  txt_white="" #white
  txt_reset="" #default foreground color
fi

# set PS1 (prompt)
export PS1="\[$txt_green\]\u\[$txt_white\]@\[$txt_green\]\h \[$txt_red\]\W \[$txt_cyan\]\$git_branch\[$txt_red\]\$git_dirty\[$txt_reset\]$ "

# add convience aliases
OS=`uname`
if [ $OS = "Linux" ]; then 
  LSColorFlag="--color=auto"
elif [ $OS = "Darwin" ]; then
  LSColorFlag="-G"
fi 

alias ls="ls $LSColorFlag"
alias la="ls -a"
alias ll="ls -lah"
alias l="ls -1"

alias ..="cd .."

# color code man pages
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}
