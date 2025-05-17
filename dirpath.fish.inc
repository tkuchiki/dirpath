function dirpath_update
    set -l current_dir_pathrc "$PWD/.pathrc"
    set repo_root (git rev-parse --show-toplevel 2>/dev/null)

    set paths

    if test -n "$repo_root" -a -f "$repo_root/.pathrc"
        set paths (cat "$repo_root/.pathrc" | grep -v '^\s*$\|^\s*#')
    end

    if test -f "$current_dir_pathrc"
        set paths (cat "$current_dir_pathrc" | grep -v '^\s*$\|^\s*#'; echo $paths)
    end

    if test -n "$paths"
        set -gx PATH (string join ':' $paths) $ORIGINAL_PATH
    else
        set -gx PATH $ORIGINAL_PATH
    end
end

if not set -q ORIGINAL_PATH
    set -gx ORIGINAL_PATH $PATH
end

function fish_prompt
    dirpath_update
    echo -n (prompt_pwd)' > '
end
