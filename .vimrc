set nocompatible

" Setup Vundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
filetype off
set rtp+=~/vimfiles/bundle/vundle/
let path='~/vimfiles/bundle'
call vundle#rc(path)
Bundle 'gmarik/vundle'

" Bundles
" vim-related
Bundle 'jlanzarotta/bufexplorer'
Bundle 'sjl/gundo.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tomtom/tlib_vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
Bundle 'Lokaltog/vim-easymotion'

" general editing
Bundle 'tpope/vim-surround'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'godlygeek/tabular'
Bundle 'scrooloose/nerdcommenter'

" project management
Bundle 'editorconfig/editorconfig-vim'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'

" web dev
Bundle 'jimmyhchan/dustjs.vim'
Bundle 'mattn/emmet-vim'
Bundle 'othree/html5.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'mintplant/vim-literate-coffeescript'
Bundle 'clvv/a.vim'
Bundle 'heartsentwined/vim-ember-script'
Bundle 'heartsentwined/vim-emblem'

" misc
Bundle 'tpope/vim-markdown'


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
" move swap files and ~ backups to a specific dir
set directory=~/vimfiles/backup/
set backupdir=~/vimfiles/backup/
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
