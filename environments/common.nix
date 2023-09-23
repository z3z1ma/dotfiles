{ pkgs, ... }: 

{
  env.EPHEMERAL = "1"; 
  dotenv.disableHint = true;
  packages = [
    pkgs.jq
    pkgs.yq
    pkgs.nixfmt
  ];
}
