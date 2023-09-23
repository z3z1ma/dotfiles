{
  description = "On demand declarative environments";
  inputs = {
    python.url = "path:./python";
  };
  outputs = inputs@{ flake-parts, python }:
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
        {
          devenv.shells.python310 = python.devShells."${system}".python310;
        };
    };
}
