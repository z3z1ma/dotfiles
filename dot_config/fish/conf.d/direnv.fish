status is-interactive
or exit 0

# Shadow the vendor direnv hook so startup can source a cached fish snippet.
if test -f /etc/fish/generated/direnv.fish
    source /etc/fish/generated/direnv.fish
else
    direnv hook fish | source
end
