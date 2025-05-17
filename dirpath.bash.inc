source "$(dirname "${BASH_SOURCE[0]}")/dirpath.sh"

PROMPT_COMMAND="dirpath_update;${PROMPT_COMMAND}"
