
# if status is-interactive
#     if cd
#         zellij_tab_name_update
#     end
# end

if status is-interactive
    #    and not set -q TMUX
    #    tmux attach -t default || tmux new -s default
    if set -q ZELLIJ
    else
        zellij
    end
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


function crepo -d "Create a directory, initialize git,"
    command mkdir $argv
    if test $status = 0
        switch $argv[(count $argv)]
            case '-*'

            case '*'
                cd $argv[(count $argv)]
                git init
                return
        end
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
    cwgoctl completion fish | source
    starship init fish | source
    zoxide init fish --cmd cd | source
    alias sf="cd ~/source"
    alias cls="clear"
    alias vim="nvim"
    alias kc="kubectl"
    set -Ux EDITOR nvim
    set -Ux GOPRIVATE github.com/CoverWhale
    alias ls="lsd"
    alias ll="ls -l"
    alias la="ls -a"
    alias lla="ls -la"
    alias lt="ls --tree"
    zellij_tab_name_update
    set -gx PATH $PATH $HOME/.krew/bin
end
