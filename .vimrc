set guifont=fixedsys:h9
set ch=2
set encoding=utf-8
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

let c_comment_strings=1
syntax on
filetype plugin indent on

set hlsearch
set mousehide

highlight Normal          gui=NONE guibg=MidnightBlue  guifg=White
highlight NonText         gui=NONE guibg=blue4
highlight Comment         gui=NONE guibg=MidnightBlue  guifg=LightGreen
highlight Constant        gui=NONE guibg=grey20        guifg=LightPink
highlight Identifier      gui=NONE guibg=MidnightBlue  guifg=LightSkyBlue
highlight Statement       gui=NONE guibg=MidnightBlue  guifg=LightCyan
highlight PreProc         gui=NONE guibg=MidnightBlue  guifg=wheat
highlight Type            gui=NONE guibg=MidnightBlue  guifg=gold
highlight Special         gui=NONE guibg=grey20        guifg=RosyBrown
highlight Ignore          gui=NONE guibg=MidnightBlue  guifg=magenta4
highlight Error           gui=NONE guibg=Red           guifg=White
highlight Todo            gui=NONE guibg=grey20        guifg=orange

set fileencoding=korea
set bs=2

" for tab vs. space problems
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
set listchars=tab:>.,eol:$

set mouse=nc
set ttymouse=xterm2
set autoindent
set autowrite
set cindent
set nu
set nocompatible
set backspace=2
set bioskey
set cpoptions=cFs$
set helpheight=15
set infercase
set keywordprg=man\ -a
set laststatus=2
set notextmode
set ruler
set scrolloff=3

set shortmess=ao
set showbreak=+++\
set showmatch
set showmode
set sidescroll=8
set smartcase
set smarttab
set splitbelow
set nostartofline
set nowrap
set ttyscroll=5
"set whichwrap=<,>,[,]
set winheight=4
set cinoptions=:0,p0,t0,<1s
if &term =~ "xterm"
if has ("terminfo")
    set t_Co=8
    set t_Sf=p1%dm
    set t_Sb=p1%dm
else
    set t_Co=8
    set t_Sf=dm
    set t_Sb=dm
endif
endif
set bg=dark
let maplocalleader = "\\"
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## b13bd423c82d1c30b016df712f6061da ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/home/khheo/.opam/sparrow-4.04.0/share/vim/syntax/ocp-indent.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
