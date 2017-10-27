runtime! debian.vim

if has("syntax")
  syntax on
endif

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.

set number
set cursorline
set smartindent

set hlsearch

set clipboard=unnamedplus,autoselect

if has ("mouse")
	set mouse=a
	set guioptions+=a
	set ttymouse=xterm2
endif

if has('persistent_undo')
	set undodir=~/.vim/undo
	set undofile
endif

noremap <C-j> <esc>
noremap! <C-j> <esc>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/dein')
  call dein#begin('~/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  " call dein#add('The-NERD-tree')
  " call dein#add('taglist.vim')
  " call dein#add('https://github.com/wesleyche/SrcExpl.git')
  " call dein#add('https://github.com/wesleyche/Trinity.git')
  call dein#add('cohama/lexima.vim')
  call dein#add('tpope/vim-surround')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

" ctags
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let g:SrcExpl_updateTagsCmd = "/usr/bin/ctags --sort=foldcase -R ."
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=0
  set cst
  set nocsverb
  if filereadable("cscope.out")
    cs add cscope.out
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set csverb
  set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

