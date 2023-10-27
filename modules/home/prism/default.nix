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
      type = lib.types.str;
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
        Can be a string like "catppuccin-mocha" or a list of strings containing each hex code to use.
      '';
      type = with lib.types; oneOf [ str (listOf str) ];
      default = "";
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
        ${pkgs.lutgen}/bin/lutgen apply ${cfg.wallpapers}/* -o $out ${
          if builtins.isList cfg.colorscheme
          # This is really dumb but it's the only way i could think to do this.
          # If cfg.colorscheme is a list we separate it and wrap each one with ''.
          # We have to put the ' on the outside and then use `' '` to as a separator to make them individual strings.
          then "-- '${builtins.concatStringsSep "' '" cfg.colorscheme}'" 
          else "-p ${cfg.colorscheme}" # Builtin colorscheme
        }
      '';
      onChange = cfg.onChange;
    };
  };
}
