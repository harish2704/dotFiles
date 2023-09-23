# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi


if [[ -f  /usr/share/fzf/shell/key-bindings.bash ]]; then
  . /usr/share/fzf/shell/key-bindings.bash
fi

if [[ -f  $HOME/.local/Apps/daily-utils/hari-autocomplete.sh ]]; then
  . $HOME/.local/Apps/daily-utils/hari-autocomplete.sh
fi

# C_ORANGERED1="\[\e[38;5;202m\]"
# C_DARKCYAN="\[\e[38;5;36m\]"
# C_YELLOW="\[\e[38;5;11m\]"
# C_CYAN1="\[\e[38;5;51m\]"
# C_RED="\[\033[38;5;9m\]"

NO_FORMAT="\[\e[0m\]"
F_BOLD="\[\e[1m\]"
C_YELLOW1="\[\e[38;5;226m\]"
C_AQUAMARINE1="\[\e[38;5;86m\]"
PS1="${F_BOLD}${C_AQUAMARINE1}\u@\h${C_YELLOW1} \w \\\$${NO_FORMAT} "

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR=vim
