# catppuccin-kvantum-flake

Standalone flake that fetches the public
[`catppuccin/kvantum`](https://github.com/catppuccin/kvantum) repository and
installs the upstream `themes/` directory into `share/Kvantum`.

## What it exposes

- `packages.<system>.default`
- `packages.<system>.catppuccin-kvantum`
- `overlays.default`
- `homeManagerModules.default`
- `nixosModules.default`
- `formatter.<system>`

## Usage

Add the flake as an input:

```nix
{
  inputs.catppuccin-kvantum.url = "github:W4T4r/catppuccin-kvantum-flake";
}
```

Install the package directly:

```nix
{
  environment.systemPackages = [
    inputs.catppuccin-kvantum.packages.${pkgs.system}.default
  ];
}
```

Or use the overlay:

```nix
{
  nixpkgs.overlays = [inputs.catppuccin-kvantum.overlays.default];

  environment.systemPackages = [pkgs.catppuccin-kvantum];
}
```

Home Manager module:

```nix
{
  imports = [inputs.catppuccin-kvantum.homeManagerModules.default];

  programs.catppuccin-kvantum.enable = true;
}
```

NixOS module:

```nix
{
  imports = [inputs.catppuccin-kvantum.nixosModules.default];

  programs.catppuccin-kvantum.enable = true;
}
```

## Notes

- This flake packages themes only. It does not configure Kvantum Manager,
  `kvantummanager`, `qt6ct`, or choose an active theme for you.
- The theme files land in the standard profile path under `share/Kvantum`.
