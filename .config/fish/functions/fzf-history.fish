function fzf-history
  history -z | eval fzf --scheme=history --read0 --print0 -q '(commandline)' | read -lz result
  if test $status -eq 0
    commandline $result
  end
end
