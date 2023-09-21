{ pkgs, ... }: 

{
  # These env vars are common to all devshell environments
  env.EPHEMERAL = "1"; 
  dotenv.disableHint = true;

  # These packages are common to all devshell environments
  packages = [
    pkgs.jq
    pkgs.yq
    pkgs.nixfmt
  ];
}
