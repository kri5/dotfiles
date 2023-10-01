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

starship init fish | source


# Source kubectl include paths
if test -d $HOME/google-cloud-sdk
    source $HOME/google-cloud-sdk/path.fish.inc
end

# Sets rust binary path
fish_add_path $HOME/.cargo/bin

# Sets rbenv binary path
set -gx PATH $HOME/.rbenv/bin $PATH

# Sets go binary path
set -gx PATH $HOME/go/bin $PATH

# Various aliases for modern utils replacements
alias ls=eza
alias find=fd
alias cat=bat
alias grep=rg

alias k=kubectl

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/kri5/code/laptop_install/google-cloud-sdk/path.fish.inc' ]; . '/home/kri5/code/laptop_install/google-cloud-sdk/path.fish.inc'; end
