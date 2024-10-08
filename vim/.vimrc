runtime! debian.vim

if has("syntax")
  syntax on
endif

set showcmd		" Show (partial) command in status line.
set showmatch	" Show matching brackets.

set number
set cursorline
set smartindent

filetype indent plugin on
set tabstop=4
set shiftwidth=4

set hlsearch

if has("clipboard")
    set clipboard^=unnamedplus,autoselect
endif

if has("mouse")
	set mouse=a
	set guioptions+=a
	" set ttymouse=xterm2
endif

if has('persistent_undo')
	set undodir=~/.vim/undo
	set undofile
endif

noremap <C-j> <esc>
noremap! <C-j> <esc>
noremap <Tab> gt
noremap <S-Tab> gT
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

highlight Comment ctermfg=Green

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
if filereadable(expand('~/.vimrc.dein'))
  source ~/.vimrc.dein
endif
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

" Powerline settings
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2
set showtabline=2
set noshowmode
