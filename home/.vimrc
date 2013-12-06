" This file is inspired by spf13's vimrc


" keyboard {
    nmap <c-s> :w<CR>
    vmap <c-s> <Esc><c-s>gv
    imap <c-s> <Esc><c-s>
    map <F8> :TlistToggle<CR>
    nmap <F2> :wa<Bar>exe "mksession! " . v:this_session<CR>
    set mouse=a
    " cmap cwd lcd %:p:h
    " cmap cd. lcd %:p:h
    set timeout timeoutlen=1000 ttimeoutlen=100
:    " }

" My settings {
	filetype on                   " required!
	set clipboard=unnamedplus
	set history=1000                 " Store a ton of history (default is 20)
	set spell                        " Spell checking on
	set hidden                       " Allow buffer switching without saving
	set directory=~/.vim/swap/
    filetype plugin indent on   " Automatically detect file types.
    let NERDSpaceDelims=1
    set listchars=tab:»\ ,eol:¶,trail:·,precedes:…,extends:…
    " let g:xml_syntax_folding=1
    au FileType xml setlocal foldmethod=syntax
    set path=.,
    let javaScript_fold=1         " JavaScript
    let perl_fold=1               " Perl
    " let php_folding=1             " PHP
    let r_syntax_folding=1        " R
    let ruby_fold=1               " Ruby
    let sh_fold_enabled=1         " sh
    let vimsyn_folding='af'       " Vim script
    let xml_syntax_folding=1      " XML
    autocmd FileType java set foldmethod=syntax
    nmap <Leader><Leader>es :tabedit ~/.vimrc <CR>
    " Open current file's snippets file
    nmap <Leader><Leader>en :execute 'tabedit ~/.vim/bundle/vim-snippets/snippets/' . &filetype . '.snippets' <CR>
" }



" for formating {
    " set nowrap                      " Wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    nmap <Leader>tt :let &expandtab=!&expandtab<CR>
    nmap <Leader>tj :let &shiftwidth=&shiftwidth-2\|let &tabstop=&tabstop-2\|let &softtabstop=&softtabstop-2\|echo 'tabstop=' &tabstop<CR>
    nmap <Leader>tk :let &shiftwidth=&shiftwidth+2\|let &tabstop=&tabstop+2\|let &softtabstop=&softtabstop+2\|echo 'tabstop=' &tabstop<CR>
" }

" for java {
    autocmd BufRead *.java set include=^#\s*import
    autocmd BufRead *.java set includeexpr=substitute(v:fname,'\\.','/','g')
    autocmd BufRead *.java set suffixesadd=.java,.xml
    " }


" for UI {

    set showmode                    " Display the current mode
	if has('statusline')
        set laststatus=2
        " Broken down into easily includeable segments
        set statusline=%w%h%m%r                 " Options
        " set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=%<%f\                     " Filename
        " set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set hlsearch                    " Highlight search terms
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
                \ 'dir':  '\v[\/](\.git|\.hg|\.svn|\.ve|node_modules)$',
                \ 'file': '\v\.(o|pyc|class)$',
                \ 'link': '',
                \ }
"}"


"for Bundle {
	set nocompatible               " be iMproved
	set rtp+=~/.vim/bundle/vundle/
	call vundle#rc()
	" let Vundle manage Vundle
	" required! 
	Bundle 'gmarik/vundle'
	" My Bundles here:
	"
	" original repos on github
	Bundle 'tpope/vim-fugitive'
	Bundle 'Lokaltog/vim-easymotion'
	Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
	" vim-scripts repos
	Bundle 'L9'
	Bundle 'FuzzyFinder'
	" non github repos
	Bundle 'git://git.wincent.com/command-t.git'
	" Bundle 'git://github.com/vim-scripts/YankRing.vim.git'
	Bundle 'git://github.com/maxbrunsfeld/vim-yankstack.git' 
	" Bundle 'vim-scripts/Auto-Pairs' 
	Bundle 'vim-scripts/DoxygenToolkit.vim' 
	" Bundle 'Raimondi/delimitMate.git' 
	Bundle 'bkad/CamelCaseMotion' 
    " Bundle 'vim-scripts/boxdraw'


    " Bundle "vim-scripts/Vim-JDE"
    " Bundle 'maksimr/vim-jsbeautify'
    " Bundle "scrooloose/syntastic"
	" Bundle "pangloss/vim-javascript"
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'garbas/vim-snipmate'
    " Bundle 'amiorin/vim-project'
    Bundle 'MarcWeber/vim-addon-mw-utils'
    Bundle 'tomtom/tlib_vim'
    Bundle 'nathanaelkane/vim-indent-guides'
    Bundle 'flazz/vim-colorschemes'
    Bundle 'vim-scripts/sessionman.vim'
    Bundle 'kien/ctrlp.vim'
    Bundle 'leshill/vim-json'
    Bundle 'godlygeek/tabular'
    Bundle 'majutsushi/tagbar'
    Bundle 'amirh/HTML-AutoCloseTag'
    Bundle 'tpope/vim-surround'
    Bundle 'vim-scripts/AutoComplPop'
    " Bundle 'Shougo/eocomplcache'
    Bundle 'spf13/vim-autoclose'
    Bundle 'scrooloose/nerdtree'
    Bundle 'harish2704/harish2704-vim'
    " Bundle 'Shougo/neocomplcache'
    Bundle 'digitaltoad/vim-jade'
    Bundle 'mustache/vim-mode'



    "Bundle 'git://github.com/vim-scripts/autoload_cscope.vim.git'
    Bundle 'honza/vim-snippets'
    " Bundle 'int3/vim-taglist-plus'
    Bundle 'vim-scripts/EasyGrep'
    Bundle 'briancollins/vim-jst'
    Bundle 'vim-scripts/matchit.zip'
    Bundle 'vim-scripts/adt.vim'
    " Bundle 'tpope/eclim'
    " Source support_function.vim to support vim-snippets.
    if filereadable(expand("~/.vim/bundle/vim-snippets/snippets/support_functions.vim"))
        source ~/.vim/bundle/vim-snippets/snippets/support_functions.vim
    endif

" }

" for JS {
	let g:html_indent_inctags = "html,body,head,tbody"
	let g:html_indent_script1 = "inc"
	let g:html_indent_style1 = "inc"
" }


" AutoCloseTag {
    " Make it so AutoCloseTag works for xml and xhtml files as well
    au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
    nmap <Leader>ac <Plug>ToggleAutoCloseMappings
" }
" NerdTree {
    map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
" }

" Tabularize {
    nmap <Leader>a& :Tabularize /&<CR>
    vmap <Leader>a& :Tabularize /&<CR>
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\zs<CR>
    vmap <Leader>a:: :Tabularize /:\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a// :Tabularize /\/\/<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
" }

" Session List {
    set sessionoptions=blank,buffers,curdir,tabpages,winsize,resize,winpos
    " nmap <leader><leader>c  :JavaCorrect<cr>
    " nmap <leader>pt :ProjectsTree<CR>
    nmap <leader>sl :SessionList<CR>
    nmap <leader>sc :SessionClose<CR>
" }

" JSON {
    nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
" }

"for easy quote/unquote {
    nmap <Leader><Leader>dQ ds"
    nmap <Leader><Leader>aQ ysiw"
    nmap <Leader><Leader>dq ds'
    nmap <Leader><Leader>aq ysiw'
" }

" for moving tab {
    nmap <C-S-PageDown> :execute 'tabmove ' . (tabpagenr()-2 )<CR>
    nmap <C-S-PageUp> :execute 'tabmove ' . tabpagenr()<CR>
" }

" gides {
    " let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
" }
" colorscheme  colorful256
" colorscheme mrkn256
set wrap
colorscheme desert256
" set foldmethod=syntax
" let javascriptfold=1
