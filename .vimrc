set nocompatible

" Setup Vundle
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugins
" vim-related
Plugin 'jlanzarotta/bufexplorer'
Plugin 'sjl/gundo.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'relops'

" general editing
Plugin 'tpope/vim-surround'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'tommcdo/vim-lion'
Plugin 'scrooloose/nerdcommenter'

" project management
Plugin 'editorconfig/editorconfig-vim' " editor config reader
Plugin 'tpope/vim-fugitive'            " git support
Plugin 'kien/ctrlp.vim'                " find files quickly
Plugin 'tpope/vim-vinegar'             " use netrw more easily

" python
Plugin 'jmcantrell/vim-virtualenv'

" web dev
Plugin 'jimmyhchan/dustjs.vim'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'mintplant/vim-literate-coffeescript'
Plugin 'clvv/a.vim'
Plugin 'heartsentwined/vim-ember-script'
Plugin 'heartsentwined/vim-emblem'

" misc
Plugin 'tpope/vim-markdown'

call vundle#end()
filetype plugin indent on


" --- plugin config --- "
" -- ctrl-p -- "
let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.?tmp$',
      \ 'file': '\.so$\|\.dat$\|\.DS_Store$'
      \}
" -- airline -- "
set guifont=Inconsolata\ for\ Powerline:h11 " not strictly airline, but related
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" -- tabular -- "
vnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a: :Tabularize /:<CR>
vnoremap <Leader>a, :Tabularize /,<CR>


" --- leader shortcuts --- "
nnoremap <leader>c :call BackgroundSwap()<cr>
nnoremap <leader><Tab> :call ToggleIndent()<CR>
map <leader>g :GundoToggle<CR>
nmap <silent> <leader>s :set nolist!<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>q! :mksession! .\session.vis<CR>:conf qa<CR>
nnoremap <leader>r :so .\session.vis<CR>


set encoding=utf-8

" http://items.sjbach.com/319/configuring-vim-right
" allows you to hide buffers without writing
set hidden
" ` is better, but ' is easier to type
nnoremap ' `
nnoremap ` '
" default history is 50
set history=1000
" enable extended % matching - match if/elsif/else/end etc.
runtime macros/matchit.vim
" better autocomplete
set wildmenu
set wildmode=longest:full,full
" case-smart searching
set ignorecase
set smartcase
" better title for terminal vim
set title
" more cursor context
set scrolloff=3
" Intuitive backspacing in insert mode
set backspace=indent,eol,start
" File-type highlighting and configuration.
" Run :filetype (without args) to see what you may have
" to turn on yourself, or just set them all to be sure.
syntax on
filetype on
filetype plugin indent on
" Highlight search terms...
set hlsearch
set incsearch " ...dynamically as they are typed.
set listchars=tab:>-,trail:·,eol:$
" shorten up some messages
set shortmess=atI
" don't beep, flash instead
set visualbell
colorscheme solarized
" prevent Insert key from triggering Replace mode
inoremap <Insert> <Nop>
set cul " highlight entire line where cursor is
set number " show line numbers


" make tabs 2 characters
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

let python_highlight_all=1
set nowrap
" move swap files, ~ backups, and undo to a specific dir
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//
set undodir=~/.vim/undo//
set ssop-=options
set ssop-=folds

autocmd FileType litcoffee runtime ftplugin/coffee.vim

" code folding
set foldmethod=indent
set foldlevel=99

" window movement
map <C-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


set background=light
" solarized color swap
function! BackgroundSwap()
    if &background=="dark"
        set background=light
    else
        set background=dark
    endif
endfunction

set lazyredraw

set guioptions= " disable all guioptions

" --- OS-specific settings --- "
if has("win32")
  "Windows options here
  set rtp+=~/.vim/YouCompleteMe
else
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
      "Mac options here
    endif
  endif
endif
