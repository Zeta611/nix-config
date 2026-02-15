{
  description = "NixOS & nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      solaar,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            solaar.nixosModules.default
            ./hosts/default/configuration.nix
            ./nixosModules
          ];
        };
      };
      homeModules = {
        darwin = ./homeManagerModules/darwin.nix;
        default = ./homeManagerModules;
      };

      darwinConfigurations = {
        "jay-macbook" = nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/jay-macbook-pro/configuration.nix
          ];
        };
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."jay-macbook".pkgs;
    };
}
