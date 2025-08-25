{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/nixos/base.nix
      ../../modules/nixos/base-programs.nix
      ../../modules/nixos/services-server.nix
      ../../modules/nixos/services-docker.nix
      ../../modules/nixos/services-tailscale.nix
    ];

  networking.hostName = "services-nixos";
  time.timeZone = "Asia/Shanghai";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  boot.kernelParams = [
    "console=ttyS0,115200"
    "console=tty1"
  ];

  system.autoUpgrade = {
    enable = true;
    flake = "/home/nya/nixos";
    dates = "daily";
  };
  
  users.users.nya = {
    isNormalUser = true;
    description = "Nya";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  home-manager.users.nya = import ./home.nix;

  fileSystems."/data-lx2023" = {
    device = "lexar2023-services-nixos";
    fsType = "virtiofs";
    options = [ "defaults" "nofail" ];
  };
 
  fileSystems."/data-lx2023/shared" = {
    device = "lexar2023-shared";
    fsType = "virtiofs";
    options = [ "defaults" "nofail" ];
  };

  fileSystems."/data-lx2024" = {
    device = "lexar2024-services-nixos";
    fsType = "virtiofs";
    options = [ "defaults" "nofail" ];
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * * root ${pkgs.docker}/bin/docker exec -u 1000 $(${pkgs.docker}/bin/docker ps -q --filter \"label=com.docker.compose.project=services-nextcloud\" --filter \"label=com.docker.compose.service=nextcloud\") php /var/www/html/cron.php"
    ];
  };

  # State version
  system.stateVersion = "25.05";
}