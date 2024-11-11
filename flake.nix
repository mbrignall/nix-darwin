{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    home-manager.url =
      "github:nix-community/home-manager";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }: {
    darwinConfigurations."OVO-LPXDY5HKQ2" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin"; # Set to your system architecture
      modules = [
        ./darwin-configuration.nix # Your external Darwin configuration
        { users.users."martin.brignall".home = "/Users/martin.brignall"; }
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."martin.brignall" =
            import ./home.nix; # Your external Home Manager configuration
        }
      ];
    };
  };
}

