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
  time.timeZone = "America/Toronto";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  boot.kernelParams = [
    "console=ttyS0,115200"
    "console=tty1"
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

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

  services.cron = {
    enable = true;
    systemCronJobs = [
      # NextCloud
      "*/5 * * * * root ${pkgs.docker}/bin/docker exec -u 1000 $(${pkgs.docker}/bin/docker ps -q --filter \"label=com.docker.compose.project=services-nextcloud\" --filter \"label=com.docker.compose.service=nextcloud\") php /var/www/html/cron.php"
      "0 * * * * root ${pkgs.docker}/bin/docker exec -u 1000 $(${pkgs.docker}/bin/docker ps -q --filter \"label=com.docker.compose.project=services-nextcloud\" --filter \"label=com.docker.compose.service=nextcloud\") php /var/www/html/occ app:update --all"
      # Seafile GC
      "0 3 * * * root ${pkgs.docker}/bin/docker exec $(${pkgs.docker}/bin/docker ps -q --filter \"label=com.docker.compose.project=services-seafile\" --filter \"label=com.docker.compose.service=seafile\") /opt/seafile/seafile-server-latest/seaf-gc.sh"
    ];
  };

  # State version
  system.stateVersion = "25.05";
}
