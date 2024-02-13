function gh_notify_actions -d "Watch gh actions and notify to Desktop when finished"
  gh run watch && osascript -e 'display notification "GitHub Run is DONE!"'
end
