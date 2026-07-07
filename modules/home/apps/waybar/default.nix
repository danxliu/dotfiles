{
  theme,
  ...
}:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        reload_style_on_change = true;
        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];
        modules-center = [ ];
        modules-right = [
          "tray"
          "custom/separator"
          "network"
          "battery"
          "custom/separator"
          "group/audio"
          "custom/separator"
          "clock"
          "custom/separator"
          "custom/power"
        ];

        "niri/workspaces" = {
          format = "{value}";
        };

        "niri/window" = {
          format = "{app_id}";
          icon = true;
          rewrite = {
            "^(.*)$" = "<span text_transform='capitalize'>$1</span>";
          };
        };
        "custom/separator" = {
          format = " / ";
        };
        "group/audio" = {
          orientation = "horizontal";
          modules = [
            "pulseaudio"
            "pulseaudio/slider"
          ];
        };

        clock = {
          timezone = "America/Los_Angeles";
          format = "{:%I:%M %p}";
          tooltip-format = "{:%A, %B %d %Y}";
        };

        battery = {
          format = "{icon}";
          format-icons = [
            "󱊡"
            "󱊢"
            "󱊣"
          ];
          tooltip-format = "{capacity}%";
          format-charging = "󰂄";
          tooltip-format-charging = "{capacity}%+";
        };

        network = {
          format-wifi = "{icon}";
          format-icons = [
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          tooltip-format-wifi = "{essid}";
          format-ethernet = "󰈀";
          tooltip-format-ethernet = "{ifname}";
          format-disconnected = "󰤮";
          tooltip-format-disconnected = "Disconnected";
        };

        pulseaudio = {
          format = "{icon}";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          format-muted = "󰝟";
          tooltip-format = "{volume}%";
          tooltip-format-muted = "Muted";
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };

        tray = {
          icon-size = 14;
          spacing = 6;
        };

        "custom/power" = {
          format = "";
          on-click = "systemctl hibernate";
          tooltip = false;
        };
      };
    };
    style = theme.replaceText (builtins.readFile ./style.css);
  };
}
