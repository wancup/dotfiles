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
	status_waiting = {
		background = "#292929",
		foreground = "#f1b100",
	},
	status_finish = {
		background = "#292929",
		foreground = "#00bac0",
	},
}

wezterm.on("format-tab-title", function(tab, _, _, _, _, _)
	local color = tab_colors.dimmed
	local is_status_updating = string.find(tab.tab_title, "^status:") ~= nil

	if tab.tab_title == "status:waiting" then
		color = tab_colors.status_waiting
	elseif tab.tab_title == "status:finish" then
		color = tab_colors.status_finish
	end

	if tab.is_active then
		color = tab_colors.active

		-- reset status
		if is_status_updating then
			wezterm.mux.get_tab(tab.tab_id):set_title("")
		end
	end

	local title = " "
		.. (tab.tab_index + 1)
		.. " "
		.. (is_status_updating and " " or (tab.tab_title .. " "))
		.. tab.active_pane.title
		.. " "
	return {
		{ Background = { Color = color.background } },
		{ Foreground = { Color = color.foreground } },
		{ Text = title },
	}
end)
