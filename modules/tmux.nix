{
  config,
  pkgs,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in {
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    mouse = true;
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      sensible
      yank
    ];

    extraConfig = ''
      source-file ~/.config/tmux/repo/tmux-conf.conf
    '';
  };

  home.packages = with pkgs; [
    fzf
  ];

  xdg.configFile."tmux/repo" = {
    source = create_symlink "${dotfiles}/tmux";
    recursive = true;
  };

  xdg.configFile."tmux-sessionizer" = {
    source = create_symlink "${dotfiles}/tmux-sessionizer";
    recursive = true;
  };
}
