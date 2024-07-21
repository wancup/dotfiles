function diff_stdout -d "diff two command's stdouts"

    function show_help
        echo -e "
USAGE:
\tdiff_stdout [OPTIONS] 'command1' 'command2'

OPTIONS:
\t-F, --fixed-strings\t Compare two inputs as normal string
\t-P, --no-pager\t Use default diff
\t-h, --help\t\t Show this help
"
    end

    argparse h/help F/fixed-strings P/no-pager -- $argv

    if set -ql _flag_help
        show_help
        return 0
    end
    if test (count $argv) -ne 2
        show_help
        return 1
    end


    set -l tmp_dir "$TMPDIR/diff_stdout"
    if not test -d $tmp_dir
        mkdir $tmp_dir
    end

    set -l input1 "$tmp_dir/input1.txt"
    set -l input2 "$tmp_dir/input2.txt"
    if set -ql _flag_fixed_strings
        echo $argv[1] >$input1
        echo $argv[2] >$input2
    else
        eval $argv[1] >$input1
        eval $argv[2] >$input2
    end

    if set -ql _flag_no_pager
        diff $input1 $input2
    else
        delta $input1 $input2
    end
    set -l exit_code $status

    rm -f $input2
    rm -f $input1
    rmdir $tmp_dir
    return $exit_code
end
