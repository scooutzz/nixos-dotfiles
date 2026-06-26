{
  config,
  pkgs,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hypr";
    foot = "foot";
    themes = "themes";
    nvim = "nvim";
  };
in {
  imports = [
    ./modules/neovim.nix
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

  programs.zsh = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
      cd = "z";
    };
    setOptions = [
      "HIST_IGNORE_DUPS"
      "HIST_IGNORE_SPACE"
      "SHARE_HISTORY"
    ];
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
  };
  programs.zoxide.enable = true;

  xdg.configFile =
    builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    ripgrep
    cargo
    nodejs
    gcc
    foot
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
