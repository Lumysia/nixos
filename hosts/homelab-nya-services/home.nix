{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
  ];

  programs.gpg.enable = true;
  programs.git.enable = true;

  programs.fastfetch.enable = true;
  programs.git-credential-oauth.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-tty;
  };
}
