return {
	-- 核心插件 (neovim lua函数库)
	{ "nvim-lua/plenary.nvim", event = "VeryLazy" },
	-- 主题插件
	{
		"folke/tokyonight.nvim",
		lazy = false, -- nvim启动时就加载
		priority = 1000, -- 确保在加载其他插件之前加载
		config = function()
			require("config.tokyonight")
			require("config.colorscheme")
		end,
	},
	-- 代码颜色
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		cmd = {
			"TSBufDisable",
			"TSBufEnable",
			"TSBufToggle",
			"TSDisable",
			"TSEnable",
			"TSToggle",
			"TSInstall",
			"TSInstallInfo",
			"TSInstallSync",
			"TSModuleInfo",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
		},
		build = ":TSUpdate",
		config = function()
			require("config.treesitter")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter",
		init = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{ "p00f/nvim-ts-rainbow", event = "BufRead", dependencies = "nvim-treesitter/nvim-treesitter" },
	-- 代码补全
	{
		"hrsh7th/nvim-cmp",
		event = "BufWinEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-emoji",
			{
				"roobert/tailwindcss-colorizer-cmp.nvim",
				config = function()
					require("tailwindcss-colorizer-cmp").setup({
						color_square_width = 2,
					})
				end,
			},
		},
		config = function()
			require("config.cmp")
		end,
	},
	-- 代码片段
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
		keys = {
			{
				"<tab>",
				function()
					require("luasnip").jump(1)
				end,
				mode = "s",
			},
			{
				"<s-tab>",
				function()
					require("luasnip").jump(-1)
				end,
				mode = { "i", "s" },
			},
		},
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
		event = "BufWinEnter",
		config = function()
			require("config.lsp")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
	},
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		init = function()
			vim.tbl_map(function(plugin)
				pcall(require, plugin)
			end, { "lspconfig", "null-ls" })
		end,
	},
	-- 格式化/代码lint
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
	},
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
	},
	{
		"jayp0521/mason-null-ls.nvim",
		dependencies = "jose-elias-alvarez/null-ls.nvim",
		event = "BufRead",
		opts = function()
			require("config.mason-null-ls")
		end,
	},
	{ "williamboman/nvim-lsp-installer", event = "VeryLazy" },
	-- auto pairs
	{
		"windwp/nvim-autopairs",
		dependencies = "hrsh7th/nvim-cmp",
		event = "VeryLazy",
		init = function()
			require("config.autopairs")
		end,
	},
	-- 注释插件
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{
		"numToStr/Comment.nvim",
		event = "InsertEnter",
		init = function()
			require("config.comment")
		end,
	},
	-- 代码缩进
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		init = function()
			require("config.indent")
		end,
	},
	-- 加载性能加速
	{
		"lewis6991/impatient.nvim",
		event = "VeryLazy",
		init = function()
			require("impatient").enable_profile()
		end,
	},
	-- 代码调试
	{
		"mfussenegger/nvim-dap",
		event = "BufWinEnter",
		enabled = vim.fn.has("win32") == 0,
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "BufWinEnter",
		dependencies = "mfussenegger/nvim-dap",
		enabled = vim.fn.has("win32") == 0,
		config = function()
			require("config.dapui")
		end,
	},
	{
		"jayp0521/mason-nvim-dap.nvim",
		event = "BufWinEnter",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		enabled = vim.fn.has("win32") == 0,
		init = function()
			require("config.mason-dap")
		end,
	},
	-- nvim启动台
	{
		"goolord/alpha-nvim",
		event = "BufWinEnter",
		config = function()
			require("config.alpha")
		end,
	},
	-- 底部状态栏
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
		event = "BufWinEnter",
		opts = function()
			require("config.lualine")
		end,
	},
	-- 顶部Tab栏
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "famiu/bufdelete.nvim" },
		event = "VeryLazy",
	},
	-- 文件树
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		lazy = false,
		-- event = "BufWinEnter",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = {
			"Neotree",
		},
		init = function()
			require("config.neotree")
		end,
	},
	-- 文件顶部面包屑
	{
		"SmiteshP/nvim-navic",
		dependencies = "neovim/nvim-lspconfig",
		event = "BufRead",
		config = function()
			require("config.breadcrumb")
			require("config.winbar")
		end,
	},
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		cmd = "Telescope",
		init = function()
			require("config.telescope")
		end,
	},
	-- 快捷键映射
	{
		"folke/which-key.nvim",
		event = "BufWinEnter",
		init = function()
			require("config.whichkey")
		end,
	},
	-- 调整窗口大小(手动)
	{
		"mrjones2014/smart-splits.nvim",
		event = "BufWinEnter",
		config = function()
			require("config.smartsplit")
		end,
	},
	-- 自动调整窗口大小
	{
		"anuvyklack/windows.nvim",
		event = "BufWinEnter",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			require("windows").setup({})
		end,
	},
	-- nvim内部终端
	{
		"akinsho/toggleterm.nvim",
		cmd = "Toggleterm",
		event = "BufWinEnter",
		init = function()
			require("config.toggleterm")
		end,
	},
	-- git插件
	{
		"lewis6991/gitsigns.nvim",
		enabled = vim.fn.executable("git") == 1,
		ft = "gitcommit",
		event = "VeryLazy",
		config = function()
			require("config.gitsigns")
		end,
	},
	-- Code Runner插件
	{
		"CRAG666/code_runner.nvim",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
		config = function()
			require("config.coderunner")
		end,
	},
	-- 统计启动时间
	{ "dstein64/vim-startuptime", cmd = "StartupTime", event = "VeryLazy" },
	-- 通知弹窗
	{
		"rcarriga/nvim-notify",
		event = "BufRead",
		config = function()
			local notify = require("notify")
			notify.setup({ background_colour = "#000000" })
			vim.notify = notify.notify
		end,
	},
	-- 输入弹窗
	{
		"stevearc/dressing.nvim",
		event = "BufWinEnter",
		config = function()
			require("config.dressing")
		end,
	},
	{
		"folke/noice.nvim",
		event = "BufWinEnter",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("config.noice")
		end,
	},
	-- 颜色插件
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					tailwind = true,
					RGB = true,
					RRGGBB = true,
					names = true,
					RRGGBBAA = true,
					AARRGGBB = true,
					rgb_fn = true,
					hsl_fn = true,
					css = true,
					css_fn = true,
					mode = "background",
					sass = { enable = true, parsers = { "css" } },
					virtualtext = "■",
				},
			})
		end,
	},
	-- 滚动插件
	{
		"karb94/neoscroll.nvim",
		event = "BufRead",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	-- Golang配置
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_, opts)
			require("gopher").setup(opts)
		end,
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	},
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function(_, opts)
			require("dap-go").setup(opts)
		end,
	},
	-- Rust配置
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		event = "BufRead",
		dependencies = {
			"mason-lspconfig.nvim",
			{
				"saecki/crates.nvim",
				ft = { "rust", "toml" },
				tag = "v0.3.0",
				dependencies = { "hrsh7th/nvim-cmp", "nvim-lua/plenary.nvim" },
				config = function(_, opts)
					local crates = require("crates")
					crates.setup(opts)
					crates.show()
				end,
			},
		},
		config = function()
			require("config.rust")
		end,
	},
	-- codeium
	{
		"Exafunction/codeium.vim",
		event = "VeryLazy",
		config = function()
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<c-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<c-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
		end,
	},
	-- Dart
	{
		"dart-lang/dart-vim-plugin",
		-- dependencies = { "natebosch/vim-lsc", "natebosch/vim-lsc-dart" },
		event = "BufRead",
		config = function()
			-- vim.g.dart_format_on_save = 1
			-- vim.g.dart_style_guide = 2
			-- vim.g.lsc_auto_map = true
		end,
	},
	-- Flutter Tools
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
		event = "BufRead",
		config = function()
			require("config.flutter")
		end,
	},
	-- Flutter Snippets
	{ "RobertBrunhage/flutter-riverpod-snippets" },
	{ "Neevash/awesome-flutter-snippets" },
	-- LSP Lines
	{
		"ErichDonGubler/lsp_lines.nvim",
		event = "VimEnter",
		config = function()
			require("lsp_lines").setup()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "*" },
				callback = function()
					local exclude_ft = {
						"lazy",
					}
					if vim.tbl_contains(exclude_ft, vim.o.filetype) then
						vim.diagnostic.config({ virtual_lines = false })
					else
						vim.diagnostic.config({ virtual_lines = true })
					end
				end,
			})
		end,
	},
	-- wakatime
	{
		"wakatime/vim-wakatime",
		event = "BufWinEnter",
	},
	-- 禅模式
	{
		"folke/zen-mode.nvim",
		event = "BufWinEnter",
		config = function()
			require("zen-mode").setup({})
		end,
	},
	-- ChatGPT
	{
		"jackMort/ChatGPT.nvim",
		event = "BufWinEnter",
		cmd = {
			"ChatGPT",
			"ChatGPTActAs",
			"ChatGPTEditWithInstructions",
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("config.gpt")
		end,
	},
	-- NeoAI
	{
		"Bryley/neoai.nvim",
		event = "VimEnter",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		cmd = {
			"NeoAI",
			"NeoAIOpen",
			"NeoAIClose",
			"NeoAIToggle",
			"NeoAIContext",
			"NeoAIContextOpen",
			"NeoAIContextClose",
			"NeoAIInject",
			"NeoAIInjectCode",
			"NeoAIInjectContext",
			"NeoAIInjectContextCode",
		},
		keys = {
			{ "<leader>as", desc = "summarize text" },
			{ "<leader>ag", desc = "generate git message" },
		},
		config = function()
			require("config.neoai")
		end,
	},
	-- Timer Down
	{
		"jackMort/pommodoro-clock.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("config.clock")
		end,
	},
	-- TODO Comments
	{
		"folke/todo-comments.nvim",
		event = "BufWinEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.todo")
		end,
	},
}
