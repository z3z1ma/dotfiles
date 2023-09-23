{
  description = "On demand declarative clojure environments";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
  };
  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };
  outputs = inputs@{ flake-parts, ... }:
    let
      mkDevEnv = { pkgs }: {
        name = "clojure";
        packages = [ ];
        languages.clojure.enable = true;
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.devenv.flakeModule ];
      flake = { };
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          cljEnv = mkDevEnv { inherit pkgs; };
        in
        {
          devenv.shells.clojure = cljEnv;
          devenv.shells.default = cljEnv;
        };
    };
}
