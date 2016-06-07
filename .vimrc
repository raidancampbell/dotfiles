" turn vim into nano

" somewhere between OSX, iTerm, tmux, and zsh, these bindings got screwy
imap <Esc>f <A-Right>
imap <Esc>b <A-Left>

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

imap <A-Left> <Esc>Bi
imap <A-Right> <Esc>EEi  " esc kicks back one column, so we need to counteract this

"	figure out how to enable cursor line wrapping

set whichwrap+=[,]

"	bind ctrl-v to pagedown, and ctrl-y to pageup

"	figure out howto specify a filename

"	remove literally every other feature

"	start in insert mode

:startinsert
