#/bin/env sh
echo "Please provide a github api token for homebrew:"
read HOMEBREW_GITHUB_API_TOKEN
export HOMEBREW_GITHUB_API_TOKEN

echo "Installing homebrew & some packages"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew install cask zsh yubikey-personalization neovim git pass mtr watch ruby ghc awscli postgresql pwgen ack wget
brew cask install iterm2 google-chrome flux gpgtools moom istat-menus wireshark yubico-authenticator yubikey-personalization-gui

echo "Setup dotfiles repo"
mkdir ~/Projects
cd ~/Projects
git clone https://github.com/holstvoogd/dotfiles dotfiles
cd dotfiles
git submodule update -i

echo "Linking dotfiles"
ln -s ~/Projects/dotfiles/vimrc ~/.vimrc
ln -s ~/Projects/dotfiles/vim ~/.vim
ln -s ~/Projects/dotfiles/zshrc ~/.zshrc
ln -s ~/Projects/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/Projects/dotfiles/rdelange.zsh-theme ~/.oh-my-zsh/themes/rdelange.zsh-theme
ln -s ~/Projects/dotfiles/gitignore ~/.gitignore
ln -s ~/Projects/dotfiles/gitconfig ~/.gitconfig

echo "export HOMEBREW_GITHUB_API_TOKEN=${HOMEBREW_GITHUB_API_TOKEN}" >> ~/.secrets.env
chmod 200 ~/.secrets.env

echo "Linking nvim"
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
ln -s $(which nvim) /usr/local/bin/vim

echo "Importing gpg keys"
gpg2 --keyserver hkp://pgp.mit.edu --fetch-keys 8F568196
grep -q enable-ssh-support ~/.gnupg/gpg-agent.conf || echo enable-ssh-support >>  ~/.gnupg/gpg-agent.conf

echo "Setup password management"
git clone git@github.com:holstvoogd/password-store.git ~/.password-store

echo "Switch dotfiles remote"
git remote rm origin
git remote add origin git@github.com:holstvoogd/dotfiles.git

echo "Aaaaaaand it done!"
