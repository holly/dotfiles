" ウインドウの幅
set columns=90
" ウインドウの高さ
set lines=30
" コマンドラインの高さ(GUI使用時)
set cmdheight=3

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
" プログラムをコピペするときにインデントがはいってるとおかしくなるので
set nopaste
" 勝手に折り返さないように
set tw=0

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
"" 常にステータス行を表示 (詳細は:he laststatus)
"set laststatus=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title

" vimgrepで自動的にQuickWindowsを開く
au QuickfixCmdPost vimgrep cw
