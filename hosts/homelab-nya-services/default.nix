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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # State version
  system.stateVersion = "25.05";
}