{
  inputs,
  config,
  pkgs,
  ...
}:

let
  home = config.users.users.daniel.home;
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core/default.nix
    ../../modules/nixos/services/docker.nix
    inputs.hermes-agent.nixosModules.default
  ];

  age.secrets.hermes-env = {
    file = ../../secrets/hermes-env.age;
    owner = "hermes";
    group = "hermes";
  };

  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true;
    container.enable = true;
    container.hostUsers = [ "daniel" ];
    container.extraVolumes = [ "${home}:${home}:rw" ];
    user = "daniel";
    group = "users";
    createUser = false;
    settings = {
      model = {
        provider = "opencode-go";
        default = "deepseek-v4-flash";
      };
      auxiliary.vision = {
        provider = "opencode-go";
        model = "mimo-v2.5";
      };
      memory.provider = "mem0";
      display.pet = {
        enabled = true;
        slug = "blahaj";
      };
    };
    environmentFiles = [ config.age.secrets.hermes-env.path ];
    environment = {
      HERMES_GWS_BIN = "${pkgs.gws}/bin/gws";
      PLAYWRIGHT_BROWSERS_PATH = "${home}/.cache/ms-playwright";
      AGENT_BROWSER_ARGS = "--no-sandbox,--disable-dev-shm-usage";
    };
    extraDependencyGroups = [ "mem0" "messaging" "exa" ];
    extraPythonPackages = [ pkgs.python312Packages.fastembed ];
    extraPackages = [ pkgs.gws ];
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
