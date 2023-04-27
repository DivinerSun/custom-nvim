local status_ok, FT = pcall(require, "flutter-tools")
if not status_ok then
	return
end

FT.setup({
	ui = {
		border = "rounded",
		notification_style = "plugin",
	},
	decorations = {
		statusline = {
			app_version = false,
			device = true,
			project_config = false,
		},
	},
	debugger = { -- integrate with nvim dap + install dart code debugger
		enabled = true,
		run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
		exception_breakpoints = {},
		register_configurations = function(_)
			require("dap").configurations.dart = {}
			require("dap.ext.vscode").load_launchjs()
		end,
	},
	-- flutter_path = "/Users/diviner/DevTools/flutter/bin/flutter",
	fvm = true,
	widget_guides = {
		enabled = true,
	},
	closing_tags = {
		highlight = "ErrorMsg",
		prefix = " ",
		enabled = true,
	},
	dev_log = {
		enabled = true,
		notify_errors = true,
		open_cmd = "tabedit",
	},
	dev_tools = {
		autostart = false,
		auto_open_browser = false,
	},
	outline = {
		open_cmd = "30vnew",
		auto_open = false,
	},
	lsp = {
		color = {
			enabled = true,
			background = false,
			background_color = nil,
			foreground = false,
			virtual_text = true,
			virtual_text_str = "■",
		},
		on_attach = require("config.lsp.handlers").on_attach,
		capabilities = {
			require("config.lsp.handlers").capabilities,
		},
		settings = {
			showTodos = true,
			completeFunctionCalls = true,
			renameFilesWithClasses = "prompt", -- "always"
			enableSnippets = true,
			updateImportsOnRename = true,
		},
	},
})
