#!/usr/bin/env bash
set -euo pipefail

# Configuration
DOTFILES_DIR="$HOME/Projects/dotfiles"
CONFIG_DIR="$HOME/.config"

# Basic packages for macOS
packages=(
  neovim
  tmux
  alacritty
  ripgrep
  fd
  git
  zsh
  starship
  lazygit
  fzf
  direnv
)

# Install core dependencies
echo "Installing core packages..."
if [[ $(uname) == "Darwin" ]]; then
  if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew update
  brew install "${packages[@]}"

  # Install JetBrains Mono Nerd Font
  brew install --cask font-jetbrains-mono-nerd-font
else
  echo "This script is designed for macOS. Please adapt for other systems."
  exit 1
fi

# Setup dotfiles repo
echo "Setting up dotfiles repository..."
mkdir -p "$DOTFILES_DIR"
if [ ! -d "$DOTFILES_DIR/.git" ]; then
  git clone https://github.com/holstvoogd/dotfiles.git "$DOTFILES_DIR"
  cd "$DOTFILES_DIR"
  git submodule update --init --recursive
fi

# Create necessary directories
mkdir -p "$CONFIG_DIR"/{tmux,alacritty}
mkdir -p "$HOME/.local/share/nvim/lazy" # For lazy.nvim plugin manager

# Create symlinks
echo "Creating symlinks..."
ln -sf "$DOTFILES_DIR/nvim/" "$CONFIG_DIR"
ln -sf "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/alacritty.yml" "$CONFIG_DIR"
ln -sf "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"

# Install TPM (Tmux Plugin Manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Install Neovim plugin manager (lazy.nvim)
if [ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
  echo "Installing lazy.nvim..."
  git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git \
    "$HOME/.local/share/nvim/lazy/lazy.nvim"
  nvim --headless +qa
fi

# Change default shell to zsh if not already
if [[ "$SHELL" != *"zsh"* ]]; then
  echo "Changing default shell to zsh..."
  chsh -s "$(which zsh)"
fi

# Initialize Neovim
echo "Initializing Neovim..."
nvim --headless "++lua vim.schedule(function() require('lazy').sync() vim.cmd.quit() end)" +qa

# Initialize TPM plugins
echo "Initializing TMux plugins..."
tmux start-server
tmux new-session -d
~/.tmux/plugins/tpm/scripts/install_plugins.sh
tmux kill-server

echo "Installation complete! Please:"
echo "1. Restart your terminal"
echo "2. Run 'tmux' to start a new session"
echo "3. Press prefix + I (capital i) to install TMux plugins"
echo "4. Start neovim and let it initialize all plugins"
echo ""
echo "Note: If you haven't already, you'll need to:"
echo "- Set up GitHub Copilot authentication by running ':Copilot auth' in Neovim"
