" avy
" NOTE: double leader is mapped to easymotion-prefix for some reason (easymotion default?)

function! Get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

" map <Leader>rf :call VimuxRunCommand("python " . bufname("%"))<CR>
" map <Leader>rs :call VimuxRunCommand("")<CR>
" map <Leader>rf :call VimuxRunCommand(join(getline(1,'$'), "\n"))<CR>
" nmap <Leader>rr :call VimuxRunCommand(getline('.'))<CR>
" vmap <Leader>rr :call VimuxRunCommand(Get_visual_selection())<CR>
" map <Leader>rc :VimuxCloseRunner<CR>
map <Leader>rs  :VtrOpenRunner<CR>
map <Leader>rf  :VtrSendFile<CR>
map <Leader>rl :VtrSendLinesToRunner<CR>
map <Leader>rr  :VtrSendCommandToRunner<CR>
map <Leader>rR  :VtrReorientRunner<CR>
map <Leader>rx  :VtrKillRunner<CR>

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
