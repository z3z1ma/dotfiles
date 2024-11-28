function quote
    set -l quote_count (cat ~/assets/quotes.json | jq 'length')
    set -l random_number (cat /dev/urandom | head -c4 | od -An -tu4 | tr -d ' ')
    set -l random_index (math "$random_number % $quote_count")
    cat ~/assets/quotes.json | jq -r --argjson idx $random_index '.[$idx] | "\(.text) - \(.author)"'
end
