source "$(dirname "${(%):-%x}")/dirpath.sh"

autoload -U add-zsh-hook

add-zsh-hook chpwd dirpath_update
add-zsh-hook preexec dirpath_update

dirpath_update
