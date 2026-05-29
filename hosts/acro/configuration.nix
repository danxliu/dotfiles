{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core/server.nix
    ../../modules/nixos/services/docker.nix
  ];

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

  # NVIDIA Drivers configuration (Headless)
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
    nvidiaSettings = false; # Not needed for headless
  };

  system.stateVersion = "25.11";
}
