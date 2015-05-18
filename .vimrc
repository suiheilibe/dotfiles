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

if has('vim_starting')
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
  set rtp+=$GOROOT/misc/vim
endif

syntax on

call neobundle#begin(expand('$HOME/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleLazy 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc'

" My Bundles here:
"
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'jdonaldson/vaxe'
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'lambdatoast/elm.vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'jason0x43/vim-js-indent'
NeoBundleLazy 'Shougo/unite.vim', {
\   'autoload' : {
\       'commands' : [ "Unite", "UniteWithCursorWord" ]
\   }
\}
NeoBundle 'ujihisa/unite-haskellimport'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'cohama/vim-hier'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'raichoo/haskell-vim'
NeoBundle 'enomsg/vim-haskellConcealPlus'

" End of NeoBundle
call neobundle#end()

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

augroup coffee
autocmd!
autocmd BufWritePost *.coffee silent :make
autocmd QuickFixCmdPost * nested cwindow | redraw!
autocmd FileType coffee setl tabstop=2 expandtab shiftwidth=2 softtabstop=2
augroup END

" For Haxe

augroup haxe
autocmd!
autocmd BufEnter * execute 'lcd ' fnameescape(expand('%:p:h'))
augroup END

" For Go

" neocomplete

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
	\ 'default' : '',
	\ 'vimshell' : $HOME.'/.vimshell_hist',
	\ 'scheme' : $HOME.'/.gosh_completions'
\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" For Haskell

augroup haskell
autocmd!
autocmd FileType haskell setl tabstop=4 expandtab softtabstop=4 shiftwidth=4 shiftround
augroup END

let g:hscoptions="liRtBQZ"

" For TypeScript

" typescript-vim
let g:typescript_compiler_options = ' --module commonjs --target ES5 --noImplicitAny'

augroup typescript
autocmd!
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
autocmd FileType typescript setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
augroup END

" watchdogs.vim setting
"let g:watchdogs_check_BufWritePost_enable = 1
let g:watchdogs_check_BufWritePost_enables = {
\   "typescript" : 1
\}

"let g:watchdogs_check_CursorHold_enable = 1
let g:watchdogs_check_CursorHold_enables = {
\   "typescript" : 1
\}

if !exists("g:quickrun_config")
    let g:quickrun_config = {}
endif
let g:quickrun_config["watchdogs_checker/_"] = {
\	"hook/copen/enable_exist_data" : 1,
\	"hook/back_window/enable_exit" : 1,
\	"hook/back_window/priority_exit" : 100,
\}
let g:quickrun_config["watchdogs_checker/tsc"] = {
\	"exec"		: "%c %o %s:p",
\	"cmdopt"	: "--module commonjs --target ES5 --noImplicitAny",
\}
