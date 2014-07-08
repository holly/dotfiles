" タブの画面上での幅(rubyは2がよい)
set tabstop=4
set shiftwidth=4
" タブをスペースに展開する (noexpandtab:展開しない)
set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set noautoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1 " ぶら下り可能幅
" プログラムをコピペするときにインデントがはいってるとおかしくなるので
set nopaste
" 勝手に折り返さないように
set tw=0
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

set nocompatible
syntax on
filetype on
filetype indent on
filetype plugin on

" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (nolist:表示しない)
set list
" どの文字でタブや改行を表示するかを設定
set listchars=tab:>-,extends:<,trail:-,eol:<
" listcharsの文字色
highlight SpecialKey guifg=#606060
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
let &titleold=expand("%:p:h")
set title

" vimgrepで自動的にQuickWindowsを開く
au QuickfixCmdPost vimgrep cw

" 新規ファイル作成時に拡張子に応じて、雛形ファイルから開くようにする
autocmd BufNewFile *.sh 0r ~/.vim/template/sh.txt
autocmd BufNewFile *.pl 0r ~/.vim/template/perl-script.txt
autocmd BufNewFile *.py 0r ~/.vim/template/python.txt

" setting markdown filetype
autocmd BufNewFile,BufRead *.md set filetype=markdown

" setting python filetype
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4


" for NEEDTree
" 隠しファイルを表示
let NERDTreeShowHidden = 1

" for vim-quickrun
let g:quickrun_config = {}
"let g:quickrun_config['markdown'] = {
"      \   'outputter': 'browser'
"      }
" http://blog.glidenote.com/blog/2013/01/10/vim-quickrun-marked/
let g:quickrun_config['markdown'] = {
      \ 'outputter' : 'null',
      \ 'command'   : 'mdbrowser.sh',
      \ 'cmdopt'    : '',
      \ 'args'      : '',
      \ 'exec'      : '%c %o %a %s',
      \ }

" for neocmplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" for unite.vim(replace FuzzyFinder)
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> <space>uy :<C-u>Unite history/yank<CR>
nnoremap <silent> <space>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <space>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <space>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <space>uu :<C-u>Unite file_mru buffer<CR>

" for NeoBundle
if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'


" Recommended to install
NeoBundle 'Shougo/vimproc', {
 \ 'build' : {
 \     'windows' : 'make -f make_mingw32.mak',
 \     'cygwin' : 'make -f make_cygwin.mak',
 \     'mac' : 'make -f make_mac.mak',
 \     'unix' : 'make -f make_unix.mak',
 \    },
 \ }

" My Bundles here:
" Refer to |:NeoBundle-examples|.
"
" Note: You don't set neobundle setting in .gvimrc!

" ...

filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.

" ======================= "
" colorschemes
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'altercation/solarized'
NeoBundle 'vol2223/vim-colorblind-colorscheme'
" plugins
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'othree/eregex.vim'
NeoBundle 'vim-scripts/Align'
NeoBundle 'vim-scripts/EnhCommentify.vim'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tyru/open-browser.vim'
" ======================= "

NeoBundleCheck

" colorscheme 
colorscheme wombat
