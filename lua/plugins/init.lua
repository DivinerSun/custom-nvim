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
				require("luasnip.loaders.from_vscode").lazy_load()
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
		dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
		event = "BufWinEnter",
		opts = function()
			require("config.lualine")
		end,
	},
	-- 文件树
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		lazy = false,
		event = "BufWinEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = {
			"Neotree",
		},
		init = function()
			require("config.neotree")
		end,
	},
}
