" https://github.com/marlomgirardi/MacOS

execute pathogen#infect() 

colorscheme monokai

syntax on
filetype plugin indent on

set backspace=2 "> make backspace work like most other programs
set tabstop=2 "> Tab size
set shiftwidth=2 "> Tab ident
set number "> Show line numbers
set relativenumber "> Calculate lines
set incsearch "> Show search in realtime
set hlsearch "> Highlight search
set fileencoding=utf-8 "> Set file encoding
set encoding=utf-8 "> Set read encoding
set expandtab "> Use space on tab
set softtabstop=2 "> fix spacing tab
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_ "> Show “invisible” characters
set ignorecase "> Ignore case of searches
set mouse=a "> Enable mouse in all modes
set showmode "> Show the current mode
set title "> Show the filename in the window titlebar
set showcmd "> Show the (partial) command as it’s being typed

" Plugins config

" https://vimawesome.com/plugin/vim-javascript
let g:javascript_plugin_jsdoc=1 "> enables syntax highlighting for JSDocs
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"

" https://vimawesome.com/plugin/markdown-syntax
let g:vim_markdown_fenced_languages = ['viml=vim', 'bash=sh', 'javascript=js']

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

set backupskip=/tmp/*,/private/tmp/* "> Don’t create backups when editing files in certain directories

