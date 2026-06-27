function generate_command_gate -d "Generate .pi/command-gate.json for the current directory"
    function show_help
        echo -e "
USAGE:
\tgenerate_command_gate

DESCRIPTION:
\tGenerate .pi/command-gate.json in the current directory.
\tIf package.json exists in the current directory, package scripts are added as pnpm run <script>.
\tIf inside a git repository, the generated file path is added to .git/info/exclude.
"
    end

    argparse h/help -- $argv
    or return 1

    if set -ql _flag_help
        show_help
        return 0
    end

    if test (count $argv) -ne 0
        show_help
        return 1
    end

    if not command -q jq
        echo "jq is required to generate .pi/command-gate.json" >&2
        return 1
    end

    set -l base_dir $PWD
    set -l pi_dir "$base_dir/.pi"
    set -l config_path "$pi_dir/command-gate.json"

    if test -e "$config_path"; or test -L "$config_path"
        echo "$config_path already exists. Nothing changed." >&2
        return 1
    end

    set -l allowed_commands
    set -l package_json "$base_dir/package.json"
    if test -f "$package_json"
        set allowed_commands (jq -r '.scripts // {} | if type == "object" then keys_unsorted[] else empty end | "pnpm run \(.)"' "$package_json")
        or return 1
    end

    mkdir -p "$pi_dir"
    or return 1

    if test (count $allowed_commands) -eq 0
        jq -n '{ allow: [] }' >"$config_path"
    else
        printf '%s\n' $allowed_commands | jq -Rn '{ allow: [inputs] }' >"$config_path"
    end
    or return 1

    if git rev-parse --is-inside-work-tree >/dev/null 2>/dev/null
        set -l git_prefix (git rev-parse --show-prefix)
        or return 1
        set -l exclude_entry "$git_prefix.pi/command-gate.json"
        set -l exclude_path (git rev-parse --path-format=absolute --git-path info/exclude)
        or return 1

        if not grep -Fxq -- "$exclude_entry" "$exclude_path"
            printf '%s\n' "$exclude_entry" >>"$exclude_path"
            or return 1
        end
    end

    echo "Generated $config_path"
end
