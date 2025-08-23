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
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # Auto update
  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos";
    dates = "10:00";
    randomizedDelaySec = "30min";
    allowReboot = false;
  };

  users.users.ivy = {
    isNormalUser = true;
    description = "Ivy";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  
  home-manager.users.ivy = import ./home.nix;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
