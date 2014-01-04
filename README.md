# holly/dotfiles

- .tmux.conf for [tmux](http://tmux.sourceforge.net/)
- .bashrc
- .gitconfig
- .gitignore, README
- .vimrc and .gvimrc for [vim](http://www.vim.org/)
- NeoBundle as vim plugin manager [NeoBundle](https://github.com/Shougo/neobundle.vim)
- symlink.sh as install script

## how to use

    $ cd
    $ git clone git://github.com/holly/dotfiles.git ~/.dotfiles
    $ # for NeoBundle
    $ cd .dotfiles
    $ git clone https://github.com/Shougo/neobundle.vim .vim/bundle/neobundle.vim
    $ pushd .vim/bundle/neobundle.vim
    $ git submodule init
    $ git submodule update
    $ popd
    $ # make dot symlink to home directory
    $ sh symlink.sh
