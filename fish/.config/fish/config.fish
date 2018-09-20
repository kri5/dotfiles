# On new install we might not have fisher installed
if not test -f ~/.config/fish/functions/fisher.fish
  # Download latest fisher version
  curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
  # Run fisher to diplay information
  fisher
  # Install bass plugin, it provides compatibility with bash
  fisher edc/bass
end
