# On new install we might not have fisher installed
if not test -f ~/.config/fish/functions/fisher.fish
  # Download latest fisher version
  curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
  # Run fisher to diplay information
  fisher
  # Install bass plugin, it provides compatibility with bash
  fisher add edc/bass
end

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

function fish_greeting
    fortune
end

# Source kubectl include paths
if test -d $HOME/google-cloud-sdk
    source $HOME/google-cloud-sdk/path.fish.inc
end

# Source rustup env
if test -d $HOME/.cargo
    source $HOME/.cargo/env
end

# Sets path to go binary and GOPATH
set -U fish_user_paths $fish_user_paths $HOME/.go/bin
set -U fish_user_paths $fish_user_paths $HOME/go/bin

# Various aliases for modern utils replacements
alias ls=exa
alias find=fd
alias cat=bat
alias grep=rg

alias k=kubectl

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/kri5/code/laptop_install/google-cloud-sdk/path.fish.inc' ]; . '/home/kri5/code/laptop_install/google-cloud-sdk/path.fish.inc'; end
