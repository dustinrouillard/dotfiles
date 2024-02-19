# Begin oh my zsh
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="edvardm"

plugins=(
    git
    sudo
)

# End oh my zsh
source $ZSH/oh-my-zsh.sh

# Settings for zsh
HISTFILE=~/.zsh_history
HISTSIZE=10000000

export EDITOR=$(which nvim)

# Terminal configuration
export TERM=xterm-256color
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PROJECTS="${HOME}/Projects"

# Add our secrets
source ~/.secrets

# Source our custom zsh files
source ~/.zsh_alias
source ~/.zsh_funcs

# Setup env for fnm
eval $(fnm env)

# Begin pnpm
export PNPM_HOME="/home/${USER}/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# End pnpm

# Setup various paths
export PATH=$HOME/.bin:/usr/local/bin:$PATH
