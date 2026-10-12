{
  pkgs,
  lib,
  ...
}:

{
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

  # Core services
  services.openssh.enable = true;
  services.tailscale.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = lib.mkDefault true;
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    tmux
    htop
    nvtopPackages.nvidia
    gh
    python315
    uv
    lm_sensors
    pciutils
    usbutils
    lshw
    unzip
    devenv
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

  programs.nix-index-database.comma.enable = true;
}
