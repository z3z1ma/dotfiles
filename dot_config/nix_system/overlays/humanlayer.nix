final: prev:

let
  version = "0.11.1";

in {
  humanlayer = final.stdenv.mkDerivation {
    pname = "humanlayer";
    inherit version;

    src = final.fetchurl {
      url = "https://registry.npmjs.org/humanlayer/-/humanlayer-${version}.tgz";
      sha256 = "sha256-l9WW8Ax0/wCtwErj9vYCtrxLr4WnAufufGdRJQTGhvw=";
    };

    buildInputs = [
      final.nodejs_22
      final.makeWrapper
    ];

    unpackPhase = ''
      tar xf $src --strip-components=1
    '';

    installPhase = ''
      export HOME=$(mktemp -d)

      npm config set strict-ssl false

      npm install --production

      mkdir -p $out/lib/humanlayer
      cp -r . $out/lib/humanlayer

      mkdir -p $out/bin

      entry="$out/lib/humanlayer/dist/index.js"

      makeWrapper ${final.nodejs_22}/bin/node $out/bin/humanlayer \
        --add-flags "$entry"

      makeWrapper ${final.nodejs_22}/bin/node $out/bin/hlyr \
        --add-flags "$entry"
    '';
  };
}
