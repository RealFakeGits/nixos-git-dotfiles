{ config, pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.firefox.nativeMessagingHosts.euwebid = true;
}
