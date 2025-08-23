{ pkgs, config, ... }:

{
  # i18n Chinese input method
  i18n.inputMethod = {
    enable = true;
    type =  "fcitx5";
    fcitx5.addons = with pkgs; [
        rime-data
        fcitx5-rime
        fcitx5-gtk
    ];
  };

  # Extra fonts
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    mplus-outline-fonts.githubRelease
  ];
}