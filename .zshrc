if [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then
export EMACS=""
if [ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]
then 
   ZSH_TMUX_AUTOSTART=true
fi
ZSH_TMUX_CONFIG="/Users/${USER}/.tmux.conf"
# Path to your oh-my-zsh installation.
export ZSH="/Users/${USER}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"

plugins=(tmux vim-interaction ansible aws dotenv helm sudo vscode virtualenv git docker docker-compose brew kubectl npm pip pyenv python terraform vagrant zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

for f in ~/shell_functions;
	do source $f;
done

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
autoload -Uz compinit
compinit
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

alias cls="clear"
alias sf="cd /Users/${USER}/source"
alias awsp="source _awsp"
alias vim="nvim"
export PATH=/Users/${USER}/Library/Frameworks/Python.framework/Versions/3.8/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/Users/${USER}/Library/Python/3.8/bin:$PATH
export GUILE_LOAD_PATH="/usr/local/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="/usr/local/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="/usr/local/lib/guile/3.0/extensions"
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH
export GOPATH=$HOME/golang
export GOROOT=/opt/homebrew/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/Users/${USER}/.cargo/bin:$PATH"
export PATH="/Users/${USER}/.local/bin:$PATH"
eval "$(pyenv init -)"
complete -C '/usr/local/bin/aws_completer' aws

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/stephenmorgan/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/stephenmorgan/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/stephenmorgan/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/stephenmorgan/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

alias kc=kubectl
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
export XDG_CONFIG_HOME=/Users/${USER}/.config


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/${USER}/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/smorgan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/${USER}/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/smorgan/google-cloud-sdk/completion.zsh.inc'; fi
export SOURCEP=~/source/personal


###### FUNCTIONS ######
# minikube start
mks () {
  minikube start
}

# minikube status 
mkstat () {
  minikube status
}

# create repo 
crepo () {
  if [ $2 ]; then
    echo "Too many arguments!"
  elif [ -z $1 ]; then 
    echo "Please supply a repo name!"
  else
    mkdir $1 && cd $_ && git init
  fi
}

export EDITOR=nvim

# if [ -r ~/.zshrc ]; then echo 'export GPG_TTY=$(tty)' >> ~/.zshrc; \
#  else echo 'export GPG_TTY=$(tty)' >> ~/.zprofile; fi



#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH=~/.npm-global/bin:$PATH
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
fi


alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-lvim="NVIM_APPNAME=LunarVim nvim"

function nvims() {
  items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim" "LunarVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# configure rust environment
#
# - autocomplete
# - rust-analyzer
# - cargo audit
# - cargo-nextest
# - cargo fmt
# - cargo clippy
# - cargo edit
#
source $HOME/.cargo/env
if [ ! -f "$HOME/.config/rustlang/autocomplete/rustup" ]; then
  mkdir -p ~/.config/rustlang/autocomplete
  rustup completions bash rustup >> ~/.config/rustlang/autocomplete/rustup
fi
source "$HOME/.config/rustlang/autocomplete/rustup"
if ! command -v rust-analyzer &> /dev/null
then
  brew install rust-analyzer
fi
if ! cargo audit --version &> /dev/null; then
  cargo install cargo-audit --features=fix
fi
if ! cargo nextest --version &> /dev/null; then
  cargo install cargo-nextest
fi
if ! cargo fmt --version &> /dev/null; then
  rustup component add rustfmt
fi
if ! cargo clippy --version &> /dev/null; then
  rustup component add clippy
fi
if ! ls ~/.cargo/bin | grep 'cargo-upgrade' &> /dev/null; then
  cargo install cargo-edit
fi

complete -o nospace -C /opt/homebrew/bin/terramate terramate
