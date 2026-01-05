# Testing Guide

This document describes how to test the customizable splash text feature.

## Prerequisites

- NixOS system with Nix flakes enabled
- Access to modify your system configuration

## Testing Default Build

To test that the package builds with the default text:

```bash
nix build github:NicoWeio/NixOS-Splash-Plasma6
```

Then verify the installed text:

```bash
grep "Plasma made by KDE" result/share/plasma/look-and-feel/NixOS-Splash-Plasma6/contents/splash/Splash.qml
```

## Testing Custom Text Override

Create a test flake.nix:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-splash-plasma6.url = "github:NicoWeio/NixOS-Splash-Plasma6";
  };

  outputs = { self, nixpkgs, nixos-splash-plasma6 }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = 
        nixos-splash-plasma6.packages.${system}.default.overrideAttrs (old: {
          splashText = "NixOS Rocks!";
        });
    };
}
```

Build and verify:

```bash
nix build
grep "NixOS Rocks!" result/share/plasma/look-and-feel/NixOS-Splash-Plasma6/contents/splash/Splash.qml
```

## Testing in NixOS Configuration

Add to your `configuration.nix`:

```nix
environment.systemPackages = with pkgs; [
  (inputs.nixos-splash-plasma6.packages.${pkgs.system}.default.overrideAttrs (old: {
    splashText = "Welcome to NixOS";
  }))
]
```

Rebuild your system:

```bash
sudo nixos-rebuild switch
```

Then check the installed file:

```bash
cat /nix/store/*-nixos-splash-plasma6-1.0/share/plasma/look-and-feel/NixOS-Splash-Plasma6/contents/splash/Splash.qml | grep "Welcome to NixOS"
```

## Manual Verification

After installing the splash screen:

1. Open KDE System Settings
2. Navigate to "Appearance" → "Splash Screen"
3. Select "NixOS Splash"
4. Click "Test"
5. Verify the custom text appears in the bottom-right corner of the splash screen
