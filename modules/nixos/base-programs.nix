{ pkgs, config, ... }:

{
  programs.vim.enable = true;
  programs.git.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  services.envfs.enable = true;
  programs.atop.enable = true;
}
