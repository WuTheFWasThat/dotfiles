" avy
" NOTE: double leader is mapped to easymotion-prefix for some reason (easymotion default?)

"toggle
" show/hide invisible chars
nnoremap <Leader>t\ :set list!<CR>
" paste mode
nnoremap <Leader>tp :set paste!<CR>
nnoremap <Leader>ti :IndentLinesToggle<CR>

" project
function! spacemacs#toggleExplorerAtRoot()
  if exists(':ProjectRootExe')
    exe "ProjectRootExe NERDTreeToggle"
  else
    exe "NERDTreeToggle"
  endif
endfunction
nnoremap <leader>pt :call spacemacs#toggleExplorerAtRoot()<CR>

" files
" yank history
nnoremap <Leader>fp :<C-u>Unite history/yank<cr>

" insert semicolon
nnoremap <Leader>i; mzA;<esc>`z

nnoremap <Leader>J :SplitjoinJoin<cr>
nnoremap <Leader>K :SplitjoinSplit<cr>

" git
nnoremap <Leader>ga :Git add --all<CR>
nnoremap <Leader>gp :Git push<CR>

nnoremap <Leader>b1 :b1<CR>
nnoremap <Leader>b2 :b2<CR>
nnoremap <Leader>b3 :b3<CR>
nnoremap <Leader>b4 :b4<CR>
nnoremap <Leader>b5 :b5<CR>
nnoremap <Leader>b6 :b6<CR>
nnoremap <Leader>b7 :b7<CR>
nnoremap <Leader>b8 :b8<CR>
nnoremap <Leader>b9 :b9<CR>
nnoremap <Leader>b0 :b10<CR>

" TODO: folding
