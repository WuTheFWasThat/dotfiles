"set foldmethod=indent
""hi Folded guifg=white guibg=black ctermfg=white ctermbg=black
"hi FoldColumn      guifg=#465457 guibg=#000000
"hi Folded          guifg=#465457 guibg=#000000
"highlight Folded guibg=grey guifg=blue
"highlight FoldColumn guibg=darkgrey guifg=white

"map n nzz

set ruler
set nu
set hlsearch
set incsearch
set cursorline
syntax enable

set background=dark

colorscheme desert
"let g:solarized_termcolors = 256
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"
"colorscheme solarized

set smartindent

set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

set hidden

autocmd BufWritePre * :%s/\s\+$//e

" An example for a vimrc file.
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2002 May 28
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"         for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"       for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
    endif

    " Switch Windows and maximize in one keypress
    "set wmh=0
    "map <C-J> <C-W>j<C-W>_
    "map <C-K> <C-W>k<C-W>_
    "map <C-N> <Esc>:bn<CR>
    "map <C-P> <Esc>:bN<CR>

    map <C-C> :s/^/\/\//<CR>\|:noh<CR>

    let g:miniBufExplMapWindowNavVim = 1
    let g:miniBufExplMapWindowNavArrows = 1
    let g:miniBufExplMapCTabSwitchBufs = 1
    let g:miniBufExplModSelTarget = 1

    " make tab sizes smaller (4 instead of 8) and all spaces...
    set sw=2
    set ts=2
    set ic
    set expandtab
    set smarttab
    " set smartindent
    set cindent
    :set comments=sl:/**,mb:\ *,elx:\ */
    "colorscheme darkblue
    "color darkblue
    vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

    " Use Vim settings, rather then Vi settings (much better!).
    " This must be first, because it changes other options as a side effect.
    set nocompatible

    " allow backspacing over everything in insert mode
    set backspace=indent,eol,start


set ts=4
set autoindent      " always set autoindenting on
if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set nobackup      " keep a backup file
set backupdir=./.backup,~/.backup,/tmp
endif
set history=50      " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch       " do incremental searching
set hlsearch

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
"colorscheme darkblue

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif


endif " has("autocmd")

nmap <space> za
nmap <F2> :cp<CR>
nmap <F3> :cn<CR>
nmap <F4> :grep <C-R>" *.cpp *.h <CR>
nmap <F5> :redraw! <CR>
nmap <F6> :tp<CR>
nmap <F7> :tn<CR>

"RENUMBER LINES, useful for lists
nmap <F8> :'<,'>! awk '/[0-9]+\. .*/ { $1 = i++ "."} {print}'<CR>
redraw!


"" VARUN ADDED
" fix meta-keys which generate <esc>a .. <esc>z
"let c='a'
"while c != 'z'
"    exec "set <M-".toupper(c).">=\e".c
"    exec "imap \e".c." <M-".toupper(c).">"
"    let c = nr2char(1+char2nr(c))
"endw
"

filetype on
filetype indent on
filetype plugin on

" SAVE LAST CURSOR POSITION

"augroup vimrcEx
"    au!
"
"      " For all text files set 'textwidth' to 78 characters.
"      "   autocmd FileType text setlocal textwidth=78
"      "
"      "     " When editing a file, always jump to the last known cursor
"      "     position.
"      "       " Don't do it when the position is invalid or when inside an
"      "       event handler
"      "         " (happens when dropping a file on gvim).
"      "           autocmd BufReadPost *
"      "               \ if line("'\"") > 0 && line("'\"") <= line("$") |
"          \   exe "normal g`\"" |
"          \ endif
"
"        augroup END

"====[ Make the 81st column stand out ]====================
"
"    " EITHER the entire 81st column, full-screen...
"    highlight ColorColumn ctermbg=magenta
"    set colorcolumn=81
"
"    " OR ELSE just the 81st column of wide lines...
"    highlight ColorColumn ctermbg=magenta
"    call matchadd('ColorColumn', '\%81v', 100)
"
"    " OR ELSE on April Fools day...
"    highlight ColorColumn ctermbg=red ctermfg=blue
"    exec 'set colorcolumn=' . join(range(2,80,3), ',')


"=====[ Highlight matches when jumping to next ]=============
"
"    " This rewires n and N to do the highlighing...
"    nnoremap <silent> n   n:call HLNext(0.4)<cr>
"    nnoremap <silent> N   N:call HLNext(0.4)<cr>
"
"
"    " EITHER blink the line containing the match...
"    function! HLNext (blinktime)
"        set invcursorline
"        redraw
"        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"        set invcursorline
"        redraw
"    endfunction
"
"    " OR ELSE ring the match in red...
"    function! HLNext (blinktime)
"        highlight RedOnRed ctermfg=red ctermbg=red
"        let [bufnum, lnum, col, off] = getpos('.')
"        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
"        echo matchlen
"        let ring_pat = (lnum > 1 ? '\%'.(lnum-1).'l\%>'.max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.\|' : '')
"                \ . '\%'.lnum.'l\%>'.max([col-4,1]) .'v\%<'.col.'v.'
"                \ . '\|'
"                \ . '\%'.lnum.'l\%>'.max([col+matchlen-1,1]) .'v\%<'.(col+matchlen+3).'v.'
"                \ . '\|'
"                \ . '\%'.(lnum+1).'l\%>'.max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.'
"        let ring = matchadd('RedOnRed', ring_pat, 101)
"        redraw
"        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"        call matchdelete(ring)
"        redraw
"    endfunction
"
"    " OR ELSE briefly hide everything except the match...
"    function! HLNext (blinktime)
"        highlight BlackOnBlack ctermfg=black ctermbg=black
"        let [bufnum, lnum, col, off] = getpos('.')
"        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
"        let hide_pat = '\%<'.lnum.'l.'
"                \ . '\|'
"                \ . '\%'.lnum.'l\%<'.col.'v.'
"                \ . '\|'
"                \ . '\%'.lnum.'l\%>'.(col+matchlen-1).'v.'
"                \ . '\|'
"                \ . '\%>'.lnum.'l.'
"        let ring = matchadd('BlackOnBlack', hide_pat, 101)
"        redraw
"        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"        call matchdelete(ring)
"        redraw
"    endfunction
"
"    " OR ELSE just highlight the match in red...
"    function! HLNext (blinktime)
"        let [bufnum, lnum, col, off] = getpos('.')
"        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
"        let target_pat = '\c\%#'.@/
"        let ring = matchadd('WhiteOnRed', target_pat, 101)
"        redraw
"        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"        call matchdelete(ring)
"        redraw
"    endfunction
"
"
""====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======
"
"    exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
"    set list
"
"
""====[ Swap : and ; to make colon commands easier to type ]======
"
    nnoremap  ;  :
"    nnoremap  :  ;
"
"
""====[ Swap v and CTRL-V, because Block mode is more useful that Visual mode "]======
"
"    nnoremap    v   <C-V>
"    nnoremap <C-V>     v
"
"    vnoremap    v   <C-V>
"    vnoremap <C-V>     v
"
"
""====[ Always turn on syntax highlighting for diffs ]=========================
"
"    " EITHER select by the file-suffix directly...
"    augroup PatchDiffHighlight
"        autocmd!
"        autocmd BufEnter  *.patch,*.rej,*.diff   syntax enable
"    augroup END
"
"    " OR ELSE use the filetype mechanism to select automatically...
"    filetype on
"    augroup PatchDiffHighlight
"        autocmd!
"        autocmd FileType  diff   syntax enable
"    augroup END
"
"
""====[ Mappings to activate spell-checking alternatives ]================
"
"    nmap  ;s     :set invspell spelllang=en<CR>
"    nmap  ;ss    :set    spell spelllang=en-basic<CR>
"
"    " To create the en-basic (or any other new) spelling list:
"    "
"    "     :mkspell  ~/.vim/spell/en-basic  basic_english_words.txt
"    "
"    " See :help mkspell
"
"
""====[ Make CTRL-K list diagraphs before each digraph entry ]===============
"
"    inoremap <expr> <C-K> ShowDigraphs()
"
"    function! ShowDigraphs ()
"        digraphs
"        call getchar()
"        return "\<C-K>"
"    endfunction
"
"    " But also consider the hudigraphs.vim and betterdigraphs.vim plugins,
"    " which offer smarter and less intrusive alternatives
"

execute pathogen#infect()

" ctrl p
set runtimepath^=~/.vim/bundle/ctrlp.vim

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" syntastic

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint', 'jshint']

" hacky: see http://stackoverflow.com/questions/15937042/syntastic-disable-automatic-compilation-of-java
" maybe undo this if i switch from intellij
let g:loaded_syntastic_java_javac_checker = 1

"let g:rustfmt_autosave = 1

" for easymotion
" rebind leader to single key instead of 2
" map <Leader> <Plug>(easymotion-prefix)
nmap gj <Plug>(easymotion-j)
nmap gk <Plug>(easymotion-k)
"" these mess up macros too much
" nmap t <Plug>(easymotion-bd-tl)
" nmap f <Plug>(easymotion-bd-fl)
" nmap <Space> <Plug>(easymotion-s)
" Bidirectional & within line 't' motion
" omap t <Plug>(easymotion-bd-tl)
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

let g:tex_flavor='latex'

" for elm stuff
let g:elm_format_autosave = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:elm_syntastic_show_warnings = 1

" http://vim.wikia.com/wiki/Mac_OS_X_clipboard_sharing
" set clipboard=unnamed
