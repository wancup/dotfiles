function rm_empty_dir
  if test (count $argv) -ne 1
    echo "rm_rmpty_dir 'target_directory_path'"
    return 1
  end

  set -l target_dir $argv[1]
  set -l file_count (count (ls -A $target_dir))
  if test $file_count -eq 0
    rm -rf $target_dir
    return 0
  else
    echo "Target directory($target_dir) id NOT empty!"
    return 100
  end
end
