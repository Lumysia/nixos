{ pkgs, config, ... }:

{
  # system-wide programs
  programs.localsend.enable = true;
  programs.gamemode.enable = true;
  programs.steam.enable = true;
}