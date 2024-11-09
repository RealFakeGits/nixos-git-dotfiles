{ config, pkgs, theme, ... }:
{
  programs.kitty = {
    enable = true;
    font.name = "IBMPlexMono";
    themeFile = "Darkside";
  };
}
