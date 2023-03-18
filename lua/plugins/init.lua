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
}
