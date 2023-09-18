# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if [[ -z $HOME_BASH_RC_LOAD ]]
then
  PATH="$HOME/.node_modules_mine/node_modules/.bin:$PATH";
  PATH="$HOME/.local/bin:$PATH";
  PATH="$HOME/go/bin:$PATH";
  PATH="$HOME/.linuxbrew/bin:$PATH";
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
  PATH="$PATH:$HOME/.local/Apps/flutter/bin"
  export PATH

  export NVM_DIR="$HOME/.nvm"
  export DENO_INSTALL="/home/harish/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
  export TIME_STYLE=long-iso
  export TCLLIBPATH=~/.local/share/tkthemes
  export ANDROID_HOME=/home/harish/.local/Apps/android-sdk

  export GTK_IM_MODULE=ibus
  export XMODIFIERS=@im=ibus
  export QT_IM_MODULE=ibus
  unset rc
  export SYSTEMD_PAGER=

  # User specific aliases and functions
  # if [ -d ~/.bashrc.d ]; then
  #   for rc in ~/.bashrc.d/*; do
  #     if [ -f "$rc" ]; then
  #       . "$rc"
  #     fi
  #   done
  # fi

  export HOME_BASH_RC_LOAD=1
fi


. /usr/share/fzf/shell/key-bindings.bash
. $HOME/Projects/Github/dotFiles/home/.local/Apps/daily-utils/hari-autocomplete.sh

#export PS1='\e[1;36;40m[\u@\h\e[1;33;40m \W]\e[0;37;40m\$ '
PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '

nvmLoad(){
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

