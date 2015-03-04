" .vimrc
" Author: Jonathan Skeate
" https://github.com/skeate/dotfiles/blob/master/.vimrc
" Significant chunks based on Steve Losh's @
" http://bitbucket.org/sjl/dotfiles/src/tip/vim/
" Less significant chunks from other places

" Basics ------------------------------------------------------------------- {{{
set nocompatible
set showmode
set hidden
set visualbell
set undofile
set list
set lazyredraw
set splitbelow
set splitright
set autowrite
set shiftround
set title
set linebreak
set shortmess=atI
set cursorline
set number
set nowrap

" Spelling
set dictionary=/usr/share/dict/words
set spellfile=~/.vim/custom-dictionary.utf-8.add,~/.vim-local-dictionary.utf-8.add
nnoremap zG 2zg

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"

" Save when losing focus
au FocusLost * :silent! wall

" Leader
let mapleader = "\\"
let maplocalleader = ","

" Cursorline {{{
" Only show cursorline in the current window and in normal mode.

augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" }}}
" Trailing whitespace {{{
" Only shown when not in insert mode

augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" }}}
" Wildmenu completion {{{
set wildmode=longest:full,full

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files
" }}}
" Tabs, spaces, wrapping {{{

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set textwidth=80
set formatoptions=crqn1j
set colorcolumn=+1

" }}}
" Backups {{{

set backup                        " enable backups
set noswapfile                    " it's 2013, Vim.

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" }}}

" }}}
" Plugins ------------------------------------------------------------------ {{{

" setup neobundle (including install if necessary) {{{

if !filereadable($HOME.'/.vim/bundle/neobundle.vim/README.md')
  echo "Installing NeoBundle..."
  echo ""
  if !isdirectory($HOME.'/.vim/bundle')
    call mkdir($HOME.'/.vim/bundle', 'p')
  endif
  silent !git clone https://github.com/Shougo/neobundle.vim
        \ ~/.vim/bundle/neobundle.vim
endif

filetype off
set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" }}}
" vim-specific {{{

NeoBundle 'tpope/vim-sensible'               " sensible defaults
NeoBundle 'flazz/vim-colorschemes'           " Color pack
NeoBundle 'bling/vim-airline'                " nice statusbar
NeoBundle 'xolox/vim-misc'                   " required for vim-shell
NeoBundle 'xolox/vim-shell'                  " better integration with OS
NeoBundle 'gcmt/taboo.vim'                   " tab renaming
NeoBundle 'majutsushi/tagbar'                " tag browser
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \    },
      \ }
NeoBundle 'YankRing.vim'                     " yank/delete/change memory

" }}}
" Movement {{{

NeoBundle 'b4winckler/vim-angry.git'         " add function arg text object
NeoBundle 'camelcasemotion'                  " camelcase motion with (eg) ,w
NeoBundle 'Lokaltog/vim-easymotion'          " move around easier
NeoBundle 'nathanaelkane/vim-indent-guides'  " show indent guides
NeoBundle 'mileszs/ack.vim'                  " find in files
NeoBundle 'rking/ag.vim'                     " same-ish as above but with ag!

" }}}
" Management {{{

NeoBundle 'dsawardekar/portkey'              " switch between related files
NeoBundle 'roman/golden-ratio'               " resize windows automatically
NeoBundle 'sjl/gundo.vim'                    " show undo tree
NeoBundle 'tommcdo/vim-lion'                 " align to character
NeoBundle 'tpope/vim-fugitive'               " git support
NeoBundle 'tpope/vim-repeat'                 " fix . repeating for plugins
NeoBundle 'tpope/vim-surround'               " surround object with text/tags
NeoBundle 'tpope/vim-unimpaired'             " add pairwise operators with [x ]x
NeoBundle 'tpope/vim-vinegar'                " make netrw nicer
NeoBundle 'kien/ctrlp.vim'                   " fuzzy file finder
NeoBundle 'jlanzarotta/bufexplorer'          " buffer list

" }}}
" Syntax & Autocomplete {{{

NeoBundle 'dsawardekar/ember.vim'                  " Ember syntax/portkey
NeoBundle 'editorconfig/editorconfig-vim'          " editor config reader
NeoBundle 'elzr/vim-json'                          " JSON syntax
NeoBundle 'hail2u/vim-css3-syntax'                 " CSS3 syntax &c.
NeoBundle 'jelera/vim-javascript-syntax'           " better syntax highlighting
NeoBundle 'kchmck/vim-coffee-script'               " Coffeescript syntax &c.
NeoBundle 'marijnh/tern_for_vim'                   " JS autocomplete
NeoBundle 'mintplant/vim-literate-coffeescript'    " .litcoffee support
NeoBundle 'mustache/vim-mustache-handlebars'       " Handlebars syntax
NeoBundle 'othree/html5.vim'                       " HTML5 syntax/autocomplete
NeoBundle 'othree/javascript-libraries-syntax.vim' " library syntax support
NeoBundle 'pangloss/vim-javascript'                " more syntax highlighting
NeoBundle 'scrooloose/syntastic'                   " syntax checking
NeoBundle 'Shougo/neocomplete.vim'                 " autocompletion
NeoBundle 'Shougo/neosnippet-snippets'             " collection of snippets
NeoBundle 'Shougo/neosnippet.vim'                  " snippets
NeoBundle 'SyntaxComplete'                         " syntax keywords in omnicmpl
NeoBundle 'tpope/vim-haml'                         " Haml, Sass, SCSS
NeoBundle 'groenewege/vim-less'                    " LESS
NeoBundle 'tpope/vim-markdown'                     " Markdown syntax
NeoBundle 'wizicer/vim-jison'                      " Jison (Bison/Flex) syntax

" }}}
" Code Assist {{{

NeoBundle 'mattn/emmet-vim'                  " <C-Y>, to expand html
NeoBundle 'scrooloose/nerdcommenter'         " comment code
NeoBundle 'Raimondi/delimitMate'             " pair quotes/brackets/etc
NeoBundle 'Chiel92/vim-autoformat'           " auto format/beautify code
NeoBundle 'colorizer'                        " highlight hex colors

" }}}
" End neobundle, check for updates {{{

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" }}}

" }}}
" Plugin Configuration ----------------------------------------------------- {{{

" Airline {{{

if(has('gui_running'))
  let g:airline_powerline_fonts = 1
endif

" }}}
" bufexplorer {{{

let g:bufExplorerShowRelativePath=1

" }}}
" ctrlp {{{

let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.?tmp$',
      \ 'file': '\.so$\|\.dat$\|\.DS_Store$'
      \ }

" }}}
" delimitMate {{{
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1
" }}}
" Golden Ratio {{{

" GR fucks up the text alignment when switching windows, so shift right on entry
autocmd VimEnter * :autocmd WinEnter * :normal ze

" }}}
" Gundo {{{

map <leader>g :GundoToggle<CR>

" }}}
" neocomplete {{{

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
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
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

" }}}
" neosnippet {{{
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
" }}}
" Syntastic {{{
""" only check HTML if :SyntasticCheck called explicitly
""" otherwise syntastic reports errors on HTML templates (eg handlebars)
let g:syntastic_mode_map = {'passive_filetypes': ['html']}
let g:syntastic_aggregate_errors = 1
let g:syntastic_javascript_checkers=['jshint','jscs']
" }}}
" Taboo {{{

nnoremap <leader>tr <Esc>:TabooRename<space>
nnoremap <leader>to <Esc>:TabooOpen<space>

" }}}
" vim-autoformat {{{

noremap <leader>} :Autoformat<cr><cr>

" }}}
" vim-vinegar {{{

" not really vinegar's fault, but netrw takes over last buffer, which is awkward
" behaviour; this fixes it
let g:netrw_altfile = 1

" }}}

" }}}
" Color scheme ------------------------------------------------------------- {{{

set t_Co=256
set background=dark
colorscheme hybrid

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}
" Abbreviations ------------------------------------------------------------ {{{

iabbrev ldis ಠ_ಠ
iabbrev lsad ಥ_ಥ
iabbrev lhap ಥ‿ಥ
iabbrev lmis ಠ‿ಠ

iabbrev vrcf `~/.vimrc` file

" }}}
" Convenience mappings ----------------------------------------------------- {{{

" <leader>Tab to change indentation
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

" Edit new file in directory of active window's file
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Make Y behave like it ought
noremap Y y$

" Fuck you, help key.
noremap  <F1> :checktime<cr>
inoremap <F1> <esc>:checktime<cr>

" Kill window
nnoremap K :q<cr>

" Man
nnoremap M K

" Toggle line numbers
nnoremap <leader>n :setlocal number!<cr>

" Sort lines
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>

" Tabs
" ctrl+(shift+)tab to switch tabs
nnoremap <C-Tab> gt
nnoremap <C-S-Tab> gT
inoremap <C-Tab> <Esc>gt
inoremap <C-S-Tab> <Esc>gT
" ctrl+alt+(shift+)tab to move tabs
nnoremap <C-A-Tab> :tabmove +1<CR>
nnoremap <C-A-S-Tab> :tabmove -1<CR>
inoremap <C-A-Tab> <Esc>:tabmove +1<CR>
inoremap <C-A-S-Tab> <Esc>:tabmove -1<CR>

" Wrap
nnoremap <leader>W :set wrap!<cr>

" Rebuild Ctags (mnemonic RC -> CR -> <cr>)
nnoremap <leader><cr> :silent !myctags >/dev/null 2>&1 &<cr>:redraw!<cr>

" Highlight Group(s)
nnoremap <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

" "Uppercase word" mapping.
"
" This mapping allows you to press <c-u> in insert mode to convert the current
" word to uppercase.  It's handy when you're writing names of constants and
" don't want to use Capslock.
"
" To use it you type the name of the constant in lowercase.  While your
" cursor is at the end of the word, press <c-u> to uppercase it, and then
" continue happily on your way:
"
"                            cursor
"                            v
"     max_connections_allowed|
"     <c-u>
"     MAX_CONNECTIONS_ALLOWED|
"                            ^
"                            cursor
"
" It works by exiting out of insert mode, recording the current cursor location
" in the z mark, using gUiw to uppercase inside the current word, moving back to
" the z mark, and entering insert mode again.
"
" Note that this will overwrite the contents of the z mark.  I never use it, but
" if you do you'll probably want to use another mark.
inoremap <C-u> <esc>mzgUiw`za

" Panic Button -- rot13s file
nnoremap <f9> mzggg?G`z

" zt is okay for putting something at the top of the screen, but when I'm
" writing prose I often want to put something at not-quite-the-top of the
" screen.  zh is "zoom to head level"
nnoremap zh mzzt10<c-u>`z

" Formatting, TextMate-style
nnoremap Q gqip
vnoremap Q gq

" Reformat line.
" I never use l as a macro register anyway.
nnoremap ql gqq

" Easier linewise reselection of what you just pasted.
nnoremap <leader>V V`]

" Indent/dedent/autoindent what you just pasted.
nnoremap <lt>> V`]<
nnoremap ><lt> V`]>
nnoremap =- V`]=

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Source
vnoremap <leader>S y:@"<CR>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" Marks and Quotes
noremap ' `
noremap æ '
noremap ` <C-^>

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Typos
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" Toggle paste
" For some reason pastetoggle doesn't redraw the screen (thus the status bar
" doesn't change) while :set paste! does, so I use that instead.
" set pastetoggle=<F6>
nnoremap <F6> :set paste!<cr>

" Toggle [i]nvisible characters
nnoremap <leader>i :set list!<cr>

" Unfuck my screen
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

" Zip Right
"
" Moves the character under the cursor to the end of the line.  Handy when you
" have something like:
"
"     foo
"
" And you want to wrap it in a method call, so you type:
"
"     println()foo
"
" Once you hit escape your cursor is on the closing paren, so you can 'zip' it
" over to the right with this mapping.
"
" This should preserve your last yank/delete as well.
nnoremap zl :let @z=@"<cr>x$p:let @"=@z<cr>

" }}}
" Quick editing ------------------------------------------------------------ {{{

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>eV :vsplit scp://vagrant//<cr>
nnoremap <leader>ed :vsplit ~/.vim/custom-dictionary.utf-8.add<cr>
nnoremap <leader>eg :vsplit ~/.gitconfig<cr>
nnoremap <leader>et :vsplit ~/.tmux.conf<cr>

" }}}
" Searching and movement --------------------------------------------------- {{{

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set hlsearch
set gdefault

set scrolloff=3
set sidescroll=1
set sidescrolloff=10

set virtualedit+=block

noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

runtime macros/matchit.vim
map <tab> %
silent! unmap [%
silent! unmap ]%

" Jumping to tags.
"
" Basically, <c-]> jumps to tags (like normal) and <c-\> opens the tag in a new
" split instead.
"
" Both of them will align the destination line to the upper middle part of the
" screen.  Both will pulse the cursor line so you can see where the hell you
" are.  <c-\> will also fold everything in the buffer and then unfold just
" enough for you to see the destination line.
function! JumpToTag()
    execute "normal! \<c-]>mzzvzz15\<c-e>"
    execute "keepjumps normal! `z"
    Pulse
endfunction
function! JumpToTagInSplit()
    execute "normal! \<c-w>v\<c-]>mzzMzvzz15\<c-e>"
    execute "keepjumps normal! `z"
    Pulse
endfunction
nnoremap <c-]> :silent! call JumpToTag()<cr>
nnoremap <c-\> :silent! call JumpToTagInSplit()<cr>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz
nnoremap <c-i> <c-i>zz

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.

" Fix linewise visual selection of various text objects
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" Directional Keys {{{

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" }}}
" Visual Mode */# from Scrooloose {{{

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" }}}

" }}}
" Folding ------------------------------------------------------------------ {{{

set foldmethod=marker
set foldlevelstart=99

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}
" Filetype-specific -------------------------------------------------------- {{{

" C {{{

augroup ft_c
    au!
    au FileType c setlocal foldmethod=marker foldmarker={,}
augroup END

" }}}
" Coffeescript {{{

" Include :Coffee commands in litcoffee files
autocmd FileType litcoffee runtime ftplugin/coffee.vim
" Use indent folding
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent
autocmd BufNewFile,BufReadPost *.litcoffee setl foldmethod=indent

" }}}
" CSS and Sass {{{

augroup ft_css
    au!

    au Filetype scss,sass,css setlocal foldmethod=marker
    au Filetype scss,sass,css setlocal foldmarker={,}
    au Filetype scss,sass,css setlocal omnifunc=csscomplete#CompleteCSS
    au Filetype scss,sass,css setlocal iskeyword+=-

    " Use <leader>S to sort properties.  Turns this:
    "
    "     p {
    "         width: 200px;
    "         height: 100px;
    "         background: red;
    "
    "         ...
    "     }
    "
    " into this:

    "     p {
    "         background: red;
    "         height: 100px;
    "         width: 200px;
    "
    "         ...
    "     }
    au BufNewFile,BufRead *.scss,*.sass,*.css nnoremap <buffer>
          \ <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au BufNewFile,BufRead *.scss,*.sass,*.css inoremap <buffer>
          \ {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END

" }}}
" Javascript {{{

let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\w*'
augroup ft_javascript
  au!

  au FileType javascript setlocal omnifunc=tern#Complete
  au BufNewFile,BufReadPost *.js setl foldmethod=indent
augroup END

" }}}
" Markdown {{{

augroup ft_markdown
    au!

    au BufNewFile,BufRead *.m*down setlocal filetype=markdown foldlevel=1

    " Use <localleader>1/2/3 to add headings.
    au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=:redraw<cr>
    au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>
    au Filetype markdown nnoremap <buffer> <localleader>3 mzI###<space><esc>`zllll
    au Filetype markdown nnoremap <buffer> <localleader>4 mzI####<space><esc>`zlllll
augroup END

" }}}
" Vim {{{

augroup vim
  au!

  au BufRead *.vimrc setlocal foldlevel=0

augroup END

" }}}

" }}}
" Text objects ------------------------------------------------------------- {{{

" Next and Last {{{
"
" Motion for "next/last object".  "Last" here means "previous", not "final".
" Unfortunately the "p" motion was already taken for paragraphs.
"
" Next acts on the next object of the given type, last acts on the previous
" object of the given type.  These don't necessarily have to be in the current
" line.
"
" Currently works for (, [, {, and their shortcuts b, r, B.
"
" Next kind of works for ' and " as long as there are no escaped versions of
" them in the string (TODO: fix that).  Last is currently broken for quotes
" (TODO: fix that).
"
" Some examples (C marks cursor positions, V means visually selected):
"
" din'  -> delete in next single quotes                foo = bar('spam')
"                                                      C
"                                                      foo = bar('')
"                                                                C
"
" canb  -> change around next parens                   foo = bar('spam')
"                                                      C
"                                                      foo = bar
"                                                               C
"
" vin"  -> select inside next double quotes            print "hello ", name
"                                                       C
"                                                      print "hello ", name
"                                                             VVVVVV

onoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>

onoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>


function! s:NextTextObject(motion, dir)
    let c = nr2char(getchar())
    let d = ''

    if c ==# "b" || c ==# "(" || c ==# ")"
        let c = "("
    elseif c ==# "B" || c ==# "{" || c ==# "}"
        let c = "{"
    elseif c ==# "r" || c ==# "[" || c ==# "]"
        let c = "["
    elseif c ==# "'"
        let c = "'"
    elseif c ==# '"'
        let c = '"'
    else
        return
    endif

    " Find the next opening-whatever.
    execute "normal! " . a:dir . c . "\<cr>"

    if a:motion ==# 'a'
        " If we're doing an 'around' method, we just need to select around it
        " and we can bail out to Vim.
        execute "normal! va" . c
    else
        " Otherwise we're looking at an 'inside' motion.  Unfortunately these
        " get tricky when you're dealing with an empty set of delimiters because
        " Vim does the wrong thing when you say vi(.

        let open = ''
        let close = ''

        if c ==# "("
            let open = "("
            let close = ")"
        elseif c ==# "{"
            let open = "{"
            let close = "}"
        elseif c ==# "["
            let open = "\\["
            let close = "\\]"
        elseif c ==# "'"
            let open = "'"
            let close = "'"
        elseif c ==# '"'
            let open = '"'
            let close = '"'
        endif

        " We'll start at the current delimiter.
        let start_pos = getpos('.')
        let start_l = start_pos[1]
        let start_c = start_pos[2]

        " Then we'll find it's matching end delimiter.
        if c ==# "'" || c ==# '"'
            " searchpairpos() doesn't work for quotes, because fuck me.
            let end_pos = searchpos(open)
        else
            let end_pos = searchpairpos(open, '', close)
        endif

        let end_l = end_pos[0]
        let end_c = end_pos[1]

        call setpos('.', start_pos)

        if start_l == end_l && start_c == (end_c - 1)
            " We're in an empty set of delimiters.  We'll append an "x"
            " character and select that so most Vim commands will do something
            " sane.  v is gonna be weird, and so is y.  Oh well.
            execute "normal! ax\<esc>\<left>"
            execute "normal! vi" . c
        elseif start_l == end_l && start_c == (end_c - 2)
            " We're on a set of delimiters that contain a single, non-newline
            " character.  We can just select that and we're done.
            execute "normal! vi" . c
        else
            " Otherwise these delimiters contain something.  But we're still not
            " sure Vim's gonna work, because if they contain nothing but
            " newlines Vim still does the wrong thing.  So we'll manually select
            " the guts ourselves.
            let whichwrap = &whichwrap
            set whichwrap+=h,l

            execute "normal! va" . c . "hol"

            let &whichwrap = whichwrap
        endif
    endif
endfunction

" }}}
" Numbers {{{

" Motion for numbers.  Great for CSS.  Lets you do things like this:
"
" margin-top: 200px; -> daN -> margin-top: px;
"              ^                          ^
" TODO: Handle floats.

onoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
xnoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
onoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
onoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>

function! s:NumberTextObject(whole)
    let num = '\v[0-9]'

    " If the current char isn't a number, walk forward.
    while getline('.')[col('.') - 1] !~# num
        normal! l
    endwhile

    " Now that we're on a number, start selecting it.
    normal! v

    " If the char after the cursor is a number, select it.
    while getline('.')[col('.')] =~# num
        normal! l
    endwhile

    " If we want an entire word, flip the select point and walk.
    if a:whole
        normal! o

        while col('.') > 1 && getline('.')[col('.') - 2] =~# num
            normal! h
        endwhile
    endif
endfunction

" }}}

" }}}
" Mini-Plugins ------------------------------------------------------------- {{{

" Highlight Word {{{
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n) " {{{
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction " }}}

" Mappings {{{

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

" }}}
" Default Highlights {{{

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" }}}

" }}}
" netrw tree drawer {{{

function! OpenNetrwInDrawer()
  silent! exec 'topleft vertical 30 new'
  silent! exec 'edit .'
  silent! exec 'normal iii'
endfunction
nnoremap <leader>d :<C-u>call OpenNetrwInDrawer()<CR>

" }}}

" }}}
" GUI/Terminal settings ---------------------------------------------------- {{{

if(has('gui_running'))
  set guioptions= " disable all guioptions
  set guifont=Inconsolata\ for\ Powerline:h11 " not strictly airline, but related
endif

"}}}
" OS-specific settings ----------------------------------------------------- {{{

if has("win32")
  "Windows options here
else
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
      "Mac options here
      " Inconsolata is a bit small on osx
      set guifont=Inconsolata\ for\ Powerline:h13
    else
      set guifont=Inconsolata-g\ for\ Powerline
    endif
  endif
endif

" }}}
