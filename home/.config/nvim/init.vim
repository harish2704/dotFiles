" This file is inspired by spf13's vimrc

" My custom commands {{{

" Grep for a word
command! -nargs=+ Gr :silent execute 'grep! -nr "<args>" | copen'
command! -nargs=* Grc grep -nr <args>
" Add file header to current buffer
command! Header :execute '0r!file-header %'

" Open Terminal in split
command! Term :execute 'sp | term'

" Cd to current file's directory
command! Cwd :execute 'cd %:p:h'

" Cd to current file's directory, but limit to current tab
command! Tcd :execute ':tcd %:p:h'

" Reload current buffer
command! Reload :execute "bufdo execute 'checktime . bufnr('%')'"

" Delete current file and close buffer
command! Rm :execute '!rm %' | bd

" Copy current file path to unnamedplus register
command! CopyFilename :let @+=@%
" }}}



" My settings {{{
filetype on                   " required!
filetype plugin indent on   " Automatically detect file types.

" set selection=exclusive       " Do not inlcude char under cursor while doing visual selection
set mouse=a
set clipboard=unnamedplus
set history=1000                 " Store a ton of history (default is 20)
set spell                        " Spell checking on
set hidden                       " Allow buffer switching without saving
set noswapfile
set title
set path=.,
set foldlevel=99
set foldmethod=indent

au BufEnter *.js.ejs set ft=javascript.ejs
" Disable python linting
autocmd VimEnter *.py SyntasticToggleMode

let g:NERDSpaceDelims=1

let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'

let javaScript_fold=0         " JavaScript
let perl_fold=1               " Perl
" let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
" let xml_syntax_folding=1      " XML
" set completeopt+=preview

" Syntax based folding found be slow. In most of the cases, we will do indenting according to syntax.
autocmd FileType java set foldmethod=indent
autocmd FileType html set foldmethod=indent
autocmd FileType javascript set foldmethod=indent
autocmd FileType xml set foldmethod=indent

" % key will be mapped by MatchTag plugin to match HTML tags.
" It is not need on php file
autocmd FileType php unmap %

" Add file header automatically for javascript files
autocmd BufNewFile *.js :Header

" }}}


" for formating {{{
" set nowrap                      " Wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=2                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=2                   " An indentation every four columns
set softtabstop=2               " Let backspace delete indent
set wrap
set cursorline                  " Highlight current line
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set nocompatible               " be iMproved
syntax on 

" for JavaScript {{{
" if we press 'gf' under require('abc/xyz'), then also sarch for ./abs/xyz.js
autocmd FileType javascript set includeexpr='./'.v:fname
autocmd FileType typescript set includeexpr='./'.v:fname
" }}}

" for java {{{
autocmd BufRead *.java set include=^#\s*import
autocmd BufRead *.java set includeexpr=substitute(v:fname,'\\.','/','g')
autocmd BufRead *.java set suffixesadd=.java,.xml
autocmd BufRead *.ect set suffixesadd=.ect ft=html.ect

" For vue js
" autocmd BufRead,BufNewFile *.vue setlocal filetype=html.vue

" For Nunjucks templates
autocmd BufRead *.njk set ft=jinja

autocmd BufEnter *.gradle set ft=groovy
" }}}


" for UI {{{

set showmode                    " Display the current mode
if has('statusline')
  set laststatus=2
  " Broken down into easily includeable segments
  set statusline=%w%h%m%r                 " Options
  " set statusline+=%{fugitive#statusline()} " Git Hotness
  " set statusline+=\ [%{&ff}/%Y]            " Filetype
  set statusline+=\ [%n]            " Filetype
  " set statusline+=\ [%{winnr()}]            " Filetype
  set statusline+=%<%f\                     " Filename
  " set statusline+=\ [%{getcwd()}]          " Current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set hlsearch                    " Highlight search terms
set noincsearch
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=1                " Lines to scroll when cursor leaves screen
set scrolloff=0                 " Minimum lines to keep above and below cursor
set list
" }}}

" for JS {{{
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

let b:javascript_fold = 0

" }}}



" AutoCloseTag {{{
" Make it so AutoCloseTag works for xml and xhtml files as well
au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
" }}}

" For NeRD Tree NERD Commenter {{{
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" * Commenting support for jinja tempaltes
" * Typedoc compatible Sexycomment support for typescript ( '/**' instead of '/*'' )
" * jsdoc3 compatible Sexycomment support for javascript ( '/**' instead of '/*'' )

au BufEnter *.ts let b:NERDSexyComMarker='* '
au BufEnter *.js let b:NERDSexyComMarker='* '
au BufEnter *.jsx let b:NERDSexyComMarker='* '
let g:NERDCustomDelimiters = {
      \ 'jinja': { 'left': '{# ', 'right': ' #}', 'leftAlt': '{# ', 'rightAlt': ' #}' },
      \ 'typescript': { 'left': '//', 'leftAlt': '/**', 'rightAlt': '*/' },
      \ 'javascript': { 'left': '//', 'leftAlt': '/**', 'rightAlt': '*/' },
\ }
" }}}

" Session List {{{
set sessionoptions=blank,buffers,curdir,tabpages,winsize,resize,winpos
" nmap <leader><leader>c  :JavaCorrect<cr>
" nmap <leader>pt :ProjectsTree<CR>
" }}}


" for JavaScript syntax checking {{{
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_typescript_checkers = ['tsuquyomi']
" }}}


" gides {{{
" let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
" }}}


" for Gtags {{{
let g:Gtags_Auto_Map = 1
let g:Gtags_VerticalWindow = 1
let g:Gtags_Auto_Update = 1
let g:GtagsCscope_Auto_Load = 1
" }}}


" set lazyredraw
let g:sparkupNextMapping = '<M-K>'


" for taggatron.
" let g:tagcommands = {
"       \    "php" : {
"       \        "tagfile" : ".php.tags",
"       \        "args" : "-R --langmap=PHP:+.mod"
"       \    }
"       \}


"for Plug {{{
"
" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Ctrl-p will open fuzzy file search using fzf plugin. These are the shortcuts available in fzf window
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }


let nvim_conf_root='~/.config/nvim/'

" Enable jsdoc comments Highlight for javascript 
let g:javascript_plugin_jsdoc = 1

call plug#begin( )
Plug 'tpope/vim-fugitive' " For Git repo management.
Plug 'brooth/far.vim'   " Interactive Fine & replace on multiple files
Plug 'Lokaltog/vim-easymotion' " Quick cursor movement to any where in the screen
" Plug 'Lokaltog/vim-distinguished'
" Plug 'junegunn/seoul256.vim'
" Plug 'whatyouhide/vim-gotham'
Plug 'rstacruz/sparkup' " HTML zen-coding  helper
" Plug 'L9'
" Plug 'FuzzyFinder'
" Plug 'git://git.wincent.com/command-t.git'
" Plug 'git://github.com/vim-scripts/YankRing.vim.git'
Plug 'git://github.com/maxbrunsfeld/vim-yankstack.git' " Clipboard histroy management.
"
" Plug 'tpope/vim-repeat'
" Plug 'svermeulen/vim-easyclip'

" Plug 'vim-scripts/Auto-Pairs' 
Plug 'vim-scripts/DoxygenToolkit.vim'  " Quickly create Doxygent style comments
" Plug 'Raimondi/delimitMate.git' 
" Plug 'bkad/CamelCaseMotion' 
" Plug 'vim-scripts/boxdraw'
" Plug 'vim-scripts/Vim-JDE'
" Plug 'maksimr/vim-jsbeautify'


Plug 'scrooloose/syntastic' " Syntax checking pluin
Plug 'rust-lang/rust.vim', { 'for': 'rust'}
Plug 'mxw/vim-jsx'
" Plug 'othree/yajs.vim'
" Plug 'harish2704/tern_for_vim' , { 'for': 'javascript' }
Plug 'harish2704/nerdcommenter' " Code commenting uncommenting
Plug 'garbas/vim-snipmate' " Snippet management
" Plug 'amiorin/vim-project'
Plug 'MarcWeber/vim-addon-mw-utils'  " Dependency of Snipmate plugin
" Plug 'tomtom/tlib_vim' " Dependency of Snipmate plugin
Plug 'nathanaelkane/vim-indent-guides' " Show indentation guides
" Plug 'flazz/vim-colorschemes'
Plug 'vim-scripts/sessionman.vim' " Session manager. Manage projects
" Plug 'kien/ctrlp.vim'
" Plug 'leshill/vim-json'
Plug 'godlygeek/tabular' " Tabularize Text
Plug 'majutsushi/tagbar'
" Plug 'amirh/HTML-AutoCloseTag'
Plug 'tpope/vim-surround' " quickly Insert/remove/change quote/brackes any vim selection.
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "Autocompletion
" Plug 'roxma/nvim-completion-manager'
" Plug 'mhartington/deoplete-typescript'
" Plug 'vim-scripts/AutoComplPop'
" Plug 'Shougo/neocomplcache'
" Plug 'Valloric/YouCompleteMe'
" Plug 'Shougo/eocomplcache'

Plug 'Shougo/vimproc.vim'
" Plug 'Quramy/tsuquyomi'
Plug 'mhartington/nvim-typescript'


Plug 'spf13/vim-autoclose' " Autoclose brackets/quotes etc
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFind' } "File tree
" My personal utils which does 
" 1. Open current file in new tab by keeping cursor position
" 2. Open all snippet files of current Filetype
" 3. Move current window to any tab
Plug 'harish2704/harish2704-vim'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
Plug 'AndrewRadev/vim-eco', { 'for': [ 'ect', 'eco' ] }
" Plug 'mustache/vim-mode'
Plug 'mustache/vim-mustache-handlebars', { 'for': 'handlebars' }
Plug 'chrisbra/NrrwRgn' " Edit a portion file as different buffer
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
" Plug 'vim-scripts/JavaScript-Indent'
" Plug 'spf13/PIV'
" Plug 'joonty/vim-taggatron'
" Plug 'git://github.com/vim-scripts/autoload_cscope.vim.git'
" Plug 'int3/vim-taglist-plus'
" Plug 'vim-scripts/EasyGrep'
Plug 'briancollins/vim-jst', { 'for': 'jst' }
Plug 'vim-scripts/matchit.zip'
Plug 'harish2704/vim-snippets'
" Plug 'vim-scripts/SyntaxRange'
" Plug 'harish2704/gtags.vim'
" Plug 'vim-scripts/guicolorscheme.vim'
" Plug 'vim-scripts/CSApprox'
" Plug 'vim-scripts/adt.vim'
" Plug 'tpope/eclim'
Plug 'tomasr/molokai'
" Plug 'joshdick/onedark.vim'
" Plug 'mhartington/oceanic-next'
" Plug 'joonty/vdebug'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'vim-scripts/SyntaxComplete'
" Plug 'justinj/vim-react-snippets'
" Plug 'othree/javascript-libraries-syntax.vim'
Plug 'Glench/Vim-Jinja2-Syntax'
" Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'
Plug 'harish2704/MatchTag'
" Plug 'leafgarland/typescript-vim'
Plug 'bogado/file-line'
" Plug 'vim-scripts/marvim'
Plug 'dohsimpson/vim-macroeditor'
Plug 'tikhomirov/vim-glsl'
Plug 'pangloss/vim-javascript' , { 'for': ['javascript', 'javascript.jsx', 'html', 'vue'] }
Plug 'posva/vim-vue'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'zenbro/mirror.vim'
" Plug 'kassio/neoterm'
call plug#end()

" Source support_function.vim to support vim-snippets.
if filereadable(expand( g:nvim_conf_root ."bundle/vim-snippets/snippets/support_functions.vim"))
  source g:nvim_conf_root . 'bundle/vim-snippets/snippets/support_functions.vim'
endif


let $FZF_DEFAULT_COMMAND='ag -g ""'


" Ctrl-p opens fuzzy file search
nmap <C-p> :Files<CR>

" Ctrl-b opens current buffers list
nmap <C-b> :Buffers<CR>

colorscheme molokai
" colorscheme OceanicNext
" colorscheme onedark

" Neovim specific settings

" Switch tabs using Alt-1..9
map ± 1gt
map ² 2gt
map ³ 3gt
map ´ 4gt
map µ 5gt
map ¶ 6gt
map · 7gt
map ¸ 8gt


" Ctrl-l -> Go to end of line
imap  <End>

" Replace grep with silver-searcher
" silver-searcher or 'ag' command is much faster than grep command. So use ag command instead of grep command for 'vimgrep'
set grepprg=ag\ --nogroup\ --nocolor
" set grepprg=grep\ -n\ $*\ /dev/null

" Ctrl-Enter on normal mode -> Jump to definition using Tern
" autocmd BufEnter *.js nmap <C-CR> :TernDefSplit<CR>

" Ctrl-/ on normal mode -> Grep word under cursor ( Recursive )
nmap  :Gr <C-R><C-W>
nmap <C-/> :Gr <C-R><C-W>


" Open the <X>version of current file using fugitive, where <X> is the string in clipboard.
" Eg: copy sha id of git commit to clip board. then press '\go' which open old
" version of current file in vsplit using fugitive
nmap <leader>go :Gvsplit <C-R>+:<C-R>%

" Open error list. By default, Syntax checking plugin ( syntastic ) will emit errors to vim's error list
nmap <leader>co :copen<CR>
nmap <leader>cc :cclose<CR>
nmap <leader>lo :lopen<CR>
nmap <leader>lc :lclose<CR>
" When opening any items in location list, Try current window, othertabs, then new tab
set switchbuf=useopen,usetab,newtab

" Ctrl-Shift-T -> Open new tab
nmap <C-S-T> :tabedit<CR>

" Ctrl-S to save file {{{
nmap <C-s> :w<CR>
vmap <C-s> <Esc><c-s>gv
imap <C-s> <Esc><c-s>
" }}}

" Alt-q Delete current buffer ( Close file )
nmap <M-q> :bd<CR>

" map <F8> :TagbarToggle<CR>
" nmap <F2> :wa<Bar>exe "mksession! " . v:this_session<CR>

" '\\es' or '<leader><leader>es' Open vimrc in a new tab
execute( 'nmap <Leader><Leader>es :tabedit '. g:nvim_conf_root .'init.vim <CR>' )

" '\\en' '<leader><leader>en' Open current file's snippets file in a new tab
nmap <Leader><Leader>en :execute 'OpenSnippets'<CR>


" for moving tab {{{
" Ctrl-Shift + Page-Up/Down to rearrange tab
nmap <C-S-PageUp> :execute 'tabmove ' . (tabpagenr()-2 )<CR>
nmap <C-S-PageDown> :execute 'tabmove ' . ( tabpagenr()+1 )<CR>
nmap <M-PageUp> :execute 'tabmove ' . (tabpagenr()-2 )<CR>
nmap <M-PageDown> :execute 'tabmove ' . ( tabpagenr()+1 )<CR>



" Ctrl-Shift + j/k to move current window in to nearby tab {{{
nmap <C-S-j> :execute 'Mt' . (tabpagenr() -1)  <CR>
nmap <C-S-k> :execute 'Mt' . (tabpagenr() +1)  <CR>
nmap <C-j> :execute 'Mt' . (tabpagenr() -1)  <CR>
nmap <C-k> :execute 'Mt' . (tabpagenr() +1)  <CR>
" }}}

 " \tr Reset shiftwidth to default value 2
nmap <Leader>tr :set tabstop=2 | set shiftwidth=2 | set softtabstop=2
 " \tt Toggle tab and spaces
nmap <Leader>tt :let &expandtab=!&expandtab<CR>
 " \tj Incraese additional two spaces width for tab
nmap <Leader>tj :let &shiftwidth=&shiftwidth-2\|let &tabstop=&tabstop-2\|let &softtabstop=&softtabstop-2\|echo 'tabstop=' &tabstop<CR>
 " \tj Decreases two spaces width for tab
nmap <Leader>tk :let &shiftwidth=&shiftwidth+2\|let &tabstop=&tabstop+2\|let &softtabstop=&softtabstop+2\|echo 'tabstop=' &tabstop<CR>
" }}}

" Session handling {{{
" List saved sessions
nmap <leader>sl :SessionList<CR>
" Save and close current session
nmap <leader>sc :SessionClose<CR>
" }}}

" Ctrl-Enter in insert mode will append ';' to the line and insert a new line 
imap <C-CR> <ESC>A;

" Ctrl-Enter in normal mode will jump to tag definition using cscope
" nmap <NL> :vert scs f g <C-R><C-W><CR>
" Ctrl-? in normal mode will jump to tag references using cscope
" nmap <C-?> :vert scs f t <C-R><C-W><CR>

" Alt + Arrows to Moving cursor to different windows {{{
nmap <M-Up> <C-W>k
nmap <M-Down> <C-W>j
nmap <M-Right> <C-W>l
nmap <M-Left> <C-W>h
" }}}

" For terminal mod {{{
tmap   <C-PageUp>   <C-\><C-n><C-PageUp>
tmap   <C-PageDown> <C-\><C-n><C-PageDown>
tmap   <M-Up>       <C-\><C-n><C-W>k
tmap   <M-Down>     <C-\><C-n><C-W>j
tmap   <M-Right>    <C-\><C-n><C-W>l
tmap   <M-Left>     <C-\><C-n><C-W>h
" }}}

" For Terminal mode Alt + [1-8] to Switch tabs {{{
tmap <M-1> <C-\><C-n>1gt
tmap <M-2> <C-\><C-n>2gt
tmap <M-3> <C-\><C-n>3gt
tmap <M-4> <C-\><C-n>4gt
tmap <M-5> <C-\><C-n>5gt
tmap <M-6> <C-\><C-n>6gt
tmap <M-7> <C-\><C-n>7gt
tmap <M-8> <C-\><C-n>8gt
" }}}

" For terminal mod {{{
tmap <M-c> <C-\><C-n><Esc>
tmap <M-c> <C-\><C-n><Esc>
" }}}

"for easy quote/unquote {{{
" \\ + a[add] / d[delete] + q[single quote] / Q [Double quote]
" \\dQ  remove double quote
nmap <Leader><Leader>dQ ds"
" \\dQ  add double quote
nmap <Leader><Leader>aQ ysiw"
" \\dQ  remove single quote
nmap <Leader><Leader>dq ds'
" \\dQ  remove double quote
nmap <Leader><Leader>aq ysiw'
" In insert mode, <Alt-S> will quote current word
imap <M-S-s> <Esc>maysiw"`aa
" In insert mode, <Alt-S> will quote current word with double quotes
imap <M-s> <Esc>maysiw'`ai
" }}}


" format JSON {{{
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
" }}}

" Alt + [1-8] to Switch tabs {{{
map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt
map <M-6> 6gt
map <M-7> 7gt
map <M-8> 8gt
" }}}


" NerdTree {{{
nmap <Leader>ac <Plug>ToggleAutoCloseMappings
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>
" }}}

" For Open a terminal in current directory
nmap <Leader><Leader>t :!gnome-terminal<CR>
" Open git-gui in current pwd
nmap <Leader><Leader>g :!git gui &<CR>

" <Alt-R> -> Reload current file
nmap <M-r> :e!<CR>

" <Ctrl-Shift-q> force Close buffer 
nmap <M-Q> :bd!<CR>

" Select a word and press Ctrl-h to replace all its occurance, even if the word is having special chars
vmap <C-h> "fy:%s#<C-r>f#
" Copy current word to 'f' register, search for that word
vmap <C-f> "fy/<C-r>f


set guicursor=n-c:block,i-ci-ve:ver40,r-cr-v:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
set termguicolors
hi Visual guibg=#603D3D

