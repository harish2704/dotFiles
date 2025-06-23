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

export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock

export EDITOR=vim
export HISTCONTROL=ignoredups
export HISTSIZE=11000
export HISTFILESIZE=11000

alias ip='ip --color=auto'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


#export PYENV_ROOT="$HOME/.pyenv"
#[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "$HOME/.deno/env"
source $HOME/.local/share/bash-completion/completions/deno.bash
eval "$(~/.local/bin/mise activate bash)"
