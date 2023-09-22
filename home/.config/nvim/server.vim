" Plane vimrmc file without any extra plugins. Useful for use in server env
" This file is inspired by spf13's vimrc

" My custom commands {{{

" Grep for a word
command! -nargs=1 Gr :execute 'grep -nr <f-args> ./ <CR>'

" Add file header to current buffer

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

set history=1000                 " Store a ton of history (default is 20)
set hidden                       " Allow buffer switching without saving
set noswapfile
set title
set path=.,
set foldlevel=99
set foldmethod=indent




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

" Press <F12> in insert mode to toggle paste mode
set pastetoggle=<F12>

" for JS {{{
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

let b:javascript_fold = 0

" }}}






" Ctrl-l -> Go to end of line
imap <C-L> <End>

" Replace grep with silver-searcher
" silver-searcher or 'ag' command is much faster than grep command. So use ag command instead of grep command for 'vimgrep'
" Uncomment below line if you have installed silversearcher ( ag command )
" "set grepprg=ag\ --nogroup\ --nocolor


" Ctrl-/ on normal mode -> Grep word under cursor ( Recursive )
" See https://stackoverflow.com/questions/9051837/how-to-map-c-to-toggle-comments-in-vim
nmap <C-_> :grep! -r <C-R><C-W>



" Open error list and location list
nmap <leader>co :copen<CR>
nmap <leader>cc :cclose<CR>
nmap <leader>lo :lopen<CR>
nmap <leader>lc :lclose<CR>


" Alt-q Delete current buffer ( Close file )
nmap <M-q> :bd<CR>

nmap <F2> :wa<Bar>exe "mksession! " . v:this_session<CR>



" for moving tab {{{
" Ctrl-Shift + Page-Up/Down to rearrange tab
nmap <M-PageUp> :execute 'tabmove ' . (tabpagenr()-2 )<CR>
nmap <M-PageDown> :execute 'tabmove ' . ( tabpagenr()+1 )<CR>



 " \tt Toggle tab and spaces
nmap <Leader>tt :let &expandtab=!&expandtab<CR>
 " \tj Incraese additional two spaces width for tab
nmap <Leader>tj :let &shiftwidth=&shiftwidth-2\|let &tabstop=&tabstop-2\|let &softtabstop=&softtabstop-2\|echo 'tabstop=' &tabstop<CR>
 " \tj Decreases two spaces width for tab
nmap <Leader>tk :let &shiftwidth=&shiftwidth+2\|let &tabstop=&tabstop+2\|let &softtabstop=&softtabstop+2\|echo 'tabstop=' &tabstop<CR>
" }}}


" Alt + Arrows to Moving cursor to different windows {{{
nmap <M-Up> <C-W>k
nmap <M-Down> <C-W>j
nmap <M-Right> <C-W>l
nmap <M-Left> <C-W>h
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


" <Alt-R> -> Reload current file
nmap <M-r> :e!<CR>

" <Ctrl-Shift-q> force Close buffer 
nmap <M-Q> :bd!<CR>

" Select a word and press Ctrl-h to replace all its occurance, even if the word is having special chars
vmap <C-h> "fy:%s#<C-r>f#
" Copy current word to 'f' register, search for that word
vmap <C-f> "fy/<C-r>f
colorscheme elflord
