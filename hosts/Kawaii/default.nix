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
      #../../modules/nixos/services-proxy.nix
      ../../modules/nixos/services-docker.nix
      ../../modules/nixos/services-libvirtd.nix

      inputs.lanzaboote.nixosModules.lanzaboote
    ];

  networking.hostName = "Kawaii";

  # networking.firewall.allowedTCPPorts = [  ];
  # networking.firewall.allowedUDPPorts = [  ];

  time.timeZone = "America/Toronto";

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  specialisation = {
    docked = {
      configuration = {
        boot.blacklistedKernelModules = config.boot.blacklistedKernelModules ++ [ "i915" ];
      };
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall = {
    enable = true;
    checkReversePath = false; # fix for Whonix gateway bridge
};

  system.autoUpgrade = {
    enable = true;
    flake = "/home/ivy/Projects/nixos";
    dates = "daily";
  };

  users.users.ivy = {
    isNormalUser = true;
    description = "Ivy";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  };
  
  home-manager.users.ivy = import ./home.nix;
  
  system.stateVersion = "25.05";
}
