return {
	{
		"akinsho/flutter-tools.nvim",
		ft = "dart",
		cmd = {
			"FlutterRun",
			"FlutterDevices",
			"FlutterEmulators",
			"FlutterDevTools",
			"FlutterDevToolsActivate",
			"FlutterLspRestart",
			"FlutterSuper",
			"FlutterReanalyze",
			"FlutterRename",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			fvm = true,
			widget_guides = {
				enabled = true,
			},
		},
	},
}
