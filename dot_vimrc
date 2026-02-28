" バックアップ
set nobackup
"set noundofile
"set noswapfile

" タブの画面上での幅(rubyは2がよい)
"
set tabstop=4
set shiftwidth=4
" タブをスペースに展開する (noexpandtab:展開しない)
set expandtab
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
set fileformats=unix,dos,mac
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1 " ぶら下り可能幅
" プログラムをコピペするときにインデントがはいってるとおかしくなるので
set paste
" 勝手に折り返さないように
set tw=0
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932

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
" 日本語を始めとした全角文字の表示に2文字分使うことでちゃんと表示できるようにする
set ambiwidth=double
" 無名レジスタ(yでヤンクしたときにコピーする先)とOSのクリップボードを結びつける
set clipboard+=unnamedplus
" 開いたファイルの階層に移動する
set autochdir
" カレント行ハイライトON
set cursorline

" vimgrepで自動的にQuickWindowsを開く
au QuickfixCmdPost vimgrep cw

" 新規ファイル作成時に拡張子に応じて、雛形ファイルから開くようにする
"autocmd BufNewFile *.sh 0r ~/.vim/template/sh.txt
"autocmd BufNewFile *.pl 0r ~/.vim/template/perl.txt
"autocmd BufNewFile *.py 0r ~/.vim/template/python.txt

" setting markdown filetype
autocmd BufNewFile,BufRead *.{mkd,md} set filetype=markdown
autocmd! FileType markdown hi! def link markdownItalic Normal
autocmd FileType markdown set commentstring=<\!--\ %s\ -->

" setting python filetype
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

" http://inari.hatenablog.com/entry/2014/05/05/231307
" 全角スペースの表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
" 挿入モード時、ステータスラインの色を変更
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

" アンダーラインを引く(color terminal)
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" アンダーラインを引く(gui)
highlight CursorLine gui=underline guifg=NONE guibg=NONE
" アンダーラインを引く(color terminal)
"highlight CursorLine cterm=NONE ctermfg=white ctermbg=black
" アンダーラインを引く(gui)
"highlight CursorLine gui=NONE guifg=white guibg=black


" ================== キーマップ ================== "
let mapleader = "\<Space>"
" バッファ切替
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

" タブ切替
nmap <C-Tab> :tabnext<CR>
nmap <C-S-Tab> :tabprevious<CR>

" ハイライトを消す（Escapeキーx2で消える）
nmap <Esc><Esc> :nohl<CR>
