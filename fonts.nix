{ config, pkgs, ... }:
{

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono 
    nerd-fonts.blex-mono
    powerline-symbols
    font-awesome
  ];
}
