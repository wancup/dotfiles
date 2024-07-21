function nvim_clipboard
    set -l target_dir "$TMPDIR/nvim-clipbord"
    if not test -d $target_dir
        mkdir $target_dir
    end

    date "+%Y-%m-%d_%H-%M-%S" | read -l now
    set -l target_file "$target_dir/$now.txt"
    nvim $target_file
    if test -f $target_file
        echo -n "$(cat $target_file)" | pbcopy
        rm -f $target_file
    end
end
