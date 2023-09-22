
if test -z "$USER_PROFILEREAD"; then

  export PYENV_ROOT="$HOME/.pyenv"
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

  PATH="$HOME/.node_modules_mine/node_modules/.bin:$PATH";
  PATH="$HOME/.local/bin:$PATH";
  PATH="$HOME/go/bin:$PATH";
  PATH="$HOME/.cargo/bin:$PATH"
  PATH="$HOME/.linuxbrew/bin:$PATH";
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
  PATH="$PATH:$HOME/.local/Apps/flutter/bin"
  PATH="$PYENV_ROOT/bin:$PATH"
  export PATH

  export DENO_INSTALL="/home/harish/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
  export TIME_STYLE=long-iso
  export TCLLIBPATH=$HOME/.local/share/tkthemes
  export ANDROID_HOME=$HOME/.local/Apps/android-sdk
  export SYSTEMD_PAGER=

  export INPUT_METHOD=ibus
  export GTK_IM_MODULE=ibus
  export XMODIFIERS=@im=ibus
  export QT_IM_MODULE=ibus

  export USER_PROFILEREAD=1
fi
