{

  description = "My First Flake";
   
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";    
     
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixpkgs-stable, ... }: 
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        bingbong = lib.nixosSystem {
        specialArgs = {
          pkgs-stable = import nixpkgs-stable { 
            inherit system;
            config.allowUnfree = true;
          };
        };
          modules = [
            ./configuration.nix
          ];
        };
      };
      homeConfigurations = {
        cbrazell = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ./home.nix 
          ];
        };
      };
    };
  
}
