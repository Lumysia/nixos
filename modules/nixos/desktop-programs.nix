{ pkgs, config, ... }:

{
  programs.localsend.enable = true;
  programs.gamemode.enable = true;
  programs.steam.enable = true;

  # MDNS discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
  # Printing service
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };
  services.thermald.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      tailscale = prev.tailscale.overrideAttrs (oldAttrs: {
        doCheck = false;
      });
    })
  ];
  services.tailscale.enable = true;
}
