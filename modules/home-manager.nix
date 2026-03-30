{packageFor}: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.catppuccin-kvantum;
in {
  options.programs.catppuccin-kvantum.enable =
    lib.mkEnableOption "Catppuccin Kvantum themes";

  config = lib.mkIf cfg.enable {
    home.packages = [(packageFor pkgs.system)];
  };
}
