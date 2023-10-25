{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.prism;
in {
  options.prism = {
    enable = lib.mkEnableOption "Enable prism";
    outputPath = lib.mkOption {
      description = ''
        The directory the the wallpapers are outputted to.
      '';
      type = lib.types.string;
      default = ".config/wallpapers/";
      example = lib.literalExample ''
        .config/wallpapers/
      '';
    };
    wallpapers = lib.mkOption {
      description = ''
        The directory the the wallpapers are stored in.
      '';
      type = lib.types.path;
      default = "";
      example = lib.literalExample ''
        ./wallpapers
      '';
    };
    colorscheme = lib.mkOption {
      description = ''
        The colorscheme to convert the wallpapers into.
      '';
      type = lib.types.string;
      default = "";
      example = lib.literalExample ''
        "catppuccin-mocha"
      '';
    };
    onChange = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Shell commands to run when wallpapers have changed between
        generations. The script will be run
        *after* the new files have been linked
        into place.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.file."${cfg.outputPath}" = {
      recursive = true;
      source = pkgs.runCommand "recolored-wallpapers" {} ''
        ${pkgs.lutgen}/bin/lutgen apply ${cfg.wallpapers}/* -p ${cfg.colorscheme} -o $out
      '';
      onChange = cfg.onChange;
    };
  };
}
