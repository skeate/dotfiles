set nocompatible

" Setup Vundle
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugins
" vim-related
Plugin 'tpope/vim-sensible'               " sensible defaults
Plugin 'jlanzarotta/bufexplorer'          " show buffers nicely
Plugin 'sjl/gundo.vim'                    " show undo tree
Plugin 'scrooloose/syntastic'             " syntax checking
Plugin 'tomtom/tlib_vim'                  " utils, required for Snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'     " utils, req Snipmate
Plugin 'altercation/vim-colors-solarized' " nice colorscheme
Plugin 'bling/vim-airline'                " nice statusbar
Plugin 'Lokaltog/vim-easymotion'          " move around easier
Plugin 'camelcasemotion'                  " allow motion through camelcase words with (eg) ,w
Plugin 'gcmt/taboo.vim'                   " allow renaming of tabs

" general editing
Plugin 'tpope/vim-surround'               " surround object with text/tags
Plugin 'garbas/vim-snipmate'              " allow snippets
Plugin 'honza/vim-snippets'               " library of snippets
Plugin 'tommcdo/vim-lion'                 " align to character
Plugin 'scrooloose/nerdcommenter'         " comment code
Plugin 'tpope/vim-repeat'                 " fix . repeating for plugins
Plugin 'tpope/vim-unimpaired'             " add pairwise operators with [x ]x
Plugin 'b4winckler/vim-angry.git'         " add function arg text object

" project management
Plugin 'kien/ctrlp.vim'                   " find files quickly
Plugin 'editorconfig/editorconfig-vim'    " editor config reader
Plugin 'tpope/vim-fugitive'               " git support
Plugin 'tpope/vim-vinegar'                " use netrw more easily
Plugin 'dsawardekar/portkey'              " switch between related files quickly
Plugin 'mileszs/ack.vim'                  " search pwd for string

" web dev
Plugin 'jimmyhchan/dustjs.vim'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'mintplant/vim-literate-coffeescript'
Plugin 'clvv/a.vim'
Plugin 'dsawardekar/ember.vim'
Plugin 'mustache/vim-mustache-handlebars'

" misc
Plugin 'tpope/vim-markdown'

call vundle#end()
filetype plugin indent on

" Compiled plugins; separate these out so no issues if not installed yet
set rtp+=~/.vim/YouCompleteMe


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
" -- literate coffeescript -- "
autocmd FileType litcoffee runtime ftplugin/coffee.vim
" -- syntastic -- "
" only check HTML if :SyntasticCheck called explicitly
" otherwise syntastic reports errors on HTML templates (eg handlebars)
let syntastic_mode_map = {'passive_filetypes': ['html']}
" -- bufexplorer -- "
let g:bufExplorerShowRelativePath=1  " Show relative paths.
" -- vim-vinegar -- "
" not really vinegar's fault, but netrw takes over last buffer, which
" is awkward behaviour; this fixes
let g:netrw_altfile = 1

" --- vim config --- "

" splits open wrong side by default
set splitbelow
set splitright

" why
noremap Y y$

" -- temp file storage -- "
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//
set undodir=~/.vim/undo//

" -- leader shortcuts -- "
map <leader>g :GundoToggle<CR>
" toggle whitespace
map <leader>s set list!<CR>
" Edit new file in directory of active window's file
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Paste line-wise and delete current line
nnoremap <leader>p pkdd

" -- color -- "
set background=dark
colorscheme solarized

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

" OSX-specific setup
if has("unix")
  let s:name = system("uname -s")
  if s:name == "Darwin\n"
    " Inconsolata is a bit small on osx
    set guifont=Inconsolata\ for\ Powerline:h13
  endif
endif
