# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1f8d2d6e-42e7-4e52-a3e1-c271618ffce4";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F6E2-475C";
      fsType = "vfat";
    };

  fileSystems."/home/cbrazell/M2Data" =
    { device = "/dev/disk/by-uuid/20542d71-5771-4b92-8f39-c245c4397031";
      fsType = "btrfs";
    };
  fileSystems."/home/cbrazell/2TBM2Data" = 
    { device = "/dev/disk/by-uuid/e02a9db7-2afc-447e-9bec-04dea41bae24";
      fsType = "btrfs";
    };
#  fileSystems."/home/cbrazell/IronOxide1TB" =
#    { device = "/dev/disk/by-uuid/0036727036726716";
#      fsType = "none";
#      options = [
#        "ro"
#      ];
#    };
#  fileSystems."/home/cbrazell/IronOxide2TB" =
#   { device = "/dev/disk/by-uuid/386696D56696936C";
#     fsType = "none";
#     options = [
#       "ro"
#     ];
#   };


  swapDevices =
    [ { device = "/dev/disk/by-uuid/825eff26-fe4d-4991-8941-9381ec870a91"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
#  hardware.graphics = {
#    enable = true;
#    enable32Bit = true;
#  };
}
