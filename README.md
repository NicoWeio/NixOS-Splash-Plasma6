# NixOS-Splash-Plasma6
![preview image of splash screen](https://github.com/nimrodium/NixOS-Splash-Plasma6/blob/main/contents/previews/splash.png "preview")

NixOS splash screen for KDE plasma6

# Usage
add NixOS-Splash-Plasma6 as a flake input to your system flake, usually `/etc/nixos/flake.nix`
```nix
   nixos-splash-plasma6 = {
      url = "github:nimrodium/nixos-splash-plasma6";
      inputs.nixpkgs.follows = "nixpkgs";
   };
```
add it as an argument to outputs or attach @inputs, or in SOME way get it accessible to the output function and then pass it to your nixosSystem 
```nix
specialArgs = {inherit nixos-splash-plasma6; }
```
or by just passing the entire inputs set. which is easier to use long term.
```nix
specialArgs = {inherit inputs; }
```
in your system's `configuration.nix` environment.systemPackages add
```nix
environment.systemPackages = with pkgs; [
  inputs.nixos-splash-plasma6.packages.${pkgs.system}.default
]
```
then select it in kde settings.

# Customization

## Changing the Splash Text

You can customize the splash screen text by overriding the `splashText` attribute:

```nix
environment.systemPackages = with pkgs; [
  (inputs.nixos-splash-plasma6.packages.${pkgs.system}.default.overrideAttrs (old: {
    splashText = "Your Custom Text Here";
  }))
]
```

The default text is "Plasma made by KDE".

> forked from https://github.com/smokey5787/EOS-Splash-Plasma6
