
# if status is-interactive
#     if cd
#         zellij_tab_name_update
#     end
# end

if status is-interactive
    and not set -q TMUX
    and begin
        not set -q TERMINAL_EMULATOR
        or test "$TERMINAL_EMULATOR" != JetBrains-JediTerm
    end
    tmux attach -t default || tmux new -s default
end
# Path configurations
set -gx PATH $HOME/.nix-profile/bin $PATH
set -gx PATH $HOME/.krew/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
# If you have a system-level profile
if test -e /etc/profiles/per-user/$USER/bin
    set -gx PATH /etc/profiles/per-user/$USER/bin $PATH
end

function zellij_tab_name_update -d "Set Zellij tab name"
    if set -q ZELLIJ
        set tab_name ''
        if git rev-parse --is-inside-work-tree >/dev/null 2>&1
            set tab_name $(basename "$(git rev-parse --show-toplevel)")/$(git rev-parse --show-prefix)
            #set tab_name {tab_name%/}
        else
            set tab_name $PWD
            if test $tab_name = $HOME
                set tab_name "~"
            else
                set tab_name $tab_name##*/
            end
        end
        zellij action rename-tab $tab_name >/dev/null 2>&1
    end
end


function crepo -d "Create a directory and initialize git"
    if test (count $argv) -eq 0
        echo "Usage: crepo <directory_name>"
        return 1
    end
    command mkdir $argv
    if test $status = 0
        cd $argv[(count $argv)]
        git init
    end
end

function cd_and_zellij_tab_name_update -d "cd and run zellij_tab_name_update"
    command cd $argv
    if test $status = 0
        switch $orgv[(count $argv)]
            case '-*'

            case '*'
                zellij_tab_name_update
                return
        end
    end

end

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish --cmd cd | source

    # Environment variables block
    set -Ux EDITOR nvim
    set -Ux GOPRIVATE github.com/CoverWhale
    set -Ux TERM xterm-256color
    set -gx PATH $PATH $HOME/.krew/bin
    set -gx DOCKER_HOST "tcp://192.168.1.65:2375"
    set -gx XDG_CONFIG_HOME "/Users/$USER/.config"

    # Aliases block
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

    set KICS_QUERIES_PATH /opt/homebrew/opt/kics/share/kics/assets/queries
    zellij_tab_name_update
    set -g fish_greeting
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/stephenmorgan/Downloads/google-cloud-sdk/path.fish.inc' ]
    . '/Users/stephenmorgan/Downloads/google-cloud-sdk/path.fish.inc'
end
source $HOME/.tenv.completion.fish

function reload
    source ~/.config/fish/config.fish
end
