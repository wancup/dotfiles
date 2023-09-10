function fzf-history
  history -z | eval fzf --scheme=history --read0 --print0 -q '(commandline)' | read -lz result
  if test $status -eq 0
    echo "RUN: $result"
    eval $result
    commandline -f repaint
  end
end
