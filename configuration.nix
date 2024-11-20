{ config, pkgs, pkgs-stable, ... }:
{
    imports =
      [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
      #  ./waybar.nix
      ];
   
#    overlays = [
#      import ./overlay/overlays.nix
#    ];

  # Kernel Manual setting for compatibility for DX games
   boot.kernelPackages = pkgs.linuxPackages_latest;
#  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_6.override {
#	  argsOverride = rec {
#		  src = pkgs.fetchurl {
#              	url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
#              	sha256 = "59+B5YjXD6tew+w7sErFPVHwhg/DsexF4KQWegJomds=";
#	    };
#	    version = "6.6.58";
#	    modDirVersion = "6.6.58";
#	  };
#  });

  # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };

    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "bingbong"; # Define your hostname.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
    time.timeZone = "America/Chicago";

  # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

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

  # NixOS Garbage Collection
    nix.optimise.automatic = true;
    nix.optimise.dates = [ "03:45" ];
          
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
  

  # Sway Enable
    sway = {
      enable = true;
      package = null; # Because home-manager is user space, we need sway here for sddm 
      };              # to be able to see it. So enable sway in home-manager/here and make
    };                # the package null here so it loads the home-manager config.
  # Vulkan Support 32/64Bit
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

  # Virt-manager
    
#    virtualisation.libvirtd.enable = true;
    virtualisation.vmware.host = {
      enable = true;
     # package = pkgs-stable.vmware-workstation;
    };

    programs.dconf.enable = true;

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

  # Locate command  
    services.locate = {
      enable = true;
      package = pkgs.mlocate;
      localuser = null;
    };
  # User Account
    users.users.cbrazell = {
      isNormalUser = true;
      extraGroups = [ "wheel" "corectrl" "libvirtd" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      ];
    }; 

  # System Wide Pkgs
    environment.systemPackages = [
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

  # Temperature Controller
    programs.corectrl.enable = true;

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
      
#      (final: prev: {
#         vmware-workstation = prev.vmware-workstation.overrideAttrs (
#           old: { src = prev.fetchFromGitHub {
#             owner = "nixos";
#             repo = "nixpkgs-unstable";
#             rev = "1bde3e8e37a72989d4d455adde764d45f45dc11c";
#             sha256 = "duwsp94fJWmsSb48ApjQKmTKW5Tzvd8f4Hd44Ge/P5Y=";
#           }; }
#         );
#       })
#     ];    

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

