local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	C = {
		name = "Flutter",
		r = { "<cmd>FlutterRun<CR>", "Flutter Run" },
		s = { "<cmd>FlutterRestart<CR>", "Flutter Restart" },
		l = { "<cmd>FlutterReload<CR>", "Flutter Reload" },
		q = { "<cmd>FlutterQuit<CR>", "Flutter Quit" },
		g = { "<cmd>FlutterPubGet<CR>", "Pub Get" },
		u = { "<cmd>FlutterPubUpgrade<CR>", "Pub Upgrade" },
		d = { "<cmd>FlutterDevices<CR>", "Devices" },
		t = { "<cmd>FlutterDevTools<CR>", "DevTools" },
		o = { "<cmd>FlutterOpenDevTools<CR>", "Open DevTools" },
		e = { "<cmd>FlutterEmulators<CR>", "Emulators" },
	},
}

which_key.register(mappings, opts)
