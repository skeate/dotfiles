" init.vim
" Author: Jonathan Skeate

" Basics ------------------------------------------------------------------- {{{

set showmode
set hidden
set visualbell
set undofile
set nolist
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
set spellfile=$XDG_DATA_HOME/vim/custom-dictionary.utf-8.add
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

set completeopt=longest,menuone

" Always show tabs
set showtabline=2

" Cursorline {{{

" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" }}}
" Trailing whitespace {{{
"
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

set backup
set noswapfile

set undodir=$XDG_CACHE_HOME/nvim/undo//     " undo files
set backupdir=$XDG_CACHE_HOME/nvim/backup// " backups

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

" setup vim-plug (including install if necessary) {{{

if !filereadable($XDG_DATA_HOME.'/vim/autoload/plug.vim')
  echo "Installing vim-plug..."
  echo ""
  silent !curl -fLo $XDG_DATA_HOME/vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

set rtp+=$XDG_CONFIG_HOME/vim/
set rtp+=$XDG_DATA_HOME/vim/
call plug#begin(expand('$XDG_DATA_HOME/vim/plugged/'))

" }}}

" general {{{

Plug 'tpope/vim-sensible'               " sensible defaults
Plug 'tpope/vim-repeat'                 " fix . repeating for plugins
Plug 'tpope/vim-surround'               " surround object with text/tags
Plug 'tpope/vim-vinegar'                " make netrw nicer
Plug 'flazz/vim-colorschemes'           " Color pack
Plug 'dracula/vim'                      " dracula theme
Plug 'bling/vim-airline'                " nice statusbar
Plug 'gcmt/taboo.vim'                   " tab renaming
Plug 'majutsushi/tagbar'                " tag browser
Plug 'tpope/vim-obsession'              " session management
Plug 'b4winckler/vim-angry'             " add function arg text object
Plug 'camelcasemotion'                  " camelcase motion with (eg) ,w
Plug 'Lokaltog/vim-easymotion'          " move around easier
Plug 'nathanaelkane/vim-indent-guides'  " show indent guides
Plug 'rking/ag.vim'                     " search in files
Plug 'terryma/vim-multiple-cursors'     " multiple cursors with <c-n>
Plug 'roman/golden-ratio'               " resize windows automatically
Plug 'sjl/gundo.vim'                    " show undo tree
Plug 'tommcdo/vim-lion'                 " align to character
Plug 'tpope/vim-fugitive'               " git support
Plug 'tpope/vim-unimpaired'             " add pairwise operators with [x ]x
Plug 'ctrlpvim/ctrlp.vim'               " fuzzy file finder
Plug 'jlanzarotta/bufexplorer'          " buffer list
Plug 'airblade/vim-gitgutter'           " show git changes in gutter
Plug 'editorconfig/editorconfig-vim'    " editor config reader
Plug 'scrooloose/syntastic'             " syntax checking
Plug 'Shougo/deoplete.nvim'             " neovim-compatible neocomplete
Plug 'Shougo/neosnippet.vim'            " snippets
Plug 'Shougo/neosnippet-snippets'       " collection of snippets
Plug 'Shougo/neco-syntax'               " syntax keywords in omnicmpl
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'colorizer'
Plug 'osyo-manga/vim-over'

" }}}
" Javascript & co. {{{

Plug 'carlitux/deoplete-ternjs',        { 'for': 'javascript' }
Plug 'pangloss/vim-javascript',         { 'for': 'javascript' }
Plug 'isRuslan/vim-es6',                { 'for': 'javascript' }
Plug 'heavenshell/vim-jsdoc',           { 'for': 'javascript' }
Plug 'dsawardekar/ember.vim',           { 'for': 'javascript' }
Plug 'bigfish/vim-js-context-coloring', { 'for': 'javascript', 'do': 'npm install --update' }

Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

Plug 'elzr/vim-json', { 'for': 'json' }

" }}}
" CSS & co. {{{

Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss'] }

Plug 'groenewege/vim-less', { 'for': 'less' }

" }}}
" HTML & co. {{{

Plug 'othree/html5.vim', { 'for': ['html', 'handlebars'] }
Plug 'mattn/emmet-vim', { 'for': ['html', 'handlebars'] }

Plug 'mustache/vim-mustache-handlebars', { 'for': 'handlebars' }

Plug 'tpope/vim-markdown', { 'for': 'markdown' }

" }}}
" Python {{{

Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent'     " fix python indenting

" }}}
" Miscellaneous {{{

Plug 'wizicer/vim-jison', { 'for': 'yacc' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }

" }}}
" End vim-plug {{{

call plug#end()

" }}}

" }}}
" Plugin Configuration ----------------------------------------------------- {{{

" Airline {{{

let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ }

" }}}
" bufexplorer {{{

let g:bufExplorerShowRelativePath=1

" }}}
" ctrlp {{{

let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.\?tmp$\|node_modules$\|bower_components$',
      \ 'file': '\.so$\|\.dat$\|\.DS_Store$'
      \ }

" }}}
" delimitMate {{{

let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1

" }}}
" deoplete {{{

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources._ = []

inoremap <silent><expr><Tab>
      \ pumvisible() ? "\<C-n>" :
      \ deoplete#manual_complete()
inoremap <silent><expr><S-Tab>
      \ pumvisible() ? "\<C-p>" :
      \ deoplete#manual_complete()
inoremap <expr><BS>
      \ deoplete#smart_close_popup() . "\<C-h>"

set wildignorecase

" }}}
" Golden Ratio {{{

" GR fucks up the text alignment when switching windows, so shift right on entry
autocmd VimEnter * :autocmd WinEnter * :normal ze

" }}}
" Gundo {{{

map <leader>g :GundoToggle<CR>

" }}}
" indent guides {{{

let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray15 ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=gray10 ctermbg=236

" }}}
" jsdoc {{{

let g:jsdoc_enable_es6 = 1
nmap <silent> <C-l> ?function<cr>:noh<cr><Plug>(jsdoc)

" }}}
" neosnippet {{{

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \ : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \ : "\<TAB>"

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
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_always_populate_loc_list = 1

" }}}
" Taboo {{{

nnoremap <leader>tr <Esc>:TabooRename<space>
nnoremap <leader>to <Esc>:TabooOpen<space>
let g:taboo_tab_format = " [%N %f]%m "
let g:taboo_renamed_tab_format = " [%N %l]%m "
set sessionoptions+=tabpages
set sessionoptions+=globals

" }}}
" Tagbar {{{

nmap <leader>T :TagbarOpenAutoClose<cr>

" }}}
" tern for vim {{{

let g:tern_show_signature_in_pum = 1

" }}}
" vim-autoformat {{{

noremap <leader>} :Autoformat<cr><cr>

" }}}
" vim-js-context-coloring {{{

let g:js_context_colors_enabled = 0
let g:js_context_colors_usemaps = 0
let g:js_context_colors_block_scope_with_let = 1
nnoremap <leader>cx :JSContextColorToggle<cr>

" }}}
" vim-obsession {{{

let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''$'', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])

" }}}
" vim-over {{{

function! VisualFindAndReplace()
    :OverCommandLine%s/
    :w
endfunction
function! VisualFindAndReplaceWithSelection() range
    :'<,'>OverCommandLine s/
    :w
endfunction

nnoremap <Leader>fr :call VisualFindAndReplace()<CR>
xnoremap <Leader>fr :call VisualFindAndReplaceWithSelection()<CR>

" }}}
" vim-vinegar {{{

" not really vinegar's fault, but netrw takes over last buffer, which is awkward
" behaviour; this fixes it
let g:netrw_altfile = 1

" }}}
" vimtex {{{

let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_latexmk_progname = 'nvr'

" }}}

" }}}
" Color scheme ------------------------------------------------------------- {{{

colorscheme hybrid
set background=dark

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}
" Abbreviations ------------------------------------------------------------ {{{

iabbrev ldis ಠ_ಠ
iabbrev lsad ಥ_ಥ
iabbrev lhap ಥ‿ಥ
iabbrev lmis ಠ‿ಠ

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

nmap <leader>a gLi{:

" }}}
" Quick editing ------------------------------------------------------------ {{{

nnoremap <leader>ev :vsplit ~/.local/etc/base/nvim/init.vim<cr>
nnoremap <leader>et :vsplit ~/.local/etc/base/tmux/tmux.conf<cr>
nnoremap <leader>ec :vsplit ~/.local/etc<cr>
nnoremap <leader>ez :vsplit ~/.local/etc/base/zsh<cr>

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

noremap <silent> <leader><space> :noh<cr>

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
    return line . ' ' . repeat(" ", fillcharcount) . foldedlinecount . ' '
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
augroup END

" }}}
" eslintrc {{{

augroup ft_eslintrc
  au!

  au BufNewFile,BufReadPost .eslintrc setl filetype=json
augroup END

" }}}
" HTML {{{

augroup ft_html
  au!

  au FileType html setlocal foldmethod=indent
  au FileType html let b:delimitMate_matchpairs = "(:),[:],{:}"

augroup END

" }}}
" Javascript {{{

augroup ft_javascript
  au!

  au BufNewFile,BufReadPost *.js setl foldmethod=indent
  "au BufEnter *.js call TextEnableCodeSnip('html', 'html`', '`;', 'Keyword')
augroup END

" }}}
" Markdown {{{

augroup ft_markdown
    au!

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

  au BufRead init.vim setlocal foldlevel=0
  au BufRead init.vim setlocal fdm=marker

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
    if mode() == "v"
      normal! "zygv
    else
      normal! "zyiw
    endif

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
function! UnHiInterestingWord(n) " {{{
    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)
endfunction " }}}

" Mappings {{{

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
vnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader><leader>1 :call UnHiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
vnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader><leader>2 :call UnHiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
vnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader><leader>3 :call UnHiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
vnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader><leader>4 :call UnHiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
vnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader><leader>5 :call UnHiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>
vnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>
nnoremap <silent> <leader><leader>6 :call UnHiInterestingWord(6)<cr>

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
" Copy Matches {{{

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

" }}}
" key check {{{

imap <buffer> <silent> <expr> <F12> Double("\<F12>")
function! Double(mymap)
  try
    let char = getchar()
  catch /^Vim:Interrupt$/
    let char = "\<Esc>"
  endtry
  "exec BPBreakIf(char == 32, 1)
  if char == '^\d\+$' || type(char) == 0
    let char = nr2char(char)
  endif " It is the ascii code.
  if char == "\<Esc>"
    return ''
  endif
  redraw
  return char.char."\<C-R>=Redraw()\<CR>".a:mymap
endfunction

function! Redraw()
  redraw
  return ''
endfunction

" }}}
" snippet highlighting {{{

function! TextEnableCodeSnip(filetype, start, end, textSnipHl) abort
  let ft = toupper(a:filetype)
  let group = 'textGroup' . ft
  if exists('b:current_syntax')
    let s:current_syntax = b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @' . group . ' syntax/' . a:filetype . '.vim'
  try
    execute 'syntax include @' . group . ' after/syntax/' . a:filetype . '.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax = s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip' . ft .
  \ ' matchgroup=' . a:textSnipHl .
  \ ' start="' . a:start . '" end="' . a:end . '"' .
  \ ' contains=@' . group
endfunction

" }}}

" }}}
" GUI/Terminal settings ---------------------------------------------------- {{{

if(has('gui_running'))
  set guioptions= " disable all guioptions
  set guifont=Inconsolata\ for\ Powerline:h11
endif

"}}}
" OS-specific settings ----------------------------------------------------- {{{

if has("win32")
  "Windows options here
else
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
      " Mac options here
      " Inconsolata is a bit small on osx
      set guifont=Inconsolata\ for\ Powerline:h13
      let g:python_host_prog = '/usr/local/bin/python2'
      let g:python3_host_prog = '/usr/local/bin/python3'
    else
      " linux options here
      " configure python path
      let g:python_host_prog = '/usr/bin/python2'
      let g:python3_host_prog = '/usr/bin/python3'
    endif
  endif
endif

" }}}
