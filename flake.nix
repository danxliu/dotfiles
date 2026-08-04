{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    hermes-agent.url = "github:NousResearch/hermes-agent";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      agenix,
      nur,
      nix-colors,
      hermes-agent,
      ...
    }:
    let
      lib = nixpkgs.lib;

      getSubDirs =
        dir: lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir dir));

      hosts = getSubDirs ./hosts;
      users = builtins.filter (user: builtins.pathExists (./users + "/${user}/default.nix")) (
        getSubDirs ./users
      );

      homeManagerModule = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "bak";
          extraSpecialArgs = { inherit inputs; };
          sharedModules = [
            inputs.nix-index-database.homeModules.nix-index
            inputs.agenix.homeManagerModules.default
          ];
        };
      };

      mkHost =
        host:
        lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            inherit nix-colors;
          };
          modules = [
            (
              { ... }:
              {
                nixpkgs.overlays = [ nur.overlays.default ];
              }
            )
            ./hosts/${host}/configuration.nix
            inputs.nix-index-database.nixosModules.nix-index
            inputs.agenix.nixosModules.default
            home-manager.nixosModules.home-manager
            homeManagerModule
          ];
        };

      mkHome =
        user:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
            overlays = [ nur.overlays.default hermes-agent.overlays.default ];
          };
          extraSpecialArgs = {
            inherit inputs nix-colors;
          };
          modules = [
            (./users + "/${user}/default.nix")
            inputs.nix-index-database.homeModules.nix-index
            inputs.agenix.homeManagerModules.default
          ];
        };
    in
    {
      nixosConfigurations = lib.genAttrs hosts mkHost;
      homeConfigurations = lib.genAttrs users mkHome;
      apps.x86_64-linux.agenix = {
        type = "app";
        program = "${agenix.packages.x86_64-linux.agenix}/bin/agenix";
      };
    };
}
