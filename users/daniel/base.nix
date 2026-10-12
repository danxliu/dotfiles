{
  pkgs,
  config,
  ...
}:

{
  imports = [
    ../../modules/home/theme
    ../../modules/home/apps/fish
    ../../modules/home/apps/tmux
    ../../modules/home/apps/neovim
    ../../modules/home/apps/lazygit
  ];

  home.username = "daniel";
  home.homeDirectory = "/home/daniel";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

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

  programs.htop.enable = true;

  home.packages = with pkgs; [
    antigravity-cli
    ffmpeg
    ncdu
    nvtopPackages.nvidia
    openssl
    poppler-utils
    pstree
    ragenix
    ripgrep
    tree
    yt-dlp
  ];

  home.shellAliases = {
    ytmp3 = "yt-dlp --extract-audio --audio-format mp3 --format bestaudio --embed-thumbnail --embed-metadata --embed-chapters --output '${config.home.homeDirectory}/Music/%(uploader)s/%(playlist)s/%(title)s.%(ext)s'";
  };
}
