# Enable the subsequent settings only in interactive sessions
case $- in
*i*) ;;
*) return ;;
esac

# TMUX auto-start (migrated from fish)
if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
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

# Environment variables (migrated from fish)
export EDITOR="nvim"
export GOPRIVATE="github.com/CoverWhale"
export TERM="xterm-256color"
# export DOCKER_HOST="tcp://192.168.1.65:2375"
export XDG_CONFIG_HOME="/Users/$USER/.config"
export KICS_QUERIES_PATH="/opt/homebrew/opt/kics/share/kics/assets/queries"

# Bash completion configuration
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# Enable extended pattern matching
shopt -s extglob
# Extended globbing
shopt -s globstar
# Case-insensitive globbing
shopt -s nocaseglob
# Append rather than overwrite history
shopt -s histappend
# Save multi-line commands as one line
shopt -s cmdhist
# Do not complete empty command line
shopt -s no_empty_cmd_completion
# Check window size after each command
shopt -s checkwinsize

# Command history configuration
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
HISTIGNORE="ls:ll:cd:pwd:exit:date:* --help:* -h"

# Better directory navigation
CDPATH=".:~:~/source"

# Better completion
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'set colored-stats on'
bind 'set visible-stats on'
bind 'set mark-symlinked-directories on'
bind 'set colored-completion-prefix on'
bind 'set menu-complete-display-prefix on'
bind 'TAB:menu-complete'
bind '"\e[Z": menu-complete-backward'

# FZF configuration
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

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

# AWS Profile function with authentication check
awsp() {
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo "Usage: awsp <profile-name> [region]"
        return 1
    fi

    # Set AWS_PROFILE first so the identity check uses this profile
    export AWS_PROFILE="$1"
    
    # Try to get caller identity to check if we're already authenticated
    echo "Checking current authentication status..."
    if ! aws sts get-caller-identity &>/dev/null; then
        echo "Not authenticated or session expired. Running yawsso..."
        # Run yawsso to log in
        yawsso login --profile "$1"
        if [ $? -ne 0 ]; then
            echo "yawsso failed to run"
            return 1
        fi
    else
        echo "Already authenticated with profile $1"
    fi

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

# Remove default greeting
export BASH_SILENCE_DEPRECATION_WARNING=1

# mcfly initialization
eval "$(mcfly init bash)"

# Pyenv initialization
if command -v pyenv >/dev/null; then
	eval "$(pyenv init -)"
	#eval "$(pyenv virtualenv-init -)"
fi

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
