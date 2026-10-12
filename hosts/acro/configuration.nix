{
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core.nix
    ../../modules/nixos/users/daniel.nix
    ../../modules/nixos/services/docker.nix
    ../../modules/nixos/services/llama-cpp.nix
  ];

  home-manager.users.daniel = {
    imports = [
      ../../users/daniel/base.nix
      ../../users/daniel/dev.nix
    ];
  };

  boot.loader.systemd-boot.enable = false;
  boot.loader.timeout = 10;
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "acro";

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    extraCommands = ''
      iptables -A nixos-fw -s 192.168.50.0/24 -j nixos-fw-accept
    '';
    extraStopCommands = ''
      iptables -D nixos-fw -s 192.168.50.0/24 -j nixos-fw-accept || true
    '';
  };

  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    openFirewall = false;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  services.avahi.openFirewall = false;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia-container-toolkit.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = false;
  };

  system.stateVersion = "25.11";
}
