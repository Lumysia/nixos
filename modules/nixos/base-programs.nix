{ pkgs, config, ... }:

{
  programs.vim.enable = true;
  programs.git.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.atop.enable = true;
}