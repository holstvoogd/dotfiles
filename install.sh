#/bin/env sh
echo "Please provide a github api token for homebrew:"
read HOMEBREW_GITHUB_API_TOKEN
export HOMEBREW_GITHUB_API_TOKEN

packages=(
    ack \
    awscli \
    curl \
    git \
    gpg2 \
    mtr \
    pwgen \
    tmux \
    vim \
    watch \
    wget \
    zsh
  )

if [[ $(uname)=="Darwin" ]]; then
  echo "Installing homebrew & some packages"
  if [[ ! -x $(which brew) ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew update
  brew install cask yubikey-personalization ghc postgresql redis direnv rbenv $packages
  brew cask install iterm2 google-chrome flux gpgtools moom istat-menus wireshark
  rbenv install
else
  echo "Installing packages"
  package_manager=$(which yum apt-get 2>/dev/null)
  sudo $package_manager install -y $packages
fi

echo "Install oh-my-zsh"
if hash chsh >/dev/null 2>&1; then
  sudo chsh -s $(grep /zsh$ /etc/shells | tail -1) $(whoami)
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Setup dotfiles repo"
mkdir ~/Projects
cd ~/Projects
git clone https://github.com/holstvoogd/dotfiles dotfiles
cd dotfiles
git submodule update -i

echo "Linking dotfiles"
ln -nsf ~/Projects/dotfiles/vimrc ~/.vimrc
ln -nsf ~/Projects/dotfiles/vim ~/.vim
ln -nsf ~/Projects/dotfiles/zshrc ~/.zshrc
ln -nsf ~/Projects/dotfiles/rdelange.zsh-theme ~/.oh-my-zsh/themes/rdelange.zsh-theme
ln -nsf ~/Projects/dotfiles/gitignore ~/.gitignore
ln -nsf ~/Projects/dotfiles/gitconfig ~/.gitconfig
ln -nsf ~/Projects/dotfiles/iterm2 ~/.iterm2

echo "export HOMEBREW_GITHUB_API_TOKEN=${HOMEBREW_GITHUB_API_TOKEN}" >> ~/.secrets.env
chmod 400 ~/.secrets.env

echo "Importing gpg keys"
gpg2 --keyserver hkp://pgp.mit.edu --fetch-keys 8F568196
grep -q enable-ssh-support ~/.gnupg/gpg-agent.conf || echo enable-ssh-support >>  ~/.gnupg/gpg-agent.conf

echo "Switch dotfiles remote"
git remote rm origin
git remote add origin git@github.com:holstvoogd/dotfiles.git

echo "Aaaaaaand it done!"
