{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../services/common.nix
    ../users/daniel.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  networking.networkmanager.enable = true;
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    tmux
    htop
    nvtopPackages.nvidia
    gh
    docker
    python315
    uv
    lm_sensors
    pciutils
    usbutils
    lshw
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  programs.dconf.enable = true;
  programs.tmux.enable = true;
  programs.fish.enable = true;

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.nix-index-database.comma.enable = true;
}
