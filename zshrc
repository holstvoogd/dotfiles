# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="rdelange"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(cp git osx)

# User configuration

#export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
export GOPATH=~/Projects/go
export PATH=$GOPATH/bin:$PATH

source $ZSH/oh-my-zsh.sh
source ~/.secrets.env

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#export RUBY_GC_MALLOC_LIMIT=64000000

# Show VI mode
# export RPS1='$(vi_mode_prompt_info)'$RPS1

source $ZSH/lib/key-bindings.zsh

if hash direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi
if hash rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

workon() {
  if [[ -z $2 ]]; then
    name=$1
    cd $(pwd | egrep '.*/Projects/\w+' -o)
  else
    name=$2
    cd ~/Projects/$1
  fi
  git fetch -p
  git worktree add $name
  cd $name
  if [[ -f .envrc ]]; then
    direnv allow
  fi
  git reset --hard origin/HEAD

  # setup db
  ln -sf ../../database.yml config/database.yml
}

cleanup_worktrees() {
  git fetch -p
  gbda 2>&1 | grep 'checked out at' | awk '{print $NF}' | egrep -v 'staging|master'  | xargs rm -rf
  git worktree prune
  gbda 2>&1
}

dbreset() {
  tgt=$1
  src=${tgt:s/_development/_backup}
  read -q "REPLY?Dropping $tgt, recreating from $src. Are you sure? (y/n) "
  if [ $REPLY = 'y' ]; then
    if [ "$( psql -tAc "SELECT 1 FROM pg_database WHERE datname='$src'" postgres )" = '1' ]; then
      echo "\nResetting db..."
      dropdb $tgt && createdb $tgt -T $src
    else
      echo "\nTemplate db $src not found!"
      exit 1
    fi
  fi
}

rgv() {
  vim $(rg $1 -l)
}

# Disable spring
export DISABLE_SPRING=1

alias e=vim
alias :e=vim

alias bem='bundle exec m'
alias be='bundle exec'
alias rr='bundle exec do rails'

alias du="ncdu --color dark -rr -x"
alias preview="fzf --preview 'bat --color \"always\" {}'"
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
alias ping='prettyping --nolegend'

export BAT_THEME="Solarized (${(L)ITERM_PROFILE})"

# Added by Krypton
export GPG_TTY=$(tty)
