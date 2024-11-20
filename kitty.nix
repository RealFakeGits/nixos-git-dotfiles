{ config, pkgs, theme, ... }:
{
  programs.kitty = {
    enable = true;
    font.name = "BlexMonoNerdFontMono";
    themeFile = "Darkside";
  };
}
