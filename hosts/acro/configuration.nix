{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core/server.nix
    ../../modules/nixos/services/docker.nix
  ];

  # Basic Bootloader config (Assuming standard systemd-boot for modern EFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "acro";

  # NVIDIA Drivers configuration (Headless)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    hardware.nvidia-container-toolkit.enable = true;
    open = false;
    nvidiaSettings = false; # Not needed for headless
  };

  system.stateVersion = "25.11";
}
