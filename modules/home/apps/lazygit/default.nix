{ ... }:
{
  programs.lazygit = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      gui = {
        border = "single";
        theme = {
          selectedLineBgColor = [ "default" "bold" ];
        };
      };
    };
  };
}
