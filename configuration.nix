# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:
#let
#  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";

#  hyprland = (import flake-compat {
#    src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
#  }).defaultNix;
#in {
#  imports = [hyprland.nixosModules.default];

#  programs.hyprland = {
#    enable = true;

    # default options, you don't need to set them
#    package = pkgs.hyprland;

#    xwayland = {
#      enable = true;
#      hidpi = true;
#    };

#    nvidiaPatches = false;
#  };
#}
    

{
    imports =
      [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
      #  ./waybar.nix
      ];


  # Kernel Manual setting for compatibility for DX games
   # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_1;

  # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };

    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "bingbong"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
    time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  #  };

  # Greetd login manager
   services.greetd = {
     enable = true; 
     settings = {
       default_session.command = ''
       ${pkgs.greetd.tuigreet}/bin/tuigreet \
         --time \
         --asterisks \
         --user-menu \
         --cmd sway \
       '';
     };
   };
   environment.etc."greetd/environments".text = ''
     sway
   '';

   services.displayManager.sddm = {
	wayland.enable = true;
   };
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  #  services.xserver = {
  #    enable = true;
  #    xkb.layout = "us";
  #    xkb.variant = "";
  # };
  

  # NixOS Garbage Collection
    nix.optimise.automatic = true;
    nix.optimise.dates = [ "03:45" ];

  
  # Printer
#    services.printing.enable = true;
#    services.avahi = {
#      enable = true;
#      nssmdns4 = true;
#      openFirewall = true;
#    };
          
  # Thunar compatability    
    services.gvfs.enable = true; # Mount, Trash, and other functionalites
    services.tumbler.enable = true; # Thumbnail Support for Images
    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
        ];
      };
    };
  # Allow Unfree Packages
    nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
        "openssl-1.1.1w"
      ];
    };  
  
  # Steam Enable
    programs = {
      gamemode.enable = true;
      steam = {
        gamescopeSession.enable = true;
        enable = true;
      }; 
  # Hyprland Enable

  #  hyprland = {
  #    enable = true;
  #    xwayland.enable = true;
  #  };
  #  waybar.enable = true;
  

  # Sway Enable
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      };
    };
  # Vulkan Support 32/64Bit
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        #extraPackages = with pkgs; [
        #  amdvlk
        #];
        #extraPackages32 = with pkgs; [
        #  driversi686Linux.amdvlk
        #]; 
      };
    };

  # Virt-manager
    
#    virtualisation.libvirtd.enable = true;
    virtualisation.vmware.host.enable = true;
    programs.dconf.enable = true;
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable sound.
    security.rtkit.enable = true;
  # hardware.pulseaudio.enable = true;
    services.pipewire = {
      wireplumber.enable = true;
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
    };
  # Zerotier
#    services.zerotierone = {
#      enable = true;
#      joinNetworks = [ "b6079f73c6de08a1" ];
#    };
  

  # PCSCD - Smart Card Reader
  #  services.pcscd.enable = true;  

  # Locate command  
    services.locate = {
      enable = true;
      package = pkgs.mlocate;
      localuser = null;
    };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.cbrazell = {
      isNormalUser = true;
      extraGroups = [ "wheel" "corectrl" "libvirtd" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      # steam
      # spotify
      # discord
      ];
    };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
#      wgnord
#      gcc
#      kitty
#      wget
#      git
#      protonup-qt
#      waybar
#      pavucontrol
#      google-chrome
#      firefox-wayland
#      rofi-wayland
#      neofetch
#      steam
#      vesktop
#      spotify
#      vim
      #qimgv
      #pamixer
      #prismlauncher
      #htop
      #obsidian
      #google-drive-ocamlfuse
      #grim
      #wl-clipboard
      #slurp
      #photoflare
      #neovim
      #gtk4
      #corectrl
      #qalculate-gtk
      #gamescope
      #openvpn
      #adwaita-icon-theme #default cursors
      #glib 
      #evince
      #wireshark
      #vulkan-tools
      #file
      #gzip
      #zip
      #unzip
      #sublime4
      #swaylock-effects
      #gamescope
      #killall
      #wine
      #libreoffice
      #mangohud
      #protontricks
      #winetricks
      #slack
      #busybox
    ];

  # Fonts for system    
#    fonts = {
#      fontDir.enable = true;
#      packages = with pkgs; [
#       (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" ]; })
#      ];
#    };

  # Temperature Controller
    programs.corectrl.enable = true;

  # This is for VMM to fix the cursor bug for making VMs

 
  # PAM Swaylock Auth
    security.pam.services.swaylock = {};
    #console.packages=[ pkgs.iosevka ];
    #console.font="${pkgs.iosevka}/share
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
    networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  #  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?

  # Overlays Go here
#    nixpkgs.overlays = [
#      (self: super: {
#         vmware-workstation = super.vmware-workstation.overrideAttrs (
#           _: { src = prev.fetchFromGithub { 
#	     owner = "
# 	     repo = 
#             url = "https://github.com/NixOS/nixpkgs/archive/47c1824c261a343a6acca36d168a0a86f0e66292.tar.gz";
#             }; }
#             );
#           })
#     (self: super: { 
#	 discord = super.discord.overrideAttrs (
#	   _: { src = builtins.fetchTarball {
#	     url = "https://www.discord.com/api/download?platform=linux&format=tar.gz";
#         }; }
#         );      
#       })
#    ];

    nix = { 
      package = pkgs.nix;
      settings.experimental-features = [ "nix-command" "flakes" ];
    };

}

