#/bin/env sh
PATH=$(dirname "${BASH_SOURCE[0]}")
git submodule update -i
ln -s $PATH/vimrc ~/.vimrc
ln -s $PATH/vim ~/.vim
ln -s $PATH/zshrc ~/.zshrc
ln -s $PATH/tmux.conf ~/.tmux.conf
ln -s $PATH/rdelange.zsh-theme ~/.oh-my-zsh/themes/rdelange.zsh-theme
ln -s $PATH/gitignore ~/.gitignore
# link nvim
if [[ -f /usr/local/bin/nvim ]]; then
  mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
  ln -s ~/.vim $XDG_CONFIG_HOME/nvim
  ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
  ln -s /usr/local/bin/nvim /usr/local/bin/vim
fi
