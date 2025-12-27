{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {nixpkgs, ...}:
   {
    packages.
     prism = {pkgs, wallpapersDir, colorscheme}: let
        inherit (nixpkgs) lib;
        scheme =
          if builtins.isAttrs colorscheme
          then lib.attrsets.attrValues colorscheme.palette
          else colorscheme;
        colors =
          # If colorscheme is a attrset, convert to a list.
          # Otherwise pass colorscheme.
          if builtins.isList scheme
          # This is really dumb but it's the only way i could think to do this.
          # If colorscheme is a list we separate it and wrap each one with ''.
          # We have to put the ' on the outside and then use `' '` to as a separator to make them individual strings.
          then "-- '${builtins.concatStringsSep "' '" scheme}'"
          else "-p ${scheme}";
      in
        pkgs.runCommand "prism" {} ''
            mkdir -p $out
            find "${wallpapersDir}" -type f -exec sh -c \
              '${pkgs.lutgen}/bin/lutgen apply "$1" -o "$out/$(basename "$1")" ${colors}' \
              _ {} \;
        '';

    };
}
