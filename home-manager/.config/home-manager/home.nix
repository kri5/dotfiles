{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kri5";
  home.homeDirectory = "/home/kri5";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.cpufetch
    pkgs.dua
    pkgs.du-dust
    pkgs.eza
    pkgs.fd
    # we required to bring our own nix gcc, as it will be invoked by the nix installed
    # neovim, and if not, the system gcc will be used, and link to libraries that are
    # not in the LD_LIBRARY_PATH of the nix store
    pkgs.gcc
    pkgs.k9s
    pkgs.kubernetes-helm
    pkgs.kubectl
    pkgs.krew
    pkgs.lemmeknow
    pkgs.neofetch
    pkgs.rustup
    pkgs.skaffold
    pkgs.tokei
  ];
  home.activation = {
    install-kubectl-plugins = lib.hm.dag.entryAfter [ "installPackages" ] ''
      PATH="${config.home.path}/bin:$PATH" $DRY_RUN_CMD krew install ctx ns;
    '';
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kri5/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
  };

  home.shellAliases = {
    find = "fd";
    k = "kubectl";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.starship.enable = true;
  programs.btop.enable = true;
  programs.zoxide.enable = true;
  programs.git.enable = true;

  programs.bash = {
    enable = true;
    initExtra = "
if [ -f $HOME/.config/bash/.bashrc ];
then
  source $HOME/.config/bash/.bashrc
fi";
  };

  programs.fish = {
    enable = true;
    shellInit = ''
if test -f $HOME/.config/fish/config.base.fish
  source $HOME/.config/fish/config.base.fish
end
${config.home.path}/bin/skaffold completion fish | source
set -gx PATH $PATH $HOME/.krew/bin
'';
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
  };

  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f --hidden";
    changeDirWidgetCommand = "fd --type d --hidden";
    fileWidgetCommand = "fd --type f --hidden";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };
}
