#/bin/env sh
if [ ! -f ~/.secrets.env ]; then
  echo "Please provide a github api token for homebrew:"
  read HOMEBREW_GITHUB_API_TOKEN
  export HOMEBREW_GITHUB_API_TOKEN
else
  source ~/.secrets.env
fi

packages=(
    ack \
    bat \
    curl \
    diff-so-fancy \
    fzf \
    git \
    mtr \
    prettyping \
    pwgen \
    tldr \
    vim \
    watch \
    wget \
    ncdu \
    zsh
  )

if [[ $(uname)=="Darwin" ]]; then
  echo "Installing homebrew & some packages"
  if [[ ! -x $(which brew) ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew update
  brew install cask $packages
  brew cask install wireshark 1password
else
  echo "Installing packages"
  package_manager=$(which yum apt-get 2>/dev/null)
  sudo $package_manager install -y $packages
fi

echo "Setup dotfiles repo"
if [ ! -f ~/Projects ]; then
  mkdir -p ~/Projects
fi
cd ~/Projects
if [ ! -f ~/Projects/dotfiles ]; then
	git clone https://github.com/holstvoogd/dotfiles dotfiles
	cd dotfiles
	git submodule update -i
fi

echo "Linking dotfiles"
ln -nsf ~/Projects/dotfiles/zshrc     ~/.zshrc
ln -nsf ~/Projects/dotfiles/vimrc     ~/.vimrc
ln -nsf ~/Projects/dotfiles/vim       ~/.vim
ln -nsf ~/Projects/dotfiles/gitignore ~/.gitignore
ln -nsf ~/Projects/dotfiles/gitconfig ~/.gitconfig
ln -nsf ~/Projects/dotfiles/iterm2    ~/.iterm2
ln -nsf ~/Projects/dotfiles/bat       ~/Library/Preferences/bat

if [ ! -f .secrets.env ]; then
  echo "export HOMEBREW_GITHUB_API_TOKEN=${HOMEBREW_GITHUB_API_TOKEN}" >> ~/.secrets.env
fi
chmod 400 ~/.secrets.env

echo "Switch dotfiles remote"
git remote rm origin
git remote add origin git@github.com:holstvoogd/dotfiles.git

echo "Install oh-my-zsh"
if hash chsh >/dev/null 2>&1; then
  sudo chsh -s $(grep /zsh$ /etc/shells | tail -1) $(whoami)
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Aaaaaaand it done!"
