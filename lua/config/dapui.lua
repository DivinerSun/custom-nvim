local dap, dapui = require("dap"), require("dapui")

-- dart dap
dap.adapters.dart = {
	type = "executable",
	command = "dart",
	-- This command was introduced upstream in https://github.com/dart-lang/sdk/commit/b68ccc9a
	args = { "debug_adapter" },
}
dap.configurations.dart = {
	{
		type = "dart",
		request = "launch",
		name = "Launch Dart Program",
		-- The nvim-dap plugin populates this variable with the filename of the current buffer
		program = "${file}",
		-- The nvim-dap plugin populates this variable with the editor's current working directory
		cwd = "${workspaceFolder}",
		args = { "--help" }, -- Note for Dart apps this is args, for Flutter apps toolArgs
	},
}

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.setup()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
