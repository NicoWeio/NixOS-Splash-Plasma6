{
  description = "Plasma6 NixOS Splash";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {self, nixpkgs,flake-utils}:
    flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages = rec {
            nixos-splash-plasma6 = pkgs.stdenv.mkDerivation {
              pname = "nixos-splash-plasma6";
              version = "1.0";
              src = ./.;
              dontBuild = true;
              installPhase = ''
                mkdir -p $out/share/plasma/look-and-feel/NixOS-Splash-Plasma6
                cp -r . $out/share/plasma/look-and-feel/NixOS-Splash-Plasma6
              '';
            };
            default = nixos-splash-plasma6;
          };
    }
    );
}
  # outputs = { self, nixpkgs, flake-utils }: {
  #   flake-utils.lib.eachDefaultSystem (system:
  #     let pkgs = nixpkgs.legacyPackages.${system};
  #     in {
  #     packages = rec {
  #       nixos-splash-plasma6 = pkgs.stdenv.mkDerivation {
  #         pname = "nixos-splash-plasma6";
  #         version = "1.0";
  #         src = ./.;
  #         dontBuild = true;
  #         installPhase = ''
  #           mkdir -p $out/share/plasma/look-and-feel/NixOS-Splash-Plasma6
  #           install ./contents $out/share/plasma/look-and-feel/NixOS-Splash-Plasma6
  #         '';
  #       };
  #       default = nixos-splash-plasma6;
  #     };
  #   }
  #   );
  # }
