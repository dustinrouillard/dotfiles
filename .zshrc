export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

autoload -Uz compinit
compinit

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="edvardm"

plugins=(
    git
    fzf
    sudo
)

source $ZSH/oh-my-zsh.sh

export EDITOR=$(which nvim)
export TERM=xterm-256color

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export GPG_TTY=$(tty) 

export HISTFILE=~/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY

export PROJECTS="${HOME}/Projects"

# Add our secrets
source ~/.secrets

# Source our custom zsh files
for file in ~/.zshrc.d/*.zsh; do
    source ${file}
done

export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
