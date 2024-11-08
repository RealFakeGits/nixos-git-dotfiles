{ config, pkgs, theme, ... }:
{
  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono";
    themeFile = "Darkside";
  };
}
