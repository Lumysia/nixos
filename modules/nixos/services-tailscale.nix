{ pkgs, ... }:

{
  services.tailscale = {
    enable = true;
    authKeyFile = "/etc/nixos/secrets/tailscale-authkey";
    extraUpFlags = [
      "--accept-dns"
      "--hostname=homelab-cat-services" 
      "--snat-subnet-routes=false"
    ];
  };
}