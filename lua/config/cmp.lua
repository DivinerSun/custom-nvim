local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- colors
vim.api.nvim_set_hl(0, "MyCursorLine", { bg = "#83a598", bold = true })

vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#d5c4a1" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#83a598" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#83a598" })

vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#fe8019" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#fb4934" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#98c379" })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#d5c4a1" })

vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#c792ea", italic = true })

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
	Question = "",

	nvim_lsp = "🚀",
	luasnip = "🔍",
	buffer = "📝",
	path = "📁",
	nvim_lua = "🌙",
	emoji = "🎉",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet
-- local new_kind_icon = require("config.icons")

local compare = cmp.config.compare

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "emoji" },
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			-- vim_item.kind = string.format("%s %s", (kind_icons[vim_item.kind] or kind_icons.Question), vim_item.kind)
			local kind = vim_item.kind
			vim_item.kind = " " .. (kind_icons[kind] or kind_icons.Question)

			local source = entry.source.name
			-- vim_item.menu = " [" .. kind_icons[source] .. "]"
			vim_item.menu = "  " .. kind_icons[source]

			vim_item.abbr = vim_item.abbr:match("[^(]+")

			-- 代码提示去重
			if source == "luasnip" or source == "nvim_lsp" then
				vim_item.dup = 0
			end

			local item = entry:get_completion_item()
			if item.detail then
				vim_item.menu = item.detail
			end

			return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
		end,
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
		-- documentation = {
		-- 	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		-- },
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
	sorting = {
		comparators = {
			-- compare.exact,
			compare.length,
			compare.recently_used,
			compare.kind,
			function(entry1, entry2)
				-- local kind_mapper = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 }
				local kind_mapper = require("cmp.types").lsp.CompletionItemKind
				local kind_score = {
					Keyword = 1,
					Method = 2,
					Class = 3,
					Variable = 4,
				}
				local kind1 = kind_score[kind_mapper[entry1:get_kind()]] or 100
				local kind2 = kind_score[kind_mapper[entry2:get_kind()]] or 100
				if kind1 < kind2 then
					return true
				end
			end,
		},
	},
})
