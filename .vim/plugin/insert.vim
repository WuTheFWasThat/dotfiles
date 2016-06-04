"""""""""""
" movement
"""""""""""

inoremap <C-c> <esc>
iunmap <esc>

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
" macros
"""""""""""

autocmd FileType python inoremap <buffer> jkf        def ():<cr><esc>k$bi
autocmd FileType javascript inoremap <buffer> jkf    function() {<cr>}<esc>k$F(a
autocmd FileType coffee inoremap <buffer> jkf    () -><cr><esc>k$F(a

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
