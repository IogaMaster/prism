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
    outPath = lib.mkOption {
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
    user = lib.mkOption {
      description = ''
        The user to activate the wallpapers for
      '';
      type = lib.types.str;
      default = throw "user cannot be unset";
    };
    colorscheme = lib.mkOption {
      description = ''
        The colorscheme to convert the wallpapers into.
        Can be a string like "catppuccin-mocha" or a list of strings containing each hex code to use.
        It also can be a colorscheme from nix-colors.
      '';
      type = with lib.types; oneOf [str (listOf str) attrs];
      default = "";
    };
  };

  config = lib.mkIf cfg.enable {
    hjem.users.${cfg.user}.files."${cfg.outPath}" = {
      source = let
        scheme =
          if builtins.isAttrs cfg.colorscheme
          then lib.attrsets.attrValues cfg.colorscheme.palette
          else cfg.colorscheme;
        colors =
          # If colorscheme is a attrset, convert to a list.
          # Otherwise pass colorscheme.
          if builtins.isList scheme
          # This is really dumb but it's the only way i could think to do this.
          # If cfg.colorscheme is a list we separate it and wrap each one with ''.
          # We have to put the ' on the outside and then use `' '` to as a separator to make them individual strings.
          then "-- '${builtins.concatStringsSep "' '" scheme}'"
          else "-p ${scheme}";
      in
        pkgs.runCommand "prism" {} ''
            mkdir $out
            for WALLPAPER in $(find ${cfg.wallpapers} -type f) 
            do
              xargs -0 -P $(nproc) -I % ${pkgs.lutgen}/bin/lutgen apply $WALLPAPER -o $out/$(basename $WALLPAPER) ${colors} %
            done
        '';
    };
  };
}
