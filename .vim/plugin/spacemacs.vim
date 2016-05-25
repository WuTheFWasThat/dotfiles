" avy
map <Leader>y <Plug>(easymotion-bd-jk)

" toggle
nnoremap <Leader>tn :set<Space>invnumber<CR>

" windows
nnoremap <Leader>ws :split<CR>
nnoremap <Leader>wv :vsplit<CR>
nnoremap <Leader>wc :q<CR>
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wl <C-W>l
nnoremap <Leader>ww <C-W>w
nnoremap <Leader>wm <C-W>o

" reindent
nnoremap <Leader>j= mzgg=G`z

" save/quit
nnoremap <Leader>fs :w<CR>
nnoremap <Leader>fS :wa<CR>
nnoremap <Leader>qq :qa<CR>
nnoremap <Leader>qQ :qa!<CR>
nnoremap <Leader>qs :xa<CR>

" clear search
nnoremap <Leader>sc :noh<CR>

" TODO:
" port stuff from:
" https://raw.githubusercontent.com/jimmay5469/vim-spacemacs/master/plugin/spacemacs.vim
" https://github.com/sthysel/vim-spacemacs/blob/master/plugin/spacemacs.vim
