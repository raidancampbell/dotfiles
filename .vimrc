" turn vim into nano

" start in insert mode
:startinsert

map <C-O> <Esc>:w<CR>
imap <C-O> <Esc>:w<CR>
map <C-X> <Esc>:q<CR>
imap <C-X> <Esc>:q<CR>
map <C-X><C-X> <Esc>:q!<CR>
imap <C-X><C-X> <Esc>:q!<CR>
map <C-K> <Esc>dd
imap <C-K> <Esc>dd<Esc>i
map <C-U> <Esc>p
imap <C-U> <Esc>p<Esc>i

" TODO:
"	bind word-skips to M-Left and M-Right
"	figure out how to enable cursor line wrapping
"	bind ctrl-v to pagedown, and ctrl-y to pageup
"	figure out how to specify a filename
"	remove literally every other feature
