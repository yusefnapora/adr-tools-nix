{
  description = "A very basic flake";

  inputs.adr-tools-src = {
    url = "github:npryce/adr-tools";
    flake = false;
  };

  outputs = { self, nixpkgs, adr-tools-src }:
  let 
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in {

    packages = forAllSystems (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        adr-tools = pkgs.stdenvNoCC.mkDerivation { 
          name = "adr-tools";
          src = adr-tools-src;

          installPhase = ''
            mkdir -p $out/bin
            cp $src/src/* $out/bin
          '';

          meta.mainProgram = "adr";
        };

        default = self.packages.${system}.adr-tools;
      }
    );

  };
}
