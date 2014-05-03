bindkey -e
# 自動補完
autoload -Uz compinit
compinit

# cdせずに移動
setopt auto_cd
# 自動でpushd. cd + <tab>でディレクトリ履歴が表示
setopt auto_pushd
# ディレクトリスタックから重複を無視する
setopt pushd_ignore_dups
# 拡張globを有効にする
setopt extended_glob
# 入力したコマンドがすでにコマンド履歴に含まれる場合、履歴から古いほうのコマンドを削除する
# コマンド履歴とは今まで入力したコマンドの一覧のことで、上下キーでたどれる
setopt hist_ignore_all_dups

# コマンドがスペースで始まる場合、コマンド履歴に追加しない
# 例： <Space>echo hello と入力
setopt hist_ignore_space

# 履歴にhistoryは記録しない
setopt hist_no_store


# <Tab> でパス名の補完候補を表示したあと、続けて <Tab> を押すと候補からパス名を選択できるようになる
# 候補を選ぶには <Tab> か Ctrl-N,B,F,P
zstyle ':completion:*:default' menu select=1

# 単語の一部として扱われる文字のセットを指定する。ここではデフォルトのセットから / を抜いたものとする
# こうすると、 Ctrl-W でカーソル前の1単語を削除したとき、 / までで削除が止まる
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

PROMPT='[%n@%m]# '
RPROMPT='[%d]'

source $ZDOTDIR/.zaliases
source $ZDOTDIR/.zfunctions
