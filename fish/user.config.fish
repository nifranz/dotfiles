source ~/.dotfiles/fish/aliases.fish
source ~/.dotfiles/fish/paths.fish
source ~/.dotfiles/fish/exports.fish
source ~/.dotfiles/fish/keybinds.fish

# Source functions folder
set function_dir "$HOME/.dotfiles/fish/functions"

if test -d $function_dir
    for f in (ls $function_dir/*.fish)
        source $f
    end
end

export tide_git_icon=''

if status is-interactive
    and not set -q TMUX
    and type -q tmux

    exec tmux
end
set -U fish_greeting
set -U fish_greeting 'Hello, Worlds!'

# set ctrl-del and cmd-del to backward-kill
bind ctrl-_ backward-kill-path-component # hex code: 0x1f
bind ctrl-\] backward-kill-line # hex code: 0x1d
