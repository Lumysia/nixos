{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      mtu = 1280; # tailscale compatible
      userland-proxy = false;
      no-new-privileges = true;
      fixed-cidr-v6 = "fd00::/80";
      ipv6 = true;
      # registry-mirrors = [ "https://docker.libcuda.so" ];
    };
  };
}
