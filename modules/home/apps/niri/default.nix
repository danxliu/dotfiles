{ theme, ... }:
let
  niriTemplate = builtins.readFile ./config.kdl;
in
{
  xdg.configFile."niri/config.kdl".text = theme.replaceText niriTemplate;
}
