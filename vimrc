" to profile vim startup
" vim --startuptime vim.log asdf.js
" less vim.log
" cat vim.log | sort -k 2
" time vim +qa

" TODO LIST:
" - way to make <leader>tn toggle relative number also
" - some solution for tags
"     instructions will need to then include
"     install ctags: e.g. `apt-get install exuberant-ctags` or `brew install ctags`
" - map M to something useful
" - map R to something useful
" - map S to something useful
" - map Q to something useful
" - figure out folding
" - matching parentheses (%) fails after first time, in markdown files??

"set foldmethod=indent
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
  " strip whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

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

" TODO: these can't possibly both work
" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>
" don't lose register contents when pasting in visual mode
vnoremap p "_dp

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
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction


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
" misc
"""""""""""""
Plug 'mhinz/vim-startify'
Plug 'moll/vim-bbye'

" Plug 'mtth/scratch.vim'

" use S instead of s in substitutions
Plug 'tpope/vim-abolish'
" substitute under cursor
Plug 'wincent/scalpel'
" Use <Leader>S instead of default <Leader>e
nmap <Leader>S <Plug>(Scalpel)
" find stuff in many files
Plug 'pelodelfuego/vim-swoop'

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
" Plug 'benmills/vimux'

" NOTE: doesn't really work properly
" Plug 'ervandew/screen'
" let g:ScreenImpl = 'Tmux'
" nnoremap <leader>ass :ScreenShell<cr>
" nnoremap <leader>asr V:ScreenSend<cr>
" vnoremap <leader>asr :ScreenSend<cr>

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
" ctrlp, just cause i'm used to it
nnoremap <C-p> :GitFiles<cr>
nnoremap <C-b> :Buffers<cr>
nnoremap <C-f> :Files<cr>
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

Plug 'Valloric/YouCompleteMe'
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
let g:SuperTabDefaultCompletionType = '<C-n>'

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

"""""""""""""
" languages
"""""""""""""

Plug 'sheerun/vim-polyglot'

Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" Plug 'flowtype/vim-flow', { 'for': 'javascript' }
Plug 'ianks/vim-tsx'
Plug 'Shougo/vimproc.vim', {'do' : 'make'} | Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
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
Plug 'Raimondi/delimitMate'
" Plug 'vim-scripts/tComment'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
" visual mode should just use s to surround
vmap s S
Plug 'tpope/vim-repeat'

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
vnoremap <silent> ; :OverCommandLine<cr>
vnoremap <silent> : :OverCommandLine<cr>
nnoremap <silent> S :OverCommandLine<cr>%s/
" TODO: for some reason this doesn't work...
" vnoremap <silent> S :OverCommandLine<cr>
nnoremap  ;  :
nnoremap  :  ;

" displays marks in gutter
Plug 'kshenoy/vim-signature'

" http://vim.wikia.com/wiki/Format_pasted_text_automatically
" NOTE: doesn't quite work perfectly :(
"       plus, doesn't work with yankring properly
" nnoremap p p=`]

Plug 'vim-scripts/YankRing.vim'
let g:yankring_history_dir = expand('$HOME/.vim/')
let g:yankring_replace_n_pkey = '['
let g:yankring_replace_n_nkey = ']'

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
" TODO: switch workflow away from this
" Plug 'fholgado/minibufexpl.vim'
" " let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplMapWindowNavArrows = 1
" let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplModSelTarget = 1

"""""""""""""
" general utilities
"""""""""""""

Plug 'tpope/vim-eunuch'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" TO TRY OUT?
"  justinmk/vim-sneak

Plug 'easymotion/vim-easymotion'
" rebind leader to single key instead of 2
" map <Leader> <Plug>(easymotion-prefix)
" map <Leader>w <Plug>(easymotion-bd-w)
" map <Leader>t <Plug>(easymotion-bd-tl)
" map <Leader>f <Plug>(easymotion-bd-f)
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
" nmap <Tab> <Plug>(easymotion-bd-jk)
" nmap <Tab><Tab> <Plug>(easymotion-jumptoanywhere)

"""""""""""""
" spacevim!
"""""""""""""

Plug 'hecal3/vim-leader-guide'
set timeoutlen=400

Plug 'ctjhoa/spacevim'
let mapleader = "\<Space>"

Plug 'vim-airline/vim-airline'
" enable status line always
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''

call plug#end()
" automatically calls:
" - filetype plugin indent on
" - syntax on

" NOTE: command line install:
" vim +PlugInstall +qall

" http://vim.wikia.com/wiki/Mac_OS_X_clipboard_sharing
" set clipboard=unnamed

" control c copies to clipboard in visual mode
" no way to do command key in regular vim... maybe neovim though?
vnoremap <C-c> "+y
nnoremap <C-c> "+y

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
