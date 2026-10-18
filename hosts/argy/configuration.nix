{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core.nix
    ../../modules/nixos/roles/desktop.nix
    ../../modules/nixos/users/daniel.nix
    ../../modules/nixos/services/docker.nix
  ];

  home-manager.users.daniel = {
    imports = [
      ../../users/daniel/default.nix
      inputs.hermes-agent.homeManagerModules.default
    ];

    programs.hermes-agent.enable = true;
    services.hermes-agent = {
      enable = true;
      gateway.enable = true;
      settings = {
        model = {
          provider = "openrouter";
          default = "deepseek/deepseek-v4.1-flash-1017";
        };
        memory.provider = "";
      };
      environmentFiles = [
        config.age.secrets.openrouter-key.path
        config.age.secrets.discord-key.path
      ];
      extraDependencyGroups = [ "messaging" ];
      extraPackages = [ pkgs.ffmpeg ];
    };
  };

  age.secrets.openrouter-key = {
    file = ../../secrets/openrouter-key.age;
    owner = "daniel";
    mode = "0400";
  };
  age.secrets.discord-key = {
    file = ../../secrets/discord-key.age;
    owner = "daniel";
    mode = "0400";
  };

  users.users.daniel.linger = true;

  boot.loader.systemd-boot.enable = false;
  boot.loader.timeout = 10;
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "argy";

  networking.firewall.allowedTCPPorts = [ 8081 ];

  hardware.bluetooth.enable = true;
  hardware.acpilight.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;
    };
  };
  services.thermald.enable = true;
  services.undervolt = {
    enable = true;
    coreOffset = -50;
    gpuOffset = -30;
    analogioOffset = -50;
  };
  system.stateVersion = "25.11";
}
