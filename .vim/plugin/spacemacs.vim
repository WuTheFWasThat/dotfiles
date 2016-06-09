" help

" avy
nmap <Leader>y <Plug>(easymotion-bd-jk)
" NOTE: double leader is mapped to easymotion-prefix for some reason (easymotion default?)

" undo tree
nnoremap <Leader>au :UndotreeToggle<CR>

"toggle
" show/hide invisible chars
nnoremap <Leader>ti :set list!<CR>
" toggle git gutter
nnoremap <Leader>tg :GitGutterToggle<CR>
" paste mode
nnoremap <Leader>tp :set paste!<CR>

" commenting

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

" commentary
nmap <Leader>;  <Plug>Commentary
vmap <Leader>;  <Plug>Commentary
omap <Leader>;  <Plug>Commentary
nmap <Leader>;; <Plug>CommentaryLine

" git
nnoremap <Leader>ga :Git add --all<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>Td :GitGutterToggle<CR>

" errors (syntastic integration)
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    SyntasticToggleMode
    " lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        " Errors
        SyntasticCheck
    endif
endfunction
nnoremap <silent> <Leader>el :<C-u>call ToggleErrors()<CR>
" nnoremap <silent> <Leader>el :SyntasticToggleMode<CR>
nnoremap <silent> <Leader>en :lnext<CR>
nnoremap <silent> <Leader>ep :lprev<CR>

" TODO: folding
