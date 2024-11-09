{

  description = "My First Flake";
   
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
#    overlays =  [
#      import ./overlays/overlays.nix 
#    ];
     
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system}; 
#      pkgsWithOverlays = import nixpkgs {
#        overlays = [ overlays ];
#      };
    in {
      nixosConfigurations = {
        bingbong = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
      homeConfigurations = {
        cbrazell = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
#    packages.x86_64-linux.vmware-workstation = pkgsWithOverlays.vmware-workstation;
    };
  
}
