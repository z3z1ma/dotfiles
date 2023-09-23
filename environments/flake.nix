{
  description = "On demand declarative environments";
  inputs = {
    clojure.url = "path:./clojure";
    elixir.url = "path:./elixir";
    go.url = "path:./go";
    python.url = "path:./python";
    rust.url = "path:./rust";
    scala.url = "path:./scala";
    zig.url = "path:./zig";
  };
  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = { };
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        {
          devShells = builtins.removeAttrs inputs.python.outputs.devShells."${system}" [ "default" ]
            // builtins.removeAttrs inputs.python.outputs.devShells."${system}" [ "default" ]
            // builtins.removeAttrs inputs.clojure.outputs.devShells."${system}" [ "default" ]
            // builtins.removeAttrs inputs.elixir.outputs.devShells."${system}" [ "default" ]
            // builtins.removeAttrs inputs.go.outputs.devShells."${system}" [ "default" ]
            // builtins.removeAttrs inputs.rust.outputs.devShells."${system}" [ "default" ]
            // builtins.removeAttrs inputs.scala.outputs.devShells."${system}" [ "default" ]
            // builtins.removeAttrs inputs.zig.outputs.devShells."${system}" [ "default" ];
        };
    };
}
