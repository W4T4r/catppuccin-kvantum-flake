{
  description = "Standalone flake that packages Catppuccin Kvantum themes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin-kvantum-src = {
      url = "github:catppuccin/kvantum";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    catppuccin-kvantum-src,
    ...
  }: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (system:
        f (import nixpkgs {inherit system;}));
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    packages = forAllSystems (pkgs: let
      version =
        if catppuccin-kvantum-src ? shortRev
        then catppuccin-kvantum-src.shortRev
        else "unstable";
      catppuccin-kvantum = pkgs.stdenvNoCC.mkDerivation {
        pname = "catppuccin-kvantum";
        inherit version;
        src = catppuccin-kvantum-src;
        dontUnpack = true;

        installPhase = ''
          runHook preInstall

          mkdir -p "$out/share/Kvantum"
          cp -r "$src/themes/." "$out/share/Kvantum/"

          runHook postInstall
        '';

        meta = with pkgs.lib; {
          description = "Catppuccin themes for Kvantum";
          homepage = "https://github.com/catppuccin/kvantum";
          license = licenses.mit;
          platforms = platforms.linux;
          maintainers = [];
        };
      };
    in {
      default = catppuccin-kvantum;
      inherit catppuccin-kvantum;
    });

    overlays.default = final: _prev: {
      catppuccin-kvantum = self.packages.${final.system}.default;
    };

    homeManagerModules.default = import ./modules/home-manager.nix {
      packageFor = system: self.packages.${system}.default;
    };
    nixosModules.default = import ./modules/nixos.nix {
      packageFor = system: self.packages.${system}.default;
    };
  };
}
