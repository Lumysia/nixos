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

  fileSystems."/data/ss2025" = {
    device = "samsung2025-services-nixos";
    fsType = "virtiofs";
    options = [ "defaults" "nofail" ];
  };

  # State version
  system.stateVersion = "25.05";
}
