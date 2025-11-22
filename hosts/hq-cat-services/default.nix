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

  # Mounts
  fileSystems."/data/lx2023" = {
    device = "lexar2023-services-nixos";
    fsType = "virtiofs";
    options = [ "defaults" "nofail" ];
  };
 
  fileSystems."/data/lx2023/shared" = {
    device = "lexar2023-shared";
    fsType = "virtiofs";
    options = [ "defaults" "nofail" ];
  };

  fileSystems."/data/lx2024" = {
    device = "lexar2024-services-nixos";
    fsType = "virtiofs";
    options = [ "defaults" "nofail" ];
  };

  # Cron Jobs
  services.cron = {
    enable = true;
    systemCronJobs = [
      # Seafile GC
      "0 5 * * * root ${pkgs.docker}/bin/docker exec $(${pkgs.docker}/bin/docker ps -q --filter \"name=^seafile$\") /opt/seafile/seafile-server-latest/seaf-gc.sh"
      # Gitea Renovate
      "15 * * * * root ${pkgs.docker}/bin/docker start $(${pkgs.docker}/bin/docker ps -a -q --filter \"name=^renovate$\")"
    ];
  };

  system.stateVersion = "25.05";
}