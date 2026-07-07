{
  config,
  pkgs,
  inputs,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hypr";
    kitty = "kitty";
    foot = "foot";
    themes = "themes";
    quickshell = "quickshell";
    yazi = "yazi";
  };
in {
  imports = [
    ./modules/zsh.nix
    ./modules/neovim.nix
    ./modules/tmux.nix
  ];

  home.username = "relaxou";
  home.homeDirectory = "/home/relaxou";
  home.stateVersion = "26.05";

  programs.git = {
    enable = true;
    settings = {
      user.name = "Fabio de Almeida";
      user.email = "fabioalmeida2004@gmail.com";
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };

  xdg.configFile =
    builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.sessionPath = [
    "${config.home.homeDirectory}/nixos-dotfiles/scripts"
  ];

  home.packages = with pkgs; [
    kitty
    foot
    yazi
    # quickshell
    # inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    quickshell
    awww
    # zen
    # inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    zen-browser
    # Nix Search
    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    })
  ];
}
