set nocompatible              " be iMproved, required
filetype off

call plug#begin(stdpath('data') . '/plugged')
Plug 'rust-lang/rust.vim'
Plug 'vim-airline/vim-airline'
Plug 'nanotech/jellybeans.vim'
Plug 'vim-syntastic/syntastic'
Plug 'NLKNguyen/papercolor-theme'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
call plug#end()

filetype plugin indent on

if filereadable("/usr/share/vim/google/google.vim")
  source /usr/share/vim/google/google.vim

  Glug youcompleteme-google
  Glug blaze
endif

" set laststatus=2		" always show split line even with one window
set autoread
set autowrite
set autowriteall
set backspace=indent,eol,start
set backupcopy=auto,breakhardlink
set cdpath=,~,~/bzr,~/work,..,./tests/
if version >= 700 && has("insert_expand")
	set completeopt=menu,preview
endif
" set dir=~/.vimswap
set display=lastline " show as much as will fit on last line, not just '@'
set expandtab
set noequalalways
set foldmethod=indent nofoldenable
set foldminlines=4
set history=1000
nohlsearch " don't show whatever we were looking for last time until we search again
set nohlsearch
set incsearch
set linebreak
set nowrapscan
set number
" set numberwidth=8
set path=,./tests,~
set noruler
set scrolljump=-25
set scrolloff=2
set shiftround
set showbreak=
set noshowcmd
set showmatch
set showmode
set suffixes+=.beam
set timeout& ttimeout&
set whichwrap=b,s,[,],<,>    " let arrows wrap around end of line
set wildignore+=*.py[co],*~
set wildmenu
set wildmode=longest:full,full
set nowrapscan
set belloff=showmatch,esc

set rulerformat=%19(%03P\ %5l/%-5L\ %3v%)
" let &statusline = &rulerformat . "  %f\  #%n\ %m%w%h%y%r%=%{strftime(\"%a\ %l:%M%P\")}"
let &statusline = &rulerformat . "  %f  #%n\ %m%w%h%y%r "

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
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

set guicursor=n-v-c-sm:block,i-ci-ve:ver50-Cursor,r-cr-o:hor30,a:Cursor-blinkon100-blinkoff50-blinkwait200

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:rustfmt_autosave = 1
let g:rust_cargo_check_tests = 1
let g:rust_cargo_check_benches = 1
let g:rust_cargo_check_examples = 1
