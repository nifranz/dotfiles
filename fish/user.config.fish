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
    exec tmux
end
