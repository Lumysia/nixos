{ pkgs, config, ... }:

{
  programs.vim.enable = true;
  programs.git.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  services.envfs.enable = true;
  # programs.nix-ld.enable = true;
  programs.atop.enable = true;
}
