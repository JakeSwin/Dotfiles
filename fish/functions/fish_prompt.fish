function fish_prompt
    set_color $fish_color_cwd
    echo -ne "\n"
    echo -n "  "
    echo -ne (prompt_pwd -D 3 -d 3) "\n"
    set_color normal
    echo -n '  ﬦ '
end
