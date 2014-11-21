syntax on
set tabstop=4
set shiftwidth=4
set number
set numberwidth=5
set backspace=indent,eol,start
set autoindent
set smartindent
set incsearch
set ignorecase
set smartcase
set hlsearch

set list
set listchars=tab:>.,trail:_,nbsp:%,extends:>,precedes:<

set fileencoding=utf-8
set encoding=utf-8

set laststatus=2
set statusline=%F\ %h%m%r%w%=[%Y][%{(&fenc!=''?&fenc:&enc)}][%{&ff}]%8l,%-8(%c%V%)%4p%%

set nocompatible               " Be iMproved

if has('vim_starting')
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('$HOME/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
"NeoBundleLazy 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc'

" My Bundles here:
"
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'jdonaldson/vaxe'
NeoBundle 'dag/vim2hs'

filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

" For CoffeeScript
autocmd BufWritePost *.coffee silent :make
autocmd FileType coffee setl tabstop=2 expandtab shiftwidth=2 softtabstop=2

" For Haxe

autocmd BufEnter * execute 'lcd ' fnameescape(expand('%:p:h'))

" For Go

set rtp+=$GOROOT/misc/vim
