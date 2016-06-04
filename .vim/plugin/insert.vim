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
" language-specific macros
"""""""""""

" autocmd FileType python     :inoremap <buffer> jkf    def ():<cr><tab><esc>k$F(i
autocmd FileType javascript :inoremap <buffer> jkf    function() {<cr><tab><cr><backspace>}<esc>kk$F(a
" autocmd FileType coffee     :inoremap <buffer> jkf    () -><cr><tab><esc>k$F(a

" autocmd FileType python     :inoremap <buffer> jki if :<cr><tab><esc>k$i
autocmd FileType javascript :inoremap <buffer> jki if () {<cr><tab><cr><backspace>} <esc>kk$F(a

" autocmd FileType python     :inoremap <buffer> jkl elif :<cr><tab><esc>k$i
autocmd FileType javascript :inoremap <buffer> jkl else if () {<cr><tab><cr><backspace>} <esc>kk$F(a

" autocmd FileType python     :inoremap <buffer> jke else:<cr><tab>
autocmd FileType javascript :inoremap <buffer> jke else {<cr><tab><cr><backspace>}<esc>kA

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
