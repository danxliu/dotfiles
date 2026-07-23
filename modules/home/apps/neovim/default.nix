{ pkgs, theme, ... }:
{
  xdg.configFile = {
    "nvim/snippets".source = ./nvim/snippets;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      bufferline-nvim
      conform-nvim
      luasnip
      nvim-lspconfig
      blink-cmp
      mini-pick
      nvim-web-devicons
      dashboard-nvim
      nvim-colorizer-lua
      vimtex
      markview-nvim
      lualine-nvim
      nvim-tree-lua
      indent-blankline-nvim
      gitsigns-nvim
      nvim-autopairs
      nvim-ts-autotag
      base16-nvim
    ];
    initLua = theme.replaceText (builtins.readFile ./nvim/init.lua);
  };
}
