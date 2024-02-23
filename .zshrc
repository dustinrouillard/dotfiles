# Begin oh my zsh
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="edvardm"

plugins=(
    git
    sudo
    fzf
    zsh-syntax-highlighting
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
for file in ~/.zshrc.d/*.zsh; do
    source ${file}
done
