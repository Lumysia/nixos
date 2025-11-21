{ pkgs, config, lib, ... }:

{
  options.features.user.ivy.enable = lib.mkEnableOption "Ivy User Identity";

  config = lib.mkIf config.features.user.ivy.enable {
    users.users.ivy = {
      isNormalUser = true;
      description = "Ivy";
      extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    };

    home-manager.users.ivy = { pkgs, ... }: {
      home.stateVersion = "25.05";
      nixpkgs.config.allowUnfree = true;
      programs.home-manager.enable = true;

      nixpkgs.config.permittedInsecurePackages = [
        "ventoy-gtk3-1.1.05"
      ];

      home.packages = with pkgs; [
        # Gnome Customization
        gnome-tweaks
        gnome-extension-manager
        gnomeExtensions.blur-my-shell
        gnomeExtensions.dash-to-dock
        gnomeExtensions.caffeine
        gnomeExtensions.appindicator
        gnomeExtensions.gsconnect
        gnomeExtensions.clipboard-indicator
        gnomeExtensions.removable-drive-menu
        gnomeExtensions.vitals
        gnomeExtensions.kimpanel
        gnomeExtensions.bing-wallpaper-changer
        gnomeExtensions.night-theme-switcher
        
        # Tools
        mission-center
        steam-run
        ventoy-full-gtk
        brave
        python3Full
        
        # GPG Utils
        gcr
      ];

      programs.git = {
        enable = true;
        userName = "Livia";
        userEmail = "91-cornice-precept@icloud.com";
        #signing = {
        #  key = "";
        #  signByDefault = false;
        #};
      };

      programs.gpg.enable = true;
      services.gpg-agent = {
        enable = true;
        pinentry.package = pkgs.pinentry-gnome3;
      };

      services.gnome-keyring.enable = true;

      programs.fastfetch.enable = true;
      programs.git-credential-oauth.enable = true;
      programs.firefox.enable = true;
      programs.vscode.enable = true;
      programs.mangohud.enable = true;
    };
  };
}