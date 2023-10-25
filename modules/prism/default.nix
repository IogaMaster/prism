{
  lib,
  config,
  ...
}: let
  cfg = config.prism;
in {
  options.prism = {
    enable = lib.mkEnableOption "Enable prism";
    outputPath =  lib.mkOption {
      description = ''
        The directory the the wallpapers are outputted to.
      '';
      type = lib.types.path;
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
  };

  config = lib.mkIf cfg.enable {
    home.file."${cfg.outputPath}" = {
        recursive = true;
        source = cfg.wallpapers;
        onChange = ''
           echo test 
        '';
    };
  };
}
