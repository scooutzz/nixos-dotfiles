{
  description = "Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    customOverlay = final: prev: {
      quickshell = inputs.quickshell.packages.${system}.default;
      zen-browser = inputs.zen-browser.packages.${system}.default;
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {inherit inputs;};
      modules = [
        {nixpkgs.overlays = [customOverlay];}

        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.relaxou = import ./home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = {inherit inputs;};
          };
        }
      ];
    };
  };
}
