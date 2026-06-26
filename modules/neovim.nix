{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    tree-sitter
    nil
    alejandra
    lua-language-server
    stylua
    bash-language-server
    vue-language-server
    vtsls
    emmet-ls
    eslint_d
    prettier
    prettierd
  ];
}
