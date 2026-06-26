{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    tree-sitter
    nil
    alejandra
    stylua
  ];
}
