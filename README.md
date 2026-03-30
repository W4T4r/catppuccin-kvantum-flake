# catppuccin-kvantum-flake

Standalone flake for packaging the upstream
[`catppuccin/kvantum`](https://github.com/catppuccin/kvantum) themes.

It fetches the upstream repository and installs `themes/` into:

```text
$out/share/Kvantum
```

## Exposed outputs

- `packages.<system>.default`
- `packages.<system>.catppuccin-kvantum`
- `overlays.default`
- `homeManagerModules.default`
- `nixosModules.default`
- `formatter.<system>`

## Supported systems

- `x86_64-linux`
- `aarch64-linux`

## Add as an input

```nix
{
  inputs.catppuccin-kvantum.url = "github:W4T4r/catppuccin-kvantum-flake";
}
```

## Usage

### Install the package directly

For NixOS:

```nix
{
  environment.systemPackages = [
    inputs.catppuccin-kvantum.packages.${pkgs.system}.default
  ];
}
```

For Home Manager:

```nix
{
  home.packages = [
    inputs.catppuccin-kvantum.packages.${pkgs.system}.default
  ];
}
```

### Use the overlay

```nix
{
  nixpkgs.overlays = [ inputs.catppuccin-kvantum.overlays.default ];

  environment.systemPackages = [ pkgs.catppuccin-kvantum ];
}
```

### Use the Home Manager module

```nix
{
  imports = [ inputs.catppuccin-kvantum.homeManagerModules.default ];

  programs.catppuccin-kvantum.enable = true;
}
```

This module adds the packaged themes to `home.packages`.

### Use the NixOS module

```nix
{
  imports = [ inputs.catppuccin-kvantum.nixosModules.default ];

  programs.catppuccin-kvantum.enable = true;
}
```

This module adds the packaged themes to `environment.systemPackages`.

## Notes

- This flake packages themes only.
- It does not install or configure `kvantummanager`.
- It does not configure `qt5ct`, `qt6ct`, or select an active Kvantum theme.
- Installed theme files are available under the standard profile path `share/Kvantum`.
