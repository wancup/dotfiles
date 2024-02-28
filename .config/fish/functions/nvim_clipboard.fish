function nvim_clipboard
  set tmp_file "$XDG_STATE_HOME/nvim-clipbord.txt"
  nvim $tmp_file
  if test -f $tmp_file
    echo -n "$(cat $tmp_file)" | pbcopy
    rm -f $tmp_file
  end
end
