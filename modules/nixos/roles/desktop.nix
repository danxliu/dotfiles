{
  pkgs,
  lib,
  ...
}:

{
  nixpkgs.config = {
    joypixels.acceptLicense = true;
  };

  # Graphical session
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  services.blueman.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.tuigreet} --time --remember --remember-user-session --cmd niri-session";
        user = "greeter";
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Hardware input
  services.libinput.enable = true;

  # Printing
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      gutenprintBin
      brlaser
    ];
  };

  # File management
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # Dconf
  programs.dconf.enable = true;

  # Runtimes
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
  programs.npm = {
    enable = true;
    package = pkgs.nodejs;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      glib
      nss
      nspr
      libX11
      libxcb
      libXcomposite
      libXext
      libXfixes
      libXrandr
      libXdamage
      alsa-lib
      mesa
      libdrm
      libxkbcommon
      pango
      cairo
      gtk3
      libgbm
      atk
      cups
      dbus
      expat
    ];
  };

  # Typography
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

  # Workstation packages
  environment.systemPackages = with pkgs; [
    xwayland-satellite

    gtk3
    gtk3.dev
    adwaita-icon-theme
    hicolor-icon-theme
    adw-gtk3
    papirus-icon-theme
    quintom-cursor-theme

    file-roller
    networkmanagerapplet
    wl-clipboard
    system-config-printer
  ];
}
