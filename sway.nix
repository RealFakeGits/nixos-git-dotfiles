{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    pamixer
    pavucontrol 
  ];


}
