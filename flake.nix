{
  description = "Nya NixOS";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, home-manager-stable, home-manager-unstable, nix-flatpak, agenix, ... }@inputs: {
    nixosConfigurations = {
      Kawaii = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/Kawaii

          home-manager-stable.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak
          agenix.nixosModules.default
        ];
      };

      Homelab-Cat-Core = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/homelab-cat-core

          home-manager-stable.nixosModules.home-manager
        ];
      };

      Homelab-Cat-Games = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/homelab-cat-games

          home-manager-stable.nixosModules.home-manager
        ];
      };

      Homelab-Cat-Services = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/homelab-cat-services

          home-manager-stable.nixosModules.home-manager
        ];
      };

      Homelab-Nya-Services = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/homelab-nya-services

          home-manager-stable.nixosModules.home-manager
        ];
      };

    };
  };
}
