set nocompatible              " be iMproved, required
filetype off

call plug#begin(stdpath('data') . '/plugged')
Plug 'tpope/vim-sensible'
Plug 'rust-lang/rust.vim'
" Plug 'nanotech/jellybeans.vim'
Plug 'vim-syntastic/syntastic'
Plug 'NLKNguyen/papercolor-theme'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'majutsushi/tagbar'
Plug 'dag/vim-fish'
Plug 'tpope/vim-commentary'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" easytags is unmaintained and doesn't seem to work well with universal-ctags.
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-easytags'
" Plug 'universal-ctags/ctags'
" Plug 'ludovicchabant/vim-gutentags'
call plug#end()

filetype plugin indent on

" set laststatus=2              " always show split line even with one window
set autoread
set autowrite
set autowriteall
set backspace=indent,eol,start
set backupcopy=auto,breakhardlink
set cdpath=,~,~/src,..
set cmdheight=2
if version >= 700 && has("insert_expand")
        set completeopt=menu,preview
endif
" set dir=~/.vimswap
set display=lastline " show as much as will fit on last line, not just '@'
set expandtab
" set noequalalways
set foldmethod=indent nofoldenable
set foldminlines=4
set history=1000
nohlsearch " don't show whatever we were looking for last time until we search again
set hlsearch
set incsearch
set linebreak
set mouse=a
set nowrapscan
set number
" set numberwidth=8
set path=,./tests,~
set relativenumber
set noruler
set scrolljump=-25
set scrolloff=2
set shiftround
set showbreak=
set showcmd
set showmatch
set showmode
" set shortmess+=c
set suffixes+=.beam
set timeout& ttimeout&
set updatetime=100
set whichwrap=b,s,[,],<,>    " let arrows wrap around end of line
set wildignore+=*.py[co],*~
set wildignore+=*/target/debug/*
set wildignore+=*/target/package/*
set wildignore+=*/target/rls/*
set wildignore+=*/target/doc/*
set wildignore+=*/target/release/*
set wildignore+=*/.git/*
set wildmenu
set wildmode=longest:full,full
set wrapscan
set belloff=showmatch,esc

set rulerformat=%19(%03P\ %5l/%-5L\ %3v%)
" let &statusline = &rulerformat . "  %f\  #%n\ %m%w%h%y%r%=%{strftime(\"%a\ %l:%M%P\")}"
let &statusline = &rulerformat . "  %f  #%n\ %m%w%h%y%r "

set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" show arrows in current split marker
" set fillchars+=stl:^

syntax on

highlight RedundantWhitespace ctermbg=red guibg=red
match RedundantWhitespace /\s\+$\| \+\ze\t/

" c= automatic formatting of comments, but not text
" r = automatically insert comment leader when breaking
" o = automatically insert comment leader on opening line
" q = format comments with gq
" l = don't break existing long lines
autocmd FileType python setlocal ts=8 sw=4 et sts=4 fo=crqo tw=78 fdi= fdn=2 fdm=indent

autocmd FileType python set efm=\ \ File\ \"%f\"\\,\ line\ %l\\,\ %m

autocmd BufNewFile *.txt setlocal formatoptions=t tw=74
autocmd BufRead *.txt setlocal formatoptions=t tw=74

autocmd FileType erlang setlocal sts=4 et tw=72 fo+=oc comments=:%%%,:%%,:%

au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" default of going to ex mode not very useful, so instead Q formats text
map Q gq

" save
nmap <F4> :wa
imap <F4> :wa

" scan through grep/compile output
imap <F12> :cnext
imap <S-F12> :cprev
nmap <F12> :cnext
nmap <S-F12> :cprev

" save file
imap  :w
nmap  :w

filetype indent on
filetype plugin on

iabbrev shakse shakes
iabbrev perhasp perhaps
iabbrev todo: TODO:
iabbrev xxx: XXX:
iabbrev fixme: FIXME:
iabbrev teh the
iabbrev ot to
iabbrev erorr error
iabbrev nto not
iabbrev wuold would
iabbrev osmething something
iabbrev littel little
iabbrev abotu about
iabbrev combinaitons combinations

au! BufRead,BufNewFile *.moin set filetype=moin tw=0 lbr

let python_highlight_builtins = 1
let python_highlight_space_errors = 0
let python_highlight_exceptions = 1

set printoptions=syntax:a,formfeed:y
set printheader=%<%f%h%m%=%{strftime(\"%Y-%m-%d\ %a\ %l:%M%P\")}\ \ Page\ %N

" use space to page through files like less; inconsistent with
" regular vim but i like it
" nmap   

highlight MergeMarker guibg=red ctermbg=red
match MergeMarker /^[<=>\|]\{7\}\( [A-Z]\+\)?$/

highlight LineNr cterm=none
highlight Folded cterm=none

au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn

if &term == "screen"
        set t_ts=]2;
        set t_fs=
        set title
endif

if $USER != "root"
        set modeline
endif

" Use global as grep application
" set grepprg=global\ -x
" set grepformat=%*[^\ ]%*[\ ]%l%*[\ ]%f%*[\ ]%m

" map <silent> <C-\> :grep <C-R>=expand("<cword>")<CR><CR><CR>
" map <silent> <C-_> :grep! -r <C-R>=expand("<cword>")<CR><CR>:cw<CR>

imap <F5> :make
nmap <F5> :make

set background=dark

function! SlowTerminal()
        set noruler noshowcmd noshowmode nottyfast
        syntax off
        set cpoptions+=$
endfunction

highlight Pmenu ctermbg=blue cterm=NONE
highlight PmenuSel ctermbg=yellow cterm=bold ctermfg=blue

if has("spell")
        set spellfile=~/.vimspell.utf-8.add
endif

" Bazaarversion control
au BufNewFile,BufRead bzr_log.*    setf bzr

" Color terminal highlighting
highlight LineNr cterm=none
highlight Folded ctermbg=black ctermfg=green
highlight PreProc ctermfg=none cterm=bold
highlight StatusLine ctermbg=5 ctermfg=white cterm=bold

nmap <F7> :silent new \| silent nmap <buffer> <F7> :bdel 
 \| silent setlocal ft=diff nonu buftype=nofile noswapfile nowrap \| silent . !bzr diff

imap  <Home>
imap  <End>

function! PatchReviewMode()
        match Comment /^ .*/
        colorscheme morning
        highlight diffAdded guifg=#080
        highlight diffRemoved guifg=#600
        highlight Comment guifg=#444
endfunction

set runtimepath+=~/.vim.d/*

map <S-Insert> "+p
imap <S-Insert> "+p

" autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
"
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

colorscheme PaperColor

let g:airline_theme='papercolor'

set guicursor=n-v-c-sm:block,i-ci-ve:ver50-Cursor,r-cr-o:hor30,a:Cursor-blinkon100-blinkoff50-blinkwait200

let g:syntastic_always_populate_loc_list = 1
" 2 = auto close location list when no errors, but don't automatically open
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_cursor_columns = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump = 0

let g:rustfmt_autosave = 1
let g:rust_cargo_check_tests = 1
let g:rust_cargo_check_benches = 1
let g:rust_cargo_check_examples = 1

let g:ctrlp_switch_buffer = ''
let g:ctrlp_prompt_mappings = {
    \ 'PrtCurLeft()':         ['<c-h>', '<c-^>'],
    \ 'PrtCurRight()':        ['<c-l>'],
    \ 'ToggleType(1)':        ['<c-f>', '<c-up>', '<right>'],
    \ 'ToggleType(-1)':       ['<c-b>', '<c-down>', '<left>'],
    \ }
" Only cache in big directories, otherwise it's annoying when a file is
" added.
let g:ctrlp_use_caching = 10000
" let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:ctrlp_extensions = ['quickfix', 'dir', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir', 'autoignore']

""""""""""""""""""""""""""""""""""""""""""""""""""
" for vim-coc, from https://github.com/neoclide/coc.nvim

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <leader>rn <Plug>(coc-rename)

