# On new install we might not have fisher installed
if not test -f ~/.config/fish/functions/fisher.fish
  # Download latest fisher version
  curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
  # Run fisher to diplay information
  fisher
  # Install bass plugin, it provides compatibility with bash
  fisher add edc/bass
  # Install metro prompt
  fisher add jorgebucaran/fish-metro
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
    source ~/google-cloud-sdk/path.fish.inc
end

# Sets GOPATH
set -x GOPATH $HOME/code/go
set fish_user_paths $GOPATH/bin

# Various aliases for modern utils replacements
alias ls=exa
alias find=fd
alias cat=bat
alias grep=rg
