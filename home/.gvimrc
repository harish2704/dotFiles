" set guifont=Monospace\ 10
" set guifont=Monaco\ 10
" set incsearch                   " Find as you type search
set cursorline                  " Highlight current line
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
colorscheme jellybeans
set guioptions-=T
set guioptions-=m
" set guifont=Ubuntu\ Mono\ 12
set guifont=Monaco\ for\ Powerline\ 12
nmap <A-Up> <C-W>k
nmap <A-Down> <C-W>j
nmap <A-Right> <C-W>l
nmap <A-Left> <C-W>h

imap <A-Up> <ESC><C-W>ki
imap <A-Down> <ESC><C-W>ji
imap <A-Right> <ESC><C-W>li
imap <A-Left> <ESC><C-W>hi

map ± 1gt
map ² 2gt
map ³ 3gt
map ´ 4gt
map µ 5gt
map ¶ 6gt
map · 7gt
map ¸ 8gt


imap ± <ESC>1gti
imap ² <ESC>2gti
imap ³ <ESC>3gti
imap ´ <ESC>4gti
imap µ <ESC>5gti
imap ¶ <ESC>6gti
imap · <ESC>7gti
imap ¸ <ESC>8gti


set guitablabel=%N\ %f
