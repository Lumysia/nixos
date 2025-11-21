{ pkgs, lib, config, ... }:

{
  options.features.services.tailscale.enable = lib.mkEnableOption "Tailscale Mesh VPN";

  config = lib.mkIf config.features.services.tailscale.enable {
    nixpkgs.overlays = [
      (final: prev: {
        tailscale = prev.tailscale.overrideAttrs (oldAttrs: {
          doCheck = false;
        });
      })
    ];

    services.tailscale = {
      enable = true;
      # Note: authKeyFile path might need adjustment per host.
      authKeyFile = "/etc/nixos/secrets/tailscale-authkey";
      extraUpFlags = [
        "--accept-dns"
        "--snat-subnet-routes=false"
      ];
    };
  };
}