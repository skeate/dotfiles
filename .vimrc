set nocompatible

" initialize some directories
if !isdirectory($HOME.'/.vim/swap')
  call mkdir($HOME.'/.vim/swap', 'p')
endif
if !isdirectory($HOME.'/.vim/undo')
  call mkdir($HOME.'/.vim/undo', 'p')
endif
if !isdirectory($HOME.'/.vim/backup')
  call mkdir($HOME.'/.vim/backup', 'p')
endif

" install neobundle if necessary
if !filereadable($HOME.'/.vim/bundle/neobundle.vim/README.md')
  echo "Installing NeoBundle..."
  echo ""
  if !isdirectory($HOME.'/.vim/bundle')
    call mkdir($HOME.'/.vim/bundle', 'p')
  endif
  silent !git clone https://github.com/Shougo/neobundle.vim
        \ ~/.vim/bundle/neobundle.vim
endif

" {{{ Plugins
filetype off
set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Plugins
" vim-related
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \    },
      \ }
NeoBundle 'tpope/vim-sensible'               " sensible defaults
NeoBundle 'jlanzarotta/bufexplorer'          " show buffers nicely
NeoBundle 'sjl/gundo.vim'                    " show undo tree
NeoBundle 'flazz/vim-colorschemes'           " Color pack
NeoBundle 'bling/vim-airline'                " nice statusbar
NeoBundle 'Lokaltog/vim-easymotion'          " move around easier
NeoBundle 'camelcasemotion'                  " camelcase motion with (eg) ,w
NeoBundle 'gcmt/taboo.vim'                   " tab renaming
NeoBundle 'nathanaelkane/vim-indent-guides'  " show indent guides
NeoBundle 'roman/golden-ratio'               " resize windows automatically
NeoBundle 'xolox/vim-misc'                   " required for vim-shell
NeoBundle 'xolox/vim-shell'                  " better integration with OS

" general editing
NeoBundle 'Shougo/unite.vim'                 " unified interface for lists
NeoBundle 'scrooloose/syntastic'             " syntax checking
NeoBundle 'SyntaxComplete'                   " syntax keywords in omnicomplete
NeoBundle 'tpope/vim-surround'               " surround object with text/tags
NeoBundle 'tommcdo/vim-lion'                 " align to character
NeoBundle 'scrooloose/nerdcommenter'         " comment code
NeoBundle 'tpope/vim-repeat'                 " fix . repeating for plugins
NeoBundle 'tpope/vim-unimpaired'             " add pairwise operators with [x ]x
NeoBundle 'b4winckler/vim-angry.git'         " add function arg text object
NeoBundle 'majutsushi/tagbar'                " tag browser
NeoBundle 'Raimondi/delimitMate'             " pair quotes/brackets/etc
NeoBundle 'Shougo/neocomplete.vim'           " autocompletion
NeoBundle 'Shougo/neosnippet.vim'            " snippets
NeoBundle 'Shougo/neosnippet-snippets'       " collection of snippets

" project management
NeoBundle 'tpope/vim-fugitive'               " git support
NeoBundle 'tpope/vim-vinegar'                " make netrw nicer
NeoBundle 'editorconfig/editorconfig-vim'    " editor config reader
NeoBundle 'dsawardekar/portkey'              " switch between related files

" python
NeoBundle 'jmcantrell/vim-virtualenv'

" web dev
NeoBundle 'mattn/emmet-vim'                        " <C-Y>, to expand html
NeoBundle 'jelera/vim-javascript-syntax'           " better syntax highlighting
NeoBundle 'pangloss/vim-javascript'                " more syntax highlighting
NeoBundle 'othree/javascript-libraries-syntax.vim' " library syntax support
NeoBundle 'marijnh/tern_for_vim'                   " JS autocomplete
NeoBundle 'tpope/vim-haml'                         " Haml, Sass, SCSS
NeoBundle 'othree/html5.vim'                       " HTML5 syntax/autocomplete
NeoBundle 'kchmck/vim-coffee-script'               " Coffeescript syntax &c.
NeoBundle 'hail2u/vim-css3-syntax'                 " CSS3 syntax &c.
NeoBundle 'mintplant/vim-literate-coffeescript'    " .litcoffee support
NeoBundle 'mustache/vim-mustache-handlebars'       " Handlebars syntax
NeoBundle 'dsawardekar/ember.vim'                  " Ember syntax/portkey
NeoBundle 'elzr/vim-json'                          " JSON syntax

" misc
NeoBundle 'tpope/vim-markdown'
NeoBundle 'wizicer/vim-jison'

call neobundle#end()
filetype plugin indent on
" Check for uninstalled bundles
NeoBundleCheck
" }}}

" {{{ Plugin Config
" bufexplorer
let g:bufExplorerShowRelativePath=1  " Show relative paths.
" ctrl-p
let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.?tmp$',
      \ 'file': '\.so$\|\.dat$\|\.DS_Store$'
      \}
" delimitMate
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1
" golden-ratio
let g:golden_ratio_exclude_nonmodifiable = 1
""" adjust view after switching
autocmd VimEnter * :autocmd WinEnter * :normal ze
" literate coffeescript
autocmd FileType litcoffee runtime ftplugin/coffee.vim
" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_fuzzy_completion = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\w*'
autocmd FileType javascript setlocal omnifunc=tern#Complete
" neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \ : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" syntastic
""" only check HTML if :SyntasticCheck called explicitly
""" otherwise syntastic reports errors on HTML templates (eg handlebars)
let syntastic_mode_map = {'passive_filetypes': ['html']}
" taboo
nnoremap <leader>tr <Esc>:TabooRename<space>
nnoremap <leader>to <Esc>:TabooOpen<space>
" vim-vinegar
""" not really vinegar's fault, but netrw takes over last buffer, which
""" is awkward behaviour; this fixes
let g:netrw_altfile = 1
" YouCompleteMe
"let g:ycm_autoclose_preview_window_after_completion = 1
" }}}

" {{{ vim config

" {{{ maps
" ctrl+(shift+)tab to switch tabs
nnoremap <C-Tab> gt
nnoremap <C-S-Tab> gT
inoremap <C-Tab> <Esc>gta
inoremap <C-S-Tab> <Esc>gTa
" ctrl+alt+(shift+)tab to move tabs
nnoremap <C-A-Tab> :tabmove +1<CR>
nnoremap <C-A-S-Tab> :tabmove -1<CR>
inoremap <C-A-Tab> <Esc>:tabmove +1<CR>a
inoremap <C-A-S-Tab> <Esc>:tabmove -1<CR>a

" ctrl+a to put in two lines (e.g. in {_})
imap <C-a> <CR><Esc>O

" make Y behave like it ought (cf d/D, c/C, etc)
noremap Y y$

" jk to go to normal mode
inoremap jk <esc>

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" -- leader shortcuts -- "
map <leader>g :GundoToggle<CR>
" toggle whitespace
map <leader>s :set list!<CR>
" Edit new file in directory of active window's file
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Paste line-wise and delete current line
nnoremap <leader>p pkdd

"}}}

" splits open wrong side by default
set splitbelow
set splitright

" -- temp file storage -- "
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//
set undodir=~/.vim/undo//
set backupcopy=yes

" -- color -- "
set t_Co=256
colorscheme hybrid

" http://items.sjbach.com/319/configuring-vim-right
" allows you to hide buffers without writing
set hidden
" ` is better, but ' is easier to type
nnoremap ' `
nnoremap ` '
set wildmode=longest:full,full " better autocomplete
" case-smart searching
set ignorecase
set smartcase
" better title for terminal vim
set title
" shorten up some messages
set shortmess=atI
" don't beep, flash instead
set visualbell
" prevent Insert key from triggering Replace mode
inoremap <Insert> <Nop>
set cul " highlight entire line where cursor is
set number " show line numbers


" -- tab config -- "
"  default: 2
"  <leader><tab> to switch to 4
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
function! ToggleIndent()
  if &tabstop=="2"
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    echo "indent set to 4"
  else
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set expandtab
    echo "indent set to 2"
  endif
endfunction
nnoremap <leader><Tab> :call ToggleIndent()<CR>

set nowrap

" code folding
set foldmethod=indent
set foldlevel=99

" window movement
map <C-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


set lazyredraw

set guioptions= " disable all guioptions

" --- GUI/Terminal settings --- "
if(has('gui_running'))
  set background=dark
  set guifont=Inconsolata\ for\ Powerline:h11 " not strictly airline, but related
  let g:airline_powerline_fonts = 1
else
  set background=light
endif

" --- OS-specific settings --- "
if has("win32")
  "Windows options here
else
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
      "Mac options here
      " Inconsolata is a bit small on osx
      set guifont=Inconsolata\ for\ Powerline:h13
    endif
  endif
endif


" vim: fdm=marker
