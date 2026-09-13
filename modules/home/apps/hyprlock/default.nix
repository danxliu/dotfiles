{ lib, config, theme, ...}:
with lib;
let
  cfg = config.apps.hyprlock;
  colors = config.colorScheme.palette;
  borderRadius = theme.borderRadius;
in
{
  options.apps.hyprlock = {
    font = {
      name = mkOption {
        type = types.str;
        default = "ZedMono NFM";
      };
      size = mkOption {
        type = types.int;
        default = 12;
      };
    };
    wallpaper = mkOption {
      type = types.path;
      default = ../../theme/wallpapers/nixos-light.png;
    };
  };
  config = {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
          ignore_empty_input = true;
        };

        animations = {
          enabled = true;
        };

        background = [
          {
            path = "${cfg.wallpaper}";
            blur_passes = 1;
            blur_size = 8;
          }
        ];

        label = [
          {
            position = "0, 100";
            text = "cmd[update:1000] echo $(date '+%H:%M')";
            color = "rgb(${colors.base00})";
            font_family = "${cfg.font.name}";
            font_size = "${toString cfg.font.size}";
            halign = "center";
            valign = "center";
          }
        ];

        input-field = [
          {
            size = "300, 50";
            position = "0, -80";
            fade_on_empty = false;
            font_family = "${cfg.font.name}";
            font_color = "rgb(${colors.base07})";
            inner_color = "rgb(${colors.base00})";
            outer_color = "rgb(${colors.base01})";
            fail_color = "rgb(${colors.base08})";
            check_color = "rgb(${colors.base0D})";
            outline_thickness = 1;
            placeholder_text = "Password";
            rounding = borderRadius;
            shadow_passes = 2;
            shadow_size = 8;
          }
        ];
      };
    };
  };
}
