#/bin/env sh
echo "Install oh-my-zsh"
if hash chsh >/dev/null 2>&1; then
  sudo chsh -s $(grep /zsh$ /etc/shells | tail -1) $(whoami)
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Linking dotfiles"
ln -nsf ~/Projects/dotfiles/vimrc ~/.vimrc
ln -nsf ~/Projects/dotfiles/vim ~/.vim
ln -nsf ~/Projects/dotfiles/zshrc ~/.zshrc
ln -nsf ~/Projects/dotfiles/rdelange.zsh-theme ~/.oh-my-zsh/themes/rdelange.zsh-theme
ln -nsf ~/Projects/dotfiles/gitignore ~/.gitignore
ln -nsf ~/Projects/dotfiles/gitconfig ~/.gitconfig
ln -nsf ~/Projects/dotfiles/iterm2 ~/.iterm2

echo "Switch dotfiles remote"
git remote rm origin
git remote add origin git@github.com:holstvoogd/dotfiles.git

echo "Aaaaaaand it done!"
