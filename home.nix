{ config, pkgs, ... }:

{

  imports = [
    ./kitty.nix
    ./neovim.nix
    ./sway.nix
    ./fonts.nix
    ./waybar.nix
    ./browsers.nix
  ];



  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cbrazell";
  home.homeDirectory = "/home/cbrazell";
  home.pointerCursor = {
#    sway.enable = true;
#    x11.enable = true;
    name = "adwaita-icon-theme";
    package = pkgs.adwaita-icon-theme;
    size = 32;
  };

  gtk.cursorTheme = {
    name = "adwaita-icon-theme";
    package = pkgs.adwaita-icon-theme;
    size = 32;

  };
  nixpkgs.config = {
    allowUnfreePredicate = _: true;
    permittedInsecurePackages = [
      "electron-25.9.0"
      "openssl-1.1.1w"
    ];
  };

#  services = {
#    swayidle.enable = true; # Lock screen
#  };


#  programs.sway.xwayland.enable = true;
  programs.git = {
     enable = true;
     userName = "RealFakeGits";
     userEmail = "realfakeemailshere82@gmail.com";
     extraConfig = {
       init.defaultBranch = "main";
     };
  };
 
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
      p11-kit
      opensc
      wgnord
      ffmpeg
      wf-recorder
      gcc
      wget
      git
      protonup-qt
      waybar
#      pavucontrol
      rofi-wayland
      neofetch
      steam
      vesktop
      spotify
      qimgv
#      pamixer
      prismlauncher
      htop
      signal-desktop
      obsidian
#      google-drive-ocamlfuse
#      grim
#      wl-clipboard
#      slurp
      photoflare
#      neovim
      gtk4
      corectrl
      qalculate-gtk
      gamescope
      openvpn
#      adwaita-icon-theme #default cursors
      glib 
      evince
      wireshark
      vulkan-tools
      file
      gzip
      zip
      unzip
      sublime4
#      swayidle
#      swaylock-effects
      gamescope
      killall
      wine64
      libreoffice
      mangohud
      protontricks
      winetricks
      slack
      open-vm-tools
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
#    ".config/kitty/kitty.conf".source = ./kitty/kitty.conf;
#    ".config/sway/config".source = ./config; 
  };
  








  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cbrazell/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
