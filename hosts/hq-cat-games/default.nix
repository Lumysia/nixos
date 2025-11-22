{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/features/core.nix
    ../../modules/features/server/openssh.nix
    ../../modules/features/virtualisation/docker.nix
    ../../modules/features/services/tailscale.nix
    ../../modules/home/users/suser.nix
  ];

  features.core.enable = true;
  features.server.openssh.enable = true;
  features.virtualisation.docker.enable = true;
  features.services.tailscale.enable = true;
  features.user.suser.enable = true;

  time.timeZone = "America/Toronto";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.kernelParams = [ "console=ttyS0,115200" "console=tty1" ];

  networking.firewall.enable = true;

  #system.autoUpgrade = {
  #  enable = true;
  #  flake = "/root/nixos";
  #  dates = "daily";
  #};

  fileSystems."/data" = {
    device = "lexar2023-games-nixos";
    fsType = "virtiofs";
    options = [ "defaults" "nofail" ];
  };

  fileSystems."/data/shared" = {
    device = "lexar2023-shared";
    fsType = "virtiofs";
    options = [ "defaults" "nofail" ];
  };

  system.stateVersion = "25.05";
}