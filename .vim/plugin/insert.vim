"""""""""""
" movement
"""""""""""
" TODO: enable these when spacemacs mappings are done (also, figure out esc
"       for visual block insert and stuff
" inoremap <esc> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>

inoremap <C-h>    <left>
inoremap <C-j>    <down>
inoremap <C-k>    <up>
inoremap <C-l>    <right>

inoremap <C-a>    <esc>I
inoremap <C-e>    <esc>A
inoremap <C-f>    <esc>lei
" inoremap <C-w>    <esc>lwi
inoremap <C-b>    <esc>bi
" this doesn't work
" imap <Alt-f>    <esc>wi
" imap <Alt-b>    <esc>bi

inoremap <C-u>    <esc><C-U>i
inoremap <C-d>    <esc><C-D>i

"""""""""""
" abbreviations
"""""""""""

" iabbrev @@    wuthefwasthat@gmail.com
" iabbrev sig   <cr>Jeff Wu<cr>wuthefwasthat@gmail.com

" autocorrect
iabbrev tehn then
iabbrev taht that
iabbrev teh the
iabbrev nad and
iabbrev adn and
