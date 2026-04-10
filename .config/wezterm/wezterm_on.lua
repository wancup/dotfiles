local wezterm = require("wezterm")

local tab_colors = {
	dimmed = {
		background = "#292929",
		foreground = "#999999",
	},
	active = {
		background = "#000000",
		foreground = "#FFFFFF",
	},
	cc_notification = {
		background = "#292929",
		foreground = "#f1b100",
	},
	cc_stop = {
		background = "#292929",
		foreground = "#00bac0",
	},
}

wezterm.on("format-tab-title", function(tab, _, _, _, _, _)
	local color = tab_colors.dimmed
	local is_cc_status = string.find(tab.tab_title, "^cc:") ~= nil

	if tab.tab_title == "cc:notification" then
		color = tab_colors.cc_notification
	elseif tab.tab_title == "cc:stop" then
		color = tab_colors.cc_stop
	end

	if tab.is_active then
		color = tab_colors.active

		-- reset status
		if is_cc_status then
			wezterm.mux.get_tab(tab.tab_id):set_title("")
		end
	end

	local title = " "
		.. (tab.tab_index + 1)
		.. " "
		.. (is_cc_status and " " or (tab.tab_title .. " "))
		.. tab.active_pane.title
		.. " "
	return {
		{ Background = { Color = color.background } },
		{ Foreground = { Color = color.foreground } },
		{ Text = title },
	}
end)
