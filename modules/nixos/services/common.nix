{
  pkgs,
  lib,
  ...
}:

{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      gutenprintBin
      brlaser
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = lib.mkDefault true;
  };

  services.openssh.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;
  services.tailscale.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
}
