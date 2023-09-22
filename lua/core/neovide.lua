-- Helper function for transparency formatting
-- 格式化透明度函数
local alpha = function()
	return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
end

if vim.g.neovide then
	-- 设置主题
	vim.g.neovide_theme = "auto"
	vim.o.guifont = "JetBrainsMono NL:h18" -- 设置字体
	-- 设置全屏
	vim.g.neovide_fullscreen = false
	-- 设置padding
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0
	-- 设置透明度
	vim.g.neovide_transparency = 0.0
	vim.g.transparency = 0.6
	vim.g.neovide_background_color = "#000000" .. alpha()
	-- 设置光标效果
	vim.g.neovide_cursor_vfx_mode = "railgun"
end
