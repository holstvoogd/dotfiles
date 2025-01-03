# ~/.zshrc

# Core Settings
export EDITOR='nvim'
export VISUAL='nvim'
export TERM="xterm-256color"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY

# Basic completion system
autoload -Uz compinit
compinit

# Key bindings
bindkey -e  # Emacs key bindings
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# Useful aliases
alias vim='nvim'
alias vi='nvim'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias g='lazygit'
alias t='tmux'
alias ta='tmux attach'
alias tn='tmux new -s'

# Initialize starship prompt
eval "$(starship init zsh)"

# Initialize direnv
eval "$(direnv hook zsh)"

# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# Load local config if exists
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Auto-start tmux
if [ -z "$TMUX" ]; then
    # Attempt to attach to existing session
    tmux attach 2>/dev/null

    # If no existing session, create a new one
    if [ $? -eq 1 ]; then
        tmux new-session
    fi
fi
