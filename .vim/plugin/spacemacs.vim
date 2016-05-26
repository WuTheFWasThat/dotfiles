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

" files
nnoremap <Leader>fed :e ~/.vimrc<CR>
nnoremap <Leader>feR :source ~/.vimrc<CR>
nnoremap <Leader>fs :w<CR>
nnoremap <Leader>fS :wa<CR>
" yank history
nnoremap <Leader>fp :<C-u>Unite history/yank<cr>
" find all (meh)
" nnoremap <Leader>fa :<C-u>Unite buffer history/yank file file_rec/async file_mru<cr>
" find files
" nnoremap <Leader>ff :<C-u>Unite file file_rec/async file_mru<cr>
" recent files
" nnoremap <Leader>fr :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<cr>

"buffers
nnoremap <Leader>bb :CtrlPBuffer<CR>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bd :bd<CR>
nnoremap <Leader>bR :e<CR>

" save/quit
nnoremap <Leader>qq :qa<CR>
nnoremap <Leader>qQ :qa!<CR>
nnoremap <Leader>qs :xa<CR>

" clear search
nnoremap <Leader>sc :noh<CR>

" git
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>Td :GitGutterToggle<CR>

" TODO:
" port stuff from:
" https://raw.githubusercontent.com/jimmay5469/vim-spacemacs/master/plugin/spacemacs.vim
" https://github.com/sthysel/vim-spacemacs/blob/master/plugin/spacemacs.vim
