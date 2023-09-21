{
  description = "Python 3.10 Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.devenv.flakeModule ];
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devenv.shells.default = {
          name = "python3.10";

          # Commons 
          imports = [
            ../common.nix
          ];

          # Base packages
          packages = [
            pkgs.python310
            pkgs.black
            pkgs.isort
            pkgs.ruff
            pkgs.poetry
          ];

          # Utilities
          scripts.fmt.exec = ''
            echo "Formatting..."
            ${pkgs.black}/bin/black src
            ${pkgs.isort}/bin/isort src
          '';
          scripts.lint.exec = ''
            echo "Linting..."
            ${pkgs.ruff}/bin/ruff --fix "$@"
          '';

          # Activate venv on shell enter
          enterShell = ''
            echo Setting up Python virtual environment...
            [ -d "$DEVENV_ROOT/.venv" ] || python -m venv "$DEVENV_ROOT/.venv"
            source "$DEVENV_ROOT/.venv/bin/activate"
          '';

          # Languages
          languages.python.enable = true;

        };
      };
      flake = { };
    };
}
