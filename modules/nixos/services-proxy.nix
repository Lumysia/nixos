{ pkgs, ... }:

{
  services.xray.enable = true;
  services.xray.settingsFile = "/etc/secrets/xray_config.json";
}