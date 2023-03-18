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
	-- 代码补全
	{
		"hrsh7th/nvim-cmp",
		event = "BufWinEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("config.cmp")
		end,
	},
}
