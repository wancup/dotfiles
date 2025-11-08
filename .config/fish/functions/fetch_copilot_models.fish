function fetch_copilot_models
    set -l token (cat ~/.config/github-copilot/apps.json | jq -r 'to_entries[0].value.oauth_token')
    curl -s \
        -H "Authorization: Bearer $token" \
        "https://api.githubcopilot.com/models" \
        | jq -r '.data[].id'
end
