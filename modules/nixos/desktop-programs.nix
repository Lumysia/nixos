{ pkgs, config, ... }:

{
  programs.localsend.enable = true;
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  
  services.printing.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      tailscale = prev.tailscale.overrideAttrs (oldAttrs: {
        doCheck = false;
      });
    })
  ];
  services.tailscale.enable = true;
}