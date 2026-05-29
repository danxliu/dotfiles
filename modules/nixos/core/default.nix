{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../desktop/niri
    ../services/common.nix
    ../users/daniel.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config = {
    allowUnfree = true;
    joypixels.acceptLicense = true;
  };

  networking.networkmanager.enable = true;
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  fonts.packages = with pkgs; [
    nerd-fonts.zed-mono
    nerd-fonts.iosevka
    material-design-icons
    ibm-plex
    joypixels
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    alegreya
    alegreya-sans
  ];

  environment.systemPackages = with pkgs; [
    gtk3
    gtk3.dev

    adwaita-icon-theme
    hicolor-icon-theme
    adw-gtk3
    papirus-icon-theme
    quintom-cursor-theme

    file-roller
    unzip
    git
    wget
    devenv
    python315
    uv
    networkmanagerapplet
    wl-clipboard
    lm_sensors
    system-config-printer
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  programs.tmux.enable = true;
  programs.fish.enable = true;

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  programs.nix-index-database.comma.enable = true;
  programs.nix-ld.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
  programs.npm = {
    enable = true;
    package = pkgs.nodejs;
  };
}
