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

call s:spacevim_bind('map', 'fx', 'file-save-quit', ':w<CR>:bd', 1)

"toggle
call s:spacevim_bind('map', 't\', 'toggle-invisible-chars', 'set list!', 1)
call s:spacevim_bind('map', 'tp', 'toggle-paste', 'set paste!', 1)
call s:spacevim_bind('map', 'ti', 'toggle-indent-lines', 'IndentLinesToggle', 1)
call s:spacevim_bind('map', 'tn', 'toggle-line-numbers', ':setlocal invnumber<CR>:setlocal invrelativenumber<CR>', 0)
call s:spacevim_bind('map', 'tg', 'toggle-git-gutter', 'GitGutterToggle', 1)

" project
function! spacemacs#toggleExplorerAtRoot()
  if exists(':ProjectRootExe')
    exe "ProjectRootExe NERDTreeToggle"
  else
    exe "NERDTreeToggle"
  endif
endfunction
call s:spacevim_bind('map', 'pt', 'toggle-explorer', ':call spacemacs#toggleExplorerAtRoot()', 1)
call s:spacevim_bind('map', 'te', 'toggle-explorer', ':call spacemacs#toggleExplorerAtRoot()', 1)

" files
" yank history
" nnoremap <Leader>fp :<C-u>Unite history/yank<cr>
nnoremap <Leader>fd :filetype detect<cr>
call s:spacevim_bind('map', 'fl', 'reload-file', ':e', 1)
call s:spacevim_bind('map', 'bD', 'force-quit-buffer', ':bd!', 1)
call s:spacevim_bind('map', 'xx', 'save-quit-all', ':wqa', 1)

" insert semicolon
nnoremap <Leader>i; mzA;<esc>`z
" insert comma
nnoremap <Leader>i, mzA,<esc>`z
" insert other punctuation
nnoremap <Leader>i. mzA.<esc>`z
nnoremap <Leader>i? mzA?<esc>`z
nnoremap <Leader>i! mzA!<esc>`z
nnoremap <Leader>i<cr> o<esc>

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

nnoremap <Leader>bl :b#<CR>

" nnoremap <Leader>bs :Scratch<CR>

function! ToggleSaveAutoGroup()
    if !exists('#onsave#BufWritePre')
        augroup onsave
            autocmd!
            " strip whitespace on save
            autocmd BufWritePre * :%s/\s\+$//e
        augroup END
    else
        augroup onsave
            autocmd!
        augroup END
    endif
endfunction

call s:spacevim_bind('map', 'tw', 'toggle-onsave-strip', ':call ToggleSaveAutoGroup()', 1)
call ToggleSaveAutoGroup()

" TODO: folding
