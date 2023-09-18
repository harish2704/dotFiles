#!/usr/bin/env bash

thisDir=$(dirname $(realpath $0) )

createDirs(){
  mkdir -p ~/.config/nvim
  mkdir -p ~/.config/spacefm
}

installUtils(){
  # Install https://github.com/harish2704/installer-scripts
  wget 'https://raw.githubusercontent.com/harish2704/installer-scripts/master/installer.sh' -O - | sh
}

installNerdFonts(){
  cd ~/Downloads
  wget -c https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CodeNewRoman.zip
  unzip CodeNewRoman.zip *.otf
  mkdir -p ~/.local/share/fonts/
  mv CodeNewRoman*.otf ~/.local/share/fonts/
  fc-cache
}

setupLunarVim(){
  cd "$thisDir"
  cd ./home/.local/Apps/neovim-distros/lunarvim/
  git clone https://github.com/LunarVim/LunarVim
  cd LunarVim
  rm config.lua
  ln -s ../config.lua ./
}

installMain(){
  cd "$thisDir"
  stow -t $HOME home
}


createDirs
installUtils
installNerdFonts
setupLunarVim
installMain
