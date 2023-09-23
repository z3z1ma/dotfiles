{
  description = "On demand declarative environments";
  inputs = {
    clojure.url = "path:./clojure";
    elixer.url = "path:./elixer";
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
          devShells = { } // inputs.python.outputs.devShells."${system}"
            // inputs.clojure.outputs.devShells."${system}"
            // inputs.elixer.outputs.devShells."${system}"
            // inputs.go.outputs.devShells."${system}"
            // inputs.python.outputs.devShells."${system}"
            // inputs.rust.outputs.devShells."${system}"
            // inputs.scala.outputs.devShells."${system}"
            // inputs.zig.outputs.devShells."${system}";
        };
    };
}
