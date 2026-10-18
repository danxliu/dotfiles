{
  pkgs,
  theme,
  ...
}:

{
  imports = [
    ../../modules/home/apps/niri
    ../../modules/home/apps/alacritty
    ../../modules/home/apps/firefox
    ../../modules/home/apps/hermes
    ../../modules/home/apps/hyprlock
    ../../modules/home/apps/dunst
    ../../modules/home/apps/waybar
    ../../modules/home/apps/wofi
    ../../modules/home/apps/zathura
    ../../modules/home/apps/zed
    ../../modules/home/desktop/xdg.nix
    ../../modules/home/services/cliphist.nix
    ../../modules/home/services/awww.nix
    ../../modules/home/services/mpd.nix
    ../../modules/home/services/gnome-keyring.nix
  ];

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

  programs.obsidian.enable = true;

  home.packages = with pkgs; [
    alacritty
    android-studio
    android-tools
    aseprite
    awww
    blender
    blockbench
    cheese
    ergogen
    gcr_4
    gimp
    godot
    gws
    hyprlock
    kicad
    libreoffice-stable
    loupe
    mpv
    ncmpcpp
    obs-studio
    pavucontrol
    pinta
    prismlauncher
    trayscale
    vesktop
    wl-clipboard
    wl-color-picker
    xdotool
  ];
}
