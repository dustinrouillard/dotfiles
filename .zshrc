export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

autoload -Uz compinit
compinit

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="edvardm"

plugins=(
    git
    sudo
)

source $ZSH/oh-my-zsh.sh

export EDITOR=$(which nvim)
export TERM=xterm-256color

export GOPATH=/Users/dustin/.gopath
export GOHOME=$GOPATH/bin
export GO111MODULE=on

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$GOHOME
export PATH=$PATH:/opt/local/bin

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PROJECTS="${HOME}/Projects";

alias projects="cd $PROJECTS"
alias gopath="cd $GOPATH/src"

alias kattach="$(which kubectl) attach -i -t"
alias kget="$(which kubectl) get"
alias kdelete="$(which kubectl) delete"

alias code="code-insiders"
alias k="kubectl"
alias v="nvim"
alias vim="nvim"
alias kubefwd="sudo -E kubefwd"
alias pw="packwiz"

source ~/.secrets
source ~/.jwt
source ~/.hopadm
source ~/.zsh_funcs

preexec () {
  TOKEN=$(jwt dustin.sh/api $PERSONAL_API_INTERNAL_SECRET)
  (nohup curl -X "POST" "${PERSONAL_API_HOST}/stats/track/commands" -H "Authorization: $TOKEN" -s &>/dev/null &)
  if [[ $1 = "docker build"* ]]; then
    (nohup curl -X "POST" "${PERSONAL_API_HOST}/stats/track/docker" -H "Authorization: $TOKEN" -s &>/dev/null &)
  elif [[ $1 = "ghcrbuild"* ]]; then
    (nohup curl -X "POST" "${PERSONAL_API_HOST}/stats/track/docker" -H "Authorization: $TOKEN" -s &>/dev/null &)
  fi
}

export GPG_TTY=$(tty) 

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dustin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dustin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dustin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dustin/google-cloud-sdk/completion.zsh.inc'; fi

export ANDROID_SDK_ROOT="${HOME}/.android"
export PATH="/usr/local/Cellar/openvpn/2.4.7/sbin:/usr/local/bin:${HOME}/.android/tools/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="${PATH}:${HOME}/.krew/bin"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

export PATH="/Users/dustin/.gem/ruby/2.6.0/bin:$PATH"
export PATH="/Users/dustin/.node_modules_global/bin:$PATH"
export PATH="/Users/dustin/.local/bin:$PATH"

HISTFILE=~/.zsh_history
HISTSIZE=10000000

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export PATH="$PATH:$HOME/.spicetify"
eval $(fnm env)

export DOCKER_HOST=10.7.20.5:2375

# pnpm
export PNPM_HOME="/Users/dustin/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

#. $HOME/.asdf/asdf.sh

#. $HOME/.asdf/completions/asdf.bash
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH=$PATH:/Users/dustin/.kubescape/bin

PATH=~/.console-ninja/.bin:$PATH