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
  " NOTE: this is much faster in some cases?  see fold commands below
  " execute a:map . " <leader>" . a:binding . " " . l:value
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

function! CustomFzfGrep()
  " Get user input from a popup
  let user_input = input('Enter search query: ')

  " Build the rg command with user input
  let g:rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
    \  '
  let command_with_input = g:rg_command . shellescape(user_input)

  " Call fzf#vim#grep with the command and input
  call fzf#vim#grep(command_with_input, 1)
endfunction

" git grep
call s:spacevim_bind('map', 'gg', 'git-grep', ':call CustomFzfGrep()', 1)

"toggle
call s:spacevim_bind('map', 't\', 'toggle-invisible-chars', 'set list!', 1)
call s:spacevim_bind('map', 'tp', 'toggle-paste', 'set paste!', 1)
call s:spacevim_bind('map', 'ti', 'toggle-indent-lines', 'IndentLinesToggle', 1)
call s:spacevim_bind('map', 'tn', 'toggle-line-numbers', ':setlocal invnumber<CR>:setlocal invrelativenumber<CR>', 0)
call s:spacevim_bind('map', 'tg', 'toggle-git-gutter', 'GitGutterToggle', 1)

call s:spacevim_bind('map', '/', 'search-current-file', 'BLines', 1)
function! spacemacs#toggleAlleFolds()
  if &foldlevel
    normal! zM<CR>
    " set foldlevel=0
  else
    normal! zR<CR>
    " set foldlevel=20
  endif
endfunction
" Just copying from http://vimdoc.sourceforge.net/htmldoc/fold.html
call s:spacevim_bind('map', 'z', 'toggle-all-folds', "call spacemacs#toggleAlleFolds()", 1)
" NOTE: for some reason these are slow!
" call s:spacevim_bind('map', 'zz', 'toggle-all-folds', "call spacemacs#toggleAlleFolds()", 1)
"" call s:spacevim_bind('map', 'za', 'toggle-fold', "normal! za", 1)
" call s:spacevim_bind('map', 'za', 'toggle-fold', "za", 0)
" call s:spacevim_bind('map', 'zA', 'toggle-fold-recursive', "zA", 0)
" call s:spacevim_bind('map', 'zf', 'create-fold', "zf", 0)
" call s:spacevim_bind('map', 'zd', 'delete-fold', "zd", 0)
" call s:spacevim_bind('map', 'zD', 'delete-fold-recursive', "zD", 0)
" call s:spacevim_bind('map', 'zE', 'delete-all-folds', "zE", 0)
" call s:spacevim_bind('map', 'zR', 'open-all-folds', "zR", 0)
" call s:spacevim_bind('map', 'zM', 'close-all-folds', "zM", 0)
" call s:spacevim_bind('map', 'zo', 'open-fold', "zo", 0)
" call s:spacevim_bind('map', 'zO', 'open-fold-recursive', "zO", 0)
" call s:spacevim_bind('map', 'zc', 'close-fold', "zc", 0)
" call s:spacevim_bind('map', 'zC', 'close-fold-recursive', "zC", 0)

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
function! spacemacs#reloadVimrc()
  source $MYVIMRC
  exe "AirlineRefresh"
endfunction
call s:spacevim_bind('map', 'feR', 'sync-configuration', ':call spacemacs#reloadVimrc()', 1)
" TODO: switch saving stuff to s instead of f?
call s:spacevim_bind('map', 'fS', 'sudo-write', ':w !sudo tee %', 1)

call s:spacevim_bind('map', 'i;', 'insert-semicolon', 'mzA;<esc>`z', 0)
call s:spacevim_bind('map', 'i,', 'insert-comma', 'mzA,<esc>`z', 0)
call s:spacevim_bind('map', 'i.', 'insert-period', 'mzA.<esc>`z', 0)
call s:spacevim_bind('map', 'i?', 'insert-question', 'mzA?<esc>`z', 0)
call s:spacevim_bind('map', 'i!', 'insert-exclamation', 'mzA!<esc>`z', 0)
call s:spacevim_bind('map', 'i<cr>', 'insert-return', 'o<esc>', 0)

call s:spacevim_bind('map', 'J', 'smart-join', ':SplitjoinJoin', 1)
call s:spacevim_bind('map', 'K', 'smart-split', ':SplitjoinJoin', 1)

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

" copilot
call s:spacevim_bind('map', 'cp', 'copilot-setup', ':Copilot setup<CR>', 0)

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
