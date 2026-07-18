{
  config,
  pkgs,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in {
  home.packages = with pkgs; [
    neovim
    # Dependencies
    ripgrep
    tree-sitter
    gcc
    # Servers
    nil
    alejandra
    lua-language-server
    stylua
    bash-language-server
    vue-language-server
    typescript-language-server
    # vtsls
    emmet-ls
    eslint_d
    prettier
    prettierd
  ];

  xdg.configFile."nvim" = {
    source = create_symlink "${dotfiles}/nvim";
    recursive = true;
  };
}
