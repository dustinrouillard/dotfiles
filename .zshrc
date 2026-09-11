export PATH="/opt/homebrew/opt/openjdk/bin:/opt/homebrew/bin:$PATH"

autoload -Uz compinit
compinit

export ZSH="$HOME/.oh-my-zsh"
# ts mad fking annoying
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"

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
export SAVEHIST=999999999
export HISTSIZE=999999999
setopt SHARE_HISTORY
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

export PROJECTS="${HOME}/Projects"

# Add our secrets
source ~/.secrets

# Source our custom zsh files
for file in ~/.zshrc.d/*.zsh; do
    source ${file}
done

export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# bun completions
[ -s "/Users/dustin/.bun/_bun" ] && source "/Users/dustin/.bun/_bun"


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
