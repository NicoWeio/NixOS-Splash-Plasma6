{ stdenv
, lib
, splashText ? "Plasma made by KDE · flake default"
}:

stdenv.mkDerivation {
  pname = "nixos-splash-plasma6";
  version = "1.0";
  src = ./.;

  inherit splashText; # exported as $splashText in the builder env

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/plasma/look-and-feel/NixOS-Splash-Plasma6
    cp -r . $out/share/plasma/look-and-feel/NixOS-Splash-Plasma6

    substituteInPlace \
      $out/share/plasma/look-and-feel/NixOS-Splash-Plasma6/contents/splash/Splash.qml \
      --replace-fail '"Plasma made by KDE"' "\"$splashText\""
  '';
}
