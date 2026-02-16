{
  description = "OpenRouter Agent Environment";

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
          buildInputs = with pkgs; [
            nodejs_20
            nodePackages.typescript
            nodePackages.tsx
            nodePackages.npm
          ];

          shellHook = ''
            echo "OpenRouter Agent Dev Environment"
            echo "Run 'npm install' to install dependencies"
          '';
        };
      }
    );
}
