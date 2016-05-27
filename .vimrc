"set foldmethod=indent
""hi Folded guifg=white guibg=black ctermfg=white ctermbg=black
"hi FoldColumn      guifg=#465457 guibg=#000000
"hi Folded          guifg=#465457 guibg=#000000
"highlight Folded guibg=grey guifg=blue
"highlight FoldColumn guibg=darkgrey guifg=white

" search centers screen
map n nzz

set ruler
set nu

" highlight for search
set hlsearch
" ignore case
set ic

set incsearch
set cursorline

set noswapfile

set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

set nosmartindent
set cindent

" lets you hide buffers when opening new files
set hidden

autocmd BufWritePre * :%s/\s\+$//e

nnoremap  ;  :
"nnoremap  :  ;

" let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

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
set history=500      " keep 50 lines of command line history
set showcmd          " display incomplete commands

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Only do this part when compiled with support for autocommands.
if has("autocmd")
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

" Required Vundle setup
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

Plugin 'ElmCast/elm-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/syntastic'
Plugin 'kchmck/vim-coffee-script'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-fugitive'
" causes issues with mapping <C-j> due to IMAP
" Plugin 'vim-latex/vim-latex'
" TODO use for grepping codebase?
" e.g. nmap <LEADER>sp :Ag<SPACE>
" Plugin 'rking/ag.vim'
Plugin 'airblade/vim-gitgutter'

Plugin 'Shougo/unite.vim'
function! s:unite_settings() "{
   nmap <buffer> <Esc>     <Plug>(unite_exit)
   " " Play nice with supertab
   " let b:SuperTabDisabled=1
   " " Enable navigation with control-j and control-k in insert mode
   " imap <buffer> <C-j> <Plug>(unite_select_next_line)
   " imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction
autocmd FileType unite call s:unite_settings()
let g:unite_split_rule = 'botright'
Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/neoyank.vim'

Plugin 'tpope/vim-commentary'
Plugin 'pangloss/vim-javascript'
Plugin 'szw/vim-maximizer'
Plugin 'szw/vim-tags'

call vundle#end()            " required
filetype plugin indent on    " required

" NOTE: command line install:
" vim +PluginInstall +qall

" syntastic

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint', 'jshint']

" HACKY: see http://stackoverflow.com/questions/15937042/syntastic-disable-automatic-compilation-of-java
" maybe undo this if i switch from intellij
let g:loaded_syntastic_java_javac_checker = 1

"let g:rustfmt_autosave = 1

let g:tex_flavor='latex'

" for elm stuff
let g:elm_format_autosave = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:elm_syntastic_show_warnings = 1

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a single file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" http://vim.wikia.com/wiki/Mac_OS_X_clipboard_sharing
" set clipboard=unnamed

" control c copies to clipboard in visual mode
" no way to do command key in regular vim...
map <C-c> "+y

let mapleader = "\<Space>"
" faster switch buffers
nnoremap <C-J> <Esc>:bn<CR>
nnoremap <C-K> <Esc>:bp<CR>
" nnoremap <Leader>1 :b1<CR>
" nnoremap <Leader>2 :b2<CR>
" nnoremap <Leader>3 :b3<CR>
" nnoremap <Leader>4 :b4<CR>
" nnoremap <Leader>5 :b5<CR>
" nnoremap <Leader>6 :b6<CR>
" nnoremap <Leader>7 :b7<CR>
" nnoremap <Leader>8 :b8<CR>
" nnoremap <Leader>9 :b9<CR>
" nnoremap <Leader>0 :b10<CR>

" example of: switch Windows and maximize in one keypress
"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_
"map <C-H> <C-W>h<C-W>_
"map <C-L> <C-W>l<C-W>_

" for easymotion
" rebind leader to single key instead of 2
" map <Leader> <Plug>(easymotion-prefix)
" map <Leader>w <Plug>(easymotion-bd-w)
" map <Leader>t <Plug>(easymotion-bd-tl)
" map <Leader>f <Plug>(easymotion-bd-f)
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1

" NOTE: this must be near the end for some reason
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  " syntax on
  syntax enable
endif
let g:solarized_termcolors = 256
set background=dark
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
colorscheme solarized
" see: http://serverfault.com/questions/268555/how-to-tell-vim-to-extend-the-background-color-to-the-whole-screen
set t_ut=
