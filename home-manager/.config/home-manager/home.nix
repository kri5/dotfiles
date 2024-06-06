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

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

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
    pkgs.ansible
    pkgs.cpufetch
    pkgs.dive
    pkgs.du-dust
    pkgs.dua
    pkgs.erdtree
    pkgs.eza
    pkgs.fd
    # we required to bring our own nix gcc, as it will be invoked by the nix installed
    # neovim, and if not, the system gcc will be used, and link to libraries that are
    # not in the LD_LIBRARY_PATH of the nix store
    pkgs.gcc
    pkgs.gitlab-runner
    pkgs.go
    (pkgs.google-cloud-sdk.withExtraComponents [
      pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])
    pkgs.grype
    pkgs.httpie
    pkgs.jd-diff-patch
    pkgs.jp
    pkgs.json2yaml
    pkgs.k9s
    pkgs.krew
    pkgs.kubectl
    pkgs.kubelogin-oidc
    pkgs.kubernetes-helm
    pkgs.lemmeknow
    pkgs.neofetch
    pkgs.nodejs_18
    pkgs.openssl.dev
    pkgs.podman
    pkgs.ruby
    pkgs.rustup
    pkgs.skaffold
    pkgs.sops
    pkgs.sqlite-interactive
    pkgs.terraform
    pkgs.terragrunt
    pkgs.tflint
    pkgs.tokei
    (pkgs.vagrant.overrideAttrs (_: { doInstallCheck = false; }))
    pkgs.velero
    pkgs.wireguard-tools
    pkgs.yaml2json
  ];
  home.activation = {
    install-kubectl-plugins = lib.hm.dag.entryAfter [ "installPackages" ] ''
      PATH="${config.home.path}/bin:$PATH" $DRY_RUN_CMD krew install ctx ns view-allocations;
    '';
    set-npm-prefix = lib.hm.dag.entryAfter [ "installPackages" ] ''
      PATH="${config.home.path}/bin:$PATH" $DRY_RUN_CMD npm set prefix ~/.npm-global;
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

  home.sessionPath = [
    "/mnt/c/Windows/System32"
  ];

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
if test -f $HOME/.nix-profile/google-cloud-sdk/path.fish.inc
  source $HOME/.nix-profile/google-cloud-sdk/path.fish.inc
end
${config.home.path}/bin/skaffold completion fish | source
${config.home.path}/bin/podman completion fish | source
set -gx PATH $PATH $HOME/.krew/bin
set -gx PATH $PATH $HOME/.npm-global/bin
'';
    plugins = [
      {
        name = "google-cloud-sdk-fish-completion";
        src = pkgs.fetchFromGitHub {
          owner = "lgathy";
          repo = "google-cloud-sdk-fish-completion";
          rev = "master";
          hash = "sha256-BIbzdxAj3mrf340l4hNkXwA13rIIFnC6BxM6YuJ7/w8=";
        };
      }
    ];
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
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
