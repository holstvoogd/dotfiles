# Neovim Copilot & LSP Cheatsheet

## Installation
First time setup:
```bash
# Install Ruby LSP
gem install ruby-lsp

# Open nvim and run:
:Lazy install
:Copilot auth
```

## Copilot Features

### Auto-completion
- `Tab` - Accept suggestion
- `Alt+]` - Next suggestion
- `Alt+[` - Previous suggestion
- `Ctrl+]` - Dismiss suggestion

### Copilot Chat (Agent Mode)
- `\cc` - Open chat / chat with selection
- `\ce` - Explain code/selection
- `\ct` - Generate tests
- `\cr` - Review code (visual mode)
- `\cf` - Fix issues (visual mode)
- `\co` - Optimize code (visual mode)
- `\cd` - Add documentation
- `\cg` - Generate commit message

### Ruby IDE Features
- `gd` - Go to definition
- `gr` - Find all references
- `K` - Show documentation hover
- `\rn` - Rename symbol
- `\ca` - Code actions (refactoring)

## Tips
- Select code in visual mode before using chat commands
- Use `:CopilotChat` with custom prompts like:
  - `:CopilotChat refactor this to use a service object`
  - `:CopilotChat add RSpec tests`
  - `:CopilotChat explain the performance implications`
