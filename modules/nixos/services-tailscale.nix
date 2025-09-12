{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      tailscale = prev.tailscale.overrideAttrs (oldAttrs: {
        doCheck = false;
      });
    })
  ];
  services.tailscale = {
    enable = true;
    authKeyFile = "/etc/nixos/secrets/tailscale-authkey";
    extraUpFlags = [
      "--accept-dns"
      "--snat-subnet-routes=false"
    ];
  };
}
