syntax on "ハイライトを有効にしています
set backspace=2
set number "行番号をつける
set ruler
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<,eol:<
set incsearch "検索ワードの最初の文字を入力すると検索が開始
set hlsearch "検索結果をハイライト
set nowrap
set showmatch
set whichwrap=h,l
set nowrapscan
set ignorecase "大文字小文字を無視
set smartcase "大文字の場合は区別
set hidden " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set history=2000
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set helplang=en
set mouse=a
set laststatus=2
set t_Co=256
colorscheme desert
"ノーマルモードのキーマップ割り当て
nnoremap ; :
nnoremap : ;
"ヴィジュアルモードでのキーマップ割り当て
vnoremap ; :
vnoremap : ;
nnoremap <Space>h ^
nnoremap <Space>l $
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj
nnoremap gk k
nnoremap gj j
vnoremap gk k
vnoremap gj j
nnoremap <Space>/ *<C-o>
nnoremap g<Space>/ g*<C-o>
nnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
nnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'
vnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
vnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'
function! s:search_forward_p()
return exists('v:searchforward') ? v:searchforward : 1
endfunction
nnoremap <Space>o :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <Space>O :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
nnoremap <silent> tt :<C-u>tabe<CR>
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q gq
onoremap aa a>
onoremap ia i>
onoremap ar a]
onoremap ir i]
onoremap ad a"
onoremap id i"
inoremap jk <Esc>
nnoremap gs :<C-u>%s///g<Left><Left><Left>
vnoremap gs :s///g<Left><Left><Left>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <C-b>
cnoremap <C-e> <C-e>
cnoremap <C-u> <C-e><C-u>
cnoremap <C-v> <C-f>a

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

    "ファイル形式別プラグインのロードを有効化
    filetype plugin indent on
