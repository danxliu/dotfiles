{
  pkgs,
  theme,
  config,
  inputs,
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
    ../../modules/home/services/mpd.nix
    ../../modules/home/services/gnome-keyring.nix
  ];
  home.username = "daniel";
  home.homeDirectory = "/home/daniel";
  home.stateVersion = "25.11";

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };
      "acro" = {
        HostName = "192.168.50.242";
        User = "daniel";
        Port = 2222;
      };
      "ts_acro" = {
        HostName = "100.96.31.77";
        User = "daniel";
        Port = 2222;
      };
      "home" = {
        HostName = "192.168.50.233";
        User = "daniel";
        Port = 2222;
        IdentityFile = "~/.ssh/id_rsa";
      };
      "ts_home" = {
        HostName = "100.85.4.120";
        User = "daniel";
        Port = 2222;
        IdentityFile = "~/.ssh/id_rsa";
      };
      "koi" = {
        HostName = "koi.ocf.berkeley.edu";
        User = "danliu";
        LocalForward = [
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
    gimp
    cheese
    prismlauncher
    aseprite
    wl-color-picker
    android-studio
    android-tools
    openssl

    pi-coding-agent
    inputs.hermes-agent.packages.x86_64-linux.desktop
    gws

    tree-sitter
    pstree
    texliveFull

    # LSPs
    clang-tools
    pyright
    jdt-language-server
    typescript-language-server
    vscode-langservers-extracted
    rust-analyzer
    nixd
    texlab
    marksman
    lua-language-server
    bash-language-server
    yaml-language-server
    svelte-language-server
    tailwindcss-language-server
    emmet-language-server
    harper
    kotlin-language-server
    nil

    # Formatters & Linters
    nixfmt
    black
    shellcheck
    prettierd
    stylua
    shfmt
    ruff

    nvtopPackages.nvidia
    antigravity-cli
    poppler-utils
    ripgrep
    tree
    xdotool
    ncdu
    awww
    ffmpeg
    ncmpcpp
    yt-dlp
    hyprlock
    pavucontrol
    docker
    gcr
  ];

  home.shellAliases = {
    ytmp3 = "yt-dlp --extract-audio --audio-format mp3 --format bestaudio --embed-thumbnail --embed-metadata --embed-chapters --output '${config.home.homeDirectory}/Music/%(uploader)s/%(playlist)s/%(title)s.%(ext)s'";
  };

  xdg.desktopEntries.hermes = {
    name = "Hermes";
    exec = "${inputs.hermes-agent.packages.x86_64-linux.desktop}/bin/hermes-desktop";
    icon = "${inputs.hermes-agent.packages.x86_64-linux.desktop}/share/hermes-desktop/dist/hermes.png";
    categories = [ "Development" "Utility" ];
    terminal = false;
  };
}
