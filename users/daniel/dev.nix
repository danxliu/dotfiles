{ pkgs, ... }:

{
  imports = [
    ../../modules/home/apps/pi
  ];

  home.packages = with pkgs; [
    tree-sitter
    texliveFull

    # Language Servers
    bash-language-server
    clang-tools
    emmet-language-server
    harper
    jdt-language-server
    kotlin-language-server
    lua-language-server
    marksman
    nil
    nixd
    pyright
    rust-analyzer
    svelte-language-server
    tailwindcss-language-server
    texlab
    typescript-language-server
    vscode-langservers-extracted
    yaml-language-server

    # Formatters & Linters
    black
    nixfmt
    prettierd
    ruff
    shellcheck
    shfmt
    stylua
  ];
}
