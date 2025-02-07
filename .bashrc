# Enable the subsequent settings only in interactive sessions
case $- in
*i*) ;;
*) return ;;
esac

# TMUX auto-start (migrated from fish)
if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ] && [ -z "$NVIM" ]; then
	if [[ -z "$TERMINAL_EMULATOR" || "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]]; then
		tmux attach -t default || tmux new -s default
	fi
fi

# Homebrew path configuration
if [[ $(uname -m) == 'arm64' ]]; then
	# For Apple Silicon Macs
	eval "$(/opt/homebrew/bin/brew shellenv)"
else
	# For Intel Macs
	eval "$(/usr/local/bin/brew shellenv)"
fi

# Path configurations
export PATH="$HOME/.nix-profile/bin:$PATH"
export PATH="$HOME/.krew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Environment variables (migrated from fish)
export EDITOR="nvim"
export GOPRIVATE="github.com/CoverWhale"
export TERM="xterm-256color"
export DOCKER_HOST="tcp://192.168.1.65:2375"
export XDG_CONFIG_HOME="/Users/$USER/.config"
export KICS_QUERIES_PATH="/opt/homebrew/opt/kics/share/kics/assets/queries"

# History configuration
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# Check window size after each command
shopt -s checkwinsize

# Enable programmable completion features
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Initialize starship prompt
eval "$(starship init bash)"

# Initialize zoxide (z command)
eval "$(zoxide init bash)"

# Enable fzf keybindings and completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Aliases (migrated from fish)
alias sf="cd ~/source"
alias cls="clear"
alias vim="nvim"
alias kc="kubectl"
alias ls="lsd"
alias ll="ls -lah"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"
alias cat="bat"
alias cq="cloudquery"
alias tf="terraform"

# Function to create repo and initialize git (migrated from fish)
crepo() {
	if [ $# -eq 0 ]; then
		echo "Usage: crepo <directory_name>"
		return 1
	fi
	mkdir "$1" && cd "$1" && git init
}

# AWS Profile function (migrated from fish)
awsp() {
	if [ $# -lt 1 ] || [ $# -gt 2 ]; then
		echo "Usage: awsp <profile-name> [region]"
		return 1
	fi

	# Run yawsso first
	yawsso login --profile "$1"
	if [ $? -ne 0 ]; then
		echo "yawsso failed to run"
		return 1
	fi

	# Set AWS_PROFILE
	export AWS_PROFILE="$1"

	# Set AWS_REGION with proper argument checking
	if [ $# -eq 2 ]; then
		export AWS_REGION="$2"
	else
		export AWS_REGION="us-east-1"
	fi

	echo "AWS Profile set to: $AWS_PROFILE"
	echo "AWS Region set to: $AWS_REGION"
}

# Reload function
reload() {
	source /Users/${USER}/.bashrc
}

# Google Cloud SDK
if [ -f '/Users/stephenmorgan/Downloads/google-cloud-sdk/path.bash.inc' ]; then
	source '/Users/stephenmorgan/Downloads/google-cloud-sdk/path.bash.inc'
fi

# Set up bash autocompletion
if [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
	source /opt/homebrew/etc/profile.d/bash_completion.sh
fi

# Remove default greeting
export BASH_SILENCE_DEPRECATION_WARNING=1

# mcfly initialization
eval "$(mcfly init bash)"
