{ pkgs, ... }:

{
  # Home Manager needs a state version.
  home.stateVersion = "25.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
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
    # Tools
    resources
    steam-run
  ];

  programs.gpg.enable = true;
  #programs.git.enable = true;

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

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
