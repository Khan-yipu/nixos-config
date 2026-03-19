{
  description = "Lean 4 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.lean4
          ];

          shellHook = ''
            echo "🟣 Lean 4 development environment"
            echo "Lean: $(lean --version)"
            # lake comes with lean4
            echo "Lake: $(lake --version)" 
            echo ""
            echo "Commands:"
            echo "  lake new <name>  - Create a new project"
            echo "  lake build       - Build the project"
            echo "  lake run         - Run the main executable"
            echo ""
          '';
        };
      }
    );
}
