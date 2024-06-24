{
  description = "SPASM-ng is a z80/eZ80 assembler with extra features to support development for TI calculators.";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: { packages = builtins.listToAttrs (map (systemName: {
    name = "${systemName}";
    value = { default =
      with import nixpkgs { system = systemName; };
      stdenv.mkDerivation {
        enableParallelBuilding = true;
        name = "spasm-ng";
        src = self;
        installPhase = ''
          mkdir -p $out/bin
          cp spasm $out/bin
        '';
        meta.mainProgram = "spasm";
        nativeBuildInputs = with pkgs; [ gmp openssl zlib ];
      };};})
   [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ]);};
}
