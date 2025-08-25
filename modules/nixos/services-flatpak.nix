{ pkgs, ... }:

{
  services.flatpak.enable = true;
  # systemd.services.flatpak-repo = {
  #   wantedBy = [ "multi-user.target" ];
  #   path = [ pkgs.flatpak ];
  #   script = ''
  #     flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  #   '';
  # };
  services.flatpak.remotes = [{
    name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
  }];
  services.flatpak.update.onActivation = true;
  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "net.agalwood.Motrix"
    "org.prismlauncher.PrismLauncher"
    "com.geeks3d.furmark"
    "md.obsidian.Obsidian"
    "org.onlyoffice.desktopeditors"
    "com.belmoussaoui.Obfuscate"
    "io.gitlab.news_flash.NewsFlash"
    "io.github.seadve.Mousai"
    "io.gitlab.adhami3310.Impression"
    "com.github.ADBeveridge.Raider"
    "io.github.alainm23.planify"
    "com.belmoussaoui.Decoder"
    "dev.geopjr.Collision"
    "org.gnome.Podcasts"
    "app.drey.Warp"
    "com.github.iwalton3.jellyfin-media-player"
    "io.github.radiolamp.mangojuice"
    "com.usebottles.bottles"
    "io.github.fabrialberio.pinapp"
    "com.nextcloud.desktopclient.nextcloud"
    "com.github.johnfactotum.Foliate"
    "io.github.amit9838.mousam"
    # China
    "com.tencent.WeChat"
  ];
}