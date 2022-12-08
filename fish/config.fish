if status is-interactive

end

alias ls="exa -lhra -s modified --no-user --git --group-directories-first"

set -U fish_greeting

zoxide init fish | source
