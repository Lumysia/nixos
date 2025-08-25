{ pkgs, ... }:

{
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.qemuGuest.enable = true;

  services.tailscale = {
    enable = true;
    authKeyFile = "/etc/nixos/secrets/tailscale-authkey";
    extraUpFlags = [
      "--accept-dns"
      "--hostname=homelab-cat-core" 
      "--snat-subnet-routes=false"
    ];
  };
}