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

  networking.hostName = "core-nixos";
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

  fileSystems."/data/shared" = {
    device = "lexar2023-shared";
    fsType = "virtiofs";
    options = [ "defaults" "nofail" ];
  };

  fileSystems."/data/lx2023" = {
    device = "lexar2023-core-nixos";
    fsType = "virtiofs";
    options = [ "defaults" "nofail" ];
  };

  system.stateVersion = "25.05";
}
