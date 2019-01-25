" to profile vim startup
" vim --startuptime vim.log asdf.js
" less vim.log
" cat vim.log | sort -k 2
" time vim +qa

" TODO LIST:
" -  switch from syntastic to ALE https://vimawesome.com/plugin/ale
" - way to make <leader>tn toggle relative number also
" - some solution for tags
"     instructions will need to then include
"     install ctags: e.g. `apt-get install exuberant-ctags` or `brew install ctags`
" - map M to something useful
" - map R to something useful
" - map S to something useful
" - map Q to something useful (it's currently EX mode which is horrible)
nnoremap Q <nop>
" - try out folds
"   perhaps with https://stackoverflow.com/questions/7034215/is-there-a-way-to-expand-a-vim-fold-automatically-when-your-put-your-cursor-on-i
" - figure out folding
" - matching parentheses (%) fails after first time, in markdown files??
" - detect shiftwidth and expandtab automatically: https://vimawesome.com/plugin/sleuth-vim
"
"  - Neovim only: Deoplete, it shows a list of completions/typedefs/etc without any kind of slowdown https://github.com/Shougo/deoplete.nvim
"    similar plugins:
"     - https://github.com/prabirshrestha/asyncomplete.vim
"     - https://github.com/lifepillar/vim-mucomplete
"     - https://github.com/roxma/nvim-completion-manager
"     - https://github.com/maralla/completor.vim (targeting vim8)
"  - https://github.com/roman/golden-ratio for smaller screens?
"  - no more incsearch? https://medium.com/@haya14busa/incsearch-vim-is-dead-long-live-incsearch-2b7070d55250

set foldmethod=marker
" { and } motions should skip over folds
set foldopen-=block
" no highlighting
hi! link Folded SignColumn

""hi Folded guifg=white guibg=black ctermfg=white ctermbg=black
"hi FoldColumn      guifg=#465457 guibg=#000000
"hi Folded          guifg=#465457 guibg=#000000
"highlight Folded guibg=grey guifg=blue
"highlight FoldColumn guibg=darkgrey guifg=white

set nu
set relativenumber

" ignore case
set ic

set incsearch

set cursorline
hi CursorLine guibg=Grey40 ctermbg=235 term=none cterm=none
" term=bold cterm=bold

set noswapfile

set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

set nosmartindent
set cindent
" fixes annoying probably with # at start of line, see http://vim.wikia.com/wiki/Restoring_indent_after_typing_hash
set cinkeys-=0#
set indentkeys-=0#

" lets you hide buffers when opening new files
" (instead of "No write since last change")
set hidden

" remember marks for 100 files
set viminfo='100

augroup misc
  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END

" parentheses matching highlight colors
" hi MatchContents cterm=none ctermbg=235 ctermfg=none
" hi MatchParen cterm=none ctermbg=240 ctermfg=red
hi MatchParen cterm=none ctermbg=240 ctermfg=none

" search centers screen
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz

" unmap it for now, more or less
nnoremap Q <esc>

" split at cursor
nnoremap K i<cr><esc>

" faster indent
nnoremap > >>
nnoremap < <<

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent      " always set autoindenting on
if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set nobackup      " keep a backup file
  set backupdir=./.backup,~/.backup,/tmp
endif

" maybe fixes watchify/webpack watching issues
" set backupcopy=yes

set history=500      " keep 50 lines of command line history
set showcmd          " display incomplete commands

set mouse=a

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" resize windows
" TODO: find better solution..
nnoremap <C-W>h <C-w>>
nnoremap <C-W>j <C-w>+
nnoremap <C-W>k <C-w>-
nnoremap <C-W>l <C-w><

"====[ Make the 81st column stand out ]====================
"
" highlight ColorColumn ctermbg=magenta
" " EITHER the entire 81st column, full-screen...
" set colorcolumn=81
" " OR ELSE just the 81st column of wide lines...
" call matchadd('ColorColumn', '\%81v', 100)
"
""====[ Mappings to activate spell-checking alternatives ]================
"
" nnoremap  ;s     :set invspell spelllang=en<CR>
" nnoremap  ;ss    :set    spell spelllang=en-basic<CR>
"
" " To create the en-basic (or any other new) spelling list:
" " :mkspell  ~/.vim/spell/en-basic  basic_english_words.txt
" " See :help mkspell

" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
" TODO: try https://github.com/roxma/vim-paste-easy instead?
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" pasting in tmux
" TODO: try https://sunaku.github.io/tmux-yank-osc52.html (if that doesnt work, https://gist.github.com/burke/5960455)

" https://stackoverflow.com/questions/33093491/vim-gf-with-file-extension-based-on-current-filetype
augroup suffixes
  autocmd!

  let associations = [
        \["javascript", ".js,.jsx,.javascript,.es,.esx,.json"],
        \["python", ".py,.pyw"]
        \]

  for ft in associations
    execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
  endfor
augroup END

" Required Plug setup
call plug#begin('~/.vim/plugged')

"""""""""""""
" spacevim!
"""""""""""""

function! SpacevimBind(map, binding, name, value, isCmd)
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

Plug 'hecal3/vim-leader-guide'
set timeoutlen=400

Plug 'ctjhoa/spacevim'
let mapleader = "\<Space>"

Plug 'vim-airline/vim-airline'
" enable status line always
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''

"""""""""""""
" misc
"""""""""""""
" Tried, meh:
" - Plug 'terryma/vim-multiple-cursors'
" instead, learn:
" - use cgn
" - apply macros on many lines :g/searchthing/normal @q

Plug 'mhinz/vim-startify'
Plug 'moll/vim-bbye'

" Plug 'mtth/scratch.vim'

" use S instead of s in substitutions
Plug 'tpope/vim-abolish'
" substitute under cursor
" Plug 'wincent/scalpel'
" Use <Leader>S instead of default <Leader>e
" call SpacevimBind('nmap', 'S', 'scalpel', '<Plug>(Scalpel)', 1)
" find stuff in many files
" TODO: learn to use
Plug 'pelodelfuego/vim-swoop'
" Possibly try instead: Olical/vim-enmasse

" if has('nvim')
if 0
  " NOTE: this messes with fzf
  " tnoremap <Esc> <C-\><C-n>
  " tnoremap <Esc> <C-\><C-n>:Tclose<CR>
  tnoremap <C-s> <C-\><C-n>
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l

  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert

  " doesn't have stupid VtrKillRunner lag, doesn't require tmux
  Plug 'kassio/neoterm'

  let g:neoterm_eof = "\r"
  let g:neoterm_position = 'vertical' " 'horizontal'
  " TODO: possibly useful (untested), run particular command
  " store command by :TMap <command>
  " then run with mapping:
  " let g:neoterm_automap_keys = '\<Space>rr'

  " NOTE: Topen will instead resume a previous terminal, if that's better
  call SpacevimBind('map', 'rs', 'runner-open', 'Tnew', 1)
  call SpacevimBind('map', 'rf', 'runner-run-file', 'TREPLSendFile', 1)
  call SpacevimBind('nmap', 'rl', 'runner-run-lines', 'TREPLSendLine', 1)
  " TODO this doesn't work for multi-line
  call SpacevimBind('vmap', 'rl', 'runner-run-lines', 'TREPLSendSelection', 1)
  " call SpacevimBind('map', 'rR', 'runner-reorient', ':VtrReorientRunner ', 1)
  call SpacevimBind('map', 'rx', 'runner-kill', 'Tclose', 1)
  call SpacevimBind('map', 'rq', 'runner-clear', 'call neoterm#clear()', 1)
  call SpacevimBind('map', 'rc', 'runner-cancel-cmd', 'call neoterm#kill()', 1)
else
  " doesn't work well in zsh
  " Plug 'christoomey/vim-run-interactive'
  " nnoremap <leader>~ :RunInInteractiveShell zsh<cr>

  Plug 'christoomey/vim-tmux-navigator'
  Plug 'christoomey/vim-tmux-runner'
  let g:VtrGitCdUpOnOpen = 1
  let g:VtrStripLeadingWhitespace = 0
  let g:VtrClearEmptyLines = 0
  let g:VtrAppendNewline = 1
  " horizontal is nicer, but messes with copy-paste
  " let g:VtrOrientation = "h"
  let g:VtrPercentage = 35
  augroup vtr
    autocmd VimLeavePre * :VtrKillRunner
  augroup END
  call SpacevimBind('map', 'rs', 'runner-open', 'VtrOpenRunner', 1)
  call SpacevimBind('map', 'rf', 'runner-run-file', 'VtrSendFile!', 1)
  call SpacevimBind('map', 'rl', 'runner-run-lines', 'VtrSendLinesToRunner!', 1)
  call SpacevimBind('map', 'rr', 'runner-rerun', 'VtrSendCommandToRunner!', 1)
  call SpacevimBind('map', 'rc', 'runner-run-custom', ':VtrSendCommandToRunner! ', 0)
  " call SpacevimBind('map', 'rR', 'runner-reorient', ':VtrReorientRunner ', 1)
  call SpacevimBind('map', 'rx', 'runner-kill', ':VtrKillRunner ', 1)

  " Plug 'benmills/vimux'
  " map <Leader>rf :call VimuxRunCommand("python " . bufname("%"))<CR>
  " map <Leader>rs :call VimuxRunCommand("")<CR>
  " map <Leader>rf :call VimuxRunCommand(join(getline(1,'$'), "\n"))<CR>
  " nmap <Leader>rr :call VimuxRunCommand(getline('.'))<CR>
  " vmap <Leader>rr :call VimuxRunCommand(Get_visual_selection())<CR>
  " map <Leader>rc :VimuxCloseRunner<CR>

  " NOTE: doesn't really work properly
  " Plug 'ervandew/screen'
  " let g:ScreenImpl = 'Tmux'
  " nnoremap <leader>ass :ScreenShell<cr>
  " nnoremap <leader>asr V:ScreenSend<cr>
  " vnoremap <leader>asr :ScreenSend<cr>
endif

"""""""""""""
" version control
"""""""""""""

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'

"""""""""""""
" search
"""""""""""""

" unneeded, with fzf
" Plug 'rking/ag.vim'

" must come AFTER ag.vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" SEE: https://github.com/junegunn/fzf.vim/issues/66
" disables use of tmux pane for fzf
" let g:fzf_layout = {}
nnoremap go :GitFiles<cr>
nnoremap gb :Buffers<cr>
" nnoremap <C-f> :Files<cr>
nnoremap gl :Lines<cr>
nnoremap ` :Marks<cr>
" nnoremap <C-f> :Files ~<cr>
" NOTE: in an fzf query, prepending ' makes a word an exact match

" Plug 'Shougo/unite.vim'
" function! s:unite_settings() "{
"    nmap <buffer> <Esc>     <Plug>(unite_exit)
"    " " Play nice with supertab
"    " let b:SuperTabDisabled=1
"    " " Enable navigation with control-j and control-k in insert mode
"    " imap <buffer> <C-j> <Plug>(unite_select_next_line)
"    " imap <buffer> <C-k> <Plug>(unite_select_previous_line)
" endfunction
" augroup unite
"   autocmd FileType unite call s:unite_settings()
" augroup END
" let g:unite_split_rule = 'botright'
" Plug 'Shougo/neomru.vim'
" Plug 'Shougo/neoyank.vim'

""""""""""""""
" general programming
""""""""""""""

" make tab be awesome
Plug 'ervandew/supertab'
set omnifunc=syntaxcomplete#Complete

Plug 'zxqfl/tabnine-vim'
" Plug 'ajh17/VimCompletesMe'
" Plug 'Valloric/YouCompleteMe'
" don't load until insert mode, see: https://github.com/junegunn/vim-plug/issues/53
" Plug 'Valloric/YouCompleteMe', { 'on': [] }
" augroup load_us_ycm
"   autocmd!
"   autocmd InsertEnter * call plug#load('YouCompleteMe')
"                      \| call youcompleteme#Enable()
" augroup END
" snippets engine, actual snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
" go down the list, not up
" let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"


" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
" for jumping between sections of the snippet
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" let g:UltiSnipsEditSplit="vertical"

Plug 'scrooloose/syntastic', { 'do': './install.py' }
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
" 'jshint'

" ignore annoying errors
let g:syntastic_html_tidy_ignore_errors=[ "proprietary attribute" ,"trimming empty <"]

" HACKY: see http://stackoverflow.com/questions/15937042/syntastic-disable-automatic-compilation-of-java
" maybe undo this if i switch from intellij
let g:loaded_syntastic_java_javac_checker = 1

" for python 3
let g:syntastic_python_python_exec = 'python3'

"""""""""""""
" languages
"""""""""""""

" TODO: try this out for python
Plug 'davidhalter/jedi-vim'
Plug 'integralist/vim-mypy'

Plug 'sheerun/vim-polyglot'

Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" Plug 'flowtype/vim-flow', { 'for': 'javascript' }
Plug 'ianks/vim-tsx'
Plug 'Shougo/vimproc.vim', {'do' : 'make'} | Plug 'Quramy/tsuquyomi', { 'for': 'typescript '}
Plug 'leafgarland/typescript-vim', { 'for': 'typescript '}
let g:syntastic_typescript_checkers = ['tslint'] " tsc
" let g:syntastic_typescript_tsc_args = '--target ES6 -p .'
" let g:syntastic_typescript_tsc_args = '-p . --noEmit'

Plug 'ElmCast/elm-vim', { 'for': 'elm' }
let g:elm_format_autosave = 1
let g:elm_syntastic_show_warnings = 1

" NOTE: C-J and C-K cause issues with rust, has something to do with delimitMate
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
"let g:rustfmt_autosave = 1

Plug 'elzr/vim-json', { 'for' : 'json' }
let g:vim_json_syntax_conceal = 0

" Plug 'cohama/lexima.vim', { 'for' : 'lisp' }

Plug 'tpope/vim-markdown', { 'for' : 'markdown' }

" Plug 'cespare/vim-toml', { 'for' : 'toml' }

" Plug 'fatih/vim-go', { 'for': 'go' }
"Plug 'nsf/gocode'

" causes issues with mapping <C-j> due to IMAP
Plug 'vim-latex/vim-latex', { 'for': 'tex' }
let g:tex_flavor='latex'
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a single file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

"""""""""""""
" editing
"""""""""""""
Plug 'Chiel92/vim-autoformat'
" let g:autoformat_autoindent = 0
" let g:autoformat_retab = 0
" autocmd BufWrite * :Autoformat
" let g:autoformat_remove_trailing_spaces = 0

Plug 'Raimondi/delimitMate'
" Plug 'vim-scripts/tComment'
Plug 'tpope/vim-commentary'
xmap <Leader>;  <Plug>Commentary
nmap <Leader>;  <Plug>Commentary
omap <Leader>;  <Plug>Commentary
nmap <Leader>;; <Plug>CommentaryLine
Plug 'tpope/vim-surround'
Plug 'docunext/closetag.vim'
Plug 'michaeljsmith/vim-indent-object'
" visual mode should just use s to surround
vmap s S
Plug 'tpope/vim-repeat'
" repeat for movements
" See https://github.com/Houl/repmo-vim
Plug 'Houl/repmo-vim'
noremap <expr> b repmo#SelfKey('b', 'w')|sunmap b
noremap <expr> e repmo#SelfKey('e', 'ge')|sunmap e
noremap <expr> w repmo#SelfKey('w', 'b')|sunmap w
noremap <expr> B repmo#SelfKey('B', 'W')|sunmap B
noremap <expr> E repmo#SelfKey('E', 'gE')|sunmap E
noremap <expr> W repmo#SelfKey('W', 'B')|sunmap W
noremap <expr> } repmo#SelfKey('}', '{')
noremap <expr> { repmo#SelfKey('{', '}')
noremap <expr> ) repmo#SelfKey(')', '(')
noremap <expr> ( repmo#SelfKey('(', ')')
noremap <expr> h repmo#SelfKey('h', 'l')|sunmap h
noremap <expr> l repmo#SelfKey('l', 'h')|sunmap l
noremap <expr> j repmo#SelfKey('j', 'k')|sunmap j
noremap <expr> k repmo#SelfKey('k', 'j')|sunmap k
" noremap <expr> j repmo#SelfKey('gj', 'gk')|sunmap j
" noremap <expr> k repmo#SelfKey('gk', 'gj')|sunmap k
noremap <expr> <C-E> repmo#SelfKey('<C-E>', '<C-Y>')
noremap <expr> <C-Y> repmo#SelfKey('<C-Y>', '<C-E>')
noremap <expr> <C-U> repmo#SelfKey('<C-U>', '<C-D>')
noremap <expr> <C-D> repmo#SelfKey('<C-D>', '<C-U>')
noremap <expr> <C-I> repmo#SelfKey('<C-I>', '<C-O>')
noremap <expr> <C-O> repmo#SelfKey('<C-O>', '<C-I>')
map <expr> ; repmo#LastKey(';')|sunmap ;
map <expr> , repmo#LastRevKey(',')|sunmap ,
noremap <expr> f repmo#ZapKey('f')|sunmap f
noremap <expr> F repmo#ZapKey('F')|sunmap F
noremap <expr> t repmo#ZapKey('t')|sunmap t
noremap <expr> T repmo#ZapKey('T')|sunmap T

" highlight all search results
Plug 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" highlight for search
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
nmap n nzz
nmap N Nzz
" display replacements as you type command
Plug 'osyo-manga/vim-over'
" NOTE: overcommandline screws up :e, for some reason (doesn't open correct buffer)
" possibly do something like this:
" https://stackoverflow.com/questions/14367440/map-e-to-explore-in-command-mode
" command! -nargs=* -bar -bang -count=0 -complete=dir E Explore <args>
" NOTE: overcommandline also has weird autocomplete
" nnoremap <silent> ; :OverCommandLine<cr>
" nnoremap <silent> : :OverCommandLine<cr>
" vnoremap <silent> ; :OverCommandLine<cr>
" vnoremap <silent> : :OverCommandLine<cr>
nnoremap <silent> S :OverCommandLine<cr>%s/
" TODO: for some reason this doesn't work...
" vnoremap <silent> S :OverCommandLine<cr>
" nnoremap  ;  :
" nnoremap  :  ;

" displays marks in gutter
Plug 'kshenoy/vim-signature'

" http://vim.wikia.com/wiki/Format_pasted_text_automatically
" NOTE: doesn't quite work perfectly :(
"       plus, doesn't work with yankring properly
" nnoremap p p=`]

" if has('nvim')
"   Plug 'bfredl/nvim-miniyank'
"   nmap p <Plug>(miniyank-autoput)
"   nmap P <Plug>(miniyank-autoPut)
"   nmap [ <Plug>(miniyank-cycle)
" else
Plug 'vim-scripts/YankRing.vim'
let g:yankring_history_dir = expand('$HOME/.vim/')
let g:yankring_replace_n_pkey = '['
let g:yankring_replace_n_nkey = ']'
" endif

Plug 'AndrewRadev/splitjoin.vim'
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''

Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Plug 'junegunn/rainbow_parentheses.vim'
" let g:rainbow#max_level = 16
" let g:rainbow#pairs = [['(', ')'], ['[', ']']]
" let g:rainbow#blacklist = []
" augroup rainbow
"   autocmd BufEnter * :RainbowParentheses<cr>
" augroup END
" Plug 'szw/vim-tags'

Plug 'mbbill/undotree'
Plug 'junegunn/vim-peekaboo'
let g:peekaboo_delay = 400

Plug 'Yggdroot/indentLine'
let g:indentLine_enabled = 0

" NOTE: these are all ignored... TODO: figure this out
" " Vim
" let g:indentLine_color_term = 240
" "GVim
" let g:indentLine_color_gui = '#A4E57E'
" " none X terminal
" let g:indentLine_color_tty_light = 7 " (default: 4)
" let g:indentLine_color_dark = 1 " (default: 2)

"""""""""""""
" windows
"""""""""""""
Plug 'szw/vim-maximizer'
" NOTE: causes issues with leader-guide and with toggling syntastic pane

"""""""""""""
" general utilities
"""""""""""""

Plug 'tpope/vim-eunuch'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" TODO: try
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'jistr/vim-nerdtree-tabs'

" TO TRY OUT?
"  justinmk/vim-sneak

" control c copies to clipboard in visual mode
" no way to do command key in regular vim... maybe neovim though?
" If on a local machine:
vnoremap <C-c> "+y
nnoremap <C-c> "+y
" If installing on a remote machine, do this instead:
" Plug 'haya14busa/vim-poweryank'
" map <C-c> <Plug>(operator-poweryank-osc52)

call plug#end()
" automatically calls:
" - filetype plugin indent on
" - syntax on

" NOTE: command line install:
" vim +PlugInstall +qall

" http://vim.wikia.com/wiki/Mac_OS_X_clipboard_sharing
" set clipboard=unnamed

" faster switch buffers
nnoremap <tab> <Esc>:bn<CR>
nnoremap <S-tab> <Esc>:bp<CR>

set background=dark
" let g:solarized_termcolors = 256
" " let g:solarized_visibility = "high"
" " let g:solarized_contrast = "high"
" colorscheme solarized
" see: http://serverfault.com/questions/268555/how-to-tell-vim-to-extend-the-background-color-to-the-whole-screen
set t_ut=

" https://stackoverflow.com/questions/290465/how-to-paste-over-without-overwriting-register
" don't lose register contents when pasting in visual mode
" xnoremap p "_dP
function! YRRunAfterMaps()
  " From Steve Losh, Preserve the yank post selection/put.
  vnoremap p :<c-u>YRPaste 'p', 'v'<cr>gv:YRYankRange 'v'<cr>
endfunction

" NOTE: i found vmail to be meh, this is not all fully tested
" if !empty($IS_VMAIL)
"   autocmd FileType vmailMessageList nmap <buffer> * <Plug>VmailToggleStar
"   autocmd FileType vmailMessageList xmap <buffer> * <Plug>VmailToggleStar
"   autocmd FileType vmailMessageList nmap <buffer> <leader>mu <Plug>VmailMarkAsUnread
"   autocmd FileType vmailMessageList xmap <buffer> <leader>mu <Plug>VmailMarkAsUnread
"   autocmd FileType vmailMessageList nmap <buffer> <leader>mr <Plug>VmailMarkAsRead
"   autocmd FileType vmailMessageList xmap <buffer> <leader>mr <Plug>VmailMarkAsRead
"   autocmd FileType vmailMessageList nmap <buffer> # <Plug>VmailDelete
"   autocmd FileType vmailMessageList xmap <buffer> # <Plug>VmailDelete
"   " autocmd FileType vmailMessageList nmap <buffer> d <Plug>VmailDelete
"   " autocmd FileType vmailMessageList xmap <buffer> d <Plug>VmailDelete
"   autocmd FileType vmailMessageList nmap <buffer> ! <Plug>VmailMarkAsSpam
"   autocmd FileType vmailMessageList xmap <buffer> ! <Plug>VmailMarkAsSpam
"   autocmd FileType vmailMessageList nmap <buffer> e <Plug>VmailArchiveMessage
"   autocmd FileType vmailMessageList xmap <buffer> e <Plug>VmailArchiveMessage
"   autocmd FileType vmailMessageList nmap <buffer> <leader>mp <Plug>VmailAppendMessagesToFile
"   autocmd FileType vmailMessageList xmap <buffer> <leader>mp <Plug>VmailAppendMessagesToFile
"   autocmd FileType vmailMessageList nmap <buffer> <leader>m/ <Plug>VmailSearch
"   autocmd FileType vmailMessageList nmap <buffer> m <Plug>VmailSwitchMailbox
"   autocmd FileType vmailMessageList nmap <buffer> <leader>mv <Plug>VmailMoveToMailbox
"   autocmd FileType vmailMessageList xmap <buffer> <leader>mv <Plug>VmailMoveToMailbox
"   autocmd FileType vmailMessageList nmap <buffer> <leader>mc <Plug>VmailCopyToMailbox
"   autocmd FileType vmailMessageList xmap <buffer> <leader>mc <Plug>VmailCopyToMailbox
"   autocmd FileType vmailMessageList nmap <buffer> c <Plug>VmailComposeNew
"   autocmd FileType vmailMessageList nmap <buffer> r <Plug>VmailComposeReply
"   autocmd FileType vmailMessageList nmap <buffer> a <Plug>VmailComposeReplyAll
"   autocmd FileType vmailMessageList nmap <buffer> f <Plug>VmailForward
"   autocmd FileType vmailMessageList nmap <buffer> o <Plug>VmailOpenMessage
"   autocmd FileType vmailMessageList nmap <buffer> <CR> <Plug>VmailToggleWindow
"
"   autocmd FileType mail nmap <buffer> r <Plug>VmailMessageWindow_Reply
"   autocmd FileType mail nmap <buffer> a <Plug>VmailMessageWindow_ReplyToAll
"   autocmd FileType mail nmap <buffer> f <Plug>VmailMessageWindow_Forward
"   autocmd FileType mail nmap <buffer> R <Plug>VmailMessageWindow_ShowRaw
"   autocmd FileType mail nmap <buffer> <C-j> <Plug>VmailMessageWindow_ShowNext
"   autocmd FileType mail nmap <buffer> <C-k> <Plug>VmailMessageWindow_ShowPrev
"   autocmd FileType mail nmap <buffer> c <Plug>VmailMessageWindow_ComposeMessage
"   autocmd FileType mail nmap <buffer> # <Plug>VmailMessageWindow_DeleteMessage
"   autocmd FileType mail nmap <buffer> * <Plug>VmailMessageWindow_ToggleStar
"   autocmd FileType mail nmap <buffer> <leader>mr <Plug>VmailMessageWindow_MarkAsRead
"   autocmd FileType mail nmap <buffer> <leader>mu <Plug>VmailMessageWindow_MarkAsUnread
"   autocmd FileType mail nmap <buffer> ! <Plug>VmailMessageWindow_MarkAsSpam
"   autocmd FileType mail nmap <buffer> e <Plug>VmailMessageWindow_ArchiveMessage
"   autocmd FileType mail nmap <buffer> <leader>mv <Plug>VmailMessageWindow_MoveToMailbox
"   autocmd FileType mail nmap <buffer> <leader>mc <Plug>VmailMessageWindow_CopyToMailbox
"   autocmd FileType mail nmap <buffer> m <Plug>VmailMessageWindow_SwitchMailBox
"   autocmd FileType mail nmap <buffer> <leader>mA <Plug>VmailMessageWindow_SaveAttachment
"   autocmd FileType mail nmap <buffer> <CR> <Plug>VmailMessageWindow_ToggleWindow
"   autocmd FileType mail nmap <buffer> <leader>mp <Plug>VmailMessageWindow_AppendMessagesToFile
"   autocmd FileType mail nmap <buffer> <leader>m/ <Plug>VmailMessageWindow_Search
"   autocmd Filetype mail nnoremap <silent> <leader>ms :call <SID>send_message()<CR>
" endif
