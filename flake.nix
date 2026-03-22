{
  description = "My NixOS Flake";
  
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };
  
  outputs = { self, nixpkgs, home-manager, chaotic, ... }: 
  let 
    myConfig = import ./config.nix;
  in
  {
    # nixosConfigurations.<hostname>
    nixosConfigurations.test = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        chaotic.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${myConfig.personal.username} = import ./home.nix;
          home-manager.users.finn = import ./home.nix;
        }
      ]
    }
  }
}