" set title
" set statusline=%F%r%h%=
" set nohlsearch

let mapleader = "\<Space>"
filetype on
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932
set number
set relativenumber
set noswapfile
set showmatch
set laststatus=2
set smartindent
set cindent
set expandtab
set tabstop=2
set shiftwidth=2
set wrapscan
set cursorline
set nowrap
highlight CursorLine cterm=NONE ctermbg=black

" <BS>が効かなくなる問題の対応
set backspace=indent,eol,start

nmap <C-c> <ESC>

" プラグインのhook配置用ディレクトリ
set runtimepath+=~/.config/vim/autoload

" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" vim-multiple-cursors
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" indentLine
let g:indentLine_char = '¦'

" vim-gitgutter
nmap <Leader>hv <Plug>GitGutterPreviewHunk

" nerdtree
autocmd vimenter * NERDTree

" tagbar
autocmd vimenter * TagbarOpen

" ale
let g:ale_linters = {
\  'eruby': [],
\}

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand("~/.config/vim/")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

syntax on

colorscheme Tomorrow-Night-Bright
