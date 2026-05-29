{
  pkgs,
  theme,
  ...
}:
{
  imports = [
    ../../modules/home/theme
    ../../modules/home/apps/alacritty
    ../../modules/home/apps/firefox
    ../../modules/home/apps/fish
    ../../modules/home/apps/hyprlock
    ../../modules/home/apps/dunst
    ../../modules/home/apps/neovim
    ../../modules/home/apps/tmux
    ../../modules/home/apps/vscode
    ../../modules/home/apps/waybar
    ../../modules/home/apps/wofi
    ../../modules/home/apps/zed
    ../../modules/home/desktop/xdg.nix
    ../../modules/home/services/session.nix
  ];
  home.username = "danliu";
  home.homeDirectory = "/home/d/da/danliu";
  home.stateVersion = "25.11";

  programs.ssh.enable = true;
  programs.home-manager.enable = true;
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Daniel Liu";
        email = "danxliu@protonmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  apps.dunst = {
    iconTheme = "Papirus";
    font = {
      name = theme.fontUIName;
      size = theme.fontSize0;
    };
  };
  apps.alacritty = {
    font = {
      name = theme.fontMonoName;
      size = theme.fontSize0;
    };
  };
  apps.hyprlock = {
    font = {
      name = theme.fontUIName;
      size = theme.fontSize5;
    };
    wallpaper = theme.wallpaper;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  fonts.fontconfig.enable = true;

  programs.htop.enable = true;
  programs.obsidian.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.zed-mono
    nerd-fonts.iosevka
    material-design-icons
    ibm-plex
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans

    vesktop
    trayscale

    tree-sitter
    pstree
    texliveFull

    nvtopPackages.nvidia

    gemini-cli
    github-copilot-cli
    ripgrep
    tree
    xdotool
    awww
    hyprlock
    pavucontrol
    alacritty
    loupe
    libreoffice-fresh
    zathura
    obs-studio
    mpv
    pinta
  ];
}
