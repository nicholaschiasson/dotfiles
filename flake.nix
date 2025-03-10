{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.just
            pkgs.nil
            pkgs.nixfmt-rfc-style
            pkgs.starship
          ];
          shellHook = ''
            eval "$(starship init bash)"
          '';
        };
      }
    );
}
