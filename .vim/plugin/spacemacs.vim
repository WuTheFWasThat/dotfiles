" avy
" NOTE: double leader is mapped to easymotion-prefix for some reason (easymotion default?)

"toggle
" show/hide invisible chars
nnoremap <Leader>ti :set list!<CR>
" paste mode
nnoremap <Leader>tp :set paste!<CR>

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
" find all (meh)
" nnoremap <Leader>fa :<C-u>Unite buffer history/yank file file_rec/async file_mru<cr>
" find files
" nnoremap <Leader>ff :<C-u>Unite file file_rec/async file_mru<cr>
" recent files
" nnoremap <Leader>fr :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<cr>

" insert semicolon
nnoremap <Leader>i; mzA;<esc>`z

" git
nnoremap <Leader>ga :Git add --all<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gc :Gcommit<CR>

" TODO: folding
