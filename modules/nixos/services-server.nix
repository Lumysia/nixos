{ pkgs, ... }:

{
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.qemuGuest.enable = true;
}