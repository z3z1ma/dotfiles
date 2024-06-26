#! /usr/bin/env fish
fish_vi_key_bindings
set gcpsetter "/opt/google-cloud-sdk/path.fish.inc"
if test -e $gcpsetter
    source $gcpsetter
end
for export in (set -Ux)
  set -eg (string split " " $export)[1]
end
starship init fish | source
zoxide init fish | source

