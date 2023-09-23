{
  description = "On demand declarative environments";
  inputs = {
    python.url = "path:./python";
  };
  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = { };
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        {
          devShells = { } // inputs.python.outputs.devShells."${system}";
        };
    };
}
