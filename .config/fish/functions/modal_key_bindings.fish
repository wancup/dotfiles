function modal_key_bindings
    for mode in default insert visual
        fish_default_key_bindings -M $mode
        bind -M $mode \er history-pager
    end
    fish_vi_key_bindings --no-erase insert
    bind -M insert ctrl-n history-search-forward
end
