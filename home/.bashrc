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

#export PS1='\e[1;36;40m[\u@\h\e[1;33;40m \W]\e[0;37;40m\$ '
PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR=vim
