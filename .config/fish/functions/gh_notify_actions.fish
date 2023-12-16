function gh_notify_actions
  gh run watch && osascript -e 'display notification "GitHub Run is DONE!"'
end
