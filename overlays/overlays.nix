self: super: {
  vmware-workstation = super.vmware-workstation.overrideAttrs (oldAttrs: rec {
    version = "17.5.2";  # Replace with your desired version
    src = super.fetchfromGitHub {
      owner = "nixos";
      repo = "nixpkgs";
      rev = "1bde3e8e37a72989d4d455adde764d45f45dc11c";
      sha256 = "sha256-duwsp94fJWmsSb48ApjQKmTKW5Tzvd8f4Hd44Ge/P5Y=";  # Replace with the correct sha256 hash
    };
  });
}
