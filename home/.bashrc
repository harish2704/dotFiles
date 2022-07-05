# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
if test -z "$USER_BASHRC_READ"; then
. $HOME/.profile

test -s ~/.alias && . ~/.alias || true

export NVM_DIR="$HOME/.nvm"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/hari/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/hari/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/hari/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/hari/Downloads/google-cloud-sdk/completion.bash.inc'; fi

export DENO_INSTALL="/home/hari/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export USER_BASHRC_READ=1
fi

nvmLoad(){
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

. $HOME/.local/Apps/daily-utils/bin/_hari-tools-completion.sh
. /usr/share/bash-completion/completions/fzf-key-bindings
