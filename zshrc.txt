# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme (powerlevel10k is recommended but you can use "robbyrussell")
ZSH_THEME="robbyrussell"

# Enable plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gs='git status'
alias lzd='lazydocker'

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt SHARE_HISTORY

# Better navigation
setopt AUTO_CD              # Type folder name to cd into it
setopt CORRECT              # Suggest corrections for mistyped commands

# pnpm
export PNPM_HOME="/home/rb136/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Created by `pipx` on 2025-08-11 05:56:54
export PATH="$PATH:/home/rb136/.local/bin"
export PATH=$PATH:/home/rb136/.local/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

