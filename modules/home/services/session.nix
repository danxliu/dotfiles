{ pkgs, theme, ... }:
{
  systemd.user.services.awww = {
    Unit = {
      Description = "Awww Wallpaper Daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.awww}/bin/awww-daemon";
      ExecStartPost = "${pkgs.writeShellScript "awww-set-wallpaper" ''
        until ${pkgs.awww}/bin/awww query >/dev/null 2>&1; do
          sleep 0.1
        done
        ${pkgs.awww}/bin/awww img ${theme.wallpaper}
      ''}";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
