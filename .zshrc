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

# Created by `pipx` on 2024-07-24 06:07:15
export PATH="$PATH:/home/dustin/.local/bin"

atuin-setup() {
	if ! which atuin &> /dev/null; then return 1; fi
	bindkey '^E' _atuin_search_widget

	export ATUIN_NOBIND="true"
	eval "$(atuin init zsh)"
	fzf-atuin-history-widget() {
	   local selected num
	   setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2>/dev/null

	   # local atuin_opts="--cmd-only --limit ${ATUIN_LIMIT:-5000}"
	   local atuin_opts="--cmd-only"
	   local fzf_opts=(
		--height=${FZF_TMUX_HEIGHT:-80%}
		--tac
		"-n2..,.."
		--tiebreak=index
		"--query=${LBUFFER}"
		"+m"
		"--bind=ctrl-d:reload(atuin search $atuin_opts -c $PWD),ctrl-r:reload(atuin search $atuin_opts)"
	   )

	   selected=$(
		eval "atuin search ${atuin_opts}" |
		   fzf "${fzf_opts[@]}"
	   )
	   local ret=$?
	   if [ -n "$selected" ]; then
		# the += lets it insert at current pos instead of replacing
		LBUFFER+="${selected}"
	   fi
	   zle reset-prompt
	   return $ret
	}
	zle -N fzf-atuin-history-widget
	bindkey '^R' fzf-atuin-history-widget
}
atuin-setup
