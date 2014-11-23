set nocompatible

let g:netrw_list_hide = '\.DS_Store'

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
Plugin 'flazz/vim-colorschemes'           " Color pack (includes solarized)
Plugin 'bling/vim-airline'                " nice statusbar
Plugin 'Lokaltog/vim-easymotion'          " move around easier
Plugin 'camelcasemotion'                  " motion through words with (eg) ,w
Plugin 'gcmt/taboo.vim'                   " allow renaming of tabs
Plugin 'nathanaelkane/vim-indent-guides'  " show indent guides
Plugin 'SyntaxComplete'                   " add syntax keywords to omnicomplete
Plugin 'roman/golden-ratio'               " resize windows automatically
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-shell'

" general editing
Plugin 'tpope/vim-surround'               " surround object with text/tags
Plugin 'garbas/vim-snipmate'              " allow snippets
Plugin 'honza/vim-snippets'               " library of snippets
Plugin 'tommcdo/vim-lion'                 " align to character
Plugin 'scrooloose/nerdcommenter'         " comment code
Plugin 'tpope/vim-repeat'                 " fix . repeating for plugins
Plugin 'tpope/vim-unimpaired'             " add pairwise operators with [x ]x
Plugin 'b4winckler/vim-angry.git'         " add function arg text object
Plugin 'majutsushi/tagbar'                " tag browser

" project management
Plugin 'kien/ctrlp.vim'                   " find files quickly
Plugin 'editorconfig/editorconfig-vim'    " editor config reader
Plugin 'tpope/vim-fugitive'               " git support
Plugin 'tpope/vim-vinegar'                " use netrw more easily
Plugin 'dsawardekar/portkey'              " switch between related files quickly
Plugin 'mileszs/ack.vim'                  " search pwd for string

" python
Plugin 'jmcantrell/vim-virtualenv'

" web dev
Plugin 'marijnh/tern_for_vim'
Plugin 'jimmyhchan/dustjs.vim'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'mintplant/vim-literate-coffeescript'
Plugin 'clvv/a.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'jelera/vim-javascript-syntax'           " better syntax highlighting
Plugin 'pangloss/vim-javascript'                " some more syntax highlighting
Plugin 'dsawardekar/ember.vim'
Plugin 'othree/javascript-libraries-syntax.vim' " library syntax support

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
" -- literate coffeescript -- "
autocmd FileType litcoffee runtime ftplugin/coffee.vim
" -- syntastic -- "
" only check HTML if :SyntasticCheck called explicitly
" otherwise syntastic reports errors on HTML templates (eg handlebars)
let syntastic_mode_map = {'passive_filetypes': ['html']}
let g:syntastic_javascript_checkers = ['jshint']
" -- bufexplorer -- "
let g:bufExplorerShowRelativePath=1  " Show relative paths.
" -- vim-vinegar -- "
" not really vinegar's fault, but netrw takes over last buffer, which
" is awkward behaviour; this fixes
let g:netrw_altfile = 1
" -- taboo -- "
nnoremap <leader>tr <Esc>:TabooRename<space>
nnoremap <leader>to <Esc>:TabooOpen<space>
" -- golden-ratio -- "
" adjust view after switching
autocmd WinEnter * normal ze
let g:golden_ratio_exclude_nonmodifiable = 1
" -- YouCompleteMe -- "
let g:ycm_autoclose_preview_window_after_insertion = 1
" -- indent guides -- "
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
normal <leader>ig

" --- vim config --- "

" show 81st column for line wrapping guide
set colorcolumn=81

" splits open wrong side by default
set splitbelow
set splitright

" why
noremap Y y$

inoremap jj <esc>

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


" -- temp file storage -- "
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//
set undodir=~/.vim/undo//
set backupcopy=yes

" -- leader shortcuts -- "
map <leader>g :GundoToggle<CR>
" toggle whitespace
map <leader>s set list!<CR>
" Edit new file in directory of active window's file
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Paste line-wise and delete current line
nnoremap <leader>p pkdd

" -- color -- "
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

map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" split lines
"nnoremap KK i<CR><Esc>


set lazyredraw

set guioptions= " disable all guioptions


" --- GUI/Terminal settings --- "
if(has('gui_running'))
  set background=dark
  " not strictly airline, but related
  set guifont=Inconsolata\ for\ Powerline:h11
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
