{ pkgs, ... }:

{
  services.tailscale = {
    enable = true;
    authKeyFile = "/etc/nixos/secrets/tailscale-authkey";
    extraUpFlags = [
      "--accept-dns"
      "--snat-subnet-routes=false"
    ];
  };
}