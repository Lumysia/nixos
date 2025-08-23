{ pkgs, config, ... }:

{
  programs.localsend.enable = true;
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  
  services.printing.enable = true;
  services.tailscale.enable = true;
}