"Appearance------
syntax enable "ハイライトを有効にしています
set hls is
colorscheme desert

"Search and Replace------
set hlsearch "検索結果をハイライト
set incsearch "検索ワードの最初の文字を入力すると検索が開始
set ignorecase "大文字小文字を無視
set smartcase "大文字の場合は区別

set backspace=2

"Edit-------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

set ruler
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<,eol:<
set nowrap
set showmatch
set whichwrap=h,l
set nowrapscan
set hidden " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set history=2000
set autoindent
set expandtab
set tabstop=2 "tabキーで２文字インデント
set shiftwidth=2
set helplang=en
set mouse=a
set laststatus=2
set t_Co=256

"ノーマルモードのキーマップ割り当て
nnoremap ; :
nnoremap : ;
"ヴィジュアルモードでのキーマップ割り当て
vnoremap ; :
vnoremap : ;

"vi互換OFF
set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    call neobundle#end()
endif

    NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \   'windows' : 'make -f make_mingw32.mak',
      \   'cygwin' : 'make -f make_cygwin.mak',
      \   'mac' : 'make -f make_mac.mak',
      \   'unix' : 'make -f make_unix.mak',
      \ },
      \ }
    
    "lightline
    NeoBundle 'itchyny/lightline.vim'
    "lightlineの設定-----------------------------------------------------
    let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ 'mode_map': {'c': 'NOMAL'},
        \ 'active': {
        \ 'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \ 'modified': 'MyModified',
        \ 'readonly': 'MyReadonly',
        \ 'fugitive': 'MyFugitive',
        \ 'filename': 'MyFilename',
        \ 'fileformat': 'MyFileformat',
        \ 'filetype': 'MyFiletype',
        \ 'fileencoding': 'MyFileencoding',
        \ 'mode': 'MyMode'
        \ }
        \ }

        function! MyModified()
          return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
        endfunction

        function! MyReadonly()
          return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
        endfunction

        function! MyFilename()
          return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'vimshell' ? vimshell#get_status_string() :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
        endfunction

        function! MyFugitive()
          try
            if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
              return fugitive#head()
            endif
          catch
          endtry
          return ''
        endfunction

        function! MyFileformat()
          return winwidth(0) > 70 ? &fileformat : ''
        endfunction

        function! MyFiletype()
          return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
        endfunction

        function! MyFileencoding()
          return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
        endfunction

        function! MyMode()
          return  &ft == 'unite' ? 'Unite' :
                \ &ft == 'vimfiler' ? 'VimFiler' :
                \ &ft == 'vimshell' ? 'VimShell' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
        endfunction
    "lightlineの設定ここまで----------------------------------

    "----------------------------------------------------
    "Unite.vimの設定
    "----------------------------------------------------
    " ファイルオープンを便利に
    NeoBundle 'Shougo/unite.vim'
    " Unite.vimで最近使ったファイルを表示できるようにする
    NeoBundle 'Shougo/neomru.vim'
    let g:unite_enable_start_insert=1
    let g:unite_source_history_yank_enable =1
    let g:unite_source_file_mru_limit = 200
    nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
    nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
    nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
    nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

    "vimfilter
    NeoBundle 'Shougo/vimfiler'
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_safe_mode_by_default = 0

    "ファイル形式別プラグインのロードを有効化
    filetype plugin indent on
