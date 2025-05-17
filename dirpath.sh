__dirpath_find_repo_root() {
  git rev-parse --show-toplevel 2>/dev/null
}

__dirpath_load_pathrc() {
  local pathrc="${1}"
  if [ -f "${pathrc}" ]; then
    sed '/^\s*$/d;/^\s*#/d' "${pathrc}"
  fi
}

__dirpath_merge_paths() {
  # 順序を保持したまま重複を削除
  awk '!seen[$0]++'
}

__dirpath_update_path() {
  local current_dir_pathrc="${PWD}/.pathrc"
  local repo_root repo_root_pathrc

  repo_root="$(__dirpath_find_repo_root)"

  if [ -n "${repo_root}" ]; then
    repo_root_pathrc="${repo_root}/.pathrc"
  fi

  local paths=""

  if [ -f "${repo_root_pathrc}" ]; then
    paths="$(__dirpath_load_pathrc "${repo_root_pathrc}")"
  fi

  if [ -f "${current_dir_pathrc}" ]; then
    paths="$(printf "%s\n%s" "$(__dirpath_load_pathrc "${current_dir_pathrc}")" "${paths}")"
  fi

  if [ -n "${paths}" ]; then
    local new_path
    new_path=$(printf "%s\n" "${paths}" | __dirpath_merge_paths | paste -sd ":" -)
    export PATH="${new_path}:${ORIGINAL_PATH}"
  else
    export PATH="${ORIGINAL_PATH}"
  fi
}

# 元のPATHをバックアップ（初回実行のみ）
if [ -z "${ORIGINAL_PATH}" ]; then
  export ORIGINAL_PATH="${PATH}"
fi

dirpath_update() {
  __dirpath_update_path
}
