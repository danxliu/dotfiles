{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  wallpaper = ./wallpapers/nixos-light.png;
  fontMonoName = "ZedMono NFM";
  fontUIName = "IBM Plex Sans";
  fontIconName = "Material Design Icons";
  fontSize0 = 12;
  fontSize1 = 18;
  fontSize2 = 24;
  fontSize3 = 32;
  fontSize4 = 48;
  fontSize5 = 72;
  replaceText =
    text:
    let
      palette = config.colorScheme.palette;
      placeholders = map (name: "@${name}@") (
        (builtins.attrNames palette)
        ++ [
          "fontMono"
          "fontUI"
          "fontIcon"
          "fontSize0"
          "fontSize1"
          "fontSize2"
          "fontSize3"
          "fontSize4"
          "fontSize5"
        ]
      );
      replacements = (map (val: "#${val}") (builtins.attrValues palette)) ++ [
        fontMonoName
        fontUIName
        fontIconName
        (toString fontSize0)
        (toString fontSize1)
        (toString fontSize2)
        (toString fontSize3)
        (toString fontSize4)
        (toString fontSize5)
      ];
    in
    builtins.replaceStrings placeholders replacements text;
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  _module.args.theme = {
    inherit replaceText;
    inherit fontMonoName;
    inherit fontUIName;
    inherit fontIconName;
    inherit fontSize0;
    inherit fontSize1;
    inherit fontSize2;
    inherit fontSize3;
    inherit fontSize4;
    inherit fontSize5;
    inherit wallpaper;
  };

  colorScheme = {
    slug = "mountain-dark";
    name = "Mountain Dark";
    palette = {
      base00 = "0f0f0f";
      base01 = "191919";
      base02 = "262626";
      base03 = "393939";
      base04 = "767676";
      base05 = "a0a0a0";
      base06 = "e7e7e7";
      base07 = "f0f0f0";
      base08 = "ac8a8c";
      base09 = "c6a679";
      base0A = "aca98a";
      base0B = "8aac8b";
      base0C = "8aacab";
      base0D = "8a98ac";
      base0E = "ac8aac";
      base0F = "8f8aac";
    };
  };
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.theme = config.gtk.theme;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    cursorTheme = {
      name = "Quintom_Ink";
      package = pkgs.quintom-cursor-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
