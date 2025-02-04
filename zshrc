# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="rdelange"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(cp git macos)

# User configuration
source $ZSH/oh-my-zsh.sh
source ~/.secrets.env

# Preferred editor
export EDITOR='vim'

source $ZSH/lib/key-bindings.zsh

if hash direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

rgv() {
  vim $(rg -l $1 $2)
}

export PATH="/opt/homebrew/sbin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$PATH"

source ~/.zshrc.local
