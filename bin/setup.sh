#!/usr/bin/env bash
# macOS-friendly (Bash 3.2). No associative arrays used.

set -uo pipefail

### ---------- logging ----------
_color() { printf "\033[%sm" "$1"; }
RESET="$( _color 0 )"; BOLD="$( _color 1 )"
BLUE="$( _color 34 )"; GREEN="$( _color 32 )"; YELLOW="$( _color 33 )"; RED="$( _color 31 )"

info()  { echo "${BLUE}[INFO]${RESET} $*"; }
ok()    { echo "${GREEN}[ OK ]${RESET} $*"; }
warn()  { echo "${YELLOW}[WARN]${RESET} $*"; }
err()   { echo "${RED}[ERR ]${RESET} $*"; }

header(){ echo; echo "${BOLD}==> $*${RESET}"; }

### ---------- tiny task framework ----------
# Declare a task with: task <name> "<description>"
# Optionally declare deps with: deps <name> "dep1 dep2"
# Optionally assign to groups with: group <groupname> "task1 task2"

TASKS=""
TASK_DESCR__() { :; }  # namespaced storage via variables TASK_DESCR__<task>, DEPS__<task>

task(){ local t="$1"; local d="${2:-}"; TASKS="$TASKS $t"; eval "TASK_DESCR__$t=\"\$d\""; }
deps(){ local t="$1"; shift; eval "DEPS__$t=\"\$*\""; }
group(){ local g="$1"; shift; eval "GROUP__$g=\"\$*\""; }

declare -a RUN_DONE=()
declare -a SUCCEEDED=()
declare -a FAILED=()
declare -a SKIPPED=()

_in_list(){ case " $1 " in *" $2 "*) return 0;; *) return 1;; esac; }

_run_task(){
  local t="$1"
  # already processed?
    for r in "${RUN_DONE[@]:-}"; do
    [ "$r" = "$t" ] && return 0
    done
  RUN_DONE+=("$t")

  # deps first
  local depvar="DEPS__${t}"; local deps="${!depvar:-}"
  for d in $deps; do
    _run_task "$d" || { warn "Skipping $t (dependency failed: $d)"; SKIPPED+=("$t"); return 1; }
    # if dep was explicitly marked as failed/ skipped, also skip
    for f in "${FAILED[@]}"; do [ "$f" = "$d" ] && { warn "Skipping $t (dependency failed: $d)"; SKIPPED+=("$t"); return 1; }; done
    for s in "${SKIPPED[@]}"; do [ "$s" = "$d" ] && { warn "Skipping $t (dependency skipped: $d)"; SKIPPED+=("$t"); return 1; }; done
  done

  # run task function
  if ! declare -F "$t" >/dev/null; then err "Task function '$t' not found"; FAILED+=("$t"); return 1; fi
  local descrvar="TASK_DESCR__${t}"; local descr="${!descrvar:-}"
  header "$t — $descr"

  if "$t"; then ok "$t completed"; SUCCEEDED+=("$t"); return 0
  else err "$t failed"; FAILED+=("$t"); return 1
  fi
}

run_all(){ for t in $TASKS; do _run_task "$t"; done; }

run_group(){
  local g="$1"; local listvar="GROUP__${g}"; local list="${!listvar:-}"
  [ -z "$list" ] && { err "Group '$g' is empty or undefined"; return 1; }
  for t in $list; do _run_task "$t"; done
}

### ---------- helpers you’ll use inside tasks ----------
# Run a command loudly, show it before executing, and propagate failures.
run(){ echo "+ $*"; "$@"; }

# Homebrew shellenv loader (works on Intel & Apple Silicon)
load_brew(){
  # Try both locations; avoid -e so we can continue in the runner.
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  elif command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
  else
    return 1
  fi
}

## ------ TASKS ------ 
task install_brew "Install Homebrew"
install_brew(){
  # Use official installer
    if command -v brew >/dev/null 2>&1; then
        info "Homebrew already installed"
        return 0;
    fi
    echo "installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo "adding additional brew repositories"
    /bin/bash -c "brew tap homebrew/cask-fonts"
    load_brew || { err "brew not found after install"; return 1; }
}

task brew_taps "Homebrew Taps"
deps install_brew
brew_taps(){
  load_brew || return 1
}

task install_cli "Install CLI tools"
deps install_brew brew_taps
install_cli(){
  load_brew || return 1
  # Example set — any failure marks the whole task as failed, dependents will skip
  run brew install fish tmux git wget neovim helix node hyfetch || return 1
  run brew install --cask font-hack-nerd-font || return 1
}

task install_gui "Install GUI Apps"
deps install_brew
install_gui(){
    sudo -v
    load_brew || return 1
    brew install --cask iterm2 spotify visual-studio-code karabiner-elements
}

install_other(){
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    sh -c "$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"
}

# 4) Dotfiles setup (unrelated to brew)
task setup_dotfiles "Symlink dotfiles"
# no deps -> runs even if brew flow fails
setup_dotfiles(){
  run mkdir -p "$HOME/.config $HOME/dev/config $HOME/dev/ressources $HOME/dev/projects $HOME/dev/uni" || return 1
  
  info configuring git files ...
  run mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak" || return 1
  run ln -sv "$HOME/.dotfiles/git/.gitconfig" "$HOME/.gitconfig" || return 1

  info setting up tmux files ...
  run ln -svf "$HOME/.dotfiles/tmux" "$HOME/.tmux" || return 1
  run ln -svf "$HOME/.dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf" || return 1

  info setting up helix files ...
  run mkdir -p "$HOME/.config/helix/" || return 1
  run ln -svf "$HOME/.dotfiles/helix-editor/config.toml" "$HOME/.config/helix/config.toml" || return 1

  info setting up npm files ...
  run mkdir -p "$HOME/.npm-packages" || return 1
  run ln -svf "$HOME/.dotfiles/.npmrc" "$HOME/.npmrc" || return 1

  info setting up karabiner files ...
  run mkdir -p $HOME/.config/karabiner/assets/ || return 1
  run ln -svnf "$HOME/.dotfiles/karabiner/" "$HOME/.config/karabiner/assets/complex_modifications" || return 1

  info Installing keyboard layouts ...
  run cp $HOME/.dotfiles/keyboard-layouts/* "/Library/Keyboard Layouts/" || return 1

  return 0
}

# 5) Mac defaults (separate group so you can run independently)
task macos_defaults "Set macOS defaults (Dock, Finder, etc)"
macos_defaults(){
    if [[ $(uname) != "Darwin" ]]; then
        err "MacOS defaults can only be set on MacOS"
        return 1
    fi
    # VSCODE
    # enable repeated key inputs by holding down a key in vscode
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

    # FINDER - UI
    # always show file extensions 
    defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
    # dont warn when changing file extensions
    defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
    # always open finder in column view (all values: Column View = clmv, List View = Nlsv, Gallery View = glyv, Icon View = icnv)
    defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
    # add quit option to finder
    defaults write com.apple.finder "QuitMenuItem" -bool "true"
    # enable the file path bar
    defaults write com.apple.finder "ShowPathbar" -bool "true"

    # FINDER - DESKTOP
    # show connected hard disk on desktop
    defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool "true"
    killall Finder


    # MENUBAR 
    # flash time seperator every second
    defaults write com.apple.menuextra.clock "FlashDateSeparators" -bool "true" && killall SystemUIServer


    # DOCK
    defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
    defaults write com.apple.dock autohide-delay -float 0; killall Dock
    defaults write com.apple.dock expose-group-apps -bool true && killall Dock # mission control group apps


    # SYSTEM
    # set system accent color to green
    defaults write 'Apple Global Domain' AppleAccentColor 3
    defaults write com.apple.spaces spans-displays -bool true && killall SystemUIServer # displays have no seperate spaces
}

setup_fish_shell(){
    if ! command -v fish >/dev/null 2>&1; then
        info "Installing fish shell with Homebrew..."
        run brew install fish
        # refresh PATH (important if fish was just added)
        load_brew || true
    else
        info "fish already installed."
    fi 

    # Figure out the Homebrew fish path (Intel vs Apple Silicon)
    FISH_BIN=""
    for p in /opt/homebrew/bin/fish /usr/local/bin/fish "$(command -v fish 2>/dev/null || true)"; do
        [ -x "$p" ] && { FISH_BIN="$p"; break; }
    done
    [ -n "$FISH_BIN" ] || { err "Couldn't determine fish binary path."; exit 1; }
    info "fish binary: $FISH_BIN"

    # --- ensure fish is an allowed login shell ---
    if ! grep -qxF "$FISH_BIN" /etc/shells; then
        info "Adding $FISH_BIN to /etc/shells (requires sudo)..."
        # Append safely without duplicates
        printf "%s\n" "$FISH_BIN" | sudo tee -a /etc/shells >/dev/null
    else
        info "fish already listed in /etc/shells."
    fi

    # --- change the login shell (only if needed) ---
    CURRENT_SHELL="${SHELL:-}"
    if [ "$CURRENT_SHELL" = "$FISH_BIN" ]; then
        info "Login shell already fish ($CURRENT_SHELL)."
    else
        info "Changing login shell to fish… (you may be prompted for your password)"
        run chsh -s "$FISH_BIN"
    fi

    mkdir -p "$HOME/.config/fish/"
    FISH_CONFIG="$HOME/.config/fish/config.fish"
    LINE='source "$HOME/.dotfiles/fish/user.config.fish"'

    # Append only if the exact line is not already present
    if ! grep -qxF "$LINE" "$FISH_CONFIG" 2>/dev/null; then
        echo "$LINE" >> "$FISH_CONFIG"
    fi
}

### ---------- groupings ----------
group brew "install_brew brew_taps install_cli install_gui"
group base "setup_dotfiles"
group mac "macos_defaults"

### ---------- CLI ----------
usage(){
  cat <<EOF
Usage:
  $0 all                      # run every task (respecting dependencies)
  $0 group <name>             # run a group (brew | base | mac | …)
  $0 task <name> [name…]      # run specific task(s)
  $0 list                     # list tasks
  $0 help
EOF
}

list_tasks(){
  echo "Tasks:"
  for t in $TASKS; do
    local dvar="TASK_DESCR__${t}"; local d="${!dvar:-}"; printf "  - %-18s %s\n" "$t" "$d"
  done
  echo; echo "Groups:"
  compgen -v | grep -E '^GROUP__' | sed 's/^GROUP__//' | while read -r g; do
    local vvar="GROUP__${g}"; echo "  - $g: ${!vvar}"
  done
}

main(){
    sudo -v
  case "${1:-all}" in
    all)        run_all ;;
    group)      shift; run_group "${1:-}";;
    task)       shift; for t in "$@"; do _run_task "$t"; done ;;
    list)       list_tasks ;;
    help|-h|--help) usage ;;
    *)          usage; exit 2 ;;
  esac

  echo
  header "Summary"
  echo "  ${GREEN}Succeeded${RESET}: ${#SUCCEEDED[@]} ${SUCCEEDED[*]:+— ${SUCCEEDED[*]}}"
  echo "  ${YELLOW}Skipped  ${RESET}: ${#SKIPPED[@]}   ${SKIPPED[*]:+— ${SKIPPED[*]}}"
  echo "  ${RED}Failed   ${RESET}: ${#FAILED[@]}    ${FAILED[*]:+— ${FAILED[*]}}"
  [ "${#FAILED[@]}" -gt 0 ] && exit 1 || exit 0
}

main "$@"
