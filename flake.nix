{
  description = "SPASM-ng is a z80/eZ80 assembler with extra features to support development for TI calculators.";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      with import nixpkgs { system = system; }; {
        packages.default = stdenv.mkDerivation {
          enableParallelBuilding = true;
          name = "spasm-ng";
          src = self;
          installPhase = ''
            mkdir -p $out/bin
            cp spasm $out/bin
          '';
          meta.mainProgram = "spasm";
          nativeBuildInputs = with pkgs; [ gmp openssl zlib ];
        };
      }
    );
}
