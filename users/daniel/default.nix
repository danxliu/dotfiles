{
  pkgs,
  theme,
  config,
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
    ../../modules/home/apps/zathura
    ../../modules/home/apps/zed
    ../../modules/home/desktop/xdg.nix
    ../../modules/home/services/session.nix
  ];
  home.username = "daniel";
  home.homeDirectory = "/home/daniel";
  home.stateVersion = "25.11";

  programs.ssh = {
    enable = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';
    matchBlocks = {
      "acro" = {
        hostname = "192.168.50.242";
        user = "daniel";
        port = 2222;
      };
      "ts_acro" = {
        hostname = "100.96.31.77";
        user = "daniel";
        port = 2222;
      };
      "home" = {
        hostname = "192.168.50.233";
        user = "daniel";
        port = 2222;
        identityFile = "~/.ssh/id_rsa";
      };
      "ts_home" = {
        hostname = "100.85.4.120";
        user = "daniel";
        port = 2222;
        identityFile = "~/.ssh/id_rsa";
      };
      "koi" = {
        hostname = "koi.ocf.berkeley.edu";
        user = "danliu";
        localForwards = [
          {
            bind.port = 8841;
            host.address = "localhost";
            host.port = 8841;
          }
        ];
      };
    };
  };

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

  programs.htop.enable = true;
  programs.obsidian.enable = true;

  home.packages = with pkgs; [
    vesktop
    trayscale
    blockbench
    alacritty
    loupe
    libreoffice-fresh
    obs-studio
    mpv
    pinta
    cheese
    prismlauncher
    aseprite
    wl-color-picker

    pi-coding-agent

    tree-sitter
    pstree
    texliveFull

    nvtopPackages.nvidia

    antigravity-cli
    poppler-utils
    ripgrep
    tree
    xdotool
    ncdu
    awww
    ffmpeg
    hyprlock
    pavucontrol
    docker
  ];
}
