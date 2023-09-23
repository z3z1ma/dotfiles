{
  description = "On demand declarative python environments";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
  };
  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };
  outputs = inputs@{ flake-parts, ... }:
    let
      mkDevEnv = { pythonVersion, pkgs }: {
        name = "python${pythonVersion}";
        packages = [
          pkgs.black
          pkgs.isort
          pkgs.ruff
          pkgs.poetry
        ];
        scripts.fmt.exec = ''
          echo "Formatting..."
          ${pkgs.black}/bin/black "$@"
          ${pkgs.isort}/bin/isort "$@"
        '';
        scripts.lint.exec = ''
          echo "Linting..."
          ${pkgs.ruff}/bin/ruff --fix "$@"
        '';
        languages.python.enable = true;
        languages.python.version = pythonVersion;
        languages.python.venv.enable = true;
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
          py310 = mkDevEnv { pythonVersion = "3.10.13"; inherit pkgs; };
          py39 = mkDevEnv { pythonVersion = "3.9"; inherit pkgs; };
          py38 = mkDevEnv { pythonVersion = "3.8"; inherit pkgs; };
        in
        {
          devenv.shells.python310 = py310;
          devenv.shells.python39 = py39;
          devenv.shells.python38 = py38;
          devenv.shells.default = py310;
        };
    };
}
