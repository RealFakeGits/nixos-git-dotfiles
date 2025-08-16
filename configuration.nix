{ config, pkgs, pkgs-stable, ... }:
{
    imports =
      [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
#        ./flake.nix
      ];

  # Kernel Manual setting for compatibility for DX games
   boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    boot.loader.efi.canTouchEfiVariables = true;
    
    networking = {
    
      firewall.enable = false;
      hostName = "bingbong"; # Define your hostname.
      networkmanager = {
        enable = true;  # Easiest to use and most distros use this by default.
        appendNameservers = [ "1.1.1.1" "9.9.9.9" ];
      };
    };
  # Tailscale setup
    services.tailscale.enable = true;

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
 
  # Programs Enable
    programs = {
      gamemode.enable = true;
      wireshark = {
        enable = true;
        dumpcap.enable = true;
      }; 
      steam = {
        gamescopeSession.enable = true;
        enable = true;
      }; 
      sway = {
        xwayland.enable = true;
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

  # VMWare
    virtualisation.vmware.host = {
      enable = true;
      package = pkgs.vmware-workstation;
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
    };
    services.pcscd = {
      enable = true;
      plugins = [ pkgs.opensc pkgs.ccid ];
    };
    security.pam.p11.enable = true;
  # User Account
    users.users.cbrazell = {
      isNormalUser = true;
      extraGroups = [ "wheel" "corectrl" "libvirtd" "wireshark" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
        pcsc-tools
        opensc
        p11-kit
        web-eid-app
      ];
    }; 

  # System Wide Pkgs
  #  environment.systemPackages = [
  #  ];

  # Temperature Controller
    programs.corectrl.enable = true;

  # PAM Swaylock Auth
    security.pam.services.swaylock = {};

    system.stateVersion = "23.05"; # Did you read the comment?
      
    nix = { 
      package = pkgs.nix;
      settings.experimental-features = [ "nix-command" "flakes" ];
    };

}

