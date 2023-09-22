dotFiles
========

My dot files 
## Usage
```sh
stow  --ignore=.local/Apps/neovim-distros/lunarvim/share --ignore=.local/Apps/neovim-distros/lunarvim/cache -t $HOME home
```
## This includes
* My openbox configuration files
    * my favorite keyboard-mappings

            <Meta-space>     : Launch kupfer (A program used to launch applications )
            <C-A-t>          : Launch terminal
            <C-A-Arrows>     : Move to workspaces
            <C-A-S-Arrows>   : Move to workspaces with current window
            <C-A-Numpad 1-9> : Tile windows as like Numpad's keys
            <C-A-End>        : Show shut-sown dialog
            <C-A-Delete>     : Show gnome-system-monitor

* My SpaceFm configuration files (It's a Highly configurable file manager )
    * favorite keyboard-mappings

            <F4>     : Open terminal in cwd (In-built)
            <C-g>    : Open git-gui in cwd
            <M-v>    : Open gvim in cwd
            <C-S-x>  : Extract archive to cwd using file-roller
            <C-s>    : select file patern
            <C-S-S>  : show in-built file search dialog
            <C-S-v>  : paste link
            <A-i>    : switch to icon-view
            <A-d>    : switch to details-list-view
            <A-1..9> : switch tabs

* My gvimrc
    * keyboard-mappings

            <A-1..9>           : Switch tabs
            <Leader><Leader>es : edit ~/.vimrc in new tab
            <Leader><Leader>en : edit current files snippets files in new tab
            <C-PageUp>         : Previous tab
            <C-PageDown>       : Next tab
            <C-S-PageUp>       : Move to previous tab position
            <C-S-PageDown>     : Move to next tab position
            <C-j>              : Move current window to previous tab position (With v-split)
            <C-k>              : Move current window to next tab position (With v-split)
            <A-Arrows>         : Move cursor to corresponding windows
            <Leader>sl         : Session List
            <Leader>sc         : Session List

* My .profile file wich includes ~/.local/bin to PATH

* mygeany script which opens `/path/to/file:37:` like format and put cursor on corresponding line number
* myvim script does the same for gvim
* update-npm-binaries script scan ~/node_modules and create links to binary tools to ~/.local/bin

#### Vim config for server

```bash
wget https://raw.githubusercontent.com/harish2704/dotFiles/master/home/.config/nvim/server.vim -O ~/.vimrc
```
