" This file is inspired by spf13's vimrc

" My settings {{{
filetype on                   " required!
filetype plugin indent on   " Automatically detect file types.

" set selection=exclusive       " Do not inlcude char under cursor while doing visual selection
set nu                          " Line numbers on
set expandtab                   " Tabs are spaces, not tabs
set shiftwidth=0                " Use indents of 4 spaces
set softtabstop=0               " Let backspace delete indent
set tabstop=2                   " An indentation every four columns
set path=.,
set autoindent                  " Indent at the same level of the previous line
set backspace=indent,eol,start  " Backspace for dummies
set clipboard=unnamedplus
set cursorline                  " Highlight current line
set foldlevel=99
set foldmethod=indent
set hidden                       " Allow buffer switching without saving
set history=1000                 " Store a ton of history (default is 20)
set hlsearch                    " Highlight search terms
set ignorecase                  " Case insensitive search
set linespace=0                 " No extra spaces between rows
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set mouse=a
set nocompatible               " be iMproved
set noincsearch
set noswapfile
set scrolljump=1                " Lines to scroll when cursor leaves screen
set scrolloff=0                 " Minimum lines to keep above and below cursor
set showmatch                   " Show matching brackets/parenthesis
set showmode                    " Display the current mode
set smartcase                   " Case sensitive when uc present
set spell                        " Spell checking on
set title
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set winminheight=0              " Windows can be 0 line high
set wrap
syntax on

let javaScript_fold=0         " JavaScript
let perl_fold=1               " Perl
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let $FZF_DEFAULT_COMMAND='ag -g ""'
let g:gruvbox_contrast_dark = 'dark'

au BufEnter *.js.ejs set ft=javascript.ejs
au BufEnter *.dart set ft=dart
au BufEnter *.sshconf set ft=sshconfig

" Disable python linting
autocmd VimEnter *.py SyntasticToggleMode



" Syntax based folding found be slow. In most of the cases, we will do indenting according to syntax.
autocmd FileType java set foldmethod=indent
autocmd FileType html set foldmethod=indent
autocmd FileType javascript set foldmethod=indent
autocmd FileType xml set foldmethod=indent

" % key will be mapped by MatchTag plugin to match HTML tags.
" It is not need on php file
" autocmd FileType php unmap %
" }}}

" for JavaScript {{{
" add '@' symbol as a valid char for js filename ( eg: '@mymodule/xyz' )
autocmd FileType javascript set isfname=@,48-57,/,.,-,_,+,,,#,$,%,~,=,@-@
autocmd FileType typescript set isfname=@,48-57,/,.,-,_,+,,,#,$,%,~,=,@-@
" if we press 'gf' under require('abc/xyz'), then also sarch for ./abs/xyz.js
function! LoadMainNodeModule(fname)
  return systemlist("node -p 'require.resolve(\"" . a:fname . "\")'")[0]
endfunction
autocmd FileType javascript set includeexpr=LoadMainNodeModule(v:fname)
autocmd FileType typescript set includeexpr=LoadMainNodeModule(v:fname)
autocmd FileType vue set includeexpr=LoadMainNodeModule(v:fname)
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

" Disable setting jsx syntax for *.js files
let g:jsx_pragma_required=1


" Session List {{{
set sessionoptions=blank,buffers,curdir,tabpages,winsize,resize,winpos
" }}}


" for JavaScript syntax checking {{{
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_javascript_checkers = ['eslint']
" }}}



" set lazyredraw
let g:sparkupNextMapping = '<M-K>'




" Ctrl-p will open fuzzy file search using fzf plugin. These are the shortcuts available in fzf window
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }


let nvim_conf_root = expand('<sfile>:p:h') . '/'

" Enable jsdoc comments Highlight for javascript 
let g:javascript_plugin_jsdoc = 1

let g:MacroManagerDir = g:nvim_conf_root . 'macros'

let g:tcomment_maps = 0
vmap <leader>c<space> :TComment<CR>
vmap <leader>cs :TCommentBlock<CR>
nmap <leader>c<space> :TComment<CR>
nmap <leader>cs :TCommentBlock<CR>

call plug#begin( )
" Bsic set of plugins {
Plug 'jamessan/vim-gnupg'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'rstacruz/sparkup'             " HTML zen-coding  helper
Plug 'tomtom/tcomment_vim'          " Code commenting uncommenting
Plug 'tpope/vim-surround'           " quickly Insert/remove/change quote/brackes any vim selection.
Plug 'harish2704/harish2704-vim'    " My utilities to move widows around tabs
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'             " Ctrl-p Quick file search
Plug 'wsdjeg/vim-fetch'
" }
"
" Extra utilities {
Plug 'Shougo/deoplete.nvim',         { 'do': ':UpdateRemotePlugins' } " Autocompletion
Plug 'vim-scripts/sessionman.vim'     " Session manager. Manage projects
Plug 'scrooloose/syntastic'           " Syntax checking pluin
Plug 'vim-scripts/DoxygenToolkit.vim' " Quickly create Doxygent style comments
Plug 'godlygeek/tabular'              " Tabularize Text
Plug 'tpope/vim-fugitive'             " For Git repo management.
Plug 'spf13/vim-autoclose'            " Autoclose brackets/quotes etc
Plug 'chrisbra/NrrwRgn'               " Edit a portion file as different buffer
Plug 'prettier/vim-prettier',        { 'do': 'yarn install',
\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
" }
"
" Langualge plugins{
Plug 'iamcco/markdown-preview.nvim',       { 'for': 'markdown', 'do': 'cd app & yarn install' }
Plug 'rust-lang/rust.vim',                 { 'for': 'rust'}
Plug 'pangloss/vim-javascript',          " { 'for': 'javascript'}
Plug 'mxw/vim-jsx' ,                       { 'for': [ 'jsx'] }
Plug 'leafOfTree/vim-vue-plugin' ,         { 'for': ['vue']}
Plug 'mhartington/nvim-typescript' ,       { 'for': [ 'javascript.ts'] }
Plug 'AndrewRadev/vim-eco',                { 'for': [ 'ect', 'eco' ] }
Plug 'Glench/Vim-Jinja2-Syntax',           { 'for': [ 'html', 'jinja', 'njk' ] }
Plug 'kchmck/vim-coffee-script',           { 'for': 'coffee' }
Plug 'digitaltoad/vim-jade',               { 'for': 'jade' }
Plug 'mustache/vim-mustache-handlebars',   { 'for': 'handlebars' }
Plug 'briancollins/vim-jst',               { 'for': 'jst' }
Plug 'evanleck/vim-svelte',                { 'for': 'svelte' }
Plug 'tikhomirov/vim-glsl',                { 'for': 'glsl' }
Plug 'ollykel/v-vim',                      { 'for': 'vlang' }
Plug 'editorconfig/editorconfig-vim'
Plug 'dart-lang/dart-vim-plugin',          { 'for': 'dart' }
Plug 'thosakwe/vim-flutter',               { 'for': 'dart' }
" }


" Other rarely used / untested plugins{
" Plug 'kshenoy/vim-signature'                           " Show markers in the margin
" Plug 'chrisbra/Colorizer'                              " A plugin to color colornames and codes
" Plug 'sjl/gundo.vim'                                   " Visualize undo tree
" Plug 'brooth/far.vim'                                  " Interactive Fine & replace on multiple files
" Plug 'Lokaltog/vim-easymotion'                         " Quick cursor movement to any where in the screen
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFind' }   " File tree
" Plug 'git://github.com/maxbrunsfeld/vim-yankstack.git' " Clipboard histroy management.
" Plug 'Yggdroot/indentLine'
" Plug 'majutsushi/tagbar'
" Plug 'Shougo/vimproc.vim'
" Plug 'vim-scripts/matchit.zip'
" Plug 'tomasr/molokai'                                  " A beautiful colorscheme
" Plug 'morhetz/gruvbox'
" Plug 'tyru/open-browser.vim'
" Plug 'Valloric/MatchTagAlways'
" Plug 'bogado/file-line'
" Plug 'dohsimpson/vim-macroeditor'                      " Edit macros in split window
" Plug 'low-ghost/vim-macro-manager'                     " Manage / save Macros
" Plug 'HerringtonDarkholme/yats.vim'                    " Typescript language plugin
" Plug 'Shougo/context_filetype.vim'
" }
call plug#end()


" enable deoplete at start up
let g:deoplete#enable_at_startup = 1

" Open edit snippets in vertial tab
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" Ctrl-p opens fuzzy file search
nmap <C-p> :Files<CR>

" Ctrl-b opens current buffers list
nmap <C-b> :Buffers<CR>

colorscheme molokai

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
nmap <Leader>tr :set tabstop=2
 " \tt Toggle tab and spaces
nmap <Leader>tt :let &expandtab=!&expandtab<CR>
 " \tj Incraese additional two spaces width for tab
nmap <Leader>tj :let &tabstop=&tabstop-2\|echo 'tabstop=' &tabstop<CR>
 " \tj Decreases two spaces width for tab
nmap <Leader>tk :let &tabstop=&tabstop+2\|echo 'tabstop=' &tabstop<CR>
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
nmap <Leader><Leader>t :!xdg-terminal&<CR>
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

" set guicursor=n-c:block,i-ci-ve:ver40,r-cr-v:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
set termguicolors

command! -register CopyMatches call CopyMatches(<q-reg>)

command! -register -range=% Unretab <line1>,<line2>call Unretab()
" My custom commands {{{

imap <M-;> <End>;<CR>
imap <M-,> <End>,<CR>
imap <M-CR> <End><CR>
" Grep for a word and open the result in errorlist
command! -nargs=+ Gr :silent execute 'grep! -nr "<args>" | copen'
" Raw version of Gr command. 
command! -nargs=* Grc grep -nr <args>

" Add file header to current buffer. Depends on https://github.com/harish2704/file-header
command! Header :execute '0r!file-header %'

" Open Terminal in split window
command! Termw :execute '!konsole -e bash-session &'
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

" Open vscode in on current line
command! Code :execute "!code ./ -g %:". ( line('.')+1 )
" }}}




function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction

function! Unretab() range
  execute a:firstline . "," . a:lastline . 's/ \{1,' . &tabstop . '}/\t/g'
endfunction
