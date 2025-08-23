{ pkgs, ... }:

{
  # Home Manager needs a state version.
  home.stateVersion = "25.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # tools
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

  programs.git-credential-oauth.enable = true;
  programs.firefox.enable = true;
  programs.vscode.enable = true;
  programs.mangohud.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
