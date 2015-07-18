" set incsearch                   " Find as you type search
colorscheme distinguished
set guioptions-=T
set guioptions-=m
set guioptions-=R
set guioptions-=L

" set guifont=Monaco\ for\ Powerline\ 12
set guifont=Ubuntu\ Mono\ 14
" set guifont=Monospace\ 10
" set guifont=Ubuntu\ Mono\ 14
" set guifont=Monaco\ 10
" set guifont=Monaco\ 12

set guitablabel=%N\ %f

" Alt + arrows to Move cursor to windows{
nmap <A-Up> <C-W>k
nmap <A-Down> <C-W>j
nmap <A-Right> <C-W>l
nmap <A-Left> <C-W>h

imap <A-Up> <ESC><C-W>ki
imap <A-Down> <ESC><C-W>ji
imap <A-Right> <ESC><C-W>li
imap <A-Left> <ESC><C-W>hi
" }

" Switch tabs in normal mode{
map ± 1gt
map ² 2gt
map ³ 3gt
map ´ 4gt
map µ 5gt
map ¶ 6gt
map · 7gt
map ¸ 8gt
" }


" Switch tabs in insert mode{
imap ± <ESC>1gti
imap ² <ESC>2gti
imap ³ <ESC>3gti
imap ´ <ESC>4gti
imap µ <ESC>5gti
imap ¶ <ESC>6gti
imap · <ESC>7gti
imap ¸ <ESC>8gti
" }


" Ctrl-Enter in insert mode will append ';' to the line and insert a new line 
imap <C-CR> <ESC>A;

" Ctrl-Enter in normal mode will jump to tag definition using cscope
nmap <C-CR> :vert scs f g <C-R><C-W><CR>
nmap ñ :bd<CR>

