{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Gnome
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
    # GPG
    gcr
    # Tools
    mission-center
    steam-run
    ventoy-full-gtk
    brave
    python3Full
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-gtk3-1.1.05"
  ];

  programs.git = {
    enable = true;
    userName = "Livia Silver";
    userEmail = "sovranova@outlook.com";
    signing = {
      key = "CEAD651C8780CF74";
      signByDefault = true;
    };
  };

  programs.fastfetch.enable = true;
  programs.git-credential-oauth.enable = true;
  programs.firefox.enable = true;
  programs.vscode.enable = true;
  programs.mangohud.enable = true;

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
