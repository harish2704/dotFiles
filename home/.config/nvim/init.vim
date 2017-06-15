" This file is inspired by spf13's vimrc

" set t_Co=256

set mouse=a

" Cd to current file's directory
command! Header :execute '0r!file-header %'
command! Term :execute 'sp | term'
command! Cwd :execute 'cd %:p:h'
command! Reload :execute "bufdo execute 'checktime . bufnr('%')'"

" set timeout timeoutlen=1000 ttimeoutlen=100

" My settings {
filetype on                   " required!
set clipboard=unnamedplus
set history=1000                 " Store a ton of history (default is 20)
set spell                        " Spell checking on
set hidden                       " Allow buffer switching without saving
" No need to specify swap directory as it is the default
filetype plugin indent on   " Automatically detect file types.
let NERDSpaceDelims=1
set listchars=tab:»\ ,eol:¶,trail:·,precedes:…,extends:…
set noswapfile
set title

set path=.,
set foldlevel=99

let javaScript_fold=0         " JavaScript
let perl_fold=1               " Perl
" let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
" let xml_syntax_folding=1      " XML

set foldmethod=indent
autocmd FileType java set foldmethod=indent
autocmd FileType html set foldmethod=indent
autocmd FileType javascript set foldmethod=indent
autocmd FileType xml set foldmethod=indent
" }


" for formating {
" set nowrap                      " Wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=2                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=2                   " An indentation every four columns
set softtabstop=2               " Let backspace delete indent

" for java {
autocmd BufRead *.java set include=^#\s*import
autocmd BufRead *.java set includeexpr=substitute(v:fname,'\\.','/','g')
autocmd BufRead *.java set suffixesadd=.java,.xml
autocmd BufRead *.ect set suffixesadd=.ect ft=html.ect
autocmd BufRead *.njk set ft=jinja
autocmd BufEnter *.gradle set ft=groovy
" }


" for UI {

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
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set list
" }

"for Ctrl-P{

let g:ctrlp_user_command = {}
let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 1
" custom file/folder ignores
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.git|\.hg|\.svn|\.ve|node_modules|bower_components)$',
      \ 'file': '\v\.(o|pyc|class)$',
      \ 'link': '',
      \ }
"}"


" for JS {
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

let b:javascript_fold = 0
" let g:tern_set_omni_function = 0

" }


" For JSX {
  " let g:jsx_ext_required = 0
"}


" AutoCloseTag {
" Make it so AutoCloseTag works for xml and xhtml files as well
au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
" }

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
" }

:let g:NERDCustomDelimiters = {
\ 'jinja': { 'left': '{# ', 'right': ' #}', 'leftAlt': '{# ', 'rightAlt': ' #}' }
\ }

" Session List {
set sessionoptions=blank,buffers,curdir,tabpages,winsize,resize,winpos
" nmap <leader><leader>c  :JavaCorrect<cr>
" nmap <leader>pt :ProjectsTree<CR>
" }


" for JavaScript syntax checking {
" let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_javascript_checkers = ['jshint']
" }


" gides {
" let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
" }
set wrap
" dont set cursorline for performance imporoovements
set cursorline                  " Highlight current line
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace


" for Gtags {
let g:Gtags_Auto_Map = 1
let g:Gtags_VerticalWindow = 1
let g:Gtags_Auto_Update = 1
let g:GtagsCscope_Auto_Load = 1
" }


" set lazyredraw
let g:sparkupNextMapping = '<M-K>'


" for taggatron.
" let g:tagcommands = {
"       \    "php" : {
"       \        "tagfile" : ".php.tags",
"       \        "args" : "-R --langmap=PHP:+.mod"
"       \    }
"       \}


"for Plug {
set nocompatible               " be iMproved
"
" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }


let nvim_conf_root='~/.config/nvim/'
call plug#begin( )
" My Plugs here:
"
" original repos on github
Plug 'tpope/vim-fugitive'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'Lokaltog/vim-distinguished'
" Plug 'junegunn/seoul256.vim'
" Plug 'whatyouhide/vim-gotham'
Plug 'rstacruz/sparkup'
" Plug 'L9'
" Plug 'FuzzyFinder'
" Plug 'git://git.wincent.com/command-t.git'
" Plug 'git://github.com/vim-scripts/YankRing.vim.git'
Plug 'git://github.com/maxbrunsfeld/vim-yankstack.git' 
" Plug 'vim-scripts/Auto-Pairs' 
Plug 'vim-scripts/DoxygenToolkit.vim' 
" Plug 'Raimondi/delimitMate.git' 
" Plug 'bkad/CamelCaseMotion' 
" Plug 'vim-scripts/boxdraw'
" Plug 'vim-scripts/Vim-JDE'
" Plug 'maksimr/vim-jsbeautify'
Plug 'scrooloose/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Plug 'othree/yajs.vim'
" Plug 'harish2704/tern_for_vim' , { 'for': 'javascript' }
Plug 'scrooloose/nerdcommenter'
Plug 'garbas/vim-snipmate'
" Plug 'amiorin/vim-project'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'flazz/vim-colorschemes'
Plug 'vim-scripts/sessionman.vim'
" Plug 'kien/ctrlp.vim'
" Plug 'leshill/vim-json'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
" Plug 'amirh/HTML-AutoCloseTag'
Plug 'tpope/vim-surround'
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" Plug 'vim-scripts/AutoComplPop'
" Plug 'Shougo/neocomplcache'
" Plug 'Valloric/YouCompleteMe'
" Plug 'Shougo/eocomplcache'
Plug 'spf13/vim-autoclose'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFind' }
Plug 'harish2704/harish2704-vim'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
Plug 'AndrewRadev/vim-eco', { 'for': [ 'ect', 'eco' ] }
" Plug 'mustache/vim-mode'
Plug 'mustache/vim-mustache-handlebars', { 'for': 'handlebars' }
Plug 'chrisbra/NrrwRgn'
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
Plug 'harish2704/gtags.vim'
" Plug 'vim-scripts/guicolorscheme.vim'
" Plug 'vim-scripts/CSApprox'
" Plug 'vim-scripts/adt.vim'
" Plug 'tpope/eclim'
Plug 'tomasr/molokai'
Plug 'joonty/vdebug'
Plug 'junegunn/fzf', { 'dir': '/opt/fzf' }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/SyntaxComplete'
Plug 'justinj/vim-react-snippets'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'
Plug 'harish2704/MatchTag'
Plug 'leafgarland/typescript-vim'
Plug 'zenbro/mirror.vim'
Plug 'kassio/neoterm'
call plug#end()

" Source support_function.vim to support vim-snippets.
if filereadable(expand( g:nvim_conf_root ."bundle/vim-snippets/snippets/support_functions.vim"))
  source g:nvim_conf_root . 'bundle/vim-snippets/snippets/support_functions.vim'
endif

" }
let $FZF_DEFAULT_COMMAND='ag -g ""'
nmap <C-p> :Files<CR>
nmap <C-b> :Buffers<CR>

" Neovim specific settings
syntax on 
" if has('neovim')
" let s:python_host_init = 'python -c "import neovim; neovim.start_host()"'
" let &initpython = s:python_host_init
" let &initclipboard = s:python_host_init
" set unnamedclip " Automatically use clipboard as storage for the unnamed register
" endif"

" colorscheme  colorful256
" colorscheme mrkn256
" colorscheme desert256
" colorscheme 256-grayvim
" colorscheme  jellybeans
" colorscheme devbox-dark-256
" colorscheme lodestone
" colorscheme distinguished
colorscheme molokai
" set foldmethod=syntax
" let javascriptfold=1
" let g:indent_guides_auto_colors = 0
" hi IndentGuidesEven  ctermbg=235
" hi IndentGuidesOdd  ctermbg=240
" hi StatusLine ctermbg=202
" hi StatusLineNC ctermbg=246 ctermfg=0
" autocmd ColorScheme * hi IndentGuidesEven  ctermbg=235 | hi IndentGuidesOdd  ctermbg=240
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
" hi SpellBad ctermbg=9 ctermfg=20


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
set grepprg=ag\ --nogroup\ --nocolor
" set grepprg=grep\ -n\ $*\ /dev/null

" Ctrl-Enter on normal mode -> Jump to definition using Tern
" autocmd BufEnter *.js nmap <C-CR> :TernDefSplit<CR>

" Ctrl-/ on normal mode -> Grep word under cursor ( Recursive )
nmap  :grep! -r <C-R><C-W>
nmap <C-/> :grep! -r <C-R><C-W>


" Open the <X>version of current file using fugitive, where <X> is the string in clipboard.
nmap <leader>go :Gvsplit <C-R>+:<C-R>%

nmap <leader>co :copen<CR>
nmap <leader>cc :cclose<CR>
nmap <leader>lo :lopen<CR>
nmap <leader>lc :lclose<CR>

" Ctrl-Shift-T -> Open new tab
nmap <C-S-T> :tabedit<CR>

" Ctrl-S to save file {
nmap <C-s> :w<CR>
vmap <C-s> <Esc><c-s>gv
imap <C-s> <Esc><c-s>
" }

" Alt-q Delete current buffer ( Close file )
nmap <M-q> :bd<CR>
" map <F8> :TagbarToggle<CR>
nmap <F2> :wa<Bar>exe "mksession! " . v:this_session<CR>
" \\es Open vimrc in a new tab
execute( 'nmap <Leader><Leader>es :tabedit '. g:nvim_conf_root .'init.vim <CR>' )
" \\en Open current file's snippets file in a new tab
nmap <Leader><Leader>en :execute 'OpenSnippets'<CR>


" for moving tab {
" Ctrl-Shift + Page-Up/Down to rearrange tab {
nmap <C-S-PageUp> :execute 'tabmove ' . (tabpagenr()-2 )<CR>
nmap <C-S-PageDown> :execute 'tabmove ' . ( tabpagenr()+1 )<CR>
nmap <M-PageUp> :execute 'tabmove ' . (tabpagenr()-2 )<CR>
nmap <M-PageDown> :execute 'tabmove ' . ( tabpagenr()+1 )<CR>
" }


" Ctrl-Shift + j/k to move current window in to another tab{
nmap <C-S-j> :execute 'Mt' . (tabpagenr() -1)  <CR>
nmap <C-S-k> :execute 'Mt' . (tabpagenr() +1)  <CR>
nmap <C-j> :execute 'Mt' . (tabpagenr() -1)  <CR>
nmap <C-k> :execute 'Mt' . (tabpagenr() +1)  <CR>
" }

 " \tt Toggle tab and spaces
nmap <Leader>tt :let &expandtab=!&expandtab<CR>
 " \tj Incraese additional two spaces width for tab
nmap <Leader>tj :let &shiftwidth=&shiftwidth-2\|let &tabstop=&tabstop-2\|let &softtabstop=&softtabstop-2\|echo 'tabstop=' &tabstop<CR>
 " \tj Decreases two spaces width for tab
nmap <Leader>tk :let &shiftwidth=&shiftwidth+2\|let &tabstop=&tabstop+2\|let &softtabstop=&softtabstop+2\|echo 'tabstop=' &tabstop<CR>
" }

" Session handling {
" List saved sessions
nmap <leader>sl :SessionList<CR>
" Save and close current session
nmap <leader>sc :SessionClose<CR>
" }

" Ctrl-Enter in insert mode will append ';' to the line and insert a new line 
imap <C-CR> <ESC>A;

" Ctrl-Enter in normal mode will jump to tag definition using cscope
" nmap <NL> :vert scs f g <C-R><C-W><CR>
" Ctrl-? in normal mode will jump to tag references using cscope
" nmap <C-?> :vert scs f t <C-R><C-W><CR>

" Alt + Arrows to Moving cursor to different windows {
nmap <M-Up> <C-W>k
nmap <M-Down> <C-W>j
nmap <M-Right> <C-W>l
nmap <M-Left> <C-W>h
" }

" For terminal mode{
tmap   <M-Up>     <C-\><C-n><C-W>k
tmap   <M-Down>   <C-\><C-n><C-W>j
tmap   <M-Right>  <C-\><C-n><C-W>l
tmap   <M-Left>   <C-\><C-n><C-W>h
" }

"for easy quote/unquote {
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
" }


" format JSON {
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
" }

" Alt + [1-8] to Switch tabs {
map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt
map <M-6> 6gt
map <M-7> 7gt
map <M-8> 8gt
" }

" For Terminal mode Alt + [1-8] to Switch tabs {
tmap <M-1> <C-\><C-n>1gt
tmap <M-2> <C-\><C-n>2gt
tmap <M-3> <C-\><C-n>3gt
tmap <M-4> <C-\><C-n>4gt
tmap <M-5> <C-\><C-n>5gt
tmap <M-6> <C-\><C-n>6gt
tmap <M-7> <C-\><C-n>7gt
tmap <M-8> <C-\><C-n>8gt
" }

" NerdTree {
nmap <Leader>ac <Plug>ToggleAutoCloseMappings
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>
" }


" Tabularize {
" nmap <Leader>a& :Tabularize /&<CR>
" vmap <Leader>a& :Tabularize /&<CR>
" nmap <Leader>a= :Tabularize /=<CR>
" vmap <Leader>a= :Tabularize /=<CR>
" nmap <Leader>a: :Tabularize /:<CR>
" vmap <Leader>a: :Tabularize /:<CR>
" nmap <Leader>a:: :Tabularize /:\zs<CR>
" vmap <Leader>a:: :Tabularize /:\zs<CR>
" nmap <Leader>a, :Tabularize /,<CR>
" vmap <Leader>a, :Tabularize /,<CR>
" vmap <Leader>a// :Tabularize /\/\/<CR>
" nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
" vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
" }


" For terminal mode{
tmap <M-c> <C-\><C-n><Esc>
" }
" For NeoTerm plugin{
nmap <Leader><Leader>o :Topen<CR>
nmap <Leader><Leader>c :Tclose<CR>
" }
" For Open a terminal in current directory{
nmap <Leader><Leader>t :!gnome-terminal<CR>
nmap <Leader><Leader>g :!git gui &<CR>
" }

" <Alt-R> -> Reload current file
nmap <M-r> :e!<CR>

" <Ctrl-Shift-q> force Close buffer 
nmap <M-Q> :bd!<CR>
vmap <C-h> "fy:%s#<C-r>f#

