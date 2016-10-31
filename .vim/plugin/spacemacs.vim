" avy
" NOTE: double leader is mapped to easymotion-prefix for some reason (easymotion default?)
function! s:spacevim_bind(map, binding, name, value, isCmd)
  if a:isCmd
    let l:value = ':' . a:value . '<cr>'
  else
    let l:value = a:value
  endif
  if a:map == "map"
    let l:noremap = 'noremap'
  elseif a:map == "nmap"
    let l:noremap = 'nnoremap'
  elseif a:map == "vmap"
    let l:noremap = 'vnoremap'
  endif
  execute l:noremap . " <silent> <SID>" . a:name . " " . l:value
  execute a:map . " <leader>" . a:binding . " <SID>" . a:name
endfunction

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
call s:spacevim_bind('map', 'rs', 'runner-open', 'VtrOpenRunner', 1)
call s:spacevim_bind('map', 'rf', 'runner-run-file', 'VtrSendFile!', 1)
call s:spacevim_bind('map', 'rl', 'runner-run-lines', 'VtrSendLinesToRunner!', 1)
call s:spacevim_bind('map', 'rr', 'runner-rerun', 'VtrSendCommandToRunner!', 1)
call s:spacevim_bind('map', 'rc', 'runner-run-custom', ':VtrSendCommandToRunner! ', 0)
" call s:spacevim_bind('map', 'rR', 'runner-reorient', ':VtrReorientRunner ', 1)
call s:spacevim_bind('map', 'rx', 'runner-kill', ':VtrKillRunner ', 1)

call s:spacevim_bind('map', 'fx', 'file-save-quit', ':w<CR>:bd', 1)

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
" nnoremap <Leader>fp :<C-u>Unite history/yank<cr>
nnoremap <Leader>fd :filetype detect<cr>

" insert semicolon
nnoremap <Leader>i; mzA;<esc>`z
" insert comma
nnoremap <Leader>i, mzA,<esc>`z
" insert other punctuation
nnoremap <Leader>i. mzA.<esc>`z
nnoremap <Leader>i? mzA?<esc>`z
nnoremap <Leader>i! mzA!<esc>`z

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

" nnoremap <Leader>bs :Scratch<CR>

" TODO: folding
