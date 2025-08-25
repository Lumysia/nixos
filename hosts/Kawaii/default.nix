{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/nixos/base.nix
      ../../modules/nixos/base-programs.nix
      ../../modules/nixos/desktop-nvidia.nix
      ../../modules/nixos/desktop-programs.nix
      ../../modules/nixos/desktop-zhcn.nix
      ../../modules/nixos/services-flatpak.nix
      ../../modules/nixos/services-proxy.nix
      ../../modules/nixos/services-docker.nix

      inputs.lanzaboote.nixosModules.lanzaboote
    ];

  networking.hostName = "Kawaii";

  # networking.firewall.allowedTCPPorts = [  ];
  # networking.firewall.allowedUDPPorts = [  ];

  time.timeZone = "Asia/Shanghai";

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  system.autoUpgrade = {
    enable = true;
    flake = "/home/ivy/Projects/nixos";
    dates = "daily";
  };

  users.users.ivy = {
    isNormalUser = true;
    description = "Ivy";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  
  home-manager.users.ivy = import ./home.nix;
  
  system.stateVersion = "25.05";
}
