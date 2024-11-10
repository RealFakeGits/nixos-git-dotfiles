{ pkgs, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

#    extraConfig = {
#      "default_border pixel 2"
#    };

    config = rec {
     # input = {
     #   xkb_numlock = "Enabled";
     # };

#      left = "a" ;
#      right = "d" ;
#      up = "w";
#      down = "s";
      
      bars = [
        { "command" = "waybar"; }
      ];

      menu = " set $menu rofi -show drun | xargs swaymsg exec -- ";
      

      output = {
        DP-1 = {
          bg = "./wallpaper.png fill";
          position = "0 0";
          resolution = "2560x1400";
        };

        DP-2 = {
          bg = "./wallpaper.png fill";
          position = "2560 0";
          resolution = "2560x1400";
        };
      };

      modifier = "Mod4";

      terminal = "kitty";

      startup = [
        { command = "spotify"; always = true; }
        { command = "slack"; always = true; }
        { command = "steam"; always = true; }
        { command = "google-chrome-stable"; always = true;}
        { command = "vesktop"; always = true; }
      ];
      keybindings = pkgs.lib.mkOptionDefault {
#        "Print" = '' exec grim -g "${slurp -d}" | wl-copy '';
        "${modifier}+f" = '' exec google-chrome-stable '';
        "${modifier}+e" = '' exec thunar '';
        "${modifier}+c" = '' kill '';
        "${modifier}+q" = '' exec ${terminal} ''; 
        "${modifier}+r" = '' exec ${menu} '';
        "${modifier}+m" = '' reload '';
        "${modifier}+Shift+m" = " exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit' ";
      };


      gaps = {
        smartBorders = "on";
      };

      window = {
        hideEdgeBorders = "both";
      };

      workspaceOutputAssign = [
        { workspace = "1"; output = "DP-1"; }
        { workspace = "2"; output = "DP-1"; }
        { workspace = "3"; output = "DP-1"; }
        { workspace = "4"; output = "DP-1"; }
        { workspace = "5"; output = "DP-1"; }
        { workspace = "6"; output = "DP-2"; }
        { workspace = "7"; output = "DP-2"; }
        { workspace = "8"; output = "DP-2"; }
        { workspace = "9"; output = "DP-2"; }
        { workspace = "0"; output = "DP-2"; }


      ];
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    pamixer
    pavucontrol 
  ];
  

}
